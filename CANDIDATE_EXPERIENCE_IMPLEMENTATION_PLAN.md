# Tabashir Candidate Experience Implementation Plan

## Executive Summary

This plan focuses on completing the Candidate experience for the Tabashir HR platform. Based on exploration, the web UI is ~90% complete, mobile UI is ~80% complete with 9 placeholder screens, and critical backend APIs are missing. The goal is to make the app fully functional for Candidates.

**Current State:**
- ✅ Web UI: 90% complete (Admin/Recruiter UIs fully implemented)
- ✅ Mobile UI: 80% complete
- ✅ Services page with payment integration
- ❌ 9 placeholder screens in mobile router
- ❌ Interview Training: "COMING SOON" placeholder
- ❌ Critical backend gaps: Job Apply endpoint missing, Admin APIs (0%), Recruiter APIs (0%)

**Target:** Production-ready Candidate experience with complete job search → apply → track flow

---

## Phase 1: Critical Backend APIs (Days 1-3)

### Priority 1: Job Application System

**Why First:** The job application flow is the core candidate journey and is currently broken.

#### 1.1 Implement Job Apply API Endpoint
**File:** `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/jobs/[jobId]/apply/route.ts`

```typescript
// Required for candidate job applications
// Handles both regular and AI-powered applications
// Updates JobApplication table in database
```

**Implementation Steps:**
1. Create POST route handler
2. Validate JWT token
3. Create JobApplication record
4. Update job applicationsCount
5. Return application details

**Estimated Effort:** 0.5 day

#### 1.2 Implement Job Application Status API
**File:** `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/job-applications/route.ts`

```typescript
// GET - List all user applications with filters
// PATCH - Update application status (for admin/recruiter)
```

**Implementation Steps:**
1. GET /api/mobile/job-applications - List user's applications
2. GET /api/mobile/job-applications/[id] - Get specific application
3. PATCH /api/mobile/job-applications/[id] - Update status

**Estimated Effort:** 1 day

#### 1.3 Job Search & Details APIs
**File:** `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/jobs/route.ts`

```typescript
// GET - Search jobs with filters (location, role, salary, etc.)
// Query params: ?search=&location=&jobType=&minSalary=&maxSalary=&page=&limit=
```

**Implementation Steps:**
1. Implement search with filters
2. Add pagination
3. Add sorting (relevance, date, salary)
4. Return job details with match score

**Estimated Effort:** 1 day

#### 1.4 Job Details API
**File:** `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/jobs/[jobId]/route.ts`

```typescript
// GET - Get detailed job information
// POST - Save/unsave job
```

**Implementation Steps:**
1. GET /api/mobile/jobs/[jobId] - Get job details
2. POST /api/mobile/jobs/[jobId]/save - Save job
3. POST /api/mobile/jobs/[jobId]/unsave - Remove saved job

**Estimated Effort:** 0.5 day

### Priority 2: AI Resume Builder APIs

#### 2.1 AI Resume Generation API
**File:** `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/ai-resume/route.ts`

```typescript
// POST - Generate AI resume from user data
// GET - List user's AI resumes
// GET /[id] - Get specific AI resume
```

**Implementation Steps:**
1. Create AI resume generation endpoint
2. Integrate with OpenAI API
3. Store in AiResume table
4. Generate PDF/Word formats

**Estimated Effort:** 1 day

#### 2.2 AI Resume Enhancement API
**File:** `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/ai-resume/[id]/enhance/route.ts`

```typescript
// POST - Enhance existing resume with AI
// Enhances summary, skills, experience descriptions
```

**Implementation Steps:**
1. Upload resume parsing
2. AI enhancement logic
3. Save enhanced version

**Estimated Effort:** 0.5 day

### Priority 3: Subscription & Payment APIs

#### 3.1 Subscription Management API
**File:** `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/subscriptions/route.ts`

```typescript
// GET - Get user's subscription status
// POST - Create new subscription
// PATCH - Update subscription
// DELETE - Cancel subscription
```

**Implementation Steps:**
1. Implement subscription CRUD
2. Integrate with Stripe
3. Handle payment webhooks
4. Track usage limits

**Estimated Effort:** 1 day

---

## Phase 2: Mobile UI Completion (Days 4-8)

### Priority 1: Complete Placeholder Screens (9 screens)

#### 2.1 Forgot Password Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/auth/presentation/screens/forgot_password_screen.dart`

**Components:**
- Email input field
- Reset password button
- Success/error states
- Navigation to login

**UI Elements:**
- Email validation
- Loading state
- Confirmation message

