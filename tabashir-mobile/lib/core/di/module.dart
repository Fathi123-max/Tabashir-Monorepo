import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/payments/data/repositories/apple_payment_platform.dart';
import '../../features/payments/data/repositories/stripe_payment_platform.dart';
import '../../features/payments/domain/repositories/payment_platform.dart';
import '../../features/payments/domain/repositories/payment_repository.dart';

import '../database/repositories/local_resume_repository.dart';
import '../database/repositories/profile_isar_repository.dart';
import '../services/applied_jobs_storage.dart';
import '../services/isar_service.dart';
import '../services/local_storage_service.dart';

import '../network/_clients/auth_dio_client.dart';
import '../network/_clients/backend_dio_client.dart';
import '../network/_clients/dio_client.dart';
import '../network/_clients/upload_dio_client.dart';
import '../network/services/ai_resume/ai_resume_api_service.dart';
import '../network/services/auth/auth_api_service.dart';
import '../network/services/auth/email_api_service.dart';
import '../network/services/job/saved_jobs_api_service.dart';
import '../network/services/job/tabashir_api_service.dart';
import '../network/services/payment/payment_api_service.dart';
import '../network/services/resume/resume_api_service.dart';
import '../network/services/subscription/subscription_api_service.dart';
import '../network/services/upload/upload_api_service.dart';
import '../network/services/user/user_api_service.dart';
import '../../features/home/services/home_api_service.dart';
import '../services/analytics_service.dart';
import '../services/apple_iap_service.dart';
import '../services/file_service.dart';
import '../services/google_signin_service.dart';
import '../services/notification_service.dart';
import '../network/services/notification/notification_api_service.dart';
import '../services/stripe_service.dart';

import 'module.config.dart';

@InjectableInit(
  preferRelativeImports: true, // by default
)
void configureDependencies() => GetIt.instance.init();

@module
abstract class RegisterModule {
  @lazySingleton
  LocalStorageService get localStorageService => LocalStorageService.instance;

  @lazySingleton
  FileService get fileService => FileService.instance;

  @lazySingleton
  NotificationService get notificationService => NotificationService.instance;

  @lazySingleton
  NotificationApiService get notificationApiService =>
      NotificationApiService(authDioClient.dio);

  @lazySingleton
  NotificationsRepository get notificationsRepository =>
      NotificationsRepositoryImpl(notificationApiService);

  @lazySingleton
  StripeService get stripeService => StripeService();

  @lazySingleton
  GoogleSignInService get googleSignInService => GoogleSignInService.instance;

  // Note: JobDetailsService will be auto-registered via @Injectable annotation
  // Note: JobMatchService will be auto-registered via @Injectable annotation
  // It requires JobsRepository which will be injected automatically

  @lazySingleton
  IsarService get isarService => IsarService();

  @lazySingleton
  LocalResumeRepository get localResumeRepository =>
      LocalResumeRepository(isarService);

  @lazySingleton
  ProfileIsarRepository get profileIsarRepository =>
      ProfileIsarRepository(isarService);

  @lazySingleton
  DioClient get dioClient => DioClient();

  @lazySingleton
  UploadDioClient get uploadDioClient => UploadDioClient();

  @lazySingleton
  AuthDioClient get authDioClient => AuthDioClient();

  @lazySingleton
  BackendDioClient get backendDioClient => BackendDioClient();

  @lazySingleton
  Dio get dio => Dio();

  // API Services
  @lazySingleton
  AuthApiService get authApiService => AuthApiService(authDioClient.dio);

  @lazySingleton
  EmailApiService get emailApiService => EmailApiService(authDioClient.dio);

  @lazySingleton
  UserApiService get userApiService => UserApiService(authDioClient.dio);

  @lazySingleton
  TabashirApiService get tabashirApiService =>
      TabashirApiService(backendDioClient.dio);

  @lazySingleton
  SubscriptionApiService get subscriptionApiService =>
      SubscriptionApiService(authDioClient.dio);

  @lazySingleton
  PaymentApiService get paymentApiService =>
      PaymentApiService(authDioClient.dio);

  @lazySingleton
  AiResumeApiService get aiResumeApiService =>
      AiResumeApiService(authDioClient.dio);

  @lazySingleton
  UploadApiService get uploadApiService =>
      UploadApiService(uploadDioClient.dio);

  @lazySingleton
  ResumeApiService get resumeApiService => ResumeApiService(authDioClient.dio);

  @lazySingleton
  SavedJobsApiService get savedJobsApiService =>
      SavedJobsApiService(backendDioClient.dio);

  @lazySingleton
  SavedJobsRepository get savedJobsRepository =>
      SavedJobsRepository(savedJobsApiService);

  @lazySingleton
  AppliedJobsStorage get appliedJobsStorage => AppliedJobsStorage();

  // Apple IAP Service (used on iOS)
  @lazySingleton
  AppleIAPService get appleIAPService => AppleIAPService(dio);

  // PaymentPlatform — platform-specific implementation
  @lazySingleton
  PaymentPlatform get paymentPlatform {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return ApplePaymentPlatform(appleIAPService);
    }
    return StripePaymentPlatform(stripeService, GetIt.instance<PaymentRepository>());
  }

  // SyncHybridResumeRepository is auto-registered via @Injectable annotation
  // It combines backend storage with local caching for offline access

  // Repositories will be auto-registered via @Injectable annotation
  // Cubits will be auto-registered via @Injectable annotation
  // HomeApiService will be auto-registered via @Injectable annotation
}
