import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/search/data/models/search_model.dart';
import 'package:tabashir/features/search/domain/repositories/search_repository.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';
part 'search_cubit.g.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._repository) : super(const SearchState());

  final SearchRepository _repository;

  /// Search for results
  Future<void> search({
    required String query,
    SearchResultType? type,
    SearchFilters? filters,
  }) async {
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        errorMessage: '',
        lastQuery: query,
      ),
    );

    try {
      final results = await _repository.search(
        query: query,
        type: type,
        filters: filters,
      );

      // Save to history
      if (type != null) {
        await _repository.saveToHistory(query: query, type: type);
      }

      emit(
        state.copyWith(
          status: SearchStatus.loaded,
          results: results,
          currentFilters: filters,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get search suggestions
  Future<void> getSearchSuggestions(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(suggestions: []));
      return;
    }

    try {
      final suggestions = await _repository.getSearchSuggestions(
        query: query,
      );

      emit(state.copyWith(suggestions: suggestions));
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear suggestions
  void clearSuggestions() {
    emit(state.copyWith(suggestions: []));
  }

  /// Get search history
  Future<void> getSearchHistory() async {
    try {
      final history = await _repository.getSearchHistory();

      emit(state.copyWith(history: history));
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear search history
  Future<void> clearSearchHistory() async {
    try {
      await _repository.clearSearchHistory();
      emit(state.copyWith(history: []));
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get trending searches
  Future<void> getTrendingSearches() async {
    try {
      final trending = await _repository.getTrendingSearches();

      emit(state.copyWith(trending: trending));
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Save search filters
  Future<void> saveSearchFilters(SearchFilters filters) async {
    try {
      await _repository.saveSearchFilters(filters);
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get saved search filters
  Future<void> getSavedSearchFilters() async {
    try {
      final filters = await _repository.getSavedSearchFilters();

      if (filters != null) {
        emit(state.copyWith(currentFilters: filters));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear results
  void clearResults() {
    emit(
      state.copyWith(
        results: [],
        lastQuery: '',
        currentFilters: null,
      ),
    );
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: SearchStatus.loaded,
      ),
    );
  }

  /// Reset state
  void reset() {
    emit(const SearchState());
  }
}
