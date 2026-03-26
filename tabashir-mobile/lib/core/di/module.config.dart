// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_bloc/flutter_bloc.dart' as _i331;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/admin/data/repositories/admin_repository_impl.dart'
    as _i335;
import '../../features/admin/domain/repositories/admin_repository.dart'
    as _i583;
import '../../features/ai_job_apply/data/repositories/ai_job_apply_repository_impl.dart'
    as _i766;
import '../../features/ai_job_apply/domain/repositories/ai_job_apply_repository.dart'
    as _i588;
import '../../features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart'
    as _i222;
import '../../features/ai_resume/data/repositories/ai_resume_repository_impl.dart'
    as _i351;
import '../../features/ai_resume/domain/repositories/ai_resume_repository.dart'
    as _i27;
import '../../features/ai_resume/presentation/cubit/ai_resume_cubit.dart'
    as _i618;
import '../../features/ai_resume_builder/data/repositories/ai_resume_builder_repository_impl.dart'
    as _i446;
import '../../features/ai_resume_builder/domain/repositories/ai_resume_builder_repository.dart'
    as _i208;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/candidate/data/repositories/candidate_repository_impl.dart'
    as _i266;
import '../../features/candidate/domain/repositories/candidate_repository.dart'
    as _i863;
import '../../features/company/data/repositories/company_repository_impl.dart'
    as _i726;
import '../../features/company/domain/repositories/company_repository.dart'
    as _i752;
import '../../features/home/data/datasources/home_local_datasource.dart'
    as _i314;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/presentation/cubit/app_initialization_cubit.dart'
    as _i731;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../../features/home/services/home_api_service.dart' as _i184;
import '../../features/job_applications/data/repositories/job_applications_repository_impl.dart'
    as _i760;
import '../../features/job_applications/domain/repositories/job_applications_repository.dart'
    as _i860;
import '../../features/job_applications/presentation/cubit/job_applications_cubit.dart'
    as _i459;
import '../../features/jobs/data/repositories/jobs_repository_impl.dart'
    as _i150;
import '../../features/jobs/domain/repositories/jobs_repository.dart' as _i973;
import '../../features/jobs/presentation/cubit/jobs_cubit.dart' as _i532;
import '../../features/jobs/presentation/cubit/saved_jobs_cubit.dart' as _i848;
import '../../features/jobs/services/job_details_service.dart' as _i656;
import '../../features/messages/data/repositories/messages_repository_impl.dart'
    as _i20;
import '../../features/messages/domain/repositories/messages_repository.dart'
    as _i794;
import '../../features/notifications/domain/repositories/notifications_repository.dart'
    as _i563;
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i452;
import '../../features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i430;
import '../../features/onboarding/presentation/cubit/onboarding_wizard_cubit.dart'
    as _i891;
import '../../features/payments/data/repositories/payment_repository_impl.dart'
    as _i842;
import '../../features/payments/domain/repositories/payment_repository.dart'
    as _i315;
import '../../features/payments/presentation/cubit/payment_cubit.dart' as _i782;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/presentation/cubit/profile_cubit.dart' as _i36;
import '../../features/recruiter/data/repositories/recruiter_repository_impl.dart'
    as _i357;
import '../../features/recruiter/domain/repositories/recruiter_repository.dart'
    as _i737;
import '../../features/resume/data/repositories/file_resume_repository_impl.dart'
    as _i6;
import '../../features/resume/data/repositories/resume_repository_impl.dart'
    as _i141;
import '../../features/resume/data/repositories/sync_hybrid_resume_repository.dart'
    as _i296;
import '../../features/resume/domain/repositories/file_resume_repository.dart'
    as _i88;
import '../../features/resume/domain/repositories/resume_repository.dart'
    as _i201;
import '../../features/resume/domain/repositories/resume_vault_repository.dart'
    as _i229;
import '../../features/resume/presentation/cubit/resume_import_cubit.dart'
    as _i658;
import '../../features/resume/presentation/cubit/resume_review_cubit.dart'
    as _i349;
import '../../features/resume/presentation/cubit/resume_vault_cubit.dart'
    as _i938;
import '../../features/resume/services/resume_parsing_service.dart' as _i1030;
import '../../features/resume/services/resume_parsing_service_impl.dart'
    as _i150;
