// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResult _$SearchResultFromJson(Map<String, dynamic> json) =>
    _SearchResult(
      id: json['id'] as String,
      type: $enumDecode(_$SearchResultTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String?,
      company: json['company'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SearchResultToJson(_SearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SearchResultTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'company': instance.company,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SearchResultTypeEnumMap = {
  SearchResultType.job: 'job',
  SearchResultType.company: 'company',
  SearchResultType.user: 'user',
  SearchResultType.resume: 'resume',
};

_SearchFilters _$SearchFiltersFromJson(Map<String, dynamic> json) =>
    _SearchFilters(
      keyword: json['keyword'] as String?,
      location: json['location'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      type: $enumDecodeNullable(_$SearchResultTypeEnumMap, json['type']),
      dateFrom: json['dateFrom'] == null
          ? null
          : DateTime.parse(json['dateFrom'] as String),
      dateTo: json['dateTo'] == null
          ? null
          : DateTime.parse(json['dateTo'] as String),
      minSalary: (json['minSalary'] as num?)?.toInt() ?? 0,
      maxSalary: (json['maxSalary'] as num?)?.toInt() ?? 1000000,
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$SearchFiltersToJson(_SearchFilters instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'location': instance.location,
      'tags': instance.tags,
      'type': _$SearchResultTypeEnumMap[instance.type],
      'dateFrom': instance.dateFrom?.toIso8601String(),
      'dateTo': instance.dateTo?.toIso8601String(),
      'minSalary': instance.minSalary,
      'maxSalary': instance.maxSalary,
      'page': instance.page,
      'limit': instance.limit,
    };

_SearchSuggestion _$SearchSuggestionFromJson(Map<String, dynamic> json) =>
    _SearchSuggestion(
      text: json['text'] as String,
      type: $enumDecode(_$SearchSuggestionTypeEnumMap, json['type']),
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SearchSuggestionToJson(_SearchSuggestion instance) =>
    <String, dynamic>{
      'text': instance.text,
      'type': _$SearchSuggestionTypeEnumMap[instance.type]!,
      'count': instance.count,
    };

const _$SearchSuggestionTypeEnumMap = {
  SearchSuggestionType.keyword: 'keyword',
  SearchSuggestionType.location: 'location',
  SearchSuggestionType.company: 'company',
  SearchSuggestionType.tag: 'tag',
};

_SearchHistory _$SearchHistoryFromJson(Map<String, dynamic> json) =>
    _SearchHistory(
      query: json['query'] as String,
      type: $enumDecode(_$SearchResultTypeEnumMap, json['type']),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$SearchHistoryToJson(_SearchHistory instance) =>
    <String, dynamic>{
      'query': instance.query,
      'type': _$SearchResultTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
