// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_sheet_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentSheetConfig {

 String get paymentIntentClientSecret; String get customerId; String get merchantDisplayName; String? get customerEphemeralKeySecret; bool get allowsDelayedPaymentMethods; String? get defaultCountry; List<PaymentSheetHeader> get headers;
/// Create a copy of PaymentSheetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentSheetConfigCopyWith<PaymentSheetConfig> get copyWith => _$PaymentSheetConfigCopyWithImpl<PaymentSheetConfig>(this as PaymentSheetConfig, _$identity);

  /// Serializes this PaymentSheetConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentSheetConfig&&(identical(other.paymentIntentClientSecret, paymentIntentClientSecret) || other.paymentIntentClientSecret == paymentIntentClientSecret)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.merchantDisplayName, merchantDisplayName) || other.merchantDisplayName == merchantDisplayName)&&(identical(other.customerEphemeralKeySecret, customerEphemeralKeySecret) || other.customerEphemeralKeySecret == customerEphemeralKeySecret)&&(identical(other.allowsDelayedPaymentMethods, allowsDelayedPaymentMethods) || other.allowsDelayedPaymentMethods == allowsDelayedPaymentMethods)&&(identical(other.defaultCountry, defaultCountry) || other.defaultCountry == defaultCountry)&&const DeepCollectionEquality().equals(other.headers, headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentIntentClientSecret,customerId,merchantDisplayName,customerEphemeralKeySecret,allowsDelayedPaymentMethods,defaultCountry,const DeepCollectionEquality().hash(headers));

@override
String toString() {
  return 'PaymentSheetConfig(paymentIntentClientSecret: $paymentIntentClientSecret, customerId: $customerId, merchantDisplayName: $merchantDisplayName, customerEphemeralKeySecret: $customerEphemeralKeySecret, allowsDelayedPaymentMethods: $allowsDelayedPaymentMethods, defaultCountry: $defaultCountry, headers: $headers)';
}


}

