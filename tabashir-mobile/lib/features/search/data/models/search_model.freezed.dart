// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchResult {

 String get id; SearchResultType get type; String get title; String get description; String? get location; String? get company; List<String> get tags; DateTime? get createdAt;
/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultCopyWith<SearchResult> get copyWith => _$SearchResultCopyWithImpl<SearchResult>(this as SearchResult, _$identity);

  /// Serializes this SearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.company, company) || other.company == company)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,location,company,const DeepCollectionEquality().hash(tags),createdAt);

@override
String toString() {
  return 'SearchResult(id: $id, type: $type, title: $title, description: $description, location: $location, company: $company, tags: $tags, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SearchResultCopyWith<$Res>  {
  factory $SearchResultCopyWith(SearchResult value, $Res Function(SearchResult) _then) = _$SearchResultCopyWithImpl;
@useResult
$Res call({
 String id, SearchResultType type, String title, String description, String? location, String? company, List<String> tags, DateTime? createdAt
});




}
/// @nodoc
class _$SearchResultCopyWithImpl<$Res>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._self, this._then);

  final SearchResult _self;
  final $Res Function(SearchResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? location = freezed,Object? company = freezed,Object? tags = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchResultType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResult].
extension SearchResultPatterns on SearchResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResult value)  $default,){
final _that = this;
switch (_that) {
case _SearchResult():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SearchResultType type,  String title,  String description,  String? location,  String? company,  List<String> tags,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.location,_that.company,_that.tags,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SearchResultType type,  String title,  String description,  String? location,  String? company,  List<String> tags,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SearchResult():
return $default(_that.id,_that.type,_that.title,_that.description,_that.location,_that.company,_that.tags,_that.createdAt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SearchResultType type,  String title,  String description,  String? location,  String? company,  List<String> tags,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.location,_that.company,_that.tags,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResult implements SearchResult {
  const _SearchResult({required this.id, required this.type, required this.title, required this.description, this.location, this.company, final  List<String> tags = const [], this.createdAt}): _tags = tags;
  factory _SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

@override final  String id;
@override final  SearchResultType type;
@override final  String title;
@override final  String description;
@override final  String? location;
@override final  String? company;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime? createdAt;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultCopyWith<_SearchResult> get copyWith => __$SearchResultCopyWithImpl<_SearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.company, company) || other.company == company)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,location,company,const DeepCollectionEquality().hash(_tags),createdAt);

@override
String toString() {
  return 'SearchResult(id: $id, type: $type, title: $title, description: $description, location: $location, company: $company, tags: $tags, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SearchResultCopyWith<$Res> implements $SearchResultCopyWith<$Res> {
  factory _$SearchResultCopyWith(_SearchResult value, $Res Function(_SearchResult) _then) = __$SearchResultCopyWithImpl;
@override @useResult
$Res call({
 String id, SearchResultType type, String title, String description, String? location, String? company, List<String> tags, DateTime? createdAt
});




}
/// @nodoc
class __$SearchResultCopyWithImpl<$Res>
    implements _$SearchResultCopyWith<$Res> {
  __$SearchResultCopyWithImpl(this._self, this._then);

  final _SearchResult _self;
  final $Res Function(_SearchResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? location = freezed,Object? company = freezed,Object? tags = null,Object? createdAt = freezed,}) {
  return _then(_SearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchResultType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SearchFilters {

 String? get keyword; String? get location; List<String>? get tags; SearchResultType? get type; DateTime? get dateFrom; DateTime? get dateTo; int get minSalary; int get maxSalary; int get page; int get limit;
/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<SearchFilters> get copyWith => _$SearchFiltersCopyWithImpl<SearchFilters>(this as SearchFilters, _$identity);

  /// Serializes this SearchFilters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.type, type) || other.type == type)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.minSalary, minSalary) || other.minSalary == minSalary)&&(identical(other.maxSalary, maxSalary) || other.maxSalary == maxSalary)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyword,location,const DeepCollectionEquality().hash(tags),type,dateFrom,dateTo,minSalary,maxSalary,page,limit);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, location: $location, tags: $tags, type: $type, dateFrom: $dateFrom, dateTo: $dateTo, minSalary: $minSalary, maxSalary: $maxSalary, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $SearchFiltersCopyWith<$Res>  {
  factory $SearchFiltersCopyWith(SearchFilters value, $Res Function(SearchFilters) _then) = _$SearchFiltersCopyWithImpl;
@useResult
$Res call({
 String? keyword, String? location, List<String>? tags, SearchResultType? type, DateTime? dateFrom, DateTime? dateTo, int minSalary, int maxSalary, int page, int limit
});




}
/// @nodoc
class _$SearchFiltersCopyWithImpl<$Res>
    implements $SearchFiltersCopyWith<$Res> {
  _$SearchFiltersCopyWithImpl(this._self, this._then);

  final SearchFilters _self;
  final $Res Function(SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = freezed,Object? location = freezed,Object? tags = freezed,Object? type = freezed,Object? dateFrom = freezed,Object? dateTo = freezed,Object? minSalary = null,Object? maxSalary = null,Object? page = null,Object? limit = null,}) {
  return _then(_self.copyWith(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchResultType?,dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,minSalary: null == minSalary ? _self.minSalary : minSalary // ignore: cast_nullable_to_non_nullable
as int,maxSalary: null == maxSalary ? _self.maxSalary : maxSalary // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchFilters].
extension SearchFiltersPatterns on SearchFilters {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchFilters value)  $default,){
final _that = this;
switch (_that) {
case _SearchFilters():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchFilters value)?  $default,){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? keyword,  String? location,  List<String>? tags,  SearchResultType? type,  DateTime? dateFrom,  DateTime? dateTo,  int minSalary,  int maxSalary,  int page,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.location,_that.tags,_that.type,_that.dateFrom,_that.dateTo,_that.minSalary,_that.maxSalary,_that.page,_that.limit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? keyword,  String? location,  List<String>? tags,  SearchResultType? type,  DateTime? dateFrom,  DateTime? dateTo,  int minSalary,  int maxSalary,  int page,  int limit)  $default,) {final _that = this;
switch (_that) {
case _SearchFilters():
return $default(_that.keyword,_that.location,_that.tags,_that.type,_that.dateFrom,_that.dateTo,_that.minSalary,_that.maxSalary,_that.page,_that.limit);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? keyword,  String? location,  List<String>? tags,  SearchResultType? type,  DateTime? dateFrom,  DateTime? dateTo,  int minSalary,  int maxSalary,  int page,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.location,_that.tags,_that.type,_that.dateFrom,_that.dateTo,_that.minSalary,_that.maxSalary,_that.page,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchFilters implements SearchFilters {
  const _SearchFilters({this.keyword, this.location, final  List<String>? tags, this.type, this.dateFrom, this.dateTo, this.minSalary = 0, this.maxSalary = 1000000, this.page = 1, this.limit = 20}): _tags = tags;
  factory _SearchFilters.fromJson(Map<String, dynamic> json) => _$SearchFiltersFromJson(json);

@override final  String? keyword;
@override final  String? location;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  SearchResultType? type;
@override final  DateTime? dateFrom;
@override final  DateTime? dateTo;
@override@JsonKey() final  int minSalary;
@override@JsonKey() final  int maxSalary;
@override@JsonKey() final  int page;
@override@JsonKey() final  int limit;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFiltersCopyWith<_SearchFilters> get copyWith => __$SearchFiltersCopyWithImpl<_SearchFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchFiltersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.type, type) || other.type == type)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.minSalary, minSalary) || other.minSalary == minSalary)&&(identical(other.maxSalary, maxSalary) || other.maxSalary == maxSalary)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyword,location,const DeepCollectionEquality().hash(_tags),type,dateFrom,dateTo,minSalary,maxSalary,page,limit);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, location: $location, tags: $tags, type: $type, dateFrom: $dateFrom, dateTo: $dateTo, minSalary: $minSalary, maxSalary: $maxSalary, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$SearchFiltersCopyWith<$Res> implements $SearchFiltersCopyWith<$Res> {
  factory _$SearchFiltersCopyWith(_SearchFilters value, $Res Function(_SearchFilters) _then) = __$SearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 String? keyword, String? location, List<String>? tags, SearchResultType? type, DateTime? dateFrom, DateTime? dateTo, int minSalary, int maxSalary, int page, int limit
});




}
/// @nodoc
class __$SearchFiltersCopyWithImpl<$Res>
    implements _$SearchFiltersCopyWith<$Res> {
  __$SearchFiltersCopyWithImpl(this._self, this._then);

  final _SearchFilters _self;
  final $Res Function(_SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = freezed,Object? location = freezed,Object? tags = freezed,Object? type = freezed,Object? dateFrom = freezed,Object? dateTo = freezed,Object? minSalary = null,Object? maxSalary = null,Object? page = null,Object? limit = null,}) {
  return _then(_SearchFilters(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchResultType?,dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,minSalary: null == minSalary ? _self.minSalary : minSalary // ignore: cast_nullable_to_non_nullable
as int,maxSalary: null == maxSalary ? _self.maxSalary : maxSalary // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SearchSuggestion {

 String get text; SearchSuggestionType get type; int get count;
/// Create a copy of SearchSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSuggestionCopyWith<SearchSuggestion> get copyWith => _$SearchSuggestionCopyWithImpl<SearchSuggestion>(this as SearchSuggestion, _$identity);

  /// Serializes this SearchSuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSuggestion&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type,count);

@override
String toString() {
  return 'SearchSuggestion(text: $text, type: $type, count: $count)';
}


}

/// @nodoc
abstract mixin class $SearchSuggestionCopyWith<$Res>  {
  factory $SearchSuggestionCopyWith(SearchSuggestion value, $Res Function(SearchSuggestion) _then) = _$SearchSuggestionCopyWithImpl;
@useResult
$Res call({
 String text, SearchSuggestionType type, int count
});




}
/// @nodoc
class _$SearchSuggestionCopyWithImpl<$Res>
    implements $SearchSuggestionCopyWith<$Res> {
  _$SearchSuggestionCopyWithImpl(this._self, this._then);

  final SearchSuggestion _self;
  final $Res Function(SearchSuggestion) _then;

/// Create a copy of SearchSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? type = null,Object? count = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchSuggestionType,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchSuggestion].
extension SearchSuggestionPatterns on SearchSuggestion {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchSuggestion() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestion():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _SearchSuggestion() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  SearchSuggestionType type,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchSuggestion() when $default != null:
return $default(_that.text,_that.type,_that.count);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  SearchSuggestionType type,  int count)  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestion():
return $default(_that.text,_that.type,_that.count);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  SearchSuggestionType type,  int count)?  $default,) {final _that = this;
switch (_that) {
case _SearchSuggestion() when $default != null:
return $default(_that.text,_that.type,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchSuggestion implements SearchSuggestion {
  const _SearchSuggestion({required this.text, required this.type, this.count = 0});
  factory _SearchSuggestion.fromJson(Map<String, dynamic> json) => _$SearchSuggestionFromJson(json);

@override final  String text;
@override final  SearchSuggestionType type;
@override@JsonKey() final  int count;

/// Create a copy of SearchSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchSuggestionCopyWith<_SearchSuggestion> get copyWith => __$SearchSuggestionCopyWithImpl<_SearchSuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchSuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchSuggestion&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type,count);

@override
String toString() {
  return 'SearchSuggestion(text: $text, type: $type, count: $count)';
}


}

/// @nodoc
abstract mixin class _$SearchSuggestionCopyWith<$Res> implements $SearchSuggestionCopyWith<$Res> {
  factory _$SearchSuggestionCopyWith(_SearchSuggestion value, $Res Function(_SearchSuggestion) _then) = __$SearchSuggestionCopyWithImpl;
@override @useResult
$Res call({
 String text, SearchSuggestionType type, int count
});




}
/// @nodoc
class __$SearchSuggestionCopyWithImpl<$Res>
    implements _$SearchSuggestionCopyWith<$Res> {
  __$SearchSuggestionCopyWithImpl(this._self, this._then);

  final _SearchSuggestion _self;
  final $Res Function(_SearchSuggestion) _then;

/// Create a copy of SearchSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? type = null,Object? count = null,}) {
  return _then(_SearchSuggestion(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchSuggestionType,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SearchHistory {

 String get query; SearchResultType get type; DateTime? get timestamp;
/// Create a copy of SearchHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchHistoryCopyWith<SearchHistory> get copyWith => _$SearchHistoryCopyWithImpl<SearchHistory>(this as SearchHistory, _$identity);

  /// Serializes this SearchHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchHistory&&(identical(other.query, query) || other.query == query)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,type,timestamp);

@override
String toString() {
  return 'SearchHistory(query: $query, type: $type, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $SearchHistoryCopyWith<$Res>  {
  factory $SearchHistoryCopyWith(SearchHistory value, $Res Function(SearchHistory) _then) = _$SearchHistoryCopyWithImpl;
@useResult
$Res call({
 String query, SearchResultType type, DateTime? timestamp
});




}
/// @nodoc
class _$SearchHistoryCopyWithImpl<$Res>
    implements $SearchHistoryCopyWith<$Res> {
  _$SearchHistoryCopyWithImpl(this._self, this._then);

  final SearchHistory _self;
  final $Res Function(SearchHistory) _then;

/// Create a copy of SearchHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? type = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchResultType,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchHistory].
extension SearchHistoryPatterns on SearchHistory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchHistory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchHistory value)  $default,){
final _that = this;
switch (_that) {
case _SearchHistory():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchHistory value)?  $default,){
final _that = this;
switch (_that) {
case _SearchHistory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  SearchResultType type,  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchHistory() when $default != null:
return $default(_that.query,_that.type,_that.timestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  SearchResultType type,  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _SearchHistory():
return $default(_that.query,_that.type,_that.timestamp);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  SearchResultType type,  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _SearchHistory() when $default != null:
return $default(_that.query,_that.type,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchHistory implements SearchHistory {
  const _SearchHistory({required this.query, required this.type, this.timestamp});
  factory _SearchHistory.fromJson(Map<String, dynamic> json) => _$SearchHistoryFromJson(json);

@override final  String query;
@override final  SearchResultType type;
@override final  DateTime? timestamp;

/// Create a copy of SearchHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchHistoryCopyWith<_SearchHistory> get copyWith => __$SearchHistoryCopyWithImpl<_SearchHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchHistory&&(identical(other.query, query) || other.query == query)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,type,timestamp);

@override
String toString() {
  return 'SearchHistory(query: $query, type: $type, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$SearchHistoryCopyWith<$Res> implements $SearchHistoryCopyWith<$Res> {
  factory _$SearchHistoryCopyWith(_SearchHistory value, $Res Function(_SearchHistory) _then) = __$SearchHistoryCopyWithImpl;
@override @useResult
$Res call({
 String query, SearchResultType type, DateTime? timestamp
});




}
/// @nodoc
class __$SearchHistoryCopyWithImpl<$Res>
    implements _$SearchHistoryCopyWith<$Res> {
  __$SearchHistoryCopyWithImpl(this._self, this._then);

  final _SearchHistory _self;
  final $Res Function(_SearchHistory) _then;

/// Create a copy of SearchHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? type = null,Object? timestamp = freezed,}) {
  return _then(_SearchHistory(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SearchResultType,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