**Estimated Effort:** 0.5 day

#### 2.2 Company Profile Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/company/presentation/screens/company_profile_screen.dart`

**Components:**
- Company information display
- Company jobs list
- About section
- Contact information

**UI Elements:**
- Company logo
- Job listings grid
- Map integration (optional)

**Estimated Effort:** 0.5 day

#### 2.3 AI Resume Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/ai_resume/presentation/screens/ai_resume_screen.dart`

**Components:**
- List of AI-generated resumes
- Create new AI resume button
- Resume preview
- Actions (edit, download, share)

**Estimated Effort:** 0.5 day

#### 2.4 Subscriptions Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/subscription/presentation/screens/subscriptions_screen.dart`

**Components:**
- Current subscription status
- Plan features list
- Upgrade/downgrade options
- Payment history

**Estimated Effort:** 1 day

#### 2.5 Payment Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/payments/presentation/screens/payment_screen.dart`

**Components:**
- Payment method selection
- Amount display
- Stripe payment form
- Success/failure handling

**UI Elements:**
- Card input form
- Loading states
- Error handling

**Estimated Effort:** 0.5 day

#### 2.6 Search Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/search/presentation/screens/search_screen.dart`

**Components:**
- Search bar
- Filter options (location, job type, salary)
- Results list
- Saved searches

**UI Elements:**
- Filter chips
- Sort options
- Pagination

**Estimated Effort:** 1 day

#### 2.7 Messages Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/messages/presentation/screens/messages_screen.dart`

**Components:**
- Conversations list
- Message bubbles
- Typing indicator
- Send message input

**UI Elements:**
- Chat list
- Message bubbles
- Attachment support

**Estimated Effort:** 1 day

#### 2.8 Resume Vault Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/resume/presentation/screens/resume_vault_screen.dart`

**Components:**
- List of uploaded resumes
- Upload new button
- Resume actions (preview, download, delete)
- Version history

**Estimated Effort:** 0.5 day

#### 2.9 Error Page
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/ui/error_page.dart`

**Components:**
- Error illustration
- Error message
- Retry button
- Report issue option

**Estimated Effort:** 0.25 day

### Priority 2: Interview Training Feature

**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/interview_training/`

**Implementation Steps:**
1. Create feature directory structure
2. Implement InterviewTrainingCubit
3. Create interview training screens
4. Build practice questions UI
5. Implement video/voice recording
6. Add AI feedback system

**Screens:**
- Training categories selection
- Practice session screen
- Question & answer interface
- Results and feedback screen
- Progress tracking

**Estimated Effort:** 3 days

### Priority 3: Complete Job Application Flow

#### 3.1 Job Details Screen Enhancement
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/jobs/presentation/screens/job_details_screen.dart`

**Enhancements:**
- Apply button integration
- Company information
- Similar jobs suggestions
- Save job functionality

**Estimated Effort:** 0.5 day

#### 3.2 Application Tracking Screen
**File:** `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/job_applications/presentation/screens/application_details_screen.dart`

**Components:**
- Application status timeline
- Job details summary
- Interview scheduling (future)
- Communication history

**Estimated Effort:** 1 day

---

## Phase 3: Polish & Production Readiness (Days 9-10)

### Priority 1: Error Handling & Loading States

#### 3.1 Global Error Handler
**Files:**
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/error/global_error_handler.dart`
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/core/error/error_widgets.dart`

**Implement:**
- Global error boundaries
- User-friendly error messages
- Retry mechanisms
- Error reporting

**Estimated Effort:** 0.5 day

#### 3.2 Loading States
**Enhancements:**
- Skeleton screens for lists
- Shimmer effects for cards
- Progress indicators for uploads
- Pull-to-refresh

**Estimated Effort:** 0.5 day

### Priority 2: Responsive Design

#### 3.1 Mobile Responsive Adjustments
**Files:**
- All screen layouts
- Breakpoint configurations

**Adjust:**
- Safe area handling
- Keyboard behavior
- Orientation changes
- Tablet layout (if needed)

**Estimated Effort:** 0.5 day

### Priority 3: Accessibility

#### 3.1 Accessibility Features
**Implement:**
- Semantic labels
- Screen reader support
- Keyboard navigation
- High contrast mode
- Font size scaling

**Files:**
- All screen widgets
- Theme configuration

**Estimated Effort:** 1 day

### Priority 4: Performance Optimization

#### 3.1 Performance Improvements
**Optimize:**
- Image caching
- List virtualization
- Lazy loading
- Bundle size reduction
- Memory management

**Files:**
- Image widgets
- List components
- Cache configurations

**Estimated Effort:** 0.5 day

---

## Phase 4: Integration Testing (Days 11-12)

### Priority 1: API Integration Testing

#### 4.1 Job Application Flow
**Test Scenarios:**
1. User searches for jobs
2. Filters and sorts results
3. Views job details
4. Applies to job
5. Tracks application status
6. Receives application updates

**Files to Test:**
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/jobs/`
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/job_applications/`
- `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/jobs/`

**Estimated Effort:** 0.5 day

#### 4.2 AI Resume Builder Flow
**Test Scenarios:**
1. User creates new AI resume
2. Fills personal details
3. Adds experience and skills
4. Generates resume
5. Downloads in PDF/Word format
6. Shares resume

**Files to Test:**
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/ai_resume_builder/`
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/ai_resume/`
- `/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/ai-resume/`

**Estimated Effort:** 0.5 day

#### 4.3 Service Purchase Flow
**Test Scenarios:**
1. User browses services
2. Selects service (AI Job Apply, ATS CV, LinkedIn)
3. Views service details
4. Proceeds to payment
5. Completes payment
6. Accesses purchased service

**Files to Test:**
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/services/`
- `/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/payments/`
- `/Users/Apple/Documents/tabashir/tabashir-web/app/api/stripe/`

