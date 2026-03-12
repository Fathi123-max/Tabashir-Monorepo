// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_details_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeDetailsResponse {

 bool get success; ResumeItem get resume;
/// Create a copy of ResumeDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeDetailsResponseCopyWith<ResumeDetailsResponse> get copyWith => _$ResumeDetailsResponseCopyWithImpl<ResumeDetailsResponse>(this as ResumeDetailsResponse, _$identity);

  /// Serializes this ResumeDetailsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeDetailsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume);

@override
String toString() {
  return 'ResumeDetailsResponse(success: $success, resume: $resume)';
}


}

/// @nodoc
abstract mixin class $ResumeDetailsResponseCopyWith<$Res>  {
  factory $ResumeDetailsResponseCopyWith(ResumeDetailsResponse value, $Res Function(ResumeDetailsResponse) _then) = _$ResumeDetailsResponseCopyWithImpl;
@useResult
$Res call({
 bool success, ResumeItem resume
});


$ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class _$ResumeDetailsResponseCopyWithImpl<$Res>
    implements $ResumeDetailsResponseCopyWith<$Res> {
  _$ResumeDetailsResponseCopyWithImpl(this._self, this._then);

  final ResumeDetailsResponse _self;
  final $Res Function(ResumeDetailsResponse) _then;

/// Create a copy of ResumeDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? resume = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,
  ));
}
/// Create a copy of ResumeDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeItemCopyWith<$Res> get resume {
  
  return $ResumeItemCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumeDetailsResponse].
extension ResumeDetailsResponsePatterns on ResumeDetailsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeDetailsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeDetailsResponse value)  $default,){
final _that = this;
switch (_that) {
case _ResumeDetailsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeDetailsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  ResumeItem resume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeDetailsResponse() when $default != null:
return $default(_that.success,_that.resume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  ResumeItem resume)  $default,) {final _that = this;
switch (_that) {
case _ResumeDetailsResponse():
return $default(_that.success,_that.resume);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  ResumeItem resume)?  $default,) {final _that = this;
switch (_that) {
case _ResumeDetailsResponse() when $default != null:
return $default(_that.success,_that.resume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeDetailsResponse implements ResumeDetailsResponse {
  const _ResumeDetailsResponse({required this.success, required this.resume});
  factory _ResumeDetailsResponse.fromJson(Map<String, dynamic> json) => _$ResumeDetailsResponseFromJson(json);

@override final  bool success;
@override final  ResumeItem resume;

/// Create a copy of ResumeDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeDetailsResponseCopyWith<_ResumeDetailsResponse> get copyWith => __$ResumeDetailsResponseCopyWithImpl<_ResumeDetailsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeDetailsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeDetailsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume);

@override
String toString() {
  return 'ResumeDetailsResponse(success: $success, resume: $resume)';
}


}

/// @nodoc
abstract mixin class _$ResumeDetailsResponseCopyWith<$Res> implements $ResumeDetailsResponseCopyWith<$Res> {
  factory _$ResumeDetailsResponseCopyWith(_ResumeDetailsResponse value, $Res Function(_ResumeDetailsResponse) _then) = __$ResumeDetailsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, ResumeItem resume
});


@override $ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class __$ResumeDetailsResponseCopyWithImpl<$Res>
    implements _$ResumeDetailsResponseCopyWith<$Res> {
  __$ResumeDetailsResponseCopyWithImpl(this._self, this._then);

  final _ResumeDetailsResponse _self;
  final $Res Function(_ResumeDetailsResponse) _then;

/// Create a copy of ResumeDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? resume = null,}) {
  return _then(_ResumeDetailsResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,
  ));
}

/// Create a copy of ResumeDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeItemCopyWith<$Res> get resume {
  
  return $ResumeItemCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}

// dart format on