import '../../features/search/data/repositories/search_repository_impl.dart'
    as _i1017;
import '../../features/search/domain/repositories/search_repository.dart'
    as _i357;
import '../../features/services/data/repositories/services_repository_impl.dart'
    as _i202;
import '../../features/services/domain/repositories/services_repository.dart'
    as _i939;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i955;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i674;
import '../../features/subscription/data/repositories/subscription_repository_impl.dart'
    as _i331;
import '../../features/subscription/domain/repositories/subscription_repository.dart'
    as _i185;
import '../../features/subscription/presentation/cubit/subscription_cubit.dart'
    as _i949;
import '../../features/upload/data/repositories/upload_repository_impl.dart'
    as _i63;
import '../../features/upload/domain/repositories/upload_repository.dart'
    as _i302;
import '../../features/upload/presentation/cubit/upload_cubit.dart' as _i895;
import '../database/repositories/local_resume_repository.dart' as _i475;
import '../database/repositories/profile_isar_repository.dart' as _i790;
import '../network/_clients/auth_dio_client.dart' as _i1032;
import '../network/_clients/backend_dio_client.dart' as _i411;
import '../network/_clients/dio_client.dart' as _i952;
import '../network/_clients/upload_dio_client.dart' as _i716;
import '../network/api_client.dart' as _i557;
import '../network/services/ai_resume/ai_resume_api_service.dart' as _i1058;
import '../network/services/auth/auth_api_service.dart' as _i692;
import '../network/services/auth/email_api_service.dart' as _i413;
import '../network/services/job/saved_jobs_api_service.dart' as _i532;
import '../network/services/job/tabashir_api_service.dart' as _i1;
import '../network/services/payment/payment_api_service.dart' as _i932;
import '../network/services/resume/resume_api_service.dart' as _i914;
import '../network/services/subscription/subscription_api_service.dart'
    as _i190;