**Estimated Effort:** 0.5 day

### Priority 2: End-to-End Testing

#### 4.1 Complete Candidate Journey
**Test Scenarios:**
1. User onboarding (if applicable)
2. Profile setup
3. Resume upload
4. Job search
5. Job application
6. Application tracking
7. Service purchase
8. AI resume generation

**Estimated Effort:** 1 day

---

## Critical Files for Implementation

### Backend API Files (Critical)

1. **`/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/jobs/[jobId]/apply/route.ts`**
   - **Reason:** Core job application functionality - currently missing
   - **Impact:** Breaks candidate journey

2. **`/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/job-applications/route.ts`**
   - **Reason:** Application tracking - critical for candidate experience
   - **Impact:** Users can't track their applications

3. **`/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/jobs/route.ts`**
   - **Reason:** Job search functionality - must be robust and feature-complete
   - **Impact:** Core job discovery feature

4. **`/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/ai-resume/route.ts`**
   - **Reason:** AI resume generation - key differentiator feature
   - **Impact:** One of three paid services

5. **`/Users/Apple/Documents/tabashir/tabashir-web/app/api/mobile/subscriptions/route.ts`**
   - **Reason:** Subscription management - required for service access
   - **Impact:** Service purchase flow

### Mobile UI Files (Critical)

6. **`/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/auth/presentation/screens/forgot_password_screen.dart`**
   - **Reason:** Password recovery - essential auth feature
   - **Impact:** Users locked out without recovery

7. **`/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/search/presentation/screens/search_screen.dart`**
   - **Reason:** Job search - core candidate feature
   - **Impact:** Users can't find jobs efficiently

8. **`/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/messages/presentation/screens/messages_screen.dart`**
   - **Reason:** Communication - important for recruiter-candidate interaction
   - **Impact:** Limited engagement

9. **`/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/subscription/presentation/screens/subscriptions_screen.dart`**
   - **Reason:** Service management - users need to manage their purchases
   - **Impact:** Poor post-purchase experience

10. **`/Users/Apple/Documents/tabashir/tabashir-mobile/lib/features/interview_training/`**
    - **Reason:** Interview training - advertised service
    - **Impact:** Unmet customer expectations

---

## Dependencies & Sequencing

### Phase 1 Dependencies
```
Job Apply API → Job Applications API → Job Search API
     ↓
AI Resume APIs (can parallelize)
     ↓
Subscription APIs (depends on Stripe setup)
```

### Phase 2 Dependencies
```
Backend APIs → Mobile UI Screens
     ↓
Interview Training (can parallelize after core screens)
     ↓
Complete Job Flow (depends on APIs)
```

### Phase 3 Dependencies
```
All UI Complete → Polish & Testing
     ↓
Performance & Accessibility
```

---

## Test Strategy

### Backend API Testing

#### 1. Unit Tests
**Tools:** Jest, Next.js test utilities
**Coverage:**
- Route handlers
- Business logic
- Database operations
- Error handling

**Example Test Files:**
- `test/api/mobile/jobs/apply.test.ts`
- `test/api/mobile/job-applications.test.ts`

#### 2. Integration Tests
**Tools:** Supertest, Test database
**Coverage:**
- API endpoint workflows
- Database transactions
- Authentication flows

