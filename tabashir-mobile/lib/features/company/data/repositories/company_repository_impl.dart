import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/features/company/data/models/company_model.dart';
import 'package:tabashir/features/company/domain/repositories/company_repository.dart';

/// Implementation of CompanyRepository
@Injectable(as: CompanyRepository)
class CompanyRepositoryImpl implements CompanyRepository {
  CompanyRepositoryImpl(this._persistenceService);

  final LocalPersistenceService _persistenceService;
  static const String _companiesKey = 'companies_data';
  static const String _reviewsKey = 'reviews_data';

  @override
  Future<CompanyProfile> getCompanyProfile({
    required String companyId,
  }) async {
    try {
      final jsonString = _persistenceService.prefs.getString('company_$companyId');
      if (jsonString == null) {
        throw Exception('Company profile not found');
      }
      final json = jsonDecode(jsonString);
      return CompanyProfile.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get company profile: $e');
    }
  }

  @override
  Future<CompanyProfile> createCompanyProfile({
    required CompanyProfile profile,
  }) async {
    try {
      final jsonString = jsonEncode(profile.toJson());
      await _persistenceService.prefs.setString('company_${profile.id}', jsonString);
      return profile;
    } catch (e) {
      throw Exception('Failed to create company profile: $e');
    }
  }

  @override
  Future<CompanyProfile> updateCompanyProfile({
    required String companyId,
    required CompanyProfile profile,
  }) async {
    try {
      final jsonString = jsonEncode(profile.toJson());
      await _persistenceService.prefs.setString('company_$companyId', jsonString);
      return profile;
    } catch (e) {
      throw Exception('Failed to update company profile: $e');
    }
  }

  @override
  Future<void> deleteCompanyProfile({
    required String companyId,
  }) async {
    try {
      await _persistenceService.prefs.remove('company_$companyId');
    } catch (e) {
      throw Exception('Failed to delete company profile: $e');
    }
  }

  @override
  Future<List<CompanyProfile>> getAllCompanies({
    String? industry,
    CompanySize? size,
    String? location,
  }) async {
    try {
      final companies = <CompanyProfile>[];
      final prefs = _persistenceService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('company_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final company = CompanyProfile.fromJson(
              json as Map<String, dynamic>,
            );

            if ((industry == null || company.industry == industry) &&
                (size == null || company.size == size) &&
                (location == null || company.location.contains(location))) {
              companies.add(company);
            }
          }
        }
      }

      return companies;
    } catch (e) {
      throw Exception('Failed to get all companies: $e');
    }
  }

  @override
  Future<List<CompanyProfile>> searchCompanies({
    required String query,
  }) async {
    try {
      final companies = <CompanyProfile>[];
      final prefs = _persistenceService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('company_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final company = CompanyProfile.fromJson(
              json as Map<String, dynamic>,
            );

            if (company.name.toLowerCase().contains(query.toLowerCase()) ||
                company.industry.toLowerCase().contains(query.toLowerCase())) {
              companies.add(company);
            }
          }
        }
      }

      return companies;
    } catch (e) {
      throw Exception('Failed to search companies: $e');
    }
  }

  @override
  Future<List<CompanyReview>> getCompanyReviews({
    required String companyId,
    ReviewStatus? status,
  }) async {
    try {
      final reviews = <CompanyReview>[];
      final prefs = _persistenceService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('review_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final review = CompanyReview.fromJson(json as Map<String, dynamic>);

            if (review.companyId == companyId &&
                (status == null || review.status == status)) {
              reviews.add(review);
            }
          }
        }
      }

      return reviews;
    } catch (e) {
      throw Exception('Failed to get company reviews: $e');
    }
  }

  @override
  Future<CompanyReview> createReview({
    required CompanyReview review,
  }) async {
    try {
      final jsonString = jsonEncode(review.toJson());
      await _persistenceService.prefs.setString('review_${review.id}', jsonString);
      return review;
    } catch (e) {
      throw Exception('Failed to create review: $e');
    }
  }

  @override
  Future<CompanyReview> updateReview({
    required String reviewId,
    required CompanyReview review,
  }) async {
    try {
      final jsonString = jsonEncode(review.toJson());
      await _persistenceService.prefs.setString('review_$reviewId', jsonString);
      return review;
    } catch (e) {
      throw Exception('Failed to update review: $e');
    }
  }

  @override
  Future<void> deleteReview({
    required String reviewId,
  }) async {
    try {
      await _persistenceService.prefs.remove('review_$reviewId');
    } catch (e) {
      throw Exception('Failed to delete review: $e');
    }
  }

  @override
  Future<void> addPostedJob({
    required String companyId,
    required String jobId,
  }) async {
    try {
      final company = await getCompanyProfile(companyId: companyId);
      final postedJobs = List<String>.from(company.postedJobs)..add(jobId);
      final updatedCompany = company.copyWith(postedJobs: postedJobs);
      await updateCompanyProfile(companyId: companyId, profile: updatedCompany);
    } catch (e) {
      throw Exception('Failed to add posted job: $e');
    }
  }

  @override
  Future<void> removePostedJob({
    required String companyId,
    required String jobId,
  }) async {
    try {
      final company = await getCompanyProfile(companyId: companyId);
      final postedJobs = List<String>.from(company.postedJobs)..remove(jobId);
      final updatedCompany = company.copyWith(postedJobs: postedJobs);
      await updateCompanyProfile(companyId: companyId, profile: updatedCompany);
    } catch (e) {
      throw Exception('Failed to remove posted job: $e');
    }
  }

  @override
  Future<List<CompanyProfile>> getCompaniesByIndustry({
    required String industry,
  }) async {
    try {
      final companies = <CompanyProfile>[];
      final prefs = _persistenceService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('company_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final company = CompanyProfile.fromJson(
              json as Map<String, dynamic>,
            );

            if (company.industry == industry) {
              companies.add(company);
            }
          }
        }
      }

      return companies;
    } catch (e) {
      throw Exception('Failed to get companies by industry: $e');
    }
  }

  @override
  Future<List<CompanyProfile>> getTopRatedCompanies({
    int limit = 10,
  }) async {
    try {
      final companies = <CompanyProfile>[];
      final prefs = _persistenceService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('company_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final company = CompanyProfile.fromJson(
              json as Map<String, dynamic>,
            );

            if (company.rating == CompanyRating.four ||
                company.rating == CompanyRating.five) {
              companies.add(company);
            }
          }
        }
      }

      return companies.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to get top rated companies: $e');
    }
  }
}
