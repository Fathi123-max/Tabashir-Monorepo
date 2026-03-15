# Tabashir Mobile - QWEN Context

## Project Overview

**Tabashir Mobile** is a Flutter application for iOS and Android providing candidates with job search, AI resume building, and application tracking on-the-go.

### Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.x |
| **Language** | Dart 3.9+ |
| **State Management** | BLoC / Cubit (`flutter_bloc`) |
| **Architecture** | Clean Architecture |
| **Navigation** | GoRouter 12.x |
| **Dependency Injection** | GetIt 8.x + Injectable 2.x |
| **Code Generation** | build_runner, freezed, json_serializable, retrofit |
| **Local Database** | Isar 3.x (NoSQL, offline-first) |
| **Networking** | Dio 5.x + retrofit_generator |
| **Storage** | flutter_secure_storage 9.x |
| **UI Utilities** | flutter_screenutil, google_fonts, cached_network_image, iconsax, shimmer |
| **Forms** | reactive_forms 18.x, dropdown_search 6.x |
| **File Handling** | file_picker, pdfx, flutter_pdf_text (local package) |
| **Localization** | easy_localization 3.x (EN, AR, ES) |
| **Notifications** | flutter_local_notifications, OneSignal, Firebase Messaging |
| **Firebase** | firebase_core, firebase_auth, firebase_analytics, firebase_crashlytics |
| **Social Sign-in** | google_sign_in, sign_in_with_apple |
| **Payments** | flutter_stripe 12.x |
| **Analytics** | fl_chart (charts), device_info_plus |
| **Linting** | very_good_analysis, bloc_lint |

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   Screens   │  │   Widgets   │  │   Cubits/Blocs      │  │
│  │  (UI Only)  │  │ (Reusable)  │  │  (State Management) │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
├─────────────────────────────────────────────────────────────┤
│                      Domain Layer                            │
│  ┌─────────────────────┐  ┌─────────────────────────────┐   │
│  │     Entities        │  │   Repository Interfaces     │   │
│  │  (Pure Dart Models) │  │      (Abstract Classes)     │   │
│  └─────────────────────┘  └─────────────────────────────┘   │
├─────────────────────────────────────────────────────────────┤
│                       Data Layer                             │
│  ┌─────────────────────┐  ┌─────────────────────────────┐   │
│  │   Repositories      │  │      Data Sources           │   │
│  │  (Implementation)   │  │  ┌──────────┐ ┌──────────┐  │   │
│  │                     │  │  │ API Client│ │ Isar DB  │  │   │
│  │                     │  │  │  (Dio)   │ │(Local DB)│  │   │
│  └─────────────────────┘  │  └──────────┘ └──────────┘  │   │
│                           └─────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### Prerequisites
- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Xcode (iOS) / Android Studio (Android)
- Firebase configuration files

### Installation

```bash
cd tabashir-mobile

# Install dependencies
flutter pub get

# Copy environment file
cp .env.example .env
# Edit .env with your API keys

# Run code generation (CRUCIAL - required after model/DI changes)
dart run build_runner build --delete-conflicting-outputs

# Run on device/emulator
flutter run
```

### Development

```bash
# Run with hot reload
flutter run

# Run on specific device
flutter run -d <device_id>

# Run on iOS simulator
flutter run -d ios

# Run on Android emulator
flutter run -d android

# Watch mode for code generation
dart run build_runner watch
```

### Code Quality

