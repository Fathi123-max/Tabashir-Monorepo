part of 'company_cubit.dart';

@freezed
sealed class CompanyState with _$CompanyState {
  const factory CompanyState({
    @Default(CompanyStatus.initial) CompanyStatus status,
    @Default('') String errorMessage,
    @Default([]) List<CompanyProfile> companies,
    CompanyProfile? currentCompany,
    @Default([]) List<CompanyReview> reviews,
  }) = _CompanyState;

  factory CompanyState.fromJson(Map<String, dynamic> json) =>
      _$CompanyStateFromJson(json);
}

enum CompanyStatus {
  initial,
  loading,
  loaded,
  error,
}
