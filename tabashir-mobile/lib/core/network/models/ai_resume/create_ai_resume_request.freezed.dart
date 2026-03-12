// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_ai_resume_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateAiResumeRequest {

 String get personalDetailsJson; String get professionalDetailsJson; String get employmentHistoryJson; String get educationJson; String get skillsJson; String get languagesJson;
/// Create a copy of CreateAiResumeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateAiResumeRequestCopyWith<CreateAiResumeRequest> get copyWith => _$CreateAiResumeRequestCopyWithImpl<CreateAiResumeRequest>(this as CreateAiResumeRequest, _$identity);

  /// Serializes this CreateAiResumeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateAiResumeRequest&&(identical(other.personalDetailsJson, personalDetailsJson) || other.personalDetailsJson == personalDetailsJson)&&(identical(other.professionalDetailsJson, professionalDetailsJson) || other.professionalDetailsJson == professionalDetailsJson)&&(identical(other.employmentHistoryJson, employmentHistoryJson) || other.employmentHistoryJson == employmentHistoryJson)&&(identical(other.educationJson, educationJson) || other.educationJson == educationJson)&&(identical(other.skillsJson, skillsJson) || other.skillsJson == skillsJson)&&(identical(other.languagesJson, languagesJson) || other.languagesJson == languagesJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personalDetailsJson,professionalDetailsJson,employmentHistoryJson,educationJson,skillsJson,languagesJson);

@override
String toString() {
  return 'CreateAiResumeRequest(personalDetailsJson: $personalDetailsJson, professionalDetailsJson: $professionalDetailsJson, employmentHistoryJson: $employmentHistoryJson, educationJson: $educationJson, skillsJson: $skillsJson, languagesJson: $languagesJson)';
}


}

