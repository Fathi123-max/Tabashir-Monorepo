import 'package:tabashir/features/company/data/models/company_model.dart';

/// Repository interface for company operations
/// Defines the contract for company data operations
abstract class CompanyRepository {
  /// Get company profile by ID
  /// Returns [CompanyProfile]
  Future<CompanyProfile> getCompanyProfile({
    required String companyId,
  });

  /// Create a new company profile
  /// Returns the created [CompanyProfile]
  Future<CompanyProfile> createCompanyProfile({
    required CompanyProfile profile,
  });

  /// Update company profile
  /// Returns the updated [CompanyProfile]
  Future<CompanyProfile> updateCompanyProfile({
    required String companyId,
    required CompanyProfile profile,
  });

  /// Delete company profile
  /// Returns void when operation is complete
  Future<void> deleteCompanyProfile({
    required String companyId,
  });

  /// Get all companies
  /// Returns list of [CompanyProfile]
  Future<List<CompanyProfile>> getAllCompanies({
    String? industry,
    CompanySize? size,
    String? location,
  });

  /// Search companies by name
  /// Returns list of [CompanyProfile]
  Future<List<CompanyProfile>> searchCompanies({
    required String query,
  });

  /// Get company reviews
  /// Returns list of [CompanyReview]
  Future<List<CompanyReview>> getCompanyReviews({
    required String companyId,
    ReviewStatus? status,
  });

  /// Create a company review
  /// Returns the created [CompanyReview]
  Future<CompanyReview> createReview({
    required CompanyReview review,
  });

  /// Update review
  /// Returns the updated [CompanyReview]
  Future<CompanyReview> updateReview({
    required String reviewId,
    required CompanyReview review,
  });

  /// Delete review
  /// Returns void when operation is complete
  Future<void> deleteReview({
    required String reviewId,
  });

  /// Add posted job to company
  /// Returns void when operation is complete
  Future<void> addPostedJob({
    required String companyId,
    required String jobId,
  });

  /// Remove posted job from company
  /// Returns void when operation is complete
  Future<void> removePostedJob({
    required String companyId,
    required String jobId,
  });

  /// Get companies by industry
  /// Returns list of [CompanyProfile]
  Future<List<CompanyProfile>> getCompaniesByIndustry({
    required String industry,
  });

  /// Get top rated companies
  /// Returns list of [CompanyProfile]
  Future<List<CompanyProfile>> getTopRatedCompanies({
    int limit = 10,
  });
}
