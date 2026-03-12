import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/features/search/data/models/search_model.dart';
import 'package:tabashir/features/search/domain/repositories/search_repository.dart';

/// Implementation of SearchRepository
@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this._isarService);

  final IsarService _isarService;
  static const String _searchHistoryKey = 'search_history_data';
  static const String _savedFiltersKey = 'search_saved_filters';

  @override
  Future<List<SearchResult>> search({
    required String query,
    SearchResultType? type,
    SearchFilters? filters,
  }) async {
    try {
      final results = <SearchResult>[];

      // In a real app, this would query a database or API
      // For now, we'll return mock data based on the query
      if (query.isNotEmpty) {
        // Mock job results
        if (type == null || type == SearchResultType.job) {
          results.add(
            SearchResult(
              id: 'job_1',
              type: SearchResultType.job,
              title: 'Senior Flutter Developer at TechCorp',
              description:
                  'We are looking for an experienced Flutter developer...',
              location: 'San Francisco, CA',
              company: 'TechCorp',
              tags: ['flutter', 'dart', 'mobile'],
              createdAt: DateTime.now(),
            ),
          );
        }

        // Mock company results
        if (type == null || type == SearchResultType.company) {
          results.add(
            SearchResult(
              id: 'company_1',
              type: SearchResultType.company,
              title: 'TechCorp',
              description:
                  'Leading technology company specializing in mobile apps',
              location: 'San Francisco, CA',
              tags: ['technology', 'mobile', 'apps'],
              createdAt: DateTime.now(),
            ),
          );
        }
      }

      return results;
    } catch (e) {
      throw Exception('Failed to search: $e');
    }
  }

  @override
  Future<List<SearchSuggestion>> getSearchSuggestions({
    required String query,
    int limit = 10,
  }) async {
    try {
      final suggestions = <SearchSuggestion>[];

      if (query.isNotEmpty) {
        suggestions.add(
          SearchSuggestion(
            text: query,
            type: SearchSuggestionType.keyword,
            count: 100,
          ),
        );
        suggestions.add(
          SearchSuggestion(
            text: '$query Developer',
            type: SearchSuggestionType.keyword,
            count: 50,
          ),
        );
        suggestions.add(
          SearchSuggestion(
            text: '$query Engineer',
            type: SearchSuggestionType.keyword,
            count: 30,
          ),
        );
      }

      return suggestions.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to get search suggestions: $e');
    }
  }

  @override
  Future<void> saveToHistory({
    required String query,
    required SearchResultType type,
  }) async {
    try {
      final jsonString = _isarService.prefs.getString(_searchHistoryKey);
      final history = jsonString != null
          ? (jsonDecode(jsonString) as List<dynamic>)
                .map((e) => SearchHistory.fromJson(e as Map<String, dynamic>))
                .toList()
          : <SearchHistory>[];

      final newEntry = SearchHistory(
        query: query,
        type: type,
        timestamp: DateTime.now(),
      );

      history.insert(0, newEntry);

      // Keep only last 50 entries
      final limitedHistory = history.take(50).toList();

      final updatedJsonString = jsonEncode(
        limitedHistory.map((e) => e.toJson()).toList(),
      );
      await _isarService.prefs.setString(_searchHistoryKey, updatedJsonString);
    } catch (e) {
      throw Exception('Failed to save to history: $e');
    }
  }

  @override
  Future<List<SearchHistory>> getSearchHistory({
    int limit = 10,
  }) async {
    try {
      final jsonString = _isarService.prefs.getString(_searchHistoryKey);
      if (jsonString == null) {
        return [];
      }

      final history = (jsonDecode(jsonString) as List<dynamic>)
          .map((e) => SearchHistory.fromJson(e as Map<String, dynamic>))
          .toList();

      return history.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to get search history: $e');
    }
  }

  @override
  Future<void> clearSearchHistory() async {
    try {
      await _isarService.prefs.remove(_searchHistoryKey);
    } catch (e) {
      throw Exception('Failed to clear search history: $e');
    }
  }

  @override
  Future<List<SearchSuggestion>> getTrendingSearches({
    int limit = 10,
  }) async {
    try {
      final trending = <SearchSuggestion>[
        const SearchSuggestion(
          text: 'Flutter Developer',
          type: SearchSuggestionType.keyword,
          count: 500,
        ),
        const SearchSuggestion(
          text: 'React Native',
          type: SearchSuggestionType.keyword,
          count: 300,
        ),
        const SearchSuggestion(
          text: 'iOS Developer',
          type: SearchSuggestionType.keyword,
          count: 250,
        ),
        const SearchSuggestion(
          text: 'Android Developer',
          type: SearchSuggestionType.keyword,
          count: 200,
        ),
        const SearchSuggestion(
          text: 'Remote',
          type: SearchSuggestionType.location,
          count: 400,
        ),
      ];

      return trending.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to get trending searches: $e');
    }
  }

  @override
  Future<void> saveSearchFilters(SearchFilters filters) async {
    try {
      final jsonString = jsonEncode(filters.toJson());
      await _isarService.prefs.setString(_savedFiltersKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save search filters: $e');
    }
  }

  @override
  Future<SearchFilters?> getSavedSearchFilters() async {
    try {
      final jsonString = _isarService.prefs.getString(_savedFiltersKey);
      if (jsonString == null) {
        return null;
      }
      final json = jsonDecode(jsonString);
      return SearchFilters.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
