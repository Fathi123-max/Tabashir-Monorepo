// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_and_generate_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaveAndGenerateRequest {

 ResumeData get resumeData; String? get templateId; String? get filename; String? get paymentIntentId;
/// Create a copy of SaveAndGenerateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveAndGenerateRequestCopyWith<SaveAndGenerateRequest> get copyWith => _$SaveAndGenerateRequestCopyWithImpl<SaveAndGenerateRequest>(this as SaveAndGenerateRequest, _$identity);

  /// Serializes this SaveAndGenerateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveAndGenerateRequest&&(identical(other.resumeData, resumeData) || other.resumeData == resumeData)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resumeData,templateId,filename,paymentIntentId);

@override
String toString() {
  return 'SaveAndGenerateRequest(resumeData: $resumeData, templateId: $templateId, filename: $filename, paymentIntentId: $paymentIntentId)';
}


}

/// @nodoc
abstract mixin class $SaveAndGenerateRequestCopyWith<$Res>  {
  factory $SaveAndGenerateRequestCopyWith(SaveAndGenerateRequest value, $Res Function(SaveAndGenerateRequest) _then) = _$SaveAndGenerateRequestCopyWithImpl;
@useResult
$Res call({
 ResumeData resumeData, String? templateId, String? filename, String? paymentIntentId
});


$ResumeDataCopyWith<$Res> get resumeData;

}
/// @nodoc
class _$SaveAndGenerateRequestCopyWithImpl<$Res>
    implements $SaveAndGenerateRequestCopyWith<$Res> {
  _$SaveAndGenerateRequestCopyWithImpl(this._self, this._then);

  final SaveAndGenerateRequest _self;
  final $Res Function(SaveAndGenerateRequest) _then;

/// Create a copy of SaveAndGenerateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resumeData = null,Object? templateId = freezed,Object? filename = freezed,Object? paymentIntentId = freezed,}) {
  return _then(_self.copyWith(
resumeData: null == resumeData ? _self.resumeData : resumeData // ignore: cast_nullable_to_non_nullable
as ResumeData,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SaveAndGenerateRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<$Res> get resumeData {
  
  return $ResumeDataCopyWith<$Res>(_self.resumeData, (value) {
    return _then(_self.copyWith(resumeData: value));
  });
}
}


/// Adds pattern-matching-related methods to [SaveAndGenerateRequest].
extension SaveAndGenerateRequestPatterns on SaveAndGenerateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaveAndGenerateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaveAndGenerateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaveAndGenerateRequest value)  $default,){
final _that = this;
switch (_that) {
case _SaveAndGenerateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaveAndGenerateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SaveAndGenerateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ResumeData resumeData,  String? templateId,  String? filename,  String? paymentIntentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaveAndGenerateRequest() when $default != null:
return $default(_that.resumeData,_that.templateId,_that.filename,_that.paymentIntentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ResumeData resumeData,  String? templateId,  String? filename,  String? paymentIntentId)  $default,) {final _that = this;
switch (_that) {
case _SaveAndGenerateRequest():
return $default(_that.resumeData,_that.templateId,_that.filename,_that.paymentIntentId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ResumeData resumeData,  String? templateId,  String? filename,  String? paymentIntentId)?  $default,) {final _that = this;
switch (_that) {
case _SaveAndGenerateRequest() when $default != null:
return $default(_that.resumeData,_that.templateId,_that.filename,_that.paymentIntentId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _SaveAndGenerateRequest implements SaveAndGenerateRequest {
  const _SaveAndGenerateRequest({required this.resumeData, this.templateId, this.filename, this.paymentIntentId});
  factory _SaveAndGenerateRequest.fromJson(Map<String, dynamic> json) => _$SaveAndGenerateRequestFromJson(json);

@override final  ResumeData resumeData;
@override final  String? templateId;
@override final  String? filename;
@override final  String? paymentIntentId;

/// Create a copy of SaveAndGenerateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveAndGenerateRequestCopyWith<_SaveAndGenerateRequest> get copyWith => __$SaveAndGenerateRequestCopyWithImpl<_SaveAndGenerateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaveAndGenerateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveAndGenerateRequest&&(identical(other.resumeData, resumeData) || other.resumeData == resumeData)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resumeData,templateId,filename,paymentIntentId);

@override
String toString() {
  return 'SaveAndGenerateRequest(resumeData: $resumeData, templateId: $templateId, filename: $filename, paymentIntentId: $paymentIntentId)';
}


}

/// @nodoc
abstract mixin class _$SaveAndGenerateRequestCopyWith<$Res> implements $SaveAndGenerateRequestCopyWith<$Res> {
  factory _$SaveAndGenerateRequestCopyWith(_SaveAndGenerateRequest value, $Res Function(_SaveAndGenerateRequest) _then) = __$SaveAndGenerateRequestCopyWithImpl;
@override @useResult
$Res call({
 ResumeData resumeData, String? templateId, String? filename, String? paymentIntentId
});


@override $ResumeDataCopyWith<$Res> get resumeData;

}
/// @nodoc
class __$SaveAndGenerateRequestCopyWithImpl<$Res>
    implements _$SaveAndGenerateRequestCopyWith<$Res> {
  __$SaveAndGenerateRequestCopyWithImpl(this._self, this._then);

  final _SaveAndGenerateRequest _self;
  final $Res Function(_SaveAndGenerateRequest) _then;

/// Create a copy of SaveAndGenerateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resumeData = null,Object? templateId = freezed,Object? filename = freezed,Object? paymentIntentId = freezed,}) {
  return _then(_SaveAndGenerateRequest(
resumeData: null == resumeData ? _self.resumeData : resumeData // ignore: cast_nullable_to_non_nullable
as ResumeData,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SaveAndGenerateRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<$Res> get resumeData {
  
  return $ResumeDataCopyWith<$Res>(_self.resumeData, (value) {
    return _then(_self.copyWith(resumeData: value));
  });
}
}

// dart format on
