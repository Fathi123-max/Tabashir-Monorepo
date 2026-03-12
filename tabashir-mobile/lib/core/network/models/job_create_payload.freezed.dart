// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_create_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobCreatePayload {

/// Job creation data
 JobCreate get payload;
/// Create a copy of JobCreatePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCreatePayloadCopyWith<JobCreatePayload> get copyWith => _$JobCreatePayloadCopyWithImpl<JobCreatePayload>(this as JobCreatePayload, _$identity);

  /// Serializes this JobCreatePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobCreatePayload&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payload);

@override
String toString() {
  return 'JobCreatePayload(payload: $payload)';
}


}

/// @nodoc
abstract mixin class $JobCreatePayloadCopyWith<$Res>  {
  factory $JobCreatePayloadCopyWith(JobCreatePayload value, $Res Function(JobCreatePayload) _then) = _$JobCreatePayloadCopyWithImpl;
@useResult
$Res call({
 JobCreate payload
});


$JobCreateCopyWith<$Res> get payload;

}
/// @nodoc
class _$JobCreatePayloadCopyWithImpl<$Res>
    implements $JobCreatePayloadCopyWith<$Res> {
  _$JobCreatePayloadCopyWithImpl(this._self, this._then);

  final JobCreatePayload _self;
  final $Res Function(JobCreatePayload) _then;

/// Create a copy of JobCreatePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payload = null,}) {
  return _then(_self.copyWith(
payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as JobCreate,
  ));
}
/// Create a copy of JobCreatePayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCreateCopyWith<$Res> get payload {
  
  return $JobCreateCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobCreatePayload].
extension JobCreatePayloadPatterns on JobCreatePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobCreatePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobCreatePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobCreatePayload value)  $default,){
final _that = this;
switch (_that) {
case _JobCreatePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobCreatePayload value)?  $default,){
final _that = this;
switch (_that) {
case _JobCreatePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JobCreate payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobCreatePayload() when $default != null:
return $default(_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JobCreate payload)  $default,) {final _that = this;
switch (_that) {
case _JobCreatePayload():
return $default(_that.payload);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JobCreate payload)?  $default,) {final _that = this;
switch (_that) {
case _JobCreatePayload() when $default != null:
return $default(_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobCreatePayload implements JobCreatePayload {
  const _JobCreatePayload({required this.payload});
  factory _JobCreatePayload.fromJson(Map<String, dynamic> json) => _$JobCreatePayloadFromJson(json);

/// Job creation data
@override final  JobCreate payload;

/// Create a copy of JobCreatePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCreatePayloadCopyWith<_JobCreatePayload> get copyWith => __$JobCreatePayloadCopyWithImpl<_JobCreatePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobCreatePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobCreatePayload&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payload);

@override
String toString() {
  return 'JobCreatePayload(payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$JobCreatePayloadCopyWith<$Res> implements $JobCreatePayloadCopyWith<$Res> {
  factory _$JobCreatePayloadCopyWith(_JobCreatePayload value, $Res Function(_JobCreatePayload) _then) = __$JobCreatePayloadCopyWithImpl;
@override @useResult
$Res call({
 JobCreate payload
});


@override $JobCreateCopyWith<$Res> get payload;

}
/// @nodoc
class __$JobCreatePayloadCopyWithImpl<$Res>
    implements _$JobCreatePayloadCopyWith<$Res> {
  __$JobCreatePayloadCopyWithImpl(this._self, this._then);

  final _JobCreatePayload _self;
  final $Res Function(_JobCreatePayload) _then;

/// Create a copy of JobCreatePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? payload = null,}) {
  return _then(_JobCreatePayload(
payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as JobCreate,
  ));
}

/// Create a copy of JobCreatePayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCreateCopyWith<$Res> get payload {
  
  return $JobCreateCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}

// dart format on
