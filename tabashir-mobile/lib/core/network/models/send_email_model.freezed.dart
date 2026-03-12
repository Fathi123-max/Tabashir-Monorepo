// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_email_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SendEmailModel {

/// Recipient email
 String get email;/// Email subject
 String? get subject;/// Email body
 String? get body;
/// Create a copy of SendEmailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendEmailModelCopyWith<SendEmailModel> get copyWith => _$SendEmailModelCopyWithImpl<SendEmailModel>(this as SendEmailModel, _$identity);

  /// Serializes this SendEmailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendEmailModel&&(identical(other.email, email) || other.email == email)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,subject,body);

@override
String toString() {
  return 'SendEmailModel(email: $email, subject: $subject, body: $body)';
}


}

/// @nodoc
abstract mixin class $SendEmailModelCopyWith<$Res>  {
  factory $SendEmailModelCopyWith(SendEmailModel value, $Res Function(SendEmailModel) _then) = _$SendEmailModelCopyWithImpl;
@useResult
$Res call({
 String email, String? subject, String? body
});




}
/// @nodoc
class _$SendEmailModelCopyWithImpl<$Res>
    implements $SendEmailModelCopyWith<$Res> {
  _$SendEmailModelCopyWithImpl(this._self, this._then);

  final SendEmailModel _self;
  final $Res Function(SendEmailModel) _then;

/// Create a copy of SendEmailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? subject = freezed,Object? body = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendEmailModel].
extension SendEmailModelPatterns on SendEmailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendEmailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendEmailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendEmailModel value)  $default,){
final _that = this;
switch (_that) {
case _SendEmailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendEmailModel value)?  $default,){
final _that = this;
switch (_that) {
case _SendEmailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String? subject,  String? body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendEmailModel() when $default != null:
return $default(_that.email,_that.subject,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String? subject,  String? body)  $default,) {final _that = this;
switch (_that) {
case _SendEmailModel():
return $default(_that.email,_that.subject,_that.body);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String? subject,  String? body)?  $default,) {final _that = this;
switch (_that) {
case _SendEmailModel() when $default != null:
return $default(_that.email,_that.subject,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendEmailModel implements SendEmailModel {
  const _SendEmailModel({required this.email, this.subject, this.body});
  factory _SendEmailModel.fromJson(Map<String, dynamic> json) => _$SendEmailModelFromJson(json);

/// Recipient email
@override final  String email;
/// Email subject
@override final  String? subject;
/// Email body
@override final  String? body;

/// Create a copy of SendEmailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendEmailModelCopyWith<_SendEmailModel> get copyWith => __$SendEmailModelCopyWithImpl<_SendEmailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendEmailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendEmailModel&&(identical(other.email, email) || other.email == email)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,subject,body);

@override
String toString() {
  return 'SendEmailModel(email: $email, subject: $subject, body: $body)';
}


}

/// @nodoc
abstract mixin class _$SendEmailModelCopyWith<$Res> implements $SendEmailModelCopyWith<$Res> {
  factory _$SendEmailModelCopyWith(_SendEmailModel value, $Res Function(_SendEmailModel) _then) = __$SendEmailModelCopyWithImpl;
@override @useResult
$Res call({
 String email, String? subject, String? body
});




}
/// @nodoc
class __$SendEmailModelCopyWithImpl<$Res>
    implements _$SendEmailModelCopyWith<$Res> {
  __$SendEmailModelCopyWithImpl(this._self, this._then);

  final _SendEmailModel _self;
  final $Res Function(_SendEmailModel) _then;

/// Create a copy of SendEmailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? subject = freezed,Object? body = freezed,}) {
  return _then(_SendEmailModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