```bash
# Format code
dart format .

# Static analysis
flutter analyze

# Run tests
flutter test
flutter test test/file_test.dart

# Clean build cache (if builds fail)
flutter clean && flutter pub get
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## Project Structure

```
tabashir-mobile/
├── lib/
│   ├── main.dart                   # App entry point
│   │
│   ├── core/                       # Core infrastructure
│   │   ├── bootstrap/              # App initialization (AppBootstrap)
│   │   ├── config/                 # App configuration
│   │   ├── constants/              # Global constants
│   │   ├── database/               # Isar database setup
│   │   ├── di/                     # Dependency injection
│   │   │   ├── injection.dart      # GetIt setup
│   │   │   └── module.config.dart  # Injectable modules
│   │   ├── error/                  # Error handling
│   │   │   ├── exceptions.dart
│   │   │   └── failures.dart
│   │   ├── error_handler/          # Global error handler (BlocObserver)
│   │   ├── extensions/             # Dart extensions
│   │   ├── localization/           # easy_localization setup
│   │   │   └── l10n.dart
│   │   ├── mixins/                 # Shared mixins
│   │   ├── models/                 # Global models
│   │   ├── navigation/             # Navigation utilities
│   │   ├── network/                # HTTP client (Dio)
│   │   │   ├── api_client.dart
│   │   │   ├── interceptors/
│   │   │   └── endpoints.dart
│   │   ├── router/                 # GoRouter configuration
│   │   │   ├── app_router.dart
│   │   │   └── route_names.dart
│   │   ├── screens/                # Global screens
│   │   ├── services/               # Core services
│   │   │   ├── apple_signin_service.dart
│   │   │   ├── analytics_service.dart
│   │   │   ├── notification_service.dart
│   │   │   ├── file_service.dart
│   │   │   └── local_storage_service.dart
│   │   ├── theme/                  # App theme
│   │   │   ├── app_theme.dart
│   │   │   └── theme_manager.dart
│   │   ├── ui/                     # Shared UI components
│   │   │   ├── buttons/
│   │   │   ├── inputs/
│   │   │   ├── loaders/
│   │   │   └── cards/
│   │   └── utils/                  # Utility functions
│   │
│   ├── features/                   # Feature modules (Clean Architecture)
│   │   ├── auth/                   # Authentication
│   │   │   ├── data/
│   │   │   │   ├── datasources/    # API/Local data sources
│   │   │   │   ├── models/         # DTOs (freezed, json_serializable)
│   │   │   │   └── repositories/   # Repository implementations
│   │   │   ├── domain/
│   │   │   │   ├── entities/       # Business entities
│   │   │   │   └── repositories/   # Repository interfaces
│   │   │   ├── presentation/
│   │   │   │   ├── cubit/          # BLoC/Cubit state management
│   │   │   │   ├── screens/        # UI screens
│   │   │   │   └── widgets/        # Feature-specific widgets
│   │   │   └── services/           # Auth-specific services
│   │   │
│   │   ├── jobs/                   # Job search
│   │   ├── resume/                 # Resume management (resume_vault)
│   │   ├── ai_resume/              # AI resume builder
│   │   ├── ai_resume_builder/      # AI resume creation flow
│   │   ├── job_applications/       # Application tracking
│   │   ├── profile/                # User profile
│   │   ├── notifications/          # Push notifications
│   │   ├── payments/               # Stripe payments
│   │   ├── subscription/           # Subscription plans
│   │   ├── admin/                  # Admin features
│   │   ├── recruiter/              # Recruiter features
│   │   ├── candidate/              # Candidate features
│   │   ├── company/                # Company details
│   │   ├── home/                   # Home screen
│   │   ├── search/                 # Search functionality
│   │   ├── messages/               # Messaging
│   │   ├── settings/               # App settings
│   │   ├── upload/                 # File upload
│   │   └── onboarding/             # Onboarding flow
│   │
│   └── shared/                     # Shared components
│       ├── widgets/                # Reusable widgets
│       └── utils/                  # Shared utilities
│
├── packages/                       # Local packages
│   └── flutter_pdf_text/           # Custom PDF text extraction
│
├── assets/
│   ├── images/                     # Image assets
│   ├── translations/               # Localization files
│   │   ├── en.json
│   │   ├── ar.json
│   │   └── es.json
│   └── ...
│
├── schema/                         # Database schema
├── database/                       # Isar database files
│
├── android/                        # Android platform files
├── ios/                            # iOS platform files
├── web/                            # Web platform files
├── linux/                          # Linux platform files
├── macos/                          # macOS platform files
├── windows/                        # Windows platform files
│
├── test/                           # Test files
│   ├── features/
│   │   ├── auth/
│   │   ├── jobs/
│   │   └── ...
│   └── helpers/
│
├── pubspec.yaml                    # Dependencies
├── analysis_options.yaml           # Lint rules (very_good_analysis)
├── build.yaml                      # build_runner config
├── firebase.json                   # Firebase config
├── .env.example                    # Environment template
└── .gitignore
```

---

## Clean Architecture Implementation

### Layer Responsibilities

#### Presentation Layer
- **Screens**: UI-only widgets, no business logic
- **Widgets**: Reusable UI components
- **Cubits/Blocs**: State management using `flutter_bloc`

```dart
// features/auth/presentation/cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;

  AuthCubit(this._loginUseCase) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    final result = await _loginUseCase.execute(email, password);
    
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.success(user)),
    );
  }
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(User user) = _Success;
  const factory AuthState.error(String message) = _Error;
}
```

#### Domain Layer
- **Entities**: Pure Dart business objects (no Flutter dependencies)
- **Repository Interfaces**: Abstract classes defining contracts
- **Use Cases**: Single-responsibility business logic

```dart
// features/auth/domain/entities/user.dart
class User {
  final String id;
  final String email;
  final String? name;
  final UserType userType;

