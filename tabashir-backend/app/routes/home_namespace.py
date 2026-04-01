from flask_restx import Namespace, Resource
from flask import request
from http import HTTPStatus
from app.database.db import execute_query
from app.routes.middleware import jwt_required
from app.services.job_apply.ai_matching import title_position_match, calculate_skills_match, semantic_location_match

home_ns = Namespace('home', description='Home Dashboard Endpoints')

@home_ns.route('/dashboard')
class Dashboard(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get user dashboard data"""
        user_id = request.user_id

        # 1. Basic User Info
        try:
            user = execute_query(
                'SELECT name, "jobCount", "aiJobApplyCount" FROM users WHERE id = %s',
                (user_id,), fetch_one=True
            )
        except Exception:
            user = None

        # 2. Candidate Profile & AI Stats
        try:
            profile = execute_query(
                '''SELECT cp."jobType", cp.skills, cp.location 
                   FROM "Candidate" c
                   JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE c."userId" = %s''',
                (user_id,), fetch_one=True
            )
        except Exception:
            profile = None

        # 3. Dynamic Matches Count
        total_matches = 0
        email = request.args.get('email')
        
        # Try to get profile if it wasn't found by userId (e.g., if mobile passes email)
        if not profile and email:
            try:
                profile = execute_query(
                    '''SELECT cp."jobType", cp.skills, cp.location 
                       FROM "Candidate" c
                       JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                       WHERE c.email = %s''',
                    (email,), fetch_one=True
                )
            except Exception as e:
                print(f"[DASHBOARD] Profile fetch by email failed: {e}")

        if profile and profile.get('skills'):
            try:
                # Simple overlap check: Job requiredSkills contains any of user skills
                match_res = execute_query('''
                    SELECT COUNT(*) as count FROM "Job" 
                    WHERE status = 'ACTIVE' 
                    AND "requiredSkills" && %s
                ''', (profile['skills'],), fetch_one=True)
                total_matches = match_res.get('count', 0) if match_res else 0
            except Exception as e:
                print(f"[DASHBOARD] Match calculation failed: {e}")

        # 4. Market Salary Logic
        avg_salary = "N/A"
        if profile and profile.get('jobType'):
            try:
                salary_res = execute_query('''
                    SELECT AVG("salaryMin") as min_sal, AVG("salaryMax") as max_sal 
                    FROM "Job" 
                    WHERE status = 'ACTIVE' AND title ILIKE %s
                ''', (f"%{profile['jobType']}%",), fetch_one=True)
                if salary_res and salary_res['min_sal']:
                    avg_salary = f"{int(salary_res['min_sal']//1000)}k - {int(salary_res['max_sal']//1000)}k AED"
            except Exception:
                pass

        # 5. Application Stats (Existing logic but cleaner)
        try:
            apps = execute_query(
                'SELECT status, COUNT(*) as count FROM "JobApplication" WHERE "userId" = %s GROUP BY status',
                (user_id,), fetch_all=True
            )
        except Exception:
            apps = None

        def _count(status_list):
            if not apps: return 0
            return sum(r['count'] for r in apps if r['status'].upper() in [s.upper() for s in status_list])

        total_apps = sum(r['count'] for r in apps) if apps else 0

        # 6. Featured Jobs (Unify match calculation with Jobs List/Details)
        try:
            featured_jobs = execute_query(
                """SELECT id, title as job_title, company as entity, "companyLogo", "jobType" as job_type, 
                          location as vacancy_city, description as job_description
                   FROM "Job" WHERE status = 'ACTIVE'
                   ORDER BY "createdAt" DESC LIMIT 5""",
                fetch_all=True
            )
            
            # Match calculation logic (same as resumes_namespace.py)
            match_profile = None
            if profile:
                print(f"[DASHBOARD] Profile found for user {user_id}: {profile.get('jobType')}, {len(profile.get('skills') or [])} skills")
                skills_list = profile.get('skills') or []
                skills_str = ", ".join(skills_list) if isinstance(skills_list, list) else str(skills_list)
                match_profile = {
                    "positions": profile.get('jobType') or "",
                    "skills": skills_str,
                    "location": profile.get('location') or ""
                }
            else:
                print(f"[DASHBOARD] ⚠️ No profile found for user {user_id} or email {email}")

            for job in featured_jobs:
                if match_profile:
                    try:
                        title_score = title_position_match(job.get('job_title', ''), match_profile['positions'])
                        skill_score = calculate_skills_match(job.get('job_description') or job.get('job_title', ''), match_profile['skills'])
                        location_score = semantic_location_match(job.get('vacancy_city', ''), match_profile['location'])

                        final_score = round((0.4 * title_score + 0.4 * skill_score + 0.2 * location_score), 3)
                        job['match_percentage'] = str(int(round(final_score * 100, 0)))
                        print(f"[DASHBOARD] Job {job.get('id')}: {job.get('job_title')} => {job['match_percentage']}% (T:{title_score:.3f}, S:{skill_score:.3f}, L:{location_score:.3f})")
                    except Exception as e:
                        print(f"[DASHBOARD] Match calc error for job {job.get('id')}: {e}")
                        job['match_percentage'] = None  # Return null on error
                else:
                    # No profile available - return null instead of '0'
                    job['match_percentage'] = None

                # Delete description after calculation to keep response slim
                if 'job_description' in job:
                    del job['job_description']
                    
        except Exception as e:
            print(f"[DASHBOARD] Featured jobs error: {e}")
            featured_jobs = []

        return {
            "user": {
                "name": user.get('name', 'User') if user else 'User',
                "jobCount": user.get('jobCount', 0) if user else 0,
                "aiJobApplyCount": user.get('aiJobApplyCount', 0) if user else 0,
                "jobType": profile.get('jobType') if profile else None
            },
            "stats": {
                "totalMatches": total_matches,
                "avgMarketSalary": avg_salary,
                "totalApplications": total_apps,
                "inReview": _count(['pending', 'IN_REVIEW']),
                "interviews": _count(['interview', 'INTERVIEW']),
                "offers": _count(['offer', 'OFFER']),
                "rejected": _count(['rejected', 'REJECTED'])
            },
            "featuredJobs": featured_jobs or []
        }, HTTPStatus.OK


@home_ns.route('/trending')
class Trending(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get trending data"""
        try:
            # 1. Fetch top trending skills for the banner
            trending_skills = execute_query(
                """SELECT LOWER(TRIM(skill)) as skill, COUNT(*) as count 
                   FROM (SELECT unnest("requiredSkills") as skill FROM "Job" WHERE status = 'ACTIVE') s 
                   GROUP BY skill ORDER BY count DESC LIMIT 3""",
                fetch_all=True
            )
            top_skills = [s['skill'] for s in trending_skills] if trending_skills else []
            
            # 2. Fetch trending jobs (most viewed)
            jobs = execute_query(
                """SELECT id, title, company, "companyLogo", "jobType",
                          "salaryMin", "salaryMax", location, "views"
                   FROM "Job"
                   WHERE status = 'ACTIVE'
                   ORDER BY "views" DESC, "createdAt" DESC
                   LIMIT 10""",
                fetch_all=True
            )
            
            # 3. Construct the trending summary for the banner
            trending_text = ""
            if top_skills:
                skills_str = " & ".join([s.capitalize() for s in top_skills[:2]])
                trending_text = f"{skills_str} roles are seeing increased demand this week."

            return {
                "trending": jobs or [],
                "trendingText": trending_text,
                "growthPercentage": 15,  # Estimated or static for now
                "topSkills": top_skills,
                "seeOpportunitiesLink": "/jobs"
            }, HTTPStatus.OK
        except Exception as e:
            print(f"[TRENDING] Error: {e}")
            return {
                "trending": [],
                "trendingText": "",
                "growthPercentage": 0,
                "topSkills": [],
                "seeOpportunitiesLink": "/jobs"
            }, HTTPStatus.OK


@home_ns.route('/recommendations')
class Recommendations(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get job recommendations sorted by AI match percentage"""
        user_id = request.user_id
        try:
            # 1. Get user profile for matching
            profile = execute_query(
                '''SELECT cp."jobType", cp.skills, cp.location FROM "Candidate" c
                   JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE c."userId" = %s''',
                (user_id,), fetch_one=True
            )
            
            # 2. Fetch jobs
            jobs = execute_query(
                """SELECT id, title as job_title, company as entity, "companyLogo", "jobType" as job_type,
                          "salaryMin"::text as salary, location as vacancy_city, description as job_description
                   FROM "Job"
                   WHERE status = 'ACTIVE'
                   ORDER BY "createdAt" DESC LIMIT 15""",
                fetch_all=True
            )
            
            # 3. Apply AI matching logic to each job
            match_profile = None
            if profile:
                skills_list = profile.get('skills') or []
                skills_str = ", ".join(skills_list) if isinstance(skills_list, list) else str(skills_list)
                match_profile = {
                    "positions": profile.get('jobType') or "",
                    "skills": skills_str,
                    "location": profile.get('location') or ""
                }

            if jobs:
                for job in jobs:
                    if match_profile:
                        try:
                            title_score = title_position_match(job.get('job_title', ''), match_profile['positions'] or "")
                            skill_score = calculate_skills_match(job.get('job_description') or job.get('job_title', ''), match_profile['skills'] or "")
                            location_score = semantic_location_match(job.get('vacancy_city', ''), match_profile['location'] or "")
                            
                            final_score = round((0.4 * title_score + 0.4 * skill_score + 0.2 * location_score), 3)
                            job['match_percentage'] = str(int(round(final_score * 100, 0)))
                        except Exception as e:
                            print(f"[RECO] Match calc error: {e}")
                            job['match_percentage'] = '0'
                    else:
                        job['match_percentage'] = '0'
                    
                    # Cleanup
                    if 'job_description' in job:
                        del job['job_description']
                
                # Re-sort by match percentage
                jobs.sort(key=lambda x: int(x.get('match_percentage', 0)), reverse=True)
            
            return {"recommendations": jobs or []}, HTTPStatus.OK
        except Exception as e:
            print(f"[RECOMMENDATIONS] Error: {e}")
            return {"recommendations": []}, HTTPStatus.OK


@home_ns.route('/analytics')
class Analytics(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get analytics data"""
        user_id = request.user_id

        # 1. Application Status Chart
        try:
            apps = execute_query(
                'SELECT status, COUNT(*) as count FROM "JobApplication" WHERE "userId" = %s GROUP BY status',
                (user_id,), fetch_all=True
            )
        except Exception:
            apps = []

        def _count(status_list):
            if not apps:
                return 0
            return sum(r['count'] for r in apps if r['status'].upper() in [s.upper() for s in status_list])

        # 2. Match Score Distribution
        match_distribution = [
            {"range": "90-100%", "count": 0},
            {"range": "80-89%", "count": 0},
            {"range": "70-79%", "count": 0},
        ]
        try:
            profile = execute_query(
                '''SELECT cp.skills FROM "Candidate" c
                   JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE c."userId" = %s''',
                (user_id,), fetch_one=True
            )
            user_skills = profile.get('skills') if profile else []
            
            if user_skills:
                # Get match percentage for the 30 most recent ACTIVE jobs (limited for performance)
                recent_jobs = execute_query(
                    '''SELECT title, description, "requiredSkills", location FROM "Job" 
                       WHERE status = 'ACTIVE' 
                       ORDER BY "createdAt" DESC LIMIT 30''',
                    fetch_all=True
                )
                
                skills_list = profile.get('skills') or []
                skills_str = ", ".join(skills_list) if isinstance(skills_list, list) else str(skills_list)
                m_profile = {
                    "positions": profile.get('jobType') or "",
                    "skills": skills_str,
                    "location": profile.get('location') or ""
                }
                
                for job in recent_jobs:
                    try:
                        title_score = title_position_match(job.get('title', ''), m_profile['positions'])
                        skill_score = calculate_skills_match(job.get('description') or job.get('title', ''), m_profile['skills'])
                        location_score = semantic_location_match(job.get('location', ''), m_profile['location'])
                        
                        percentage = (0.4 * title_score + 0.4 * skill_score + 0.2 * location_score) * 100
                        
                        if percentage >= 90:
                            match_distribution[0]["count"] += 1
                        elif percentage >= 80:
                            match_distribution[1]["count"] += 1
                        elif percentage >= 70:
                            match_distribution[2]["count"] += 1
                    except Exception:
                        continue
        except Exception as e:
            print(f"[ANALYTICS] Match Score error: {e}")

        # 3. Monthly Applications
        try:
            monthly_apps = execute_query(
                '''SELECT to_char("appliedAt", 'Mon') as month, COUNT(*) as count 
                   FROM "JobApplication" 
                   WHERE "userId" = %s AND "appliedAt" > NOW() - INTERVAL '6 months' 
                   GROUP BY month, date_trunc('month', "appliedAt")
                   ORDER BY date_trunc('month', "appliedAt")''',
                (user_id,), fetch_all=True
            )
        except Exception as e:
            print(f"[ANALYTICS] Monthly Apps error: {e}")
            monthly_apps = []

        # 4. Skills Demand
        try:
            skills_demand = execute_query(
                '''SELECT LOWER(TRIM(skill)) as skill, COUNT(*) as demand 
                   FROM (SELECT unnest("requiredSkills") as skill FROM "Job" WHERE status = 'ACTIVE') s 
                   GROUP BY skill ORDER BY demand DESC LIMIT 5''',
                fetch_all=True
            )
        except Exception as e:
            print(f"[ANALYTICS] Skills Demand error: {e}")
            skills_demand = []

        return {
            "applicationStatusChart": [
                {"name": "In Review", "value": _count(['pending', 'IN_REVIEW']), "color": "#FFA500"},
                {"name": "Interview", "value": _count(['interview', 'INTERVIEW']), "color": "#0D56E1"},
                {"name": "Offer", "value": _count(['offer', 'OFFER']), "color": "#34D399"},
                {"name": "Rejected", "value": _count(['rejected', 'REJECTED']), "color": "#EF4444"},
            ],
            "matchScoreDistribution": match_distribution,
            "monthlyApplications": monthly_apps or [],
            "skillsDemand": skills_demand or []
        }, HTTPStatus.OK


@home_ns.route('/market-insights')
class MarketInsights(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get market insights for the user"""
        try:
            user_id = request.user_id

            user = execute_query(
                """SELECT cp."jobType", cp.skills, cp.location
                   FROM "Candidate" c
                   LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE c."userId" = %s""",
                (user_id,),
                fetch_one=True
            )

            total_jobs = execute_query(
                "SELECT COUNT(*) as count FROM \"Job\" WHERE status = 'ACTIVE'",
                fetch_one=True
            )

            recent_jobs = execute_query(
                "SELECT COUNT(*) as count FROM \"Job\" WHERE status = 'ACTIVE' AND \"createdAt\" > NOW() - INTERVAL '7 days'",
                fetch_one=True
            )

            top_locations = execute_query(
                """SELECT location, COUNT(*) as count 
                   FROM "Job" 
                   WHERE status = 'ACTIVE' AND location IS NOT NULL
                   GROUP BY location ORDER BY count DESC LIMIT 5""",
                fetch_all=True
            )

            job_types = execute_query(
                """SELECT "jobType", COUNT(*) as count
                   FROM "Job"
                   WHERE status = 'ACTIVE' AND "jobType" IS NOT NULL
                   GROUP BY "jobType"
                   ORDER BY count DESC""",
                fetch_all=True
            )

            total_applications = execute_query(
                "SELECT COUNT(*) as count FROM \"JobApplication\"",
                fetch_one=True
            )

            avg_applications = 0
            if total_jobs and total_jobs.get('count', 0) > 0:
                total_apps = total_applications.get('count', 0) if total_applications else 0
                avg_applications = round(total_apps / total_jobs.get('count', 1), 1)

            trending_skills = execute_query(
                """SELECT LOWER(TRIM(skill)) as skill, COUNT(*) as count 
                   FROM (SELECT unnest("requiredSkills") as skill FROM "Job" WHERE status = 'ACTIVE') s 
                   GROUP BY skill ORDER BY count DESC LIMIT 10""",
                fetch_all=True
            )

            return {
                "totalJobs": total_jobs.get('count', 0) if total_jobs else 0,
                "newJobsThisWeek": recent_jobs.get('count', 0) if recent_jobs else 0,
                "averageApplicationsPerJob": avg_applications,
                "totalApplications": total_applications.get('count', 0) if total_applications else 0,
                "trendingSkills": trending_skills,
                "topLocations": top_locations or [],
                "jobTypes": job_types or [],
                "userPreferences": {
                    "jobType": user.get('jobType') if user else None,
                    "skills": user.get('skills') or [] if user else [],
                    "location": user.get('location') if user else None
                }
            }, HTTPStatus.OK
        except Exception as e:
            return {
                "totalJobs": 0,
                "newJobsThisWeek": 0,
                "averageApplicationsPerJob": 0,
                "totalApplications": 0,
                "trendingSkills": [],
                "topLocations": [],
                "jobTypes": [],
                "userPreferences": {}
            }, HTTPStatus.OK


@home_ns.route('/notifications/count')
class NotificationCount(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get unread notification count"""
        user_id = request.user_id
        try:
            result = execute_query(
                'SELECT COUNT(*) as count FROM "Notification" WHERE "userId" = %s AND "isRead" = False',
                (user_id,), fetch_one=True
            )
            return {"count": result.get('count', 0) if result else 0}, HTTPStatus.OK
        except Exception as e:
            print(f"[NOTIFICATIONS] Count error: {e}")
            return {"count": 0}, HTTPStatus.OK


@home_ns.route('/ai-job-apply/config')
class AIJobApplyConfig(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get AI job apply configuration for the user"""
        user_id = request.user_id

        user = execute_query(
            """SELECT "aiJobApplyCount", "jobCount"
               FROM users
               WHERE id = %s""",
            (user_id,),
            fetch_one=True
        )

        config = {
            "autoApplyEnabled": False,
            "dailyApplicationLimit": 10,
            "keywords": [],
            "jobTypes": ["Full-time", "Part-time", "Contract"],
            "locations": [],
            "salaryRange": {"min": 0, "max": 200000},
            "experienceLevels": ["Entry", "Mid", "Senior"],
            "jobsAppliedCount": user.get('aiJobApplyCount', 0) if user else 0,
            "totalJobsPosted": user.get('jobCount', 0) if user else 0
        }

        return config, HTTPStatus.OK
