# Resume API - Quick Reference Card

## 🚀 Quick Start

```bash
# 1. Start the server
cd tabashir-web && pnpm dev

# 2. Get JWT token (login first)
# Use existing auth endpoint or mobile app

# 3. Test endpoints
./test-resume-api.sh YOUR_JWT_TOKEN
```

---

## 📋 All Endpoints (9 Total)

### CRUD Operations
```bash
# List all resumes
GET /api/mobile/resumes

# Upload resume
POST /api/mobile/resumes
Body: multipart/form-data with 'file' field

# Get resume
GET /api/mobile/resumes/{id}

# Update resume
PUT /api/mobile/resumes/{id}
Body: multipart/form-data with 'file' field

# Delete resume
DELETE /api/mobile/resumes/{id}
```

### Enhanced Features
```bash
# Duplicate
POST /api/mobile/resumes/{id}/duplicate

# Export PDF
POST /api/mobile/resumes/{id}/export/pdf

# Export Word
POST /api/mobile/resumes/{id}/export/word

# Translate
POST /api/mobile/resumes/{id}/translate
Body: {"targetLanguage": "ar"}
```

---

## 🔑 Authentication

All requests require:
```
Authorization: Bearer YOUR_JWT_TOKEN
```

---

## 🌍 Supported Languages

`ar` `en` `es` `fr` `de` `it` `pt` `ru` `zh` `ja` `ko`

---

## ⚙️ Environment Variables

```env
JWT_ACCESS_SECRET=xxx
JWT_REFRESH_SECRET=xxx
DATABASE_URL=xxx
UPLOADTHING_SECRET=xxx
UPLOADTHING_APP_ID=xxx
OPENAI_API_KEY=xxx  # For translation
```

---

## 📦 Dependencies

```bash
pnpm add docx  # Already installed
```

---

## 🧪 Quick Test

```bash
# Test auth
curl http://localhost:3000/api/mobile/test \
  -H "Authorization: Bearer TOKEN"

# List resumes
curl http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer TOKEN"
```

---

## 📁 Files Created

```
app/api/mobile/resumes/
├── route.ts                           # List, Upload
├── [id]/
│   ├── route.ts                       # Get, Update, Delete
│   ├── duplicate/route.ts             # Duplicate
│   ├── export/
│   │   ├── pdf/route.ts              # Export PDF
│   │   └── word/route.ts             # Export Word
│   └── translate/route.ts            # Translate

app/utils/jwt.ts                       # JWT utilities
lib/mobile-auth.ts                     # Auth middleware
```

---

## ✅ Status

- Phase 1: ✅ Complete (5 endpoints)
- Phase 2: ✅ Complete (4 endpoints)
- Total: ✅ 9 endpoints ready

---

## 🐛 Common Issues

**401 Unauthorized**
- Check JWT token is valid
- Verify JWT_ACCESS_SECRET is set

**404 Not Found**
- Resume doesn't exist
- User doesn't own the resume

**400 Bad Request (Word/Translate)**
- Resume needs `formatedContent`
- Check OPENAI_API_KEY for translation

---

## 📱 Mobile Integration

```dart
// In ResumeRepositoryImpl
final response = await _apiClient.get('/mobile/resumes');
final response = await _apiClient.post('/mobile/resumes', data: formData);
final response = await _apiClient.post('/mobile/resumes/$id/duplicate');
final response = await _apiClient.post('/mobile/resumes/$id/translate', 
  data: {'targetLanguage': 'ar'});
```

---

**Ready to test! 🎉**