#### 3. Manual Testing
**Tools:** Postman, curl
**Test Scenarios:**
- JWT authentication
- Error responses
- Rate limiting
- Data validation

### Mobile App Testing

#### 1. Widget Tests
**Tools:** Flutter test
**Coverage:**
- UI components
- State management
- User interactions

**Example Test Files:**
- `test/features/jobs/jobs_screen_test.dart`
- `test/features/auth/login_screen_test.dart`

#### 2. Integration Tests
**Tools:** Flutter integration_test
**Coverage:**
- Complete user flows
- Screen navigation
- API integration

**Test Scenarios:**
- Job search and apply
- Resume generation
- Service purchase

#### 3. Manual Testing
**Tools:** Physical devices, simulators
**Test Scenarios:**
- All placeholder screens functionality
- Payment flow
- Offline behavior
- Performance on various devices

---

## Risk Assessment & Mitigation

### High Risk

1. **Job Apply API Complexity**
   - **Risk:** Integration with external job sources
   - **Mitigation:** Start with simple internal job database, add external sources later
   - **Contingency:** Mock external APIs initially

2. **AI Resume Generation Cost**
   - **Risk:** OpenAI API costs could be high
   - **Mitigation:** Implement usage limits, cache results
   - **Contingency:** Rate limiting, tiered access

3. **Stripe Payment Integration**
   - **Risk:** Payment failures or security issues
   - **Mitigation:** Follow Stripe best practices, extensive testing
   - **Contingency:** Test mode with extensive validation

### Medium Risk

1. **Interview Training AI Feedback**
   - **Risk:** AI quality may not meet expectations
   - **Mitigation:** Start with rule-based feedback, improve AI over time
   - **Contingency:** Human review option

2. **Performance with Large Job Lists**
   - **Risk:** Slow performance on mobile
   - **Mitigation:** Pagination, caching, lazy loading
   - **Contingency:** Virtual scrolling, reduced data

### Low Risk

1. **UI Polish**
   - **Risk:** Minor bugs or inconsistencies
   - **Mitigation:** Regular testing, design review
   - **Contingency:** Hot fixes post-launch

---

## Resource Requirements

### Development Team

1. **Backend Developer (1)**
   - Focus: APIs, database, integrations
   - Timeline: Days 1-8 (full-time)

2. **Mobile Developer (1)**
   - Focus: UI screens, state management, integration
   - Timeline: Days 4-12 (full-time)

3. **QA Engineer (0.5)**
   - Focus: Testing, bug reports, validation
   - Timeline: Days 8-12 (part-time)

4. **DevOps (0.25)**
   - Focus: Deployment, monitoring, CI/CD
   - Timeline: Days 9-12 (part-time)

### External Services

1. **OpenAI API** - For AI features
2. **Stripe** - For payments
3. **UploadThing** - For file uploads
4. **Database hosting** - PostgreSQL

---

## Success Metrics

### Technical Metrics

1. **API Response Times**
   - Job search: < 500ms
   - Job apply: < 1s
   - AI resume generation: < 10s

2. **Mobile App Performance**
   - App startup: < 2s
   - Screen navigation: < 300ms
   - Memory usage: < 150MB

3. **Test Coverage**
   - Backend: > 80%
   - Mobile: > 70%

### Business Metrics

1. **User Flow Completion**
   - Job search to apply: > 60%
   - Service purchase: > 15%
   - AI resume generation: > 20%

2. **Error Rates**
   - API errors: < 1%
   - App crashes: < 0.1%
   - Payment failures: < 2%

---

## Post-Launch Roadmap

### Week 1-2 Post-Launch
- Monitor error rates
- Collect user feedback
- Fix critical bugs
- Performance optimization

### Month 1
- Admin panel completion (for recruiters/admins)
- Enhanced analytics
- Push notifications
- Social login options

### Month 2-3
- Interview scheduling
- Video interview integration
- Advanced AI matching
- Multi-language support (Arabic)

---

## Conclusion

This implementation plan focuses on completing the Candidate experience with a clear 12-day timeline. The plan prioritizes critical backend APIs first, followed by UI completion, then polish and testing.

**Key Success Factors:**
1. Complete job application flow first (highest impact)
2. Implement all 9 placeholder screens
3. Build Interview Training feature
4. Comprehensive testing before launch

**Expected Outcome:**
A production-ready Tabashir app where Candidates can:
- Search and find relevant jobs
- Apply to positions easily
- Track application status
- Generate AI-enhanced resumes
- Purchase and use career services
- Prepare for interviews

The plan is aggressive but achievable with the right resources and focus on the Candidate experience.
