part of 'search_cubit.dart';

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStatus.initial) SearchStatus status,
    @Default('') String errorMessage,
    @Default([]) List<SearchResult> results,
    @Default([]) List<SearchSuggestion> suggestions,
    @Default([]) List<SearchHistory> history,
    @Default([]) List<SearchSuggestion> trending,
    SearchFilters? currentFilters,
    String? lastQuery,
  }) = _SearchState;

  factory SearchState.fromJson(Map<String, dynamic> json) =>
      _$SearchStateFromJson(json);
}

enum SearchStatus {
  initial,
  loading,
  loaded,
  error,
}
