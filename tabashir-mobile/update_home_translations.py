import json
import os

def update_json(file_path, entries):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    data.update(entries)
    
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

en_entries = {
    "loading_profile": "Loading your profile...",
    "your_stats": "Your Stats",
    "jobs_by_location": "Jobs by Location",
    "matched_for_you": "Matched For You",
    "see_all": "See All",
    "my_applications": "My Applications",
    "welcome_back_subtitle": "Welcome back! Ready to find your dream job?",
    "premium_member": "Premium Member",
    "ai_job_apply_pro": "AI Job Apply: Pro Plan",
    "ai_job_apply": "AI Job Apply",
    "applies_left_alert": "Only {count} left!",
    "low_applies_warning": "Running low on applies",
    "applies_remaining": "{count} applies remaining",
    "unlimited_plan": "Unlimited plan",
    "free_plan_10": "Free plan (10 applies)",
    "no_applies_left": "No AI Applies Remaining",
    "upgrade_to_continue": "Upgrade to continue using AI job apply",
    "upgrade_to_pro": "Upgrade to Pro",
    "no_applications_yet": "No Applications Yet",
    "start_applying_description": "Start applying to jobs to track your applications here",
    "browse_jobs": "Browse Jobs",
    "no_matched_jobs_yet": "No Matched Jobs Yet",
    "finding_matches_description": "We're finding the best jobs for you based on your profile",
    "all_matched_jobs": "All Matched Jobs",
    "no_matched_jobs_found": "No Matched Jobs Found",
    "no_matches_description": "We couldn't find any jobs matching your profile. Try updating your resume or profile to get better matches.",
    "tips": "Tips:",
    "tip_upload_resume": "• Upload an updated resume",
    "tip_complete_profile": "• Complete your profile details",
    "tip_preferred_locations": "• Specify your preferred locations",
    "tip_add_skills": "• Add relevant skills and experience"
}

ar_entries = {
    "loading_profile": "جاري تحميل ملفك الشخصي...",
    "your_stats": "إحصائياتك",
    "jobs_by_location": "وظائف حسب الموقع",
    "matched_for_you": "وظائف تناسبك",
    "see_all": "عرض الكل",
    "my_applications": "طلباتي",
    "welcome_back_subtitle": "مرحباً بعودتك! هل أنت مستعد لإيجاد وظيفة أحلامك؟",
    "premium_member": "عضو مميز",
    "ai_job_apply_pro": "التقديم التلقائي: الخطة المميزة",
    "ai_job_apply": "التقديم التلقائي",
    "applies_left_alert": "بقي {count} فقط!",
    "low_applies_warning": "أوشكت فرص التقديم على الانتهاء",
    "applies_remaining": "بقي {count} فرص تقديم",
    "unlimited_plan": "خطة غير محدودة",
    "free_plan_10": "الخطة المجانية (10 تقديمات)",
    "no_applies_left": "لم يتبقى فرص تقديم تلقائي",
    "upgrade_to_continue": "قم بالترقية لمواصلة استخدام التقديم التلقائي",
    "upgrade_to_pro": "الترقية للمميز",
    "no_applications_yet": "لا توجد طلبات بعد",
    "start_applying_description": "ابدأ في التقديم على الوظائف لتتبع طلباتك هنا",
    "browse_jobs": "تصفح الوظائف",
    "no_matched_jobs_yet": "لا توجد وظائف متطابقة بعد",
    "finding_matches_description": "نحن نبحث عن أفضل الوظائف لك بناءً على ملفك الشخصي",
    "all_matched_jobs": "كل الوظائف المتطابقة",
    "no_matched_jobs_found": "لم يتم العثور على وظائف متطابقة",
    "no_matches_description": "لم نتمكن من العثور على أي وظائف تطابق ملفك الشخصي. جرب تحديث سيرتك الذاتية أو ملفك الشخصي للحصول على نتائج أفضل.",
    "tips": "نصائح:",
    "tip_upload_resume": "• ارفع سيرة ذاتية محدثة",
    "tip_complete_profile": "• أكمل تفاصيل ملفك الشخصي",
    "tip_preferred_locations": "• حدد مواقعك المفضلة",
    "tip_add_skills": "• أضف مهارات وخبرات ذات صلة"
}

update_json('tabashir-mobile/assets/translations/en.json', en_entries)
update_json('tabashir-mobile/assets/translations/ar.json', ar_entries)
print("Successfully updated translations.")
