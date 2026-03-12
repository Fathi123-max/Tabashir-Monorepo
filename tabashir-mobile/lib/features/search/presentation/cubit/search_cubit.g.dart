// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchState _$SearchStateFromJson(Map<String, dynamic> json) => _SearchState(
  status:
      $enumDecodeNullable(_$SearchStatusEnumMap, json['status']) ??
      SearchStatus.initial,
  errorMessage: json['errorMessage'] as String? ?? '',
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  suggestions:
      (json['suggestions'] as List<dynamic>?)
          ?.map((e) => SearchSuggestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => SearchHistory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  trending:
      (json['trending'] as List<dynamic>?)
          ?.map((e) => SearchSuggestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentFilters: json['currentFilters'] == null
      ? null
      : SearchFilters.fromJson(json['currentFilters'] as Map<String, dynamic>),
  lastQuery: json['lastQuery'] as String?,
);

Map<String, dynamic> _$SearchStateToJson(_SearchState instance) =>
    <String, dynamic>{
      'status': _$SearchStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'results': instance.results,
      'suggestions': instance.suggestions,
      'history': instance.history,
      'trending': instance.trending,
      'currentFilters': instance.currentFilters,
      'lastQuery': instance.lastQuery,
    };

const _$SearchStatusEnumMap = {
  SearchStatus.initial: 'initial',
  SearchStatus.loading: 'loading',
  SearchStatus.loaded: 'loaded',
  SearchStatus.error: 'error',
};
