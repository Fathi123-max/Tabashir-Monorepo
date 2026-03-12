// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'formatted_cv_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormattedCVResponse {

@JsonKey(name: 'formatted_resume') Map<String, dynamic> get formattedResume;
/// Create a copy of FormattedCVResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormattedCVResponseCopyWith<FormattedCVResponse> get copyWith => _$FormattedCVResponseCopyWithImpl<FormattedCVResponse>(this as FormattedCVResponse, _$identity);

  /// Serializes this FormattedCVResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormattedCVResponse&&const DeepCollectionEquality().equals(other.formattedResume, formattedResume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(formattedResume));

@override
String toString() {
  return 'FormattedCVResponse(formattedResume: $formattedResume)';
}


}

/// @nodoc
abstract mixin class $FormattedCVResponseCopyWith<$Res>  {
  factory $FormattedCVResponseCopyWith(FormattedCVResponse value, $Res Function(FormattedCVResponse) _then) = _$FormattedCVResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'formatted_resume') Map<String, dynamic> formattedResume
});




}
/// @nodoc
class _$FormattedCVResponseCopyWithImpl<$Res>
    implements $FormattedCVResponseCopyWith<$Res> {
  _$FormattedCVResponseCopyWithImpl(this._self, this._then);

  final FormattedCVResponse _self;
  final $Res Function(FormattedCVResponse) _then;

/// Create a copy of FormattedCVResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formattedResume = null,}) {
  return _then(_self.copyWith(
formattedResume: null == formattedResume ? _self.formattedResume : formattedResume // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [FormattedCVResponse].
extension FormattedCVResponsePatterns on FormattedCVResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormattedCVResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormattedCVResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormattedCVResponse value)  $default,){
final _that = this;
switch (_that) {
case _FormattedCVResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormattedCVResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FormattedCVResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'formatted_resume')  Map<String, dynamic> formattedResume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormattedCVResponse() when $default != null:
return $default(_that.formattedResume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'formatted_resume')  Map<String, dynamic> formattedResume)  $default,) {final _that = this;
switch (_that) {
case _FormattedCVResponse():
return $default(_that.formattedResume);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'formatted_resume')  Map<String, dynamic> formattedResume)?  $default,) {final _that = this;
switch (_that) {
case _FormattedCVResponse() when $default != null:
return $default(_that.formattedResume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormattedCVResponse implements FormattedCVResponse {
  const _FormattedCVResponse({@JsonKey(name: 'formatted_resume') required final  Map<String, dynamic> formattedResume}): _formattedResume = formattedResume;
  factory _FormattedCVResponse.fromJson(Map<String, dynamic> json) => _$FormattedCVResponseFromJson(json);

 final  Map<String, dynamic> _formattedResume;
@override@JsonKey(name: 'formatted_resume') Map<String, dynamic> get formattedResume {
  if (_formattedResume is EqualUnmodifiableMapView) return _formattedResume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_formattedResume);
}


/// Create a copy of FormattedCVResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormattedCVResponseCopyWith<_FormattedCVResponse> get copyWith => __$FormattedCVResponseCopyWithImpl<_FormattedCVResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormattedCVResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormattedCVResponse&&const DeepCollectionEquality().equals(other._formattedResume, _formattedResume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_formattedResume));

@override
String toString() {
  return 'FormattedCVResponse(formattedResume: $formattedResume)';
}


}

/// @nodoc
abstract mixin class _$FormattedCVResponseCopyWith<$Res> implements $FormattedCVResponseCopyWith<$Res> {
  factory _$FormattedCVResponseCopyWith(_FormattedCVResponse value, $Res Function(_FormattedCVResponse) _then) = __$FormattedCVResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'formatted_resume') Map<String, dynamic> formattedResume
});




}
/// @nodoc
class __$FormattedCVResponseCopyWithImpl<$Res>
    implements _$FormattedCVResponseCopyWith<$Res> {
  __$FormattedCVResponseCopyWithImpl(this._self, this._then);

  final _FormattedCVResponse _self;
  final $Res Function(_FormattedCVResponse) _then;

/// Create a copy of FormattedCVResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formattedResume = null,}) {
  return _then(_FormattedCVResponse(
formattedResume: null == formattedResume ? _self._formattedResume : formattedResume // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