import '../network/services/upload/upload_api_service.dart' as _i772;
import '../network/services/user/user_api_service.dart' as _i676;
import '../services/applied_jobs_storage.dart' as _i801;
import '../services/file_service.dart' as _i367;
import '../services/google_signin_service.dart' as _i699;
import '../services/isar_service.dart' as _i792;
import '../services/job_match_service.dart' as _i403;
import '../services/local_storage_service.dart' as _i527;
import '../services/notification_service.dart' as _i941;
import '../services/onesignal_notification_service.dart' as _i469;
import '../services/stripe_service.dart' as _i333;
import '../session/cubit/session_cubit.dart' as _i763;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i403.JobMatchService>(() => _i403.JobMatchService());
    gh.lazySingleton<_i527.LocalStorageService>(
      () => registerModule.localStorageService,
    );
    gh.lazySingleton<_i367.FileService>(() => registerModule.fileService);
    gh.lazySingleton<_i941.NotificationService>(
      () => registerModule.notificationService,
    );
    gh.lazySingleton<_i563.NotificationsRepository>(
      () => registerModule.notificationsRepository,
    );
    gh.lazySingleton<_i333.StripeService>(() => registerModule.stripeService);
    gh.lazySingleton<_i699.GoogleSignInService>(
      () => registerModule.googleSignInService,
    );
    gh.lazySingleton<_i792.IsarService>(() => registerModule.isarService);
    gh.lazySingleton<_i475.LocalResumeRepository>(
      () => registerModule.localResumeRepository,
    );
    gh.lazySingleton<_i790.ProfileIsarRepository>(
      () => registerModule.profileIsarRepository,
    );
    gh.lazySingleton<_i952.DioClient>(() => registerModule.dioClient);
    gh.lazySingleton<_i716.UploadDioClient>(
      () => registerModule.uploadDioClient,
    );
    gh.lazySingleton<_i1032.AuthDioClient>(() => registerModule.authDioClient);
    gh.lazySingleton<_i411.BackendDioClient>(
      () => registerModule.backendDioClient,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i692.AuthApiService>(() => registerModule.authApiService);
    gh.lazySingleton<_i413.EmailApiService>(
      () => registerModule.emailApiService,
    );
    gh.lazySingleton<_i676.UserApiService>(() => registerModule.userApiService);
    gh.lazySingleton<_i1.TabashirApiService>(
      () => registerModule.tabashirApiService,
    );
    gh.lazySingleton<_i190.SubscriptionApiService>(
      () => registerModule.subscriptionApiService,
    );
    gh.lazySingleton<_i932.PaymentApiService>(
      () => registerModule.paymentApiService,
    );
    gh.lazySingleton<_i1058.AiResumeApiService>(
      () => registerModule.aiResumeApiService,
    );
    gh.lazySingleton<_i772.UploadApiService>(
      () => registerModule.uploadApiService,
    );
    gh.lazySingleton<_i914.ResumeApiService>(
      () => registerModule.resumeApiService,
    );
    gh.lazySingleton<_i532.SavedJobsApiService>(
      () => registerModule.savedJobsApiService,
    );
    gh.lazySingleton<_i792.SavedJobsRepository>(
      () => registerModule.savedJobsRepository,
    );
    gh.lazySingleton<_i801.AppliedJobsStorage>(
      () => registerModule.appliedJobsStorage,
    );
    gh.lazySingleton<_i763.SessionCubit>(() => _i763.SessionCubit());
    gh.factory<_i973.JobsRepository>(
      () => _i150.JobsRepositoryImpl(gh<_i1.TabashirApiService>()),
    );
    gh.factory<_i848.SavedJobsCubit>(
      () => _i848.SavedJobsCubit(gh<_i792.SavedJobsRepository>()),
    );
    gh.singleton<_i469.OneSignalNotificationServiceBase>(
      () => _i469.OneSignalNotificationService.create(),
    );
    gh.factory<_i894.ProfileRepository>(
      () => _i334.ProfileRepositoryImpl(
        gh<_i676.UserApiService>(),
        gh<_i692.AuthApiService>(),
        gh<_i790.ProfileIsarRepository>(),
      ),
    );
    gh.factory<_i860.JobApplicationsRepository>(
      () => _i760.JobApplicationsRepositoryImpl(gh<_i1.TabashirApiService>()),
    );
    gh.factory<_i656.JobDetailsService>(
      () => _i656.JobDetailsService(gh<_i973.JobsRepository>()),
    );
    gh.lazySingleton<_i36.ProfileCubit>(
      () => _i36.ProfileCubit(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i27.AiResumeRepository>(
      () => _i351.AiResumeRepositoryImpl(gh<_i1058.AiResumeApiService>()),
    );
    gh.factory<_i184.HomeApiService>(
      () => _i184.HomeApiService(
        gh<_i1.TabashirApiService>(),
        gh<_i676.UserApiService>(),
        gh<_i1032.AuthDioClient>(),
        gh<_i527.LocalStorageService>(),
      ),
    );
    gh.singleton<_i557.ApiClient>(
      () => _i557.ApiClient(
        gh<_i952.DioClient>(),
        gh<_i1032.AuthDioClient>(),
        gh<_i411.BackendDioClient>(),
      ),
    );
    gh.factory<_i88.FileResumeRepository>(
      () => _i6.FileResumeRepositoryImpl(gh<_i914.ResumeApiService>()),
    );
    gh.factory<_i939.ServicesRepository>(
      () => _i202.ServicesRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i1030.ResumeParsingService>(
      () => _i150.ResumeParsingServiceImpl(
        gh<_i367.FileService>(),
        gh<_i1.TabashirApiService>(),
      ),
    );
    gh.factory<_i588.AiJobApplyRepository>(
      () => _i766.AiJobApplyRepositoryImpl(
        gh<_i1.TabashirApiService>(),
        gh<_i792.IsarService>(),
      ),
    );
    gh.factory<_i752.CompanyRepository>(
      () => _i726.CompanyRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i331.Cubit<_i459.JobApplicationsState>>(
      () => _i459.JobApplicationsCubit(gh<_i860.JobApplicationsRepository>()),
    );
    gh.factory<_i737.RecruiterRepository>(
      () => _i357.RecruiterRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i314.HomeLocalDataSource>(
      () => _i314.HomeLocalDataSource(gh<_i527.LocalStorageService>()),
    );
    gh.factory<_i208.AiResumeBuilderRepository>(
      () => _i446.AiResumeBuilderRepositoryImpl(
        gh<_i792.IsarService>(),
        gh<_i1058.AiResumeApiService>(),
      ),
    );
    gh.factory<_i430.OnboardingRepository>(
      () => _i452.OnboardingRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i331.Cubit<_i618.AiResumeState>>(
      () => _i618.AiResumeCubit(gh<_i27.AiResumeRepository>()),
    );
    gh.factory<_i229.ResumeVaultRepository>(
      () => _i296.SyncHybridResumeRepository(
        gh<_i914.ResumeApiService>(),
        gh<_i475.LocalResumeRepository>(),
      ),
    );
    gh.factory<_i794.MessagesRepository>(
      () => _i20.MessagesRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i201.ResumeRepository>(
      () => _i141.ResumeRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i583.AdminRepository>(
      () => _i335.AdminRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i185.SubscriptionRepository>(
      () =>
          _i331.SubscriptionRepositoryImpl(gh<_i190.SubscriptionApiService>()),
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i692.AuthApiService>(),
        gh<_i413.EmailApiService>(),
      ),
    );
    gh.factory<_i863.CandidateRepository>(
      () => _i266.CandidateRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i302.UploadRepository>(
      () => _i63.UploadRepositoryImpl(gh<_i772.UploadApiService>()),
    );
    gh.lazySingleton<_i9.HomeCubit>(
      () => _i9.HomeCubit(gh<_i184.HomeApiService>()),
    );
    gh.factory<_i891.OnboardingWizardCubit>(
      () => _i891.OnboardingWizardCubit(
        gh<_i588.AiJobApplyRepository>(),
        gh<_i36.ProfileCubit>(),
      ),
    );
    gh.factory<_i674.SettingsRepository>(
      () => _i955.SettingsRepositoryImpl(gh<_i527.LocalStorageService>()),
    );
    gh.factory<_i0.HomeRepository>(
      () => _i76.HomeRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i532.JobsCubit>(
      () => _i532.JobsCubit(
        gh<_i973.JobsRepository>(),
        gh<_i792.SavedJobsRepository>(),
        gh<_i801.AppliedJobsStorage>(),
      ),
    );
    gh.factory<_i315.PaymentRepository>(
      () => _i842.PaymentRepositoryImpl(gh<_i932.PaymentApiService>()),
    );
    gh.factory<_i357.SearchRepository>(
      () => _i1017.SearchRepositoryImpl(gh<_i792.IsarService>()),
    );
    gh.factory<_i222.AiJobApplyCubit>(
      () => _i222.AiJobApplyCubit(
        gh<_i588.AiJobApplyRepository>(),
        gh<_i229.ResumeVaultRepository>(),
        gh<_i36.ProfileCubit>(),
      ),
    );
    gh.lazySingleton<_i938.ResumeVaultCubit>(
      () => _i938.ResumeVaultCubit(gh<_i229.ResumeVaultRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () =>
          _i117.AuthCubit(gh<_i787.AuthRepository>(), gh<_i36.ProfileCubit>()),
    );
    gh.lazySingleton<_i731.AppInitializationCubit>(
      () => _i731.AppInitializationCubit(
        gh<_i894.ProfileRepository>(),
        gh<_i184.HomeApiService>(),
        gh<_i229.ResumeVaultRepository>(),
      ),
    );
    gh.factory<_i331.Cubit<_i782.PaymentState>>(
      () => _i782.PaymentCubit(
        gh<_i315.PaymentRepository>(),
        gh<_i333.StripeService>(),
      ),
    );
    gh.factory<_i658.ResumeImportCubit>(
      () => _i658.ResumeImportCubit(
        gh<_i1030.ResumeParsingService>(),
        gh<_i229.ResumeVaultRepository>(),
      ),
    );
    gh.factory<_i331.Cubit<_i949.SubscriptionState>>(
      () => _i949.SubscriptionCubit(gh<_i185.SubscriptionRepository>()),
    );
    gh.factoryParam<_i349.ResumeReviewCubit, Map<String, dynamic>?, dynamic>(
      (initialData, _) => _i349.ResumeReviewCubit(
        profileCubit: gh<_i36.ProfileCubit>(),
        resumeVaultCubit: gh<_i938.ResumeVaultCubit>(),
        initialData: initialData,
      ),
    );
    gh.factory<_i331.Cubit<_i895.UploadState>>(
      () => _i895.UploadCubit(gh<_i302.UploadRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i946.RegisterModule {}