/// @nodoc
abstract mixin class $PaymentSheetConfigCopyWith<$Res>  {
  factory $PaymentSheetConfigCopyWith(PaymentSheetConfig value, $Res Function(PaymentSheetConfig) _then) = _$PaymentSheetConfigCopyWithImpl;
@useResult
$Res call({
 String paymentIntentClientSecret, String customerId, String merchantDisplayName, String? customerEphemeralKeySecret, bool allowsDelayedPaymentMethods, String? defaultCountry, List<PaymentSheetHeader> headers
});




}
/// @nodoc
class _$PaymentSheetConfigCopyWithImpl<$Res>
    implements $PaymentSheetConfigCopyWith<$Res> {
  _$PaymentSheetConfigCopyWithImpl(this._self, this._then);

  final PaymentSheetConfig _self;
  final $Res Function(PaymentSheetConfig) _then;

/// Create a copy of PaymentSheetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentIntentClientSecret = null,Object? customerId = null,Object? merchantDisplayName = null,Object? customerEphemeralKeySecret = freezed,Object? allowsDelayedPaymentMethods = null,Object? defaultCountry = freezed,Object? headers = null,}) {
  return _then(_self.copyWith(
paymentIntentClientSecret: null == paymentIntentClientSecret ? _self.paymentIntentClientSecret : paymentIntentClientSecret // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,merchantDisplayName: null == merchantDisplayName ? _self.merchantDisplayName : merchantDisplayName // ignore: cast_nullable_to_non_nullable
as String,customerEphemeralKeySecret: freezed == customerEphemeralKeySecret ? _self.customerEphemeralKeySecret : customerEphemeralKeySecret // ignore: cast_nullable_to_non_nullable
as String?,allowsDelayedPaymentMethods: null == allowsDelayedPaymentMethods ? _self.allowsDelayedPaymentMethods : allowsDelayedPaymentMethods // ignore: cast_nullable_to_non_nullable
as bool,defaultCountry: freezed == defaultCountry ? _self.defaultCountry : defaultCountry // ignore: cast_nullable_to_non_nullable
as String?,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as List<PaymentSheetHeader>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentSheetConfig].
extension PaymentSheetConfigPatterns on PaymentSheetConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentSheetConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentSheetConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentSheetConfig value)  $default,){
final _that = this;
switch (_that) {
case _PaymentSheetConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentSheetConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentSheetConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentIntentClientSecret,  String customerId,  String merchantDisplayName,  String? customerEphemeralKeySecret,  bool allowsDelayedPaymentMethods,  String? defaultCountry,  List<PaymentSheetHeader> headers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentSheetConfig() when $default != null:
return $default(_that.paymentIntentClientSecret,_that.customerId,_that.merchantDisplayName,_that.customerEphemeralKeySecret,_that.allowsDelayedPaymentMethods,_that.defaultCountry,_that.headers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentIntentClientSecret,  String customerId,  String merchantDisplayName,  String? customerEphemeralKeySecret,  bool allowsDelayedPaymentMethods,  String? defaultCountry,  List<PaymentSheetHeader> headers)  $default,) {final _that = this;
switch (_that) {
case _PaymentSheetConfig():
return $default(_that.paymentIntentClientSecret,_that.customerId,_that.merchantDisplayName,_that.customerEphemeralKeySecret,_that.allowsDelayedPaymentMethods,_that.defaultCountry,_that.headers);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentIntentClientSecret,  String customerId,  String merchantDisplayName,  String? customerEphemeralKeySecret,  bool allowsDelayedPaymentMethods,  String? defaultCountry,  List<PaymentSheetHeader> headers)?  $default,) {final _that = this;
switch (_that) {
case _PaymentSheetConfig() when $default != null:
return $default(_that.paymentIntentClientSecret,_that.customerId,_that.merchantDisplayName,_that.customerEphemeralKeySecret,_that.allowsDelayedPaymentMethods,_that.defaultCountry,_that.headers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentSheetConfig implements PaymentSheetConfig {
  const _PaymentSheetConfig({required this.paymentIntentClientSecret, required this.customerId, required this.merchantDisplayName, this.customerEphemeralKeySecret, this.allowsDelayedPaymentMethods = false, this.defaultCountry, final  List<PaymentSheetHeader> headers = const []}): _headers = headers;
  factory _PaymentSheetConfig.fromJson(Map<String, dynamic> json) => _$PaymentSheetConfigFromJson(json);

@override final  String paymentIntentClientSecret;
@override final  String customerId;
@override final  String merchantDisplayName;
@override final  String? customerEphemeralKeySecret;
@override@JsonKey() final  bool allowsDelayedPaymentMethods;
@override final  String? defaultCountry;
 final  List<PaymentSheetHeader> _headers;
@override@JsonKey() List<PaymentSheetHeader> get headers {
  if (_headers is EqualUnmodifiableListView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_headers);
}


/// Create a copy of PaymentSheetConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentSheetConfigCopyWith<_PaymentSheetConfig> get copyWith => __$PaymentSheetConfigCopyWithImpl<_PaymentSheetConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentSheetConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentSheetConfig&&(identical(other.paymentIntentClientSecret, paymentIntentClientSecret) || other.paymentIntentClientSecret == paymentIntentClientSecret)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.merchantDisplayName, merchantDisplayName) || other.merchantDisplayName == merchantDisplayName)&&(identical(other.customerEphemeralKeySecret, customerEphemeralKeySecret) || other.customerEphemeralKeySecret == customerEphemeralKeySecret)&&(identical(other.allowsDelayedPaymentMethods, allowsDelayedPaymentMethods) || other.allowsDelayedPaymentMethods == allowsDelayedPaymentMethods)&&(identical(other.defaultCountry, defaultCountry) || other.defaultCountry == defaultCountry)&&const DeepCollectionEquality().equals(other._headers, _headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentIntentClientSecret,customerId,merchantDisplayName,customerEphemeralKeySecret,allowsDelayedPaymentMethods,defaultCountry,const DeepCollectionEquality().hash(_headers));

@override
String toString() {
  return 'PaymentSheetConfig(paymentIntentClientSecret: $paymentIntentClientSecret, customerId: $customerId, merchantDisplayName: $merchantDisplayName, customerEphemeralKeySecret: $customerEphemeralKeySecret, allowsDelayedPaymentMethods: $allowsDelayedPaymentMethods, defaultCountry: $defaultCountry, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$PaymentSheetConfigCopyWith<$Res> implements $PaymentSheetConfigCopyWith<$Res> {
  factory _$PaymentSheetConfigCopyWith(_PaymentSheetConfig value, $Res Function(_PaymentSheetConfig) _then) = __$PaymentSheetConfigCopyWithImpl;
@override @useResult
$Res call({
 String paymentIntentClientSecret, String customerId, String merchantDisplayName, String? customerEphemeralKeySecret, bool allowsDelayedPaymentMethods, String? defaultCountry, List<PaymentSheetHeader> headers
});




}
/// @nodoc
class __$PaymentSheetConfigCopyWithImpl<$Res>
    implements _$PaymentSheetConfigCopyWith<$Res> {
  __$PaymentSheetConfigCopyWithImpl(this._self, this._then);

  final _PaymentSheetConfig _self;
  final $Res Function(_PaymentSheetConfig) _then;

/// Create a copy of PaymentSheetConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentIntentClientSecret = null,Object? customerId = null,Object? merchantDisplayName = null,Object? customerEphemeralKeySecret = freezed,Object? allowsDelayedPaymentMethods = null,Object? defaultCountry = freezed,Object? headers = null,}) {
  return _then(_PaymentSheetConfig(
paymentIntentClientSecret: null == paymentIntentClientSecret ? _self.paymentIntentClientSecret : paymentIntentClientSecret // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,merchantDisplayName: null == merchantDisplayName ? _self.merchantDisplayName : merchantDisplayName // ignore: cast_nullable_to_non_nullable
as String,customerEphemeralKeySecret: freezed == customerEphemeralKeySecret ? _self.customerEphemeralKeySecret : customerEphemeralKeySecret // ignore: cast_nullable_to_non_nullable
as String?,allowsDelayedPaymentMethods: null == allowsDelayedPaymentMethods ? _self.allowsDelayedPaymentMethods : allowsDelayedPaymentMethods // ignore: cast_nullable_to_non_nullable
as bool,defaultCountry: freezed == defaultCountry ? _self.defaultCountry : defaultCountry // ignore: cast_nullable_to_non_nullable
as String?,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as List<PaymentSheetHeader>,
  ));
}


}


/// @nodoc
mixin _$PaymentSheetHeader {

 String get text; bool get expandable;
/// Create a copy of PaymentSheetHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentSheetHeaderCopyWith<PaymentSheetHeader> get copyWith => _$PaymentSheetHeaderCopyWithImpl<PaymentSheetHeader>(this as PaymentSheetHeader, _$identity);

  /// Serializes this PaymentSheetHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentSheetHeader&&(identical(other.text, text) || other.text == text)&&(identical(other.expandable, expandable) || other.expandable == expandable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,expandable);

@override
String toString() {
  return 'PaymentSheetHeader(text: $text, expandable: $expandable)';
}


}

/// @nodoc
abstract mixin class $PaymentSheetHeaderCopyWith<$Res>  {
  factory $PaymentSheetHeaderCopyWith(PaymentSheetHeader value, $Res Function(PaymentSheetHeader) _then) = _$PaymentSheetHeaderCopyWithImpl;
@useResult
$Res call({
 String text, bool expandable
});




}
/// @nodoc
class _$PaymentSheetHeaderCopyWithImpl<$Res>
    implements $PaymentSheetHeaderCopyWith<$Res> {
  _$PaymentSheetHeaderCopyWithImpl(this._self, this._then);

  final PaymentSheetHeader _self;
  final $Res Function(PaymentSheetHeader) _then;

/// Create a copy of PaymentSheetHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? expandable = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,expandable: null == expandable ? _self.expandable : expandable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentSheetHeader].
extension PaymentSheetHeaderPatterns on PaymentSheetHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentSheetHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentSheetHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentSheetHeader value)  $default,){
final _that = this;
switch (_that) {
case _PaymentSheetHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentSheetHeader value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentSheetHeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  bool expandable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentSheetHeader() when $default != null:
return $default(_that.text,_that.expandable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  bool expandable)  $default,) {final _that = this;
switch (_that) {
case _PaymentSheetHeader():
return $default(_that.text,_that.expandable);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  bool expandable)?  $default,) {final _that = this;
switch (_that) {
case _PaymentSheetHeader() when $default != null:
return $default(_that.text,_that.expandable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentSheetHeader implements PaymentSheetHeader {
  const _PaymentSheetHeader({required this.text, this.expandable = false});
  factory _PaymentSheetHeader.fromJson(Map<String, dynamic> json) => _$PaymentSheetHeaderFromJson(json);

@override final  String text;
@override@JsonKey() final  bool expandable;

/// Create a copy of PaymentSheetHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentSheetHeaderCopyWith<_PaymentSheetHeader> get copyWith => __$PaymentSheetHeaderCopyWithImpl<_PaymentSheetHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentSheetHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentSheetHeader&&(identical(other.text, text) || other.text == text)&&(identical(other.expandable, expandable) || other.expandable == expandable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,expandable);

@override
String toString() {
  return 'PaymentSheetHeader(text: $text, expandable: $expandable)';
}


}

/// @nodoc
abstract mixin class _$PaymentSheetHeaderCopyWith<$Res> implements $PaymentSheetHeaderCopyWith<$Res> {
  factory _$PaymentSheetHeaderCopyWith(_PaymentSheetHeader value, $Res Function(_PaymentSheetHeader) _then) = __$PaymentSheetHeaderCopyWithImpl;
@override @useResult
$Res call({
 String text, bool expandable
});




}
/// @nodoc
class __$PaymentSheetHeaderCopyWithImpl<$Res>
    implements _$PaymentSheetHeaderCopyWith<$Res> {
  __$PaymentSheetHeaderCopyWithImpl(this._self, this._then);

  final _PaymentSheetHeader _self;
  final $Res Function(_PaymentSheetHeader) _then;

/// Create a copy of PaymentSheetHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? expandable = null,}) {
  return _then(_PaymentSheetHeader(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,expandable: null == expandable ? _self.expandable : expandable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
