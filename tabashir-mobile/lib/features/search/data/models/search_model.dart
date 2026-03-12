import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_model.freezed.dart';
part 'search_model.g.dart';

@freezed
sealed class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String id,
    required SearchResultType type,
    required String title,
    required String description,
    String? location,
    String? company,
    @Default([]) List<String> tags,
    DateTime? createdAt,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

enum SearchResultType {
  job,
  company,
  user,
  resume,
}

@freezed
sealed class SearchFilters with _$SearchFilters {
  const factory SearchFilters({
    String? keyword,
    String? location,
    List<String>? tags,
    SearchResultType? type,
    DateTime? dateFrom,
    DateTime? dateTo,
    @Default(0) int minSalary,
    @Default(1000000) int maxSalary,
    @Default(1) int page,
    @Default(20) int limit,
  }) = _SearchFilters;

  factory SearchFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchFiltersFromJson(json);
}

@freezed
sealed class SearchSuggestion with _$SearchSuggestion {
  const factory SearchSuggestion({
    required String text,
    required SearchSuggestionType type,
    @Default(0) int count,
  }) = _SearchSuggestion;

  factory SearchSuggestion.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionFromJson(json);
}

enum SearchSuggestionType {
  keyword,
  location,
  company,
  tag,
}

@freezed
sealed class SearchHistory with _$SearchHistory {
  const factory SearchHistory({
    required String query,
    required SearchResultType type,
    DateTime? timestamp,
  }) = _SearchHistory;

  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);
}