/// @nodoc
abstract mixin class $CreateAiResumeRequestCopyWith<$Res>  {
  factory $CreateAiResumeRequestCopyWith(CreateAiResumeRequest value, $Res Function(CreateAiResumeRequest) _then) = _$CreateAiResumeRequestCopyWithImpl;
@useResult
$Res call({
 String personalDetailsJson, String professionalDetailsJson, String employmentHistoryJson, String educationJson, String skillsJson, String languagesJson
});




}
/// @nodoc
class _$CreateAiResumeRequestCopyWithImpl<$Res>
    implements $CreateAiResumeRequestCopyWith<$Res> {
  _$CreateAiResumeRequestCopyWithImpl(this._self, this._then);

  final CreateAiResumeRequest _self;
  final $Res Function(CreateAiResumeRequest) _then;

/// Create a copy of CreateAiResumeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personalDetailsJson = null,Object? professionalDetailsJson = null,Object? employmentHistoryJson = null,Object? educationJson = null,Object? skillsJson = null,Object? languagesJson = null,}) {
  return _then(_self.copyWith(
personalDetailsJson: null == personalDetailsJson ? _self.personalDetailsJson : personalDetailsJson // ignore: cast_nullable_to_non_nullable
as String,professionalDetailsJson: null == professionalDetailsJson ? _self.professionalDetailsJson : professionalDetailsJson // ignore: cast_nullable_to_non_nullable
as String,employmentHistoryJson: null == employmentHistoryJson ? _self.employmentHistoryJson : employmentHistoryJson // ignore: cast_nullable_to_non_nullable
as String,educationJson: null == educationJson ? _self.educationJson : educationJson // ignore: cast_nullable_to_non_nullable
as String,skillsJson: null == skillsJson ? _self.skillsJson : skillsJson // ignore: cast_nullable_to_non_nullable
as String,languagesJson: null == languagesJson ? _self.languagesJson : languagesJson // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateAiResumeRequest].
extension CreateAiResumeRequestPatterns on CreateAiResumeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateAiResumeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateAiResumeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateAiResumeRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateAiResumeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateAiResumeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateAiResumeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String personalDetailsJson,  String professionalDetailsJson,  String employmentHistoryJson,  String educationJson,  String skillsJson,  String languagesJson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateAiResumeRequest() when $default != null:
return $default(_that.personalDetailsJson,_that.professionalDetailsJson,_that.employmentHistoryJson,_that.educationJson,_that.skillsJson,_that.languagesJson);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String personalDetailsJson,  String professionalDetailsJson,  String employmentHistoryJson,  String educationJson,  String skillsJson,  String languagesJson)  $default,) {final _that = this;
switch (_that) {
case _CreateAiResumeRequest():
return $default(_that.personalDetailsJson,_that.professionalDetailsJson,_that.employmentHistoryJson,_that.educationJson,_that.skillsJson,_that.languagesJson);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String personalDetailsJson,  String professionalDetailsJson,  String employmentHistoryJson,  String educationJson,  String skillsJson,  String languagesJson)?  $default,) {final _that = this;
switch (_that) {
case _CreateAiResumeRequest() when $default != null:
return $default(_that.personalDetailsJson,_that.professionalDetailsJson,_that.employmentHistoryJson,_that.educationJson,_that.skillsJson,_that.languagesJson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateAiResumeRequest implements CreateAiResumeRequest {
  const _CreateAiResumeRequest({required this.personalDetailsJson, required this.professionalDetailsJson, required this.employmentHistoryJson, required this.educationJson, required this.skillsJson, required this.languagesJson});
  factory _CreateAiResumeRequest.fromJson(Map<String, dynamic> json) => _$CreateAiResumeRequestFromJson(json);

@override final  String personalDetailsJson;
@override final  String professionalDetailsJson;
@override final  String employmentHistoryJson;
@override final  String educationJson;
@override final  String skillsJson;
@override final  String languagesJson;

/// Create a copy of CreateAiResumeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateAiResumeRequestCopyWith<_CreateAiResumeRequest> get copyWith => __$CreateAiResumeRequestCopyWithImpl<_CreateAiResumeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateAiResumeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateAiResumeRequest&&(identical(other.personalDetailsJson, personalDetailsJson) || other.personalDetailsJson == personalDetailsJson)&&(identical(other.professionalDetailsJson, professionalDetailsJson) || other.professionalDetailsJson == professionalDetailsJson)&&(identical(other.employmentHistoryJson, employmentHistoryJson) || other.employmentHistoryJson == employmentHistoryJson)&&(identical(other.educationJson, educationJson) || other.educationJson == educationJson)&&(identical(other.skillsJson, skillsJson) || other.skillsJson == skillsJson)&&(identical(other.languagesJson, languagesJson) || other.languagesJson == languagesJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personalDetailsJson,professionalDetailsJson,employmentHistoryJson,educationJson,skillsJson,languagesJson);

@override
String toString() {
  return 'CreateAiResumeRequest(personalDetailsJson: $personalDetailsJson, professionalDetailsJson: $professionalDetailsJson, employmentHistoryJson: $employmentHistoryJson, educationJson: $educationJson, skillsJson: $skillsJson, languagesJson: $languagesJson)';
}


}

/// @nodoc
abstract mixin class _$CreateAiResumeRequestCopyWith<$Res> implements $CreateAiResumeRequestCopyWith<$Res> {
  factory _$CreateAiResumeRequestCopyWith(_CreateAiResumeRequest value, $Res Function(_CreateAiResumeRequest) _then) = __$CreateAiResumeRequestCopyWithImpl;
@override @useResult
$Res call({
 String personalDetailsJson, String professionalDetailsJson, String employmentHistoryJson, String educationJson, String skillsJson, String languagesJson
});




}
/// @nodoc
class __$CreateAiResumeRequestCopyWithImpl<$Res>
    implements _$CreateAiResumeRequestCopyWith<$Res> {
  __$CreateAiResumeRequestCopyWithImpl(this._self, this._then);

  final _CreateAiResumeRequest _self;
  final $Res Function(_CreateAiResumeRequest) _then;

/// Create a copy of CreateAiResumeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personalDetailsJson = null,Object? professionalDetailsJson = null,Object? employmentHistoryJson = null,Object? educationJson = null,Object? skillsJson = null,Object? languagesJson = null,}) {
  return _then(_CreateAiResumeRequest(
personalDetailsJson: null == personalDetailsJson ? _self.personalDetailsJson : personalDetailsJson // ignore: cast_nullable_to_non_nullable
as String,professionalDetailsJson: null == professionalDetailsJson ? _self.professionalDetailsJson : professionalDetailsJson // ignore: cast_nullable_to_non_nullable
as String,employmentHistoryJson: null == employmentHistoryJson ? _self.employmentHistoryJson : employmentHistoryJson // ignore: cast_nullable_to_non_nullable
as String,educationJson: null == educationJson ? _self.educationJson : educationJson // ignore: cast_nullable_to_non_nullable
as String,skillsJson: null == skillsJson ? _self.skillsJson : skillsJson // ignore: cast_nullable_to_non_nullable
as String,languagesJson: null == languagesJson ? _self.languagesJson : languagesJson // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