  const User({
    required this.id,
    required this.email,
    this.name,
    required this.userType,
  });
}

// features/auth/domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(RegisterParams params);
  Future<Either<Failure, void>> logout();
}

// features/auth/domain/usecases/login_usecase.dart
@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, User>> execute(String email, String password) async {
    return await _repository.login(email, password);
  }
}
```

#### Data Layer
- **Models**: DTOs with `freezed` and `json_serializable`
- **Repository Implementations**: Concrete implementations
- **Data Sources**: API calls (Dio) and local database (Isar)

```dart
// features/auth/data/models/user_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    required String userType,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        userType: user.userType.name,
      );

  User toEntity() => User(
        id: id,
        email: email,
        name: name,
        userType: UserType.values.firstWhere((e) => e.name == userType),
      );
}

// features/auth/data/repositories/auth_repository_impl.dart
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await _remoteDataSource.login(email, password);
      await _localDataSource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(DioFailure.fromDioError(e));
    }
  }
}
```

---

## Dependency Injection

### GetIt + Injectable Setup

```dart
// core/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:tabashir/core/di/module.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> initDependencies() async {
  await getIt.init();
}

// Usage in main.dart
void main() async {
  await AppBootstrap.initializeApp();
  await initDependencies();
  runApp(MyApp());
}
```

### Module Configuration

```dart
// core/di/module.config.dart
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {}
```

### Registering Dependencies

```dart
// In any data layer file
import 'package:injectable/injectable.dart';
import '../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  // Implementation
}

// In any cubit file
@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(LoginUseCase useCase) : super(const AuthState.initial());
}
```

---

## Navigation (GoRouter)

### Router Configuration

```dart
// core/router/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'route_names.dart';

@LazySingleton()
class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: RouteNames.splash,
      routes: [
        GoRoute(
          path: RouteNames.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: RouteNames.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RouteNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
        // Nested routes
        GoRoute(
          path: RouteNames.jobDetails,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final jobId = state.pathParameters['id']!;
            return JobDetailScreen(jobId: jobId);
          },
        ),
      ],
    );
  }
}

// core/router/route_names.dart
class RouteNames {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const jobs = '/jobs';
  static const jobDetails = '/jobs/:id';
  static const resume = '/resume';
  static const profile = '/profile';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const applications = '/applications';
  static const savedJobs = '/saved-jobs';
}
```

### Navigation Usage

```dart
// In a cubit or screen
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Navigate to a route
context.go(RouteNames.home);

// Navigate with parameters
context.go('/jobs/${job.id}');

// Push to stack
context.push(RouteNames.login);

// Replace current route
context.go(RouteNames.home);

// Pop
context.pop();

// Pop with result
context.pop(result);
```

---

## Networking (Dio)

### API Client Setup

```dart
// core/network/api_client.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

@LazySingleton()
class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3001/api/mobile',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(LoggingInterceptor());
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post<T>(path, data: data, queryParameters: queryParameters);
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
  }) async {
    return await dio.put<T>(path, data: data);
  }

  Future<Response<T>> delete<T>(String path) async {
    return await dio.delete<T>(path);
  }
}
```

### Auth Interceptor

```dart
// core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../../services/local_storage_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await LocalStorageService.instance.getAccessToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token refresh or logout
    }
    handler.next(err);
  }
}
```

### Retrofit for Type-Safe API Calls

```dart
// features/jobs/data/datasources/job_remote_datasource.dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/job_model.dart';

part 'job_remote_datasource.g.dart';

@RestApi(baseUrl: '/api/mobile/jobs')
abstract class JobRemoteDataSource {
  @factoryMethod
  factory JobRemoteDataSource(Dio dio) = _JobRemoteDataSource;

  @GET('/')
  Future<List<JobModel>> getJobs();

  @GET('/{id}')
  Future<JobModel> getJobById(@Path('id') String id);

  @POST('/')
  Future<JobModel> createJob(@Body() JobModel job);

