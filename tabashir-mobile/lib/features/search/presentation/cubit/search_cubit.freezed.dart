// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchState {

 SearchStatus get status; String get errorMessage; List<SearchResult> get results; List<SearchSuggestion> get suggestions; List<SearchHistory> get history; List<SearchSuggestion> get trending; SearchFilters? get currentFilters; String? get lastQuery;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);

  /// Serializes this SearchState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&const DeepCollectionEquality().equals(other.history, history)&&const DeepCollectionEquality().equals(other.trending, trending)&&(identical(other.currentFilters, currentFilters) || other.currentFilters == currentFilters)&&(identical(other.lastQuery, lastQuery) || other.lastQuery == lastQuery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(suggestions),const DeepCollectionEquality().hash(history),const DeepCollectionEquality().hash(trending),currentFilters,lastQuery);

@override
String toString() {
  return 'SearchState(status: $status, errorMessage: $errorMessage, results: $results, suggestions: $suggestions, history: $history, trending: $trending, currentFilters: $currentFilters, lastQuery: $lastQuery)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 SearchStatus status, String errorMessage, List<SearchResult> results, List<SearchSuggestion> suggestions, List<SearchHistory> history, List<SearchSuggestion> trending, SearchFilters? currentFilters, String? lastQuery
});


$SearchFiltersCopyWith<$Res>? get currentFilters;

}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? results = null,Object? suggestions = null,Object? history = null,Object? trending = null,Object? currentFilters = freezed,Object? lastQuery = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SearchStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<SearchResult>,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<SearchSuggestion>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<SearchHistory>,trending: null == trending ? _self.trending : trending // ignore: cast_nullable_to_non_nullable
as List<SearchSuggestion>,currentFilters: freezed == currentFilters ? _self.currentFilters : currentFilters // ignore: cast_nullable_to_non_nullable
as SearchFilters?,lastQuery: freezed == lastQuery ? _self.lastQuery : lastQuery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<$Res>? get currentFilters {
    if (_self.currentFilters == null) {
    return null;
  }

  return $SearchFiltersCopyWith<$Res>(_self.currentFilters!, (value) {
    return _then(_self.copyWith(currentFilters: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchState value)  $default,){
final _that = this;
switch (_that) {
case _SearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchStatus status,  String errorMessage,  List<SearchResult> results,  List<SearchSuggestion> suggestions,  List<SearchHistory> history,  List<SearchSuggestion> trending,  SearchFilters? currentFilters,  String? lastQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.results,_that.suggestions,_that.history,_that.trending,_that.currentFilters,_that.lastQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchStatus status,  String errorMessage,  List<SearchResult> results,  List<SearchSuggestion> suggestions,  List<SearchHistory> history,  List<SearchSuggestion> trending,  SearchFilters? currentFilters,  String? lastQuery)  $default,) {final _that = this;
switch (_that) {
case _SearchState():
return $default(_that.status,_that.errorMessage,_that.results,_that.suggestions,_that.history,_that.trending,_that.currentFilters,_that.lastQuery);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchStatus status,  String errorMessage,  List<SearchResult> results,  List<SearchSuggestion> suggestions,  List<SearchHistory> history,  List<SearchSuggestion> trending,  SearchFilters? currentFilters,  String? lastQuery)?  $default,) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.results,_that.suggestions,_that.history,_that.trending,_that.currentFilters,_that.lastQuery);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchState implements SearchState {
  const _SearchState({this.status = SearchStatus.initial, this.errorMessage = '', final  List<SearchResult> results = const [], final  List<SearchSuggestion> suggestions = const [], final  List<SearchHistory> history = const [], final  List<SearchSuggestion> trending = const [], this.currentFilters, this.lastQuery}): _results = results,_suggestions = suggestions,_history = history,_trending = trending;
  factory _SearchState.fromJson(Map<String, dynamic> json) => _$SearchStateFromJson(json);

@override@JsonKey() final  SearchStatus status;
@override@JsonKey() final  String errorMessage;
 final  List<SearchResult> _results;
@override@JsonKey() List<SearchResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  List<SearchSuggestion> _suggestions;
@override@JsonKey() List<SearchSuggestion> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

 final  List<SearchHistory> _history;
@override@JsonKey() List<SearchHistory> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

 final  List<SearchSuggestion> _trending;
@override@JsonKey() List<SearchSuggestion> get trending {
  if (_trending is EqualUnmodifiableListView) return _trending;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trending);
}

@override final  SearchFilters? currentFilters;
@override final  String? lastQuery;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&const DeepCollectionEquality().equals(other._history, _history)&&const DeepCollectionEquality().equals(other._trending, _trending)&&(identical(other.currentFilters, currentFilters) || other.currentFilters == currentFilters)&&(identical(other.lastQuery, lastQuery) || other.lastQuery == lastQuery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_suggestions),const DeepCollectionEquality().hash(_history),const DeepCollectionEquality().hash(_trending),currentFilters,lastQuery);

@override
String toString() {
  return 'SearchState(status: $status, errorMessage: $errorMessage, results: $results, suggestions: $suggestions, history: $history, trending: $trending, currentFilters: $currentFilters, lastQuery: $lastQuery)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 SearchStatus status, String errorMessage, List<SearchResult> results, List<SearchSuggestion> suggestions, List<SearchHistory> history, List<SearchSuggestion> trending, SearchFilters? currentFilters, String? lastQuery
});


@override $SearchFiltersCopyWith<$Res>? get currentFilters;

}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? results = null,Object? suggestions = null,Object? history = null,Object? trending = null,Object? currentFilters = freezed,Object? lastQuery = freezed,}) {
  return _then(_SearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SearchStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<SearchResult>,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<SearchSuggestion>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<SearchHistory>,trending: null == trending ? _self._trending : trending // ignore: cast_nullable_to_non_nullable
as List<SearchSuggestion>,currentFilters: freezed == currentFilters ? _self.currentFilters : currentFilters // ignore: cast_nullable_to_non_nullable
as SearchFilters?,lastQuery: freezed == lastQuery ? _self.lastQuery : lastQuery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<$Res>? get currentFilters {
    if (_self.currentFilters == null) {
    return null;
  }

  return $SearchFiltersCopyWith<$Res>(_self.currentFilters!, (value) {
    return _then(_self.copyWith(currentFilters: value));
  });
}
}

// dart format on
