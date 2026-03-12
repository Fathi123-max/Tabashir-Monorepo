import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
sealed class CompanyProfile with _$CompanyProfile {
  const factory CompanyProfile({
    required String id,
    required String name,
    required String industry,
    required String description,
    required String location,
    String? website,
    String? logoUrl,
    String? coverImageUrl,
    @Default(CompanySize.small) CompanySize size,
    @Default(CompanyType.private) CompanyType type,
    int? foundedYear,
    @Default([]) List<String> specializations,
    @Default([]) List<String> benefits,
    int? employeeCount,
    @Default(CompanyRating.one) CompanyRating rating,
    @Default([]) List<String> postedJobs,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CompanyProfile;

  factory CompanyProfile.fromJson(Map<String, dynamic> json) =>
      _$CompanyProfileFromJson(json);
}

enum CompanySize {
  startup, // 1-10
  small, // 11-50
  medium, // 51-200
  large, // 201-1000
  enterprise, // 1000+
}

enum CompanyType {
  private,
  public,
  nonprofit,
  government,
  partnership,
}

enum CompanyRating {
  one,
  two,
  three,
  four,
  five,
}

@freezed
sealed class CompanyReview with _$CompanyReview {
  const factory CompanyReview({
    required String id,
    required String companyId,
    required String reviewerName,
    required String reviewerEmail,
    required CompanyRating overallRating,
    required CompanyRating cultureRating,
    required CompanyRating salaryRating,
    required CompanyRating workLifeBalanceRating,
    required String title,
    required String content,
    @Default(ReviewStatus.pending) ReviewStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CompanyReview;

  factory CompanyReview.fromJson(Map<String, dynamic> json) =>
      _$CompanyReviewFromJson(json);
}

enum ReviewStatus {
  pending,
  approved,
  rejected,
}
