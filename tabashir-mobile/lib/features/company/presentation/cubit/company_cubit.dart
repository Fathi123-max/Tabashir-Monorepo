import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/company/data/models/company_model.dart';
import 'package:tabashir/features/company/domain/repositories/company_repository.dart';

part 'company_state.dart';
part 'company_cubit.freezed.dart';
part 'company_cubit.g.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit(this._repository) : super(const CompanyState());

  final CompanyRepository _repository;

  /// Get company profile
  Future<void> getCompanyProfile(String companyId) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final company = await _repository.getCompanyProfile(
        companyId: companyId,
      );

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          currentCompany: company,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create company profile
  Future<void> createCompanyProfile(CompanyProfile profile) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final createdProfile = await _repository.createCompanyProfile(
        profile: profile,
      );

      final updatedCompanies = List<CompanyProfile>.from(state.companies)
        ..add(createdProfile);

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          companies: updatedCompanies,
          currentCompany: createdProfile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update company profile
  Future<void> updateCompanyProfile({
    required String companyId,
    required CompanyProfile profile,
  }) async {
    try {
      final updatedProfile = await _repository.updateCompanyProfile(
        companyId: companyId,
        profile: profile,
      );

      final updatedCompanies = state.companies
          .map((c) => c.id == companyId ? updatedProfile : c)
          .toList();

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          companies: updatedCompanies,
          currentCompany: updatedProfile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get all companies
  Future<void> getAllCompanies({
    String? industry,
    CompanySize? size,
    String? location,
  }) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final companies = await _repository.getAllCompanies(
        industry: industry,
        size: size,
        location: location,
      );

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          companies: companies,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Search companies
  Future<void> searchCompanies(String query) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final companies = await _repository.searchCompanies(query: query);

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          companies: companies,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get company reviews
  Future<void> getCompanyReviews(
    String companyId, {
    ReviewStatus? status,
  }) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final reviews = await _repository.getCompanyReviews(
        companyId: companyId,
        status: status,
      );

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          reviews: reviews,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create review
  Future<void> createReview(CompanyReview review) async {
    try {
      final createdReview = await _repository.createReview(review: review);

      final updatedReviews = List<CompanyReview>.from(state.reviews)
        ..add(createdReview);

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          reviews: updatedReviews,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update review
  Future<void> updateReview({
    required String reviewId,
    required CompanyReview review,
  }) async {
    try {
      final updatedReview = await _repository.updateReview(
        reviewId: reviewId,
        review: review,
      );

      final updatedReviews = state.reviews
          .map((r) => r.id == reviewId ? updatedReview : r)
          .toList();

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          reviews: updatedReviews,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Delete review
  Future<void> deleteReview(String reviewId) async {
    try {
      await _repository.deleteReview(reviewId: reviewId);

      final updatedReviews = state.reviews
          .where((r) => r.id != reviewId)
          .toList();

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          reviews: updatedReviews,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get companies by industry
  Future<void> getCompaniesByIndustry(String industry) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final companies = await _repository.getCompaniesByIndustry(
        industry: industry,
      );

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          companies: companies,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get top rated companies
  Future<void> getTopRatedCompanies({int limit = 10}) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final companies = await _repository.getTopRatedCompanies(limit: limit);

      emit(
        state.copyWith(
          status: CompanyStatus.loaded,
          companies: companies,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Add posted job
  Future<void> addPostedJob({
    required String companyId,
    required String jobId,
  }) async {
    try {
      await _repository.addPostedJob(
        companyId: companyId,
        jobId: jobId,
      );

      // Refresh current company
      await getCompanyProfile(companyId);
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Remove posted job
  Future<void> removePostedJob({
    required String companyId,
    required String jobId,
  }) async {
    try {
      await _repository.removePostedJob(
        companyId: companyId,
        jobId: jobId,
      );

      // Refresh current company
      await getCompanyProfile(companyId);
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: CompanyStatus.loaded,
      ),
    );
  }

  /// Reset state
  void reset() {
    emit(const CompanyState());
  }
}
