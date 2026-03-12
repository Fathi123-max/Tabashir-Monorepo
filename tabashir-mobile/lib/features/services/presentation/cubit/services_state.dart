part of 'services_cubit.dart';

@freezed
class ServicesState with _$ServicesState {
  const factory ServicesState.initial() = ServicesInitial;
  const factory ServicesState.loading() = ServicesLoading;
  const factory ServicesState.loaded() = ServicesLoaded;
  const factory ServicesState.error(String message) = ServicesError;
}
