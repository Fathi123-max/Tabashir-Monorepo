// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_docx_from_json_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerateDocxFromJsonRequest {

/// Structured resume data in JSON format
@JsonKey(name: 'formatted_resume') Map<String, dynamic> get formattedResume;/// Output language: 'regular' or 'arabic'
 String? get outputLanguage;
/// Create a copy of GenerateDocxFromJsonRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerateDocxFromJsonRequestCopyWith<GenerateDocxFromJsonRequest> get copyWith => _$GenerateDocxFromJsonRequestCopyWithImpl<GenerateDocxFromJsonRequest>(this as GenerateDocxFromJsonRequest, _$identity);

  /// Serializes this GenerateDocxFromJsonRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerateDocxFromJsonRequest&&const DeepCollectionEquality().equals(other.formattedResume, formattedResume)&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(formattedResume),outputLanguage);

@override
String toString() {
  return 'GenerateDocxFromJsonRequest(formattedResume: $formattedResume, outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class $GenerateDocxFromJsonRequestCopyWith<$Res>  {
  factory $GenerateDocxFromJsonRequestCopyWith(GenerateDocxFromJsonRequest value, $Res Function(GenerateDocxFromJsonRequest) _then) = _$GenerateDocxFromJsonRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'formatted_resume') Map<String, dynamic> formattedResume, String? outputLanguage
});




}
/// @nodoc
class _$GenerateDocxFromJsonRequestCopyWithImpl<$Res>
    implements $GenerateDocxFromJsonRequestCopyWith<$Res> {
  _$GenerateDocxFromJsonRequestCopyWithImpl(this._self, this._then);

  final GenerateDocxFromJsonRequest _self;
  final $Res Function(GenerateDocxFromJsonRequest) _then;

/// Create a copy of GenerateDocxFromJsonRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formattedResume = null,Object? outputLanguage = freezed,}) {
  return _then(_self.copyWith(
formattedResume: null == formattedResume ? _self.formattedResume : formattedResume // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerateDocxFromJsonRequest].
extension GenerateDocxFromJsonRequestPatterns on GenerateDocxFromJsonRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerateDocxFromJsonRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerateDocxFromJsonRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerateDocxFromJsonRequest value)  $default,){
final _that = this;
switch (_that) {
case _GenerateDocxFromJsonRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerateDocxFromJsonRequest value)?  $default,){
final _that = this;
switch (_that) {
case _GenerateDocxFromJsonRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'formatted_resume')  Map<String, dynamic> formattedResume,  String? outputLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerateDocxFromJsonRequest() when $default != null:
return $default(_that.formattedResume,_that.outputLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'formatted_resume')  Map<String, dynamic> formattedResume,  String? outputLanguage)  $default,) {final _that = this;
switch (_that) {
case _GenerateDocxFromJsonRequest():
return $default(_that.formattedResume,_that.outputLanguage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'formatted_resume')  Map<String, dynamic> formattedResume,  String? outputLanguage)?  $default,) {final _that = this;
switch (_that) {
case _GenerateDocxFromJsonRequest() when $default != null:
return $default(_that.formattedResume,_that.outputLanguage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenerateDocxFromJsonRequest implements GenerateDocxFromJsonRequest {
  const _GenerateDocxFromJsonRequest({@JsonKey(name: 'formatted_resume') required final  Map<String, dynamic> formattedResume, this.outputLanguage = 'regular'}): _formattedResume = formattedResume;
  factory _GenerateDocxFromJsonRequest.fromJson(Map<String, dynamic> json) => _$GenerateDocxFromJsonRequestFromJson(json);

/// Structured resume data in JSON format
 final  Map<String, dynamic> _formattedResume;
/// Structured resume data in JSON format
@override@JsonKey(name: 'formatted_resume') Map<String, dynamic> get formattedResume {
  if (_formattedResume is EqualUnmodifiableMapView) return _formattedResume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_formattedResume);
}

/// Output language: 'regular' or 'arabic'
@override@JsonKey() final  String? outputLanguage;

/// Create a copy of GenerateDocxFromJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerateDocxFromJsonRequestCopyWith<_GenerateDocxFromJsonRequest> get copyWith => __$GenerateDocxFromJsonRequestCopyWithImpl<_GenerateDocxFromJsonRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerateDocxFromJsonRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateDocxFromJsonRequest&&const DeepCollectionEquality().equals(other._formattedResume, _formattedResume)&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_formattedResume),outputLanguage);

@override
String toString() {
  return 'GenerateDocxFromJsonRequest(formattedResume: $formattedResume, outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class _$GenerateDocxFromJsonRequestCopyWith<$Res> implements $GenerateDocxFromJsonRequestCopyWith<$Res> {
  factory _$GenerateDocxFromJsonRequestCopyWith(_GenerateDocxFromJsonRequest value, $Res Function(_GenerateDocxFromJsonRequest) _then) = __$GenerateDocxFromJsonRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'formatted_resume') Map<String, dynamic> formattedResume, String? outputLanguage
});




}
/// @nodoc
class __$GenerateDocxFromJsonRequestCopyWithImpl<$Res>
    implements _$GenerateDocxFromJsonRequestCopyWith<$Res> {
  __$GenerateDocxFromJsonRequestCopyWithImpl(this._self, this._then);

  final _GenerateDocxFromJsonRequest _self;
  final $Res Function(_GenerateDocxFromJsonRequest) _then;

/// Create a copy of GenerateDocxFromJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formattedResume = null,Object? outputLanguage = freezed,}) {
  return _then(_GenerateDocxFromJsonRequest(
formattedResume: null == formattedResume ? _self._formattedResume : formattedResume // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
