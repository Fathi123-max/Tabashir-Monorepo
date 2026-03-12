// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeState {

 ResumeCubitStatus get status; String get errorMessage; List<Resume> get resumes; Resume? get currentResume; String? get exportUrl;
/// Create a copy of ResumeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeStateCopyWith<ResumeState> get copyWith => _$ResumeStateCopyWithImpl<ResumeState>(this as ResumeState, _$identity);

  /// Serializes this ResumeState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.resumes, resumes)&&(identical(other.currentResume, currentResume) || other.currentResume == currentResume)&&(identical(other.exportUrl, exportUrl) || other.exportUrl == exportUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(resumes),currentResume,exportUrl);

@override
String toString() {
  return 'ResumeState(status: $status, errorMessage: $errorMessage, resumes: $resumes, currentResume: $currentResume, exportUrl: $exportUrl)';
}


}

/// @nodoc
abstract mixin class $ResumeStateCopyWith<$Res>  {
  factory $ResumeStateCopyWith(ResumeState value, $Res Function(ResumeState) _then) = _$ResumeStateCopyWithImpl;
@useResult
$Res call({
 ResumeCubitStatus status, String errorMessage, List<Resume> resumes, Resume? currentResume, String? exportUrl
});


$ResumeCopyWith<$Res>? get currentResume;

}
/// @nodoc
class _$ResumeStateCopyWithImpl<$Res>
    implements $ResumeStateCopyWith<$Res> {
  _$ResumeStateCopyWithImpl(this._self, this._then);

  final ResumeState _self;
  final $Res Function(ResumeState) _then;

/// Create a copy of ResumeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? resumes = null,Object? currentResume = freezed,Object? exportUrl = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeCubitStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,resumes: null == resumes ? _self.resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<Resume>,currentResume: freezed == currentResume ? _self.currentResume : currentResume // ignore: cast_nullable_to_non_nullable
as Resume?,exportUrl: freezed == exportUrl ? _self.exportUrl : exportUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ResumeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeCopyWith<$Res>? get currentResume {
    if (_self.currentResume == null) {
    return null;
  }

  return $ResumeCopyWith<$Res>(_self.currentResume!, (value) {
    return _then(_self.copyWith(currentResume: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumeState].
extension ResumeStatePatterns on ResumeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeState value)  $default,){
final _that = this;
switch (_that) {
case _ResumeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeState value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ResumeCubitStatus status,  String errorMessage,  List<Resume> resumes,  Resume? currentResume,  String? exportUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.resumes,_that.currentResume,_that.exportUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ResumeCubitStatus status,  String errorMessage,  List<Resume> resumes,  Resume? currentResume,  String? exportUrl)  $default,) {final _that = this;
switch (_that) {
case _ResumeState():
return $default(_that.status,_that.errorMessage,_that.resumes,_that.currentResume,_that.exportUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ResumeCubitStatus status,  String errorMessage,  List<Resume> resumes,  Resume? currentResume,  String? exportUrl)?  $default,) {final _that = this;
switch (_that) {
case _ResumeState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.resumes,_that.currentResume,_that.exportUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeState implements ResumeState {
  const _ResumeState({this.status = ResumeCubitStatus.initial, this.errorMessage = '', final  List<Resume> resumes = const [], this.currentResume, this.exportUrl}): _resumes = resumes;
  factory _ResumeState.fromJson(Map<String, dynamic> json) => _$ResumeStateFromJson(json);

@override@JsonKey() final  ResumeCubitStatus status;
@override@JsonKey() final  String errorMessage;
 final  List<Resume> _resumes;
@override@JsonKey() List<Resume> get resumes {
  if (_resumes is EqualUnmodifiableListView) return _resumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resumes);
}

@override final  Resume? currentResume;
@override final  String? exportUrl;

/// Create a copy of ResumeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeStateCopyWith<_ResumeState> get copyWith => __$ResumeStateCopyWithImpl<_ResumeState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._resumes, _resumes)&&(identical(other.currentResume, currentResume) || other.currentResume == currentResume)&&(identical(other.exportUrl, exportUrl) || other.exportUrl == exportUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(_resumes),currentResume,exportUrl);

@override
String toString() {
  return 'ResumeState(status: $status, errorMessage: $errorMessage, resumes: $resumes, currentResume: $currentResume, exportUrl: $exportUrl)';
}


}

/// @nodoc
abstract mixin class _$ResumeStateCopyWith<$Res> implements $ResumeStateCopyWith<$Res> {
  factory _$ResumeStateCopyWith(_ResumeState value, $Res Function(_ResumeState) _then) = __$ResumeStateCopyWithImpl;
@override @useResult
$Res call({
 ResumeCubitStatus status, String errorMessage, List<Resume> resumes, Resume? currentResume, String? exportUrl
});


@override $ResumeCopyWith<$Res>? get currentResume;

}
/// @nodoc
class __$ResumeStateCopyWithImpl<$Res>
    implements _$ResumeStateCopyWith<$Res> {
  __$ResumeStateCopyWithImpl(this._self, this._then);

  final _ResumeState _self;
  final $Res Function(_ResumeState) _then;

/// Create a copy of ResumeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? resumes = null,Object? currentResume = freezed,Object? exportUrl = freezed,}) {
  return _then(_ResumeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeCubitStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,resumes: null == resumes ? _self._resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<Resume>,currentResume: freezed == currentResume ? _self.currentResume : currentResume // ignore: cast_nullable_to_non_nullable
as Resume?,exportUrl: freezed == exportUrl ? _self.exportUrl : exportUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ResumeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeCopyWith<$Res>? get currentResume {
    if (_self.currentResume == null) {
    return null;
  }

  return $ResumeCopyWith<$Res>(_self.currentResume!, (value) {
    return _then(_self.copyWith(currentResume: value));
  });
}
}

// dart format on
