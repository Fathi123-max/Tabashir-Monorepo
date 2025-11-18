# Technology Stack

## Web Application (tabashir-web)

### Core Stack
- **Framework**: Next.js 15.2.4 with App Router
- **Language**: TypeScript 5.8.3
- **Runtime**: Node.js (Latest LTS)
- **Package Manager**: pnpm
- **Database**: PostgreSQL with Prisma ORM 6.8.2
- **Authentication**: NextAuth.js 5.0.0-beta.28

### Key Libraries
- **UI**: Radix UI primitives, shadcn/ui components, Tailwind CSS 3.4.17
- **Forms**: React Hook Form with Zod validation
- **State**: Zustand
- **Rich Text**: TipTap 2.12.0
- **Payments**: Stripe 18.1.0
- **File Upload**: UploadThing 7.7.2
- **PDF Processing**: pdf-lib, pdf-parse, pdfmake
- **AI**: OpenAI 4.100.0
- **Email**: Nodemailer 7.0.3
- **i18n**: i18next 25.2.1

### Common Commands
```bash
# Development
pnpm dev                    # Start dev server (http://localhost:3000)
pnpm build                  # Build for production
pnpm start                  # Start production server
pnpm lint                   # Run ESLint

# Database
pnpm dlx prisma generate    # Generate Prisma client
pnpm dlx prisma db push     # Push schema changes
pnpm dlx prisma migrate dev # Create and run migrations
pnpm dlx prisma studio      # Open Prisma Studio GUI
```

## Mobile Application (tabashir-mobile)

### Core Stack
- **Framework**: Flutter 3.9.2+
- **Language**: Dart
- **State Management**: flutter_bloc 9.1.1 (BLoC/Cubit pattern)
- **Navigation**: go_router 12.1.3
- **DI**: get_it 8.2.0, injectable 2.3.2
- **Database**: Isar 3.1.0 (NoSQL)
- **Secure Storage**: flutter_secure_storage 9.2.2

### Key Libraries
- **HTTP**: dio 5.3.2, retrofit 4.0.1, pretty_dio_logger 1.4.0
- **UI**: flutter_screenutil 5.9.3, google_fonts 6.2.1, iconsax 0.0.8
- **Forms**: reactive_forms 18.0.0
- **Localization**: easy_localization 3.0.7
- **Firebase**: firebase_core, firebase_auth, firebase_messaging, firebase_crashlytics
- **Notifications**: flutter_local_notifications 19.5.0, onesignal_flutter 5.2.1
- **Social Auth**: google_sign_in 6.2.1, sign_in_with_apple 7.0.1
- **Payments**: flutter_stripe 12.1.0
- **Code Gen**: freezed 3.2.3, json_serializable 6.8.0, build_runner 2.10.0

### Common Commands
```bash
# Development
flutter pub get                                          # Install dependencies
flutter run                                              # Run app
flutter run -d <device>                                  # Run on specific device
dart run build_runner build --delete-conflicting-outputs # Generate code
flutter clean                                            # Clean build artifacts

# Code Quality
flutter analyze                                          # Static analysis
dart format .                                            # Format code
flutter test                                             # Run tests

# Build
flutter build apk                                        # Build Android APK
flutter build ios                                        # Build iOS
flutter build appbundle                                  # Build Android App Bundle
```

## External Services
- **AI**: OpenAI GPT-4o for resume optimization
- **Payments**: Stripe for payment processing
- **File Storage**: UploadThing for file uploads
- **Email**: SMTP (configurable) via Nodemailer
- **Push Notifications**: Firebase Cloud Messaging, OneSignal
- **Analytics**: Firebase Analytics
- **Crash Reporting**: Firebase Crashlytics
