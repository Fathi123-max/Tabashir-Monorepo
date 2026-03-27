// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggest_job_titles_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuggestJobTitlesResponse {

 bool get success;@JsonKey(name: 'suggested_job_titles') List<String> get suggestedJobTitles;
/// Create a copy of SuggestJobTitlesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuggestJobTitlesResponseCopyWith<SuggestJobTitlesResponse> get copyWith => _$SuggestJobTitlesResponseCopyWithImpl<SuggestJobTitlesResponse>(this as SuggestJobTitlesResponse, _$identity);

  /// Serializes this SuggestJobTitlesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuggestJobTitlesResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.suggestedJobTitles, suggestedJobTitles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(suggestedJobTitles));

@override
String toString() {
  return 'SuggestJobTitlesResponse(success: $success, suggestedJobTitles: $suggestedJobTitles)';
}


}

/// @nodoc
abstract mixin class $SuggestJobTitlesResponseCopyWith<$Res>  {
  factory $SuggestJobTitlesResponseCopyWith(SuggestJobTitlesResponse value, $Res Function(SuggestJobTitlesResponse) _then) = _$SuggestJobTitlesResponseCopyWithImpl;
@useResult
$Res call({
 bool success,@JsonKey(name: 'suggested_job_titles') List<String> suggestedJobTitles
});




}
/// @nodoc
class _$SuggestJobTitlesResponseCopyWithImpl<$Res>
    implements $SuggestJobTitlesResponseCopyWith<$Res> {
  _$SuggestJobTitlesResponseCopyWithImpl(this._self, this._then);

  final SuggestJobTitlesResponse _self;
  final $Res Function(SuggestJobTitlesResponse) _then;

/// Create a copy of SuggestJobTitlesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? suggestedJobTitles = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,suggestedJobTitles: null == suggestedJobTitles ? _self.suggestedJobTitles : suggestedJobTitles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SuggestJobTitlesResponse].
extension SuggestJobTitlesResponsePatterns on SuggestJobTitlesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuggestJobTitlesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuggestJobTitlesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuggestJobTitlesResponse value)  $default,){
final _that = this;
switch (_that) {
case _SuggestJobTitlesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuggestJobTitlesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SuggestJobTitlesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success, @JsonKey(name: 'suggested_job_titles')  List<String> suggestedJobTitles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuggestJobTitlesResponse() when $default != null:
return $default(_that.success,_that.suggestedJobTitles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success, @JsonKey(name: 'suggested_job_titles')  List<String> suggestedJobTitles)  $default,) {final _that = this;
switch (_that) {
case _SuggestJobTitlesResponse():
return $default(_that.success,_that.suggestedJobTitles);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success, @JsonKey(name: 'suggested_job_titles')  List<String> suggestedJobTitles)?  $default,) {final _that = this;
switch (_that) {
case _SuggestJobTitlesResponse() when $default != null:
return $default(_that.success,_that.suggestedJobTitles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuggestJobTitlesResponse implements SuggestJobTitlesResponse {
  const _SuggestJobTitlesResponse({required this.success, @JsonKey(name: 'suggested_job_titles') required final  List<String> suggestedJobTitles}): _suggestedJobTitles = suggestedJobTitles;
  factory _SuggestJobTitlesResponse.fromJson(Map<String, dynamic> json) => _$SuggestJobTitlesResponseFromJson(json);

@override final  bool success;
 final  List<String> _suggestedJobTitles;
@override@JsonKey(name: 'suggested_job_titles') List<String> get suggestedJobTitles {
  if (_suggestedJobTitles is EqualUnmodifiableListView) return _suggestedJobTitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestedJobTitles);
}


/// Create a copy of SuggestJobTitlesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuggestJobTitlesResponseCopyWith<_SuggestJobTitlesResponse> get copyWith => __$SuggestJobTitlesResponseCopyWithImpl<_SuggestJobTitlesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuggestJobTitlesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuggestJobTitlesResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._suggestedJobTitles, _suggestedJobTitles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_suggestedJobTitles));

@override
String toString() {
  return 'SuggestJobTitlesResponse(success: $success, suggestedJobTitles: $suggestedJobTitles)';
}


}

/// @nodoc
abstract mixin class _$SuggestJobTitlesResponseCopyWith<$Res> implements $SuggestJobTitlesResponseCopyWith<$Res> {
  factory _$SuggestJobTitlesResponseCopyWith(_SuggestJobTitlesResponse value, $Res Function(_SuggestJobTitlesResponse) _then) = __$SuggestJobTitlesResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success,@JsonKey(name: 'suggested_job_titles') List<String> suggestedJobTitles
});




}
/// @nodoc
class __$SuggestJobTitlesResponseCopyWithImpl<$Res>
    implements _$SuggestJobTitlesResponseCopyWith<$Res> {
  __$SuggestJobTitlesResponseCopyWithImpl(this._self, this._then);

  final _SuggestJobTitlesResponse _self;
  final $Res Function(_SuggestJobTitlesResponse) _then;

/// Create a copy of SuggestJobTitlesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? suggestedJobTitles = null,}) {
  return _then(_SuggestJobTitlesResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,suggestedJobTitles: null == suggestedJobTitles ? _self._suggestedJobTitles : suggestedJobTitles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
