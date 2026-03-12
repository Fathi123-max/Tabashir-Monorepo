// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_linkedin_email_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SendLinkedInEmailRequest {

/// Recipient email
@JsonKey(name: 'recipient_email') String get recipientEmail;/// Recipient name
@JsonKey(name: 'recipient_name') String get recipientName;
/// Create a copy of SendLinkedInEmailRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendLinkedInEmailRequestCopyWith<SendLinkedInEmailRequest> get copyWith => _$SendLinkedInEmailRequestCopyWithImpl<SendLinkedInEmailRequest>(this as SendLinkedInEmailRequest, _$identity);

  /// Serializes this SendLinkedInEmailRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendLinkedInEmailRequest&&(identical(other.recipientEmail, recipientEmail) || other.recipientEmail == recipientEmail)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipientEmail,recipientName);

@override
String toString() {
  return 'SendLinkedInEmailRequest(recipientEmail: $recipientEmail, recipientName: $recipientName)';
}


}

/// @nodoc
abstract mixin class $SendLinkedInEmailRequestCopyWith<$Res>  {
  factory $SendLinkedInEmailRequestCopyWith(SendLinkedInEmailRequest value, $Res Function(SendLinkedInEmailRequest) _then) = _$SendLinkedInEmailRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'recipient_email') String recipientEmail,@JsonKey(name: 'recipient_name') String recipientName
});




}
/// @nodoc
class _$SendLinkedInEmailRequestCopyWithImpl<$Res>
    implements $SendLinkedInEmailRequestCopyWith<$Res> {
  _$SendLinkedInEmailRequestCopyWithImpl(this._self, this._then);

  final SendLinkedInEmailRequest _self;
  final $Res Function(SendLinkedInEmailRequest) _then;

/// Create a copy of SendLinkedInEmailRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recipientEmail = null,Object? recipientName = null,}) {
  return _then(_self.copyWith(
recipientEmail: null == recipientEmail ? _self.recipientEmail : recipientEmail // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SendLinkedInEmailRequest].
extension SendLinkedInEmailRequestPatterns on SendLinkedInEmailRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendLinkedInEmailRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendLinkedInEmailRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendLinkedInEmailRequest value)  $default,){
final _that = this;
switch (_that) {
case _SendLinkedInEmailRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendLinkedInEmailRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SendLinkedInEmailRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'recipient_email')  String recipientEmail, @JsonKey(name: 'recipient_name')  String recipientName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendLinkedInEmailRequest() when $default != null:
return $default(_that.recipientEmail,_that.recipientName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'recipient_email')  String recipientEmail, @JsonKey(name: 'recipient_name')  String recipientName)  $default,) {final _that = this;
switch (_that) {
case _SendLinkedInEmailRequest():
return $default(_that.recipientEmail,_that.recipientName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'recipient_email')  String recipientEmail, @JsonKey(name: 'recipient_name')  String recipientName)?  $default,) {final _that = this;
switch (_that) {
case _SendLinkedInEmailRequest() when $default != null:
return $default(_that.recipientEmail,_that.recipientName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendLinkedInEmailRequest implements SendLinkedInEmailRequest {
  const _SendLinkedInEmailRequest({@JsonKey(name: 'recipient_email') required this.recipientEmail, @JsonKey(name: 'recipient_name') required this.recipientName});
  factory _SendLinkedInEmailRequest.fromJson(Map<String, dynamic> json) => _$SendLinkedInEmailRequestFromJson(json);

/// Recipient email
@override@JsonKey(name: 'recipient_email') final  String recipientEmail;
/// Recipient name
@override@JsonKey(name: 'recipient_name') final  String recipientName;

/// Create a copy of SendLinkedInEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendLinkedInEmailRequestCopyWith<_SendLinkedInEmailRequest> get copyWith => __$SendLinkedInEmailRequestCopyWithImpl<_SendLinkedInEmailRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendLinkedInEmailRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendLinkedInEmailRequest&&(identical(other.recipientEmail, recipientEmail) || other.recipientEmail == recipientEmail)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipientEmail,recipientName);

@override
String toString() {
  return 'SendLinkedInEmailRequest(recipientEmail: $recipientEmail, recipientName: $recipientName)';
}


}

/// @nodoc
abstract mixin class _$SendLinkedInEmailRequestCopyWith<$Res> implements $SendLinkedInEmailRequestCopyWith<$Res> {
  factory _$SendLinkedInEmailRequestCopyWith(_SendLinkedInEmailRequest value, $Res Function(_SendLinkedInEmailRequest) _then) = __$SendLinkedInEmailRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'recipient_email') String recipientEmail,@JsonKey(name: 'recipient_name') String recipientName
});




}
/// @nodoc
class __$SendLinkedInEmailRequestCopyWithImpl<$Res>
    implements _$SendLinkedInEmailRequestCopyWith<$Res> {
  __$SendLinkedInEmailRequestCopyWithImpl(this._self, this._then);

  final _SendLinkedInEmailRequest _self;
  final $Res Function(_SendLinkedInEmailRequest) _then;

/// Create a copy of SendLinkedInEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recipientEmail = null,Object? recipientName = null,}) {
  return _then(_SendLinkedInEmailRequest(
recipientEmail: null == recipientEmail ? _self.recipientEmail : recipientEmail // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
