// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_vault_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResumeVaultState {

 ResumeVaultStatus get status; List<ResumeItem> get resumes; String? get errorMessage;
/// Create a copy of ResumeVaultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeVaultStateCopyWith<ResumeVaultState> get copyWith => _$ResumeVaultStateCopyWithImpl<ResumeVaultState>(this as ResumeVaultState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeVaultState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.resumes, resumes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(resumes),errorMessage);

@override
String toString() {
  return 'ResumeVaultState(status: $status, resumes: $resumes, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ResumeVaultStateCopyWith<$Res>  {
  factory $ResumeVaultStateCopyWith(ResumeVaultState value, $Res Function(ResumeVaultState) _then) = _$ResumeVaultStateCopyWithImpl;
@useResult
$Res call({
 ResumeVaultStatus status, List<ResumeItem> resumes, String? errorMessage
});




}
/// @nodoc
class _$ResumeVaultStateCopyWithImpl<$Res>
    implements $ResumeVaultStateCopyWith<$Res> {
  _$ResumeVaultStateCopyWithImpl(this._self, this._then);

  final ResumeVaultState _self;
  final $Res Function(ResumeVaultState) _then;

/// Create a copy of ResumeVaultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? resumes = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeVaultStatus,resumes: null == resumes ? _self.resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeVaultState].
extension ResumeVaultStatePatterns on ResumeVaultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeVaultState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeVaultState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeVaultState value)  $default,){
final _that = this;
switch (_that) {
case _ResumeVaultState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeVaultState value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeVaultState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ResumeVaultStatus status,  List<ResumeItem> resumes,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeVaultState() when $default != null:
return $default(_that.status,_that.resumes,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ResumeVaultStatus status,  List<ResumeItem> resumes,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ResumeVaultState():
return $default(_that.status,_that.resumes,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ResumeVaultStatus status,  List<ResumeItem> resumes,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ResumeVaultState() when $default != null:
return $default(_that.status,_that.resumes,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ResumeVaultState extends ResumeVaultState {
  const _ResumeVaultState({this.status = ResumeVaultStatus.initial, final  List<ResumeItem> resumes = const <ResumeItem>[], this.errorMessage}): _resumes = resumes,super._();
  

@override@JsonKey() final  ResumeVaultStatus status;
 final  List<ResumeItem> _resumes;
@override@JsonKey() List<ResumeItem> get resumes {
  if (_resumes is EqualUnmodifiableListView) return _resumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resumes);
}

@override final  String? errorMessage;

/// Create a copy of ResumeVaultState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeVaultStateCopyWith<_ResumeVaultState> get copyWith => __$ResumeVaultStateCopyWithImpl<_ResumeVaultState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeVaultState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._resumes, _resumes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_resumes),errorMessage);

@override
String toString() {
  return 'ResumeVaultState(status: $status, resumes: $resumes, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ResumeVaultStateCopyWith<$Res> implements $ResumeVaultStateCopyWith<$Res> {
  factory _$ResumeVaultStateCopyWith(_ResumeVaultState value, $Res Function(_ResumeVaultState) _then) = __$ResumeVaultStateCopyWithImpl;
@override @useResult
$Res call({
 ResumeVaultStatus status, List<ResumeItem> resumes, String? errorMessage
});




}
/// @nodoc
class __$ResumeVaultStateCopyWithImpl<$Res>
    implements _$ResumeVaultStateCopyWith<$Res> {
  __$ResumeVaultStateCopyWithImpl(this._self, this._then);

  final _ResumeVaultState _self;
  final $Res Function(_ResumeVaultState) _then;

/// Create a copy of ResumeVaultState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? resumes = null,Object? errorMessage = freezed,}) {
  return _then(_ResumeVaultState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeVaultStatus,resumes: null == resumes ? _self._resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
