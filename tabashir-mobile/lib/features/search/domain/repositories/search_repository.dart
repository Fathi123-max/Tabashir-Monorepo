import 'package:tabashir/features/search/data/models/search_model.dart';

/// Repository interface for search operations
/// Defines the contract for search data operations
abstract class SearchRepository {
  /// Search for jobs, companies, users
  /// Returns list of [SearchResult]
  Future<List<SearchResult>> search({
    required String query,
    SearchResultType? type,
    SearchFilters? filters,
  });

  /// Get search suggestions
  /// Returns list of [SearchSuggestion]
  Future<List<SearchSuggestion>> getSearchSuggestions({
    required String query,
    int limit = 10,
  });

  /// Save search query to history
  /// Returns void when operation is complete
  Future<void> saveToHistory({
    required String query,
    required SearchResultType type,
  });

  /// Get search history
  /// Returns list of [SearchHistory]
  Future<List<SearchHistory>> getSearchHistory({
    int limit = 10,
  });

  /// Clear search history
  /// Returns void when operation is complete
  Future<void> clearSearchHistory();

  /// Get trending searches
  /// Returns list of [SearchSuggestion]
  Future<List<SearchSuggestion>> getTrendingSearches({
    int limit = 10,
  });

  /// Save search filters
  /// Returns void when operation is complete
  Future<void> saveSearchFilters(SearchFilters filters);

  /// Get saved search filters
  /// Returns [SearchFilters]
  Future<SearchFilters?> getSavedSearchFilters();
}