  @POST('/apply')
  Future<void> applyToJob(@Body() ApplyJobRequest request);
}
```

---

## Local Database (Isar)

### Setup

```dart
// core/database/app_database.dart
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppDatabase {
  late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    
    isar = await Isar.open(
      [
        JobSchema,
        ResumeSchema,
        ApplicationSchema,
        UserSchema,
      ],
      directory: dir.path,
    );
  }

  void close() {
    isar.close();
  }
}
```

### Model Definition

```dart
// features/jobs/data/models/job_entity.dart
import 'package:isar/isar.dart';

part 'job_entity.g.dart';

@collection
class JobEntity {
  Id id = Isar.autoIncrement;
  
  @Index(type: IndexType.value)
  String jobId = '';
  
  String title = '';
  String company = '';
  String location = '';
  String? description;
  DateTime? postedAt;
  bool isSaved = false;
  bool isApplied = false;
}
```

### Repository with Isar

```dart
// features/jobs/data/repositories/job_repository_impl.dart
@LazySingleton(as: JobRepository)
class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource _remoteDataSource;
  final AppDatabase _database;

  JobRepositoryImpl(this._remoteDataSource, this._database);

  @override
  Future<Either<Failure, List<Job>>> getJobs() async {
    try {
      // Try cache first
      final cachedJobs = await _database.isar.jobEntities
          .filter()
          .isSavedEqualTo(true)
          .findAll();

      if (cachedJobs.isNotEmpty) {
        return Right(cachedJobs.map((e) => e.toEntity()).toList());
      }

      // Fetch from API
      final jobModels = await _remoteDataSource.getJobs();
      
      // Cache locally
      await _database.isar.writeTxn(() async {
        await _database.isar.jobEntities.putAll(jobModels);
      });

      return Right(jobModels.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(DioFailure.fromDioError(e));
    }
  }
}
```

---

## State Management (BLoC/Cubit)

### Cubit Pattern

```dart
// features/jobs/presentation/cubit/jobs_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/job.dart';
import '../../domain/usecases/get_jobs_use_case.dart';

part 'jobs_cubit.freezed.dart';

@injectable
class JobsCubit extends Cubit<JobsState> {
  final GetJobsUseCase _getJobsUseCase;

  JobsCubit(this._getJobsUseCase) : super(const JobsState.initial());

  Future<void> loadJobs() async {
    emit(const JobsState.loading());
    
    final result = await _getJobsUseCase.execute();
    
    result.fold(
      (failure) => emit(JobsState.error(failure.message)),
      (jobs) => emit(JobsState.success(jobs)),
    );
  }

  Future<void> saveJob(Job job) async {
    // Implementation
  }

  Future<void> applyToJob(Job job) async {
    // Implementation
  }
}

@freezed
class JobsState with _$JobsState {
  const factory JobsState.initial() = _Initial;
  const factory JobsState.loading() = _Loading;
  const factory JobsState.success(List<Job> jobs) = _Success;
  const factory JobsState.error(String message) = _Error;
}
```

### Usage in Screens

```dart
// features/jobs/presentation/screens/jobs_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabashir/core/di/injection.dart';
import '../cubit/jobs_cubit.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<JobsCubit>()..loadJobs(),
      child: BlocBuilder<JobsCubit, JobsState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(child: CircularProgressIndicator()),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            success: (state) => ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                return JobCard(job: job);
              },
            ),
            error: (state) => Center(child: Text(state.message)),
          );
        },
      ),
    );
  }
}
```

---

## Localization

### Setup

```dart
// main.dart
import 'package:easy_localization/easy_localization.dart';

