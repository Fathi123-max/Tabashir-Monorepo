# Backend Quick Reference Card

## 🔗 URLs

| Backend | Development | Production |
|---------|-------------|------------|
| **Main Backend** | `http://localhost:3000` | `https://app.tabashir.ae` |
| **Resume Backend** | `http://localhost:8000` (?) | `https://backend.tabashir.ae` |

---

## 🔑 API Tokens

**API Token:** `a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5`

**Usage:**
- Header: `X-API-TOKEN: <token>`
- Used for: Resume backend authentication

---

## 📱 Mobile App Configuration

### Current Settings (UPDATED ✅)

**AuthDioClient:**
```dart
baseUrl: 'https://app.tabashir.ae/api'
// For local: 'http://localhost:3000/api'
```

**BackendDioClient:**
```dart
baseUrl: 'https://backend.tabashir.ae/api/v1/resume'
// For local: 'http://localhost:8000/api/v1/resume'
```

---

## 🌐 Web App Configuration

### Environment Variables (UPDATED ✅)

```env
NEXT_PUBLIC_BACKEND_URL="https://backend.tabashir.ae"
NEXT_PUBLIC_API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"
```

---

## 🧪 Quick Tests

### Test Main Backend
```bash
curl http://localhost:3000/api/mobile/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}'
```

### Test Resume Backend
```bash
curl https://backend.tabashir.ae/api/v1/resume/jobs \
  -H "X-API-TOKEN: a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"
```

---

## ⚠️ Important Questions

1. **Is `backend.tabashir.ae` accessible?**
   - [ ] Yes, it's deployed
   - [ ] No, need to deploy
   - [ ] Running locally

2. **Do you have the resume backend source code?**
   - [ ] Yes
   - [ ] No
   - [ ] It's a third-party service

3. **What technology is the resume backend?**
   - [ ] Python/FastAPI
   - [ ] Node.js/Express
   - [ ] Other: ___________

---

## 🚀 Start Commands

```bash
# Main Backend
cd tabashir-web && pnpm dev

# Mobile App
cd tabashir-mobile && flutter run

# Resume Backend (if local)
# cd path/to/resume-backend && [start command]
```
