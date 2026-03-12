// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_resume_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiResumeState {

 AiResumeStatus get status; String get errorMessage; CreateAiResumeResponse? get resume;
/// Create a copy of AiResumeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResumeStateCopyWith<AiResumeState> get copyWith => _$AiResumeStateCopyWithImpl<AiResumeState>(this as AiResumeState, _$identity);

  /// Serializes this AiResumeState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResumeState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.resume, resume) || other.resume == resume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,resume);

@override
String toString() {
  return 'AiResumeState(status: $status, errorMessage: $errorMessage, resume: $resume)';
}


}

/// @nodoc
abstract mixin class $AiResumeStateCopyWith<$Res>  {
  factory $AiResumeStateCopyWith(AiResumeState value, $Res Function(AiResumeState) _then) = _$AiResumeStateCopyWithImpl;
@useResult
$Res call({
 AiResumeStatus status, String errorMessage, CreateAiResumeResponse? resume
});


$CreateAiResumeResponseCopyWith<$Res>? get resume;

}
/// @nodoc
class _$AiResumeStateCopyWithImpl<$Res>
    implements $AiResumeStateCopyWith<$Res> {
  _$AiResumeStateCopyWithImpl(this._self, this._then);

  final AiResumeState _self;
  final $Res Function(AiResumeState) _then;

/// Create a copy of AiResumeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? resume = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiResumeStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,resume: freezed == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as CreateAiResumeResponse?,
  ));
}
/// Create a copy of AiResumeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreateAiResumeResponseCopyWith<$Res>? get resume {
    if (_self.resume == null) {
    return null;
  }

  return $CreateAiResumeResponseCopyWith<$Res>(_self.resume!, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiResumeState].
extension AiResumeStatePatterns on AiResumeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiResumeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiResumeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiResumeState value)  $default,){
final _that = this;
switch (_that) {
case _AiResumeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiResumeState value)?  $default,){
final _that = this;
switch (_that) {
case _AiResumeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiResumeStatus status,  String errorMessage,  CreateAiResumeResponse? resume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiResumeState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.resume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiResumeStatus status,  String errorMessage,  CreateAiResumeResponse? resume)  $default,) {final _that = this;
switch (_that) {
case _AiResumeState():
return $default(_that.status,_that.errorMessage,_that.resume);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiResumeStatus status,  String errorMessage,  CreateAiResumeResponse? resume)?  $default,) {final _that = this;
switch (_that) {
case _AiResumeState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.resume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiResumeState implements AiResumeState {
  const _AiResumeState({this.status = AiResumeStatus.initial, this.errorMessage = '', this.resume});
  factory _AiResumeState.fromJson(Map<String, dynamic> json) => _$AiResumeStateFromJson(json);

@override@JsonKey() final  AiResumeStatus status;
@override@JsonKey() final  String errorMessage;
@override final  CreateAiResumeResponse? resume;

/// Create a copy of AiResumeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiResumeStateCopyWith<_AiResumeState> get copyWith => __$AiResumeStateCopyWithImpl<_AiResumeState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiResumeStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiResumeState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.resume, resume) || other.resume == resume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,resume);

@override
String toString() {
  return 'AiResumeState(status: $status, errorMessage: $errorMessage, resume: $resume)';
}


}

/// @nodoc
abstract mixin class _$AiResumeStateCopyWith<$Res> implements $AiResumeStateCopyWith<$Res> {
  factory _$AiResumeStateCopyWith(_AiResumeState value, $Res Function(_AiResumeState) _then) = __$AiResumeStateCopyWithImpl;
@override @useResult
$Res call({
 AiResumeStatus status, String errorMessage, CreateAiResumeResponse? resume
});


@override $CreateAiResumeResponseCopyWith<$Res>? get resume;

}
/// @nodoc
class __$AiResumeStateCopyWithImpl<$Res>
    implements _$AiResumeStateCopyWith<$Res> {
  __$AiResumeStateCopyWithImpl(this._self, this._then);

  final _AiResumeState _self;
  final $Res Function(_AiResumeState) _then;

/// Create a copy of AiResumeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? resume = freezed,}) {
  return _then(_AiResumeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiResumeStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,resume: freezed == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as CreateAiResumeResponse?,
  ));
}

/// Create a copy of AiResumeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreateAiResumeResponseCopyWith<$Res>? get resume {
    if (_self.resume == null) {
    return null;
  }

  return $CreateAiResumeResponseCopyWith<$Res>(_self.resume!, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}

// dart format on
