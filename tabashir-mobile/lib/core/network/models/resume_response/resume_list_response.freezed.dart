// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeListResponse {

 bool get success; List<ResumeItem> get resumes;
/// Create a copy of ResumeListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeListResponseCopyWith<ResumeListResponse> get copyWith => _$ResumeListResponseCopyWithImpl<ResumeListResponse>(this as ResumeListResponse, _$identity);

  /// Serializes this ResumeListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeListResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.resumes, resumes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(resumes));

@override
String toString() {
  return 'ResumeListResponse(success: $success, resumes: $resumes)';
}


}

/// @nodoc
abstract mixin class $ResumeListResponseCopyWith<$Res>  {
  factory $ResumeListResponseCopyWith(ResumeListResponse value, $Res Function(ResumeListResponse) _then) = _$ResumeListResponseCopyWithImpl;
@useResult
$Res call({
 bool success, List<ResumeItem> resumes
});




}
/// @nodoc
class _$ResumeListResponseCopyWithImpl<$Res>
    implements $ResumeListResponseCopyWith<$Res> {
  _$ResumeListResponseCopyWithImpl(this._self, this._then);

  final ResumeListResponse _self;
  final $Res Function(ResumeListResponse) _then;

/// Create a copy of ResumeListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? resumes = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resumes: null == resumes ? _self.resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeListResponse].
extension ResumeListResponsePatterns on ResumeListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeListResponse value)  $default,){
final _that = this;
switch (_that) {
case _ResumeListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  List<ResumeItem> resumes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeListResponse() when $default != null:
return $default(_that.success,_that.resumes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  List<ResumeItem> resumes)  $default,) {final _that = this;
switch (_that) {
case _ResumeListResponse():
return $default(_that.success,_that.resumes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  List<ResumeItem> resumes)?  $default,) {final _that = this;
switch (_that) {
case _ResumeListResponse() when $default != null:
return $default(_that.success,_that.resumes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeListResponse implements ResumeListResponse {
  const _ResumeListResponse({required this.success, required final  List<ResumeItem> resumes}): _resumes = resumes;
  factory _ResumeListResponse.fromJson(Map<String, dynamic> json) => _$ResumeListResponseFromJson(json);

@override final  bool success;
 final  List<ResumeItem> _resumes;
@override List<ResumeItem> get resumes {
  if (_resumes is EqualUnmodifiableListView) return _resumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resumes);
}


/// Create a copy of ResumeListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeListResponseCopyWith<_ResumeListResponse> get copyWith => __$ResumeListResponseCopyWithImpl<_ResumeListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeListResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._resumes, _resumes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_resumes));

@override
String toString() {
  return 'ResumeListResponse(success: $success, resumes: $resumes)';
}


}

/// @nodoc
abstract mixin class _$ResumeListResponseCopyWith<$Res> implements $ResumeListResponseCopyWith<$Res> {
  factory _$ResumeListResponseCopyWith(_ResumeListResponse value, $Res Function(_ResumeListResponse) _then) = __$ResumeListResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, List<ResumeItem> resumes
});




}
/// @nodoc
class __$ResumeListResponseCopyWithImpl<$Res>
    implements _$ResumeListResponseCopyWith<$Res> {
  __$ResumeListResponseCopyWithImpl(this._self, this._then);

  final _ResumeListResponse _self;
  final $Res Function(_ResumeListResponse) _then;

/// Create a copy of ResumeListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? resumes = null,}) {
  return _then(_ResumeListResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resumes: null == resumes ? _self._resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeItem>,
  ));
}


}

// dart format on