void main() async {
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('es'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}
```

### Translation Files

```json
// assets/translations/en.json
{
  "login": {
    "title": "Welcome Back",
    "email": "Email",
    "password": "Password",
    "submit": "Sign In",
    "forgot": "Forgot Password?"
  },
  "jobs": {
    "search": "Search Jobs",
    "apply": "Apply Now",
    "saved": "Saved Jobs",
    "applied": "Applied Jobs"
  },
  "common": {
    "loading": "Loading...",
    "error": "Something went wrong",
    "retry": "Retry",
    "cancel": "Cancel",
    "save": "Save"
  }
}
```

### Usage

```dart
// In widgets
import 'package:easy_localization/easy_localization.dart';

Text('login.title'.tr()),
Text('jobs.search'.tr()),
Text('common.loading'.tr()),

// With parameters
Text('greeting'.tr(namedArgs: {'name': userName})),
```

---

## Theming

### App Theme

```dart
// core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D47A1),
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D47A1),
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    );
  }
}
```

### Responsive Design with ScreenUtil

```dart
// In widgets
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container(
  width: 343.w,    // Scales based on design width (375)
  height: 80.h,    // Scales based on design height (812)
  padding: EdgeInsets.all(16.w),
  margin: EdgeInsets.symmetric(horizontal: 16.w),
  child: Text(
    'Responsive Text',
    style: TextStyle(
      fontSize: 16.sp,  // Scales font size
      fontWeight: FontWeight.w600,
    ),
  ),
)
```

---

## Testing

### Unit Tests (Cubits)

```dart
// test/features/auth/auth_cubit_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late AuthCubit cubit;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    cubit = AuthCubit(mockLoginUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when login is successful',
      build: () {
        when(mockLoginUseCase.execute(any, any))
            .thenAnswer((_) async => Right(testUser));
        return cubit;
      },
      act: (cubit) => cubit.login('test@example.com', 'password'),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when login fails',
      build: () {
        when(mockLoginUseCase.execute(any, any))
            .thenAnswer((_) async => Left(AuthFailure('Invalid credentials')));
        return cubit;
      },
      act: (cubit) => cubit.login('test@example.com', 'wrong'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Invalid credentials'),
      ],
    );
  });
}
```

### Widget Tests

```dart
// test/features/auth/login_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  testWidgets('LoginScreen displays login form', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
    );

    expect(find.text('login.title'.tr()), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('login.submit'.tr()), findsOneWidget);
  });
}
```

---

## Environment Variables

```env
# .env
FIREBASE_PROJECT_ID=your-project-id
GOOGLE_SIGN_IN_CLIENT_ID=your-client-id
STRIPE_PUBLISHABLE_KEY=pk_test_...
ONESIGNAL_APP_ID=your-app-id
API_BASE_URL=http://localhost:3001/api/mobile
```

---

## Common Tasks

### Adding a New Feature

1. Create feature directory structure:
```bash
lib/features/new_feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── cubit/
    ├── screens/
    └── widgets/
```

2. Create entities (domain layer)
3. Create repository interface (domain layer)
4. Create models (data layer) with `freezed`
5. Create data sources and repository implementation
6. Create cubit and screens
7. Register route in `app_router.dart`
8. Register DI in module config
9. Run code generation:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Running Code Generation

```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on changes)
dart run build_runner watch

# Clean build
dart run build_runner clean
dart run build_runner build
```

### Adding a New Route

```dart
// core/router/route_names.dart
class RouteNames {
  static const newFeature = '/new-feature';
  static const newFeatureDetails = '/new-feature/:id';
}

// core/router/app_router.dart
GoRoute(
  path: RouteNames.newFeature,
  builder: (context, state) => const NewFeatureScreen(),
),
GoRoute(
  path: RouteNames.newFeatureDetails,
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return NewFeatureDetailScreen(id: id);
  },
),
```

---

## Troubleshooting

### Build Runner Errors

```bash
# Clean and regenerate
dart run build_runner clean
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Isar Database Issues

```dart
// Reinitialize database
await Isar.deleteDatabase();
await AppDatabase().init();
```

### Dependency Injection Errors

- Ensure `@injectable` or `@LazySingleton` annotations are present
- Run `build_runner` after adding new injectables
- Check for circular dependencies

### Navigation Issues

- Ensure routes are registered in `app_router.dart`
- Use correct `RouteNames` constants
- Check for proper context when navigating

---

## Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point |
| `lib/core/di/injection.dart` | GetIt DI setup |
| `lib/core/router/app_router.dart` | GoRouter configuration |
| `lib/core/network/api_client.dart` | Dio HTTP client |
| `lib/core/database/app_database.dart` | Isar database |
| `lib/core/theme/app_theme.dart` | App theming |
| `assets/translations/*.json` | Localization files |
| `pubspec.yaml` | Dependencies |
| `analysis_options.yaml` | Lint rules |

---

## External Integrations

### Firebase

```dart
// core/bootstrap/app_bootstrap.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AppBootstrap {
  static Future<void> initializeApp() async {
    await Firebase.initializeApp();
    
    // Initialize Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    
    // Initialize other services
  }
}
```

### Stripe

```dart
// features/payments/services/stripe_service.dart
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  Future<void> init() async {
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  }

  Future<void> makePayment(String paymentIntentId) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentId,
      ),
    );
    await Stripe.instance.presentPaymentSheet();
  }
}
```

### OneSignal (Push Notifications)

```dart
// core/services/notification_service.dart
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  Future<void> init() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
    
    OneSignal.Notifications.requestPermission(true);
  }

  void setExternalUserId(String userId) {
    OneSignal.login(userId);
  }
}
```
