// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResumeReviewState {

 ResumeReviewStatus get status; Map<String, dynamic> get data; bool get profileSynced; bool get vaultSynced; String? get errorMessage;
/// Create a copy of ResumeReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeReviewStateCopyWith<ResumeReviewState> get copyWith => _$ResumeReviewStateCopyWithImpl<ResumeReviewState>(this as ResumeReviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeReviewState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.profileSynced, profileSynced) || other.profileSynced == profileSynced)&&(identical(other.vaultSynced, vaultSynced) || other.vaultSynced == vaultSynced)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(data),profileSynced,vaultSynced,errorMessage);

@override
String toString() {
  return 'ResumeReviewState(status: $status, data: $data, profileSynced: $profileSynced, vaultSynced: $vaultSynced, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ResumeReviewStateCopyWith<$Res>  {
  factory $ResumeReviewStateCopyWith(ResumeReviewState value, $Res Function(ResumeReviewState) _then) = _$ResumeReviewStateCopyWithImpl;
@useResult
$Res call({
 ResumeReviewStatus status, Map<String, dynamic> data, bool profileSynced, bool vaultSynced, String? errorMessage
});




}
/// @nodoc
class _$ResumeReviewStateCopyWithImpl<$Res>
    implements $ResumeReviewStateCopyWith<$Res> {
  _$ResumeReviewStateCopyWithImpl(this._self, this._then);

  final ResumeReviewState _self;
  final $Res Function(ResumeReviewState) _then;

/// Create a copy of ResumeReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? data = null,Object? profileSynced = null,Object? vaultSynced = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeReviewStatus,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,profileSynced: null == profileSynced ? _self.profileSynced : profileSynced // ignore: cast_nullable_to_non_nullable
as bool,vaultSynced: null == vaultSynced ? _self.vaultSynced : vaultSynced // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeReviewState].
extension ResumeReviewStatePatterns on ResumeReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeReviewState value)  $default,){
final _that = this;
switch (_that) {
case _ResumeReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ResumeReviewStatus status,  Map<String, dynamic> data,  bool profileSynced,  bool vaultSynced,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeReviewState() when $default != null:
return $default(_that.status,_that.data,_that.profileSynced,_that.vaultSynced,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ResumeReviewStatus status,  Map<String, dynamic> data,  bool profileSynced,  bool vaultSynced,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ResumeReviewState():
return $default(_that.status,_that.data,_that.profileSynced,_that.vaultSynced,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ResumeReviewStatus status,  Map<String, dynamic> data,  bool profileSynced,  bool vaultSynced,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ResumeReviewState() when $default != null:
return $default(_that.status,_that.data,_that.profileSynced,_that.vaultSynced,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ResumeReviewState implements ResumeReviewState {
  const _ResumeReviewState({this.status = ResumeReviewStatus.initial, final  Map<String, dynamic> data = const {}, this.profileSynced = false, this.vaultSynced = false, this.errorMessage}): _data = data;
  

@override@JsonKey() final  ResumeReviewStatus status;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override@JsonKey() final  bool profileSynced;
@override@JsonKey() final  bool vaultSynced;
@override final  String? errorMessage;

/// Create a copy of ResumeReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeReviewStateCopyWith<_ResumeReviewState> get copyWith => __$ResumeReviewStateCopyWithImpl<_ResumeReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeReviewState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.profileSynced, profileSynced) || other.profileSynced == profileSynced)&&(identical(other.vaultSynced, vaultSynced) || other.vaultSynced == vaultSynced)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_data),profileSynced,vaultSynced,errorMessage);

@override
String toString() {
  return 'ResumeReviewState(status: $status, data: $data, profileSynced: $profileSynced, vaultSynced: $vaultSynced, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ResumeReviewStateCopyWith<$Res> implements $ResumeReviewStateCopyWith<$Res> {
  factory _$ResumeReviewStateCopyWith(_ResumeReviewState value, $Res Function(_ResumeReviewState) _then) = __$ResumeReviewStateCopyWithImpl;
@override @useResult
$Res call({
 ResumeReviewStatus status, Map<String, dynamic> data, bool profileSynced, bool vaultSynced, String? errorMessage
});




}
/// @nodoc
class __$ResumeReviewStateCopyWithImpl<$Res>
    implements _$ResumeReviewStateCopyWith<$Res> {
  __$ResumeReviewStateCopyWithImpl(this._self, this._then);

  final _ResumeReviewState _self;
  final $Res Function(_ResumeReviewState) _then;

/// Create a copy of ResumeReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? data = null,Object? profileSynced = null,Object? vaultSynced = null,Object? errorMessage = freezed,}) {
  return _then(_ResumeReviewState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeReviewStatus,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,profileSynced: null == profileSynced ? _self.profileSynced : profileSynced // ignore: cast_nullable_to_non_nullable
as bool,vaultSynced: null == vaultSynced ? _self.vaultSynced : vaultSynced // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
