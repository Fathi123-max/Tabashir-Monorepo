// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StripePaymentMethod {

 String get id; String get type; CardDetails? get card; bool get isDefault; BillingDetails? get billingDetails; DateTime? get created;
/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StripePaymentMethodCopyWith<StripePaymentMethod> get copyWith => _$StripePaymentMethodCopyWithImpl<StripePaymentMethod>(this as StripePaymentMethod, _$identity);

  /// Serializes this StripePaymentMethod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StripePaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.card, card) || other.card == card)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.billingDetails, billingDetails) || other.billingDetails == billingDetails)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,card,isDefault,billingDetails,created);

@override
String toString() {
  return 'StripePaymentMethod(id: $id, type: $type, card: $card, isDefault: $isDefault, billingDetails: $billingDetails, created: $created)';
}


}

/// @nodoc
abstract mixin class $StripePaymentMethodCopyWith<$Res>  {
  factory $StripePaymentMethodCopyWith(StripePaymentMethod value, $Res Function(StripePaymentMethod) _then) = _$StripePaymentMethodCopyWithImpl;
@useResult
$Res call({
 String id, String type, CardDetails? card, bool isDefault, BillingDetails? billingDetails, DateTime? created
});


$CardDetailsCopyWith<$Res>? get card;$BillingDetailsCopyWith<$Res>? get billingDetails;

}
/// @nodoc
class _$StripePaymentMethodCopyWithImpl<$Res>
    implements $StripePaymentMethodCopyWith<$Res> {
  _$StripePaymentMethodCopyWithImpl(this._self, this._then);

  final StripePaymentMethod _self;
  final $Res Function(StripePaymentMethod) _then;

/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? card = freezed,Object? isDefault = null,Object? billingDetails = freezed,Object? created = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,card: freezed == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as CardDetails?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,billingDetails: freezed == billingDetails ? _self.billingDetails : billingDetails // ignore: cast_nullable_to_non_nullable
as BillingDetails?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardDetailsCopyWith<$Res>? get card {
    if (_self.card == null) {
    return null;
  }

  return $CardDetailsCopyWith<$Res>(_self.card!, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillingDetailsCopyWith<$Res>? get billingDetails {
    if (_self.billingDetails == null) {
    return null;
  }

  return $BillingDetailsCopyWith<$Res>(_self.billingDetails!, (value) {
    return _then(_self.copyWith(billingDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [StripePaymentMethod].
extension StripePaymentMethodPatterns on StripePaymentMethod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StripePaymentMethod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StripePaymentMethod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StripePaymentMethod value)  $default,){
final _that = this;
switch (_that) {
case _StripePaymentMethod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StripePaymentMethod value)?  $default,){
final _that = this;
switch (_that) {
case _StripePaymentMethod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  CardDetails? card,  bool isDefault,  BillingDetails? billingDetails,  DateTime? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StripePaymentMethod() when $default != null:
return $default(_that.id,_that.type,_that.card,_that.isDefault,_that.billingDetails,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  CardDetails? card,  bool isDefault,  BillingDetails? billingDetails,  DateTime? created)  $default,) {final _that = this;
switch (_that) {
case _StripePaymentMethod():
return $default(_that.id,_that.type,_that.card,_that.isDefault,_that.billingDetails,_that.created);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  CardDetails? card,  bool isDefault,  BillingDetails? billingDetails,  DateTime? created)?  $default,) {final _that = this;
switch (_that) {
case _StripePaymentMethod() when $default != null:
return $default(_that.id,_that.type,_that.card,_that.isDefault,_that.billingDetails,_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StripePaymentMethod implements StripePaymentMethod {
  const _StripePaymentMethod({required this.id, required this.type, required this.card, required this.isDefault, this.billingDetails, this.created});
  factory _StripePaymentMethod.fromJson(Map<String, dynamic> json) => _$StripePaymentMethodFromJson(json);

@override final  String id;
@override final  String type;
@override final  CardDetails? card;
@override final  bool isDefault;
@override final  BillingDetails? billingDetails;
@override final  DateTime? created;

/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StripePaymentMethodCopyWith<_StripePaymentMethod> get copyWith => __$StripePaymentMethodCopyWithImpl<_StripePaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StripePaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StripePaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.card, card) || other.card == card)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.billingDetails, billingDetails) || other.billingDetails == billingDetails)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,card,isDefault,billingDetails,created);

@override
String toString() {
  return 'StripePaymentMethod(id: $id, type: $type, card: $card, isDefault: $isDefault, billingDetails: $billingDetails, created: $created)';
}


}

/// @nodoc
abstract mixin class _$StripePaymentMethodCopyWith<$Res> implements $StripePaymentMethodCopyWith<$Res> {
  factory _$StripePaymentMethodCopyWith(_StripePaymentMethod value, $Res Function(_StripePaymentMethod) _then) = __$StripePaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, CardDetails? card, bool isDefault, BillingDetails? billingDetails, DateTime? created
});


@override $CardDetailsCopyWith<$Res>? get card;@override $BillingDetailsCopyWith<$Res>? get billingDetails;

}
/// @nodoc
class __$StripePaymentMethodCopyWithImpl<$Res>
    implements _$StripePaymentMethodCopyWith<$Res> {
  __$StripePaymentMethodCopyWithImpl(this._self, this._then);

  final _StripePaymentMethod _self;
  final $Res Function(_StripePaymentMethod) _then;

/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? card = freezed,Object? isDefault = null,Object? billingDetails = freezed,Object? created = freezed,}) {
  return _then(_StripePaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,card: freezed == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as CardDetails?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,billingDetails: freezed == billingDetails ? _self.billingDetails : billingDetails // ignore: cast_nullable_to_non_nullable
as BillingDetails?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardDetailsCopyWith<$Res>? get card {
    if (_self.card == null) {
    return null;
  }

  return $CardDetailsCopyWith<$Res>(_self.card!, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of StripePaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BillingDetailsCopyWith<$Res>? get billingDetails {
    if (_self.billingDetails == null) {
    return null;
  }

  return $BillingDetailsCopyWith<$Res>(_self.billingDetails!, (value) {
    return _then(_self.copyWith(billingDetails: value));
  });
}
}


/// @nodoc
mixin _$CardDetails {

 String get brand; int get expMonth; int get expYear; String? get last4; String? get fingerprint;
/// Create a copy of CardDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardDetailsCopyWith<CardDetails> get copyWith => _$CardDetailsCopyWithImpl<CardDetails>(this as CardDetails, _$identity);

  /// Serializes this CardDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardDetails&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.expMonth, expMonth) || other.expMonth == expMonth)&&(identical(other.expYear, expYear) || other.expYear == expYear)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,brand,expMonth,expYear,last4,fingerprint);

@override
String toString() {
  return 'CardDetails(brand: $brand, expMonth: $expMonth, expYear: $expYear, last4: $last4, fingerprint: $fingerprint)';
}


}

/// @nodoc
abstract mixin class $CardDetailsCopyWith<$Res>  {
  factory $CardDetailsCopyWith(CardDetails value, $Res Function(CardDetails) _then) = _$CardDetailsCopyWithImpl;
@useResult
$Res call({
 String brand, int expMonth, int expYear, String? last4, String? fingerprint
});




}
/// @nodoc
class _$CardDetailsCopyWithImpl<$Res>
    implements $CardDetailsCopyWith<$Res> {
  _$CardDetailsCopyWithImpl(this._self, this._then);

  final CardDetails _self;
  final $Res Function(CardDetails) _then;

/// Create a copy of CardDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? brand = null,Object? expMonth = null,Object? expYear = null,Object? last4 = freezed,Object? fingerprint = freezed,}) {
  return _then(_self.copyWith(
brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,expMonth: null == expMonth ? _self.expMonth : expMonth // ignore: cast_nullable_to_non_nullable
as int,expYear: null == expYear ? _self.expYear : expYear // ignore: cast_nullable_to_non_nullable
as int,last4: freezed == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String?,fingerprint: freezed == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CardDetails].
extension CardDetailsPatterns on CardDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardDetails value)  $default,){
final _that = this;
switch (_that) {
case _CardDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardDetails value)?  $default,){
final _that = this;
switch (_that) {
case _CardDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String brand,  int expMonth,  int expYear,  String? last4,  String? fingerprint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardDetails() when $default != null:
return $default(_that.brand,_that.expMonth,_that.expYear,_that.last4,_that.fingerprint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String brand,  int expMonth,  int expYear,  String? last4,  String? fingerprint)  $default,) {final _that = this;
switch (_that) {
case _CardDetails():
return $default(_that.brand,_that.expMonth,_that.expYear,_that.last4,_that.fingerprint);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String brand,  int expMonth,  int expYear,  String? last4,  String? fingerprint)?  $default,) {final _that = this;
switch (_that) {
case _CardDetails() when $default != null:
return $default(_that.brand,_that.expMonth,_that.expYear,_that.last4,_that.fingerprint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardDetails implements CardDetails {
  const _CardDetails({required this.brand, required this.expMonth, required this.expYear, this.last4, this.fingerprint});
  factory _CardDetails.fromJson(Map<String, dynamic> json) => _$CardDetailsFromJson(json);

@override final  String brand;
@override final  int expMonth;
@override final  int expYear;
@override final  String? last4;
@override final  String? fingerprint;

/// Create a copy of CardDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardDetailsCopyWith<_CardDetails> get copyWith => __$CardDetailsCopyWithImpl<_CardDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardDetails&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.expMonth, expMonth) || other.expMonth == expMonth)&&(identical(other.expYear, expYear) || other.expYear == expYear)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,brand,expMonth,expYear,last4,fingerprint);

@override
String toString() {
  return 'CardDetails(brand: $brand, expMonth: $expMonth, expYear: $expYear, last4: $last4, fingerprint: $fingerprint)';
}


}

/// @nodoc
abstract mixin class _$CardDetailsCopyWith<$Res> implements $CardDetailsCopyWith<$Res> {
  factory _$CardDetailsCopyWith(_CardDetails value, $Res Function(_CardDetails) _then) = __$CardDetailsCopyWithImpl;
@override @useResult
$Res call({
 String brand, int expMonth, int expYear, String? last4, String? fingerprint
});




}
/// @nodoc
class __$CardDetailsCopyWithImpl<$Res>
    implements _$CardDetailsCopyWith<$Res> {
  __$CardDetailsCopyWithImpl(this._self, this._then);

  final _CardDetails _self;
  final $Res Function(_CardDetails) _then;

/// Create a copy of CardDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? brand = null,Object? expMonth = null,Object? expYear = null,Object? last4 = freezed,Object? fingerprint = freezed,}) {
  return _then(_CardDetails(
brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,expMonth: null == expMonth ? _self.expMonth : expMonth // ignore: cast_nullable_to_non_nullable
as int,expYear: null == expYear ? _self.expYear : expYear // ignore: cast_nullable_to_non_nullable
as int,last4: freezed == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String?,fingerprint: freezed == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BillingDetails {

 String? get name; String? get email; String? get phone; Address? get address;
/// Create a copy of BillingDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingDetailsCopyWith<BillingDetails> get copyWith => _$BillingDetailsCopyWithImpl<BillingDetails>(this as BillingDetails, _$identity);

  /// Serializes this BillingDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingDetails&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,phone,address);

@override
String toString() {
  return 'BillingDetails(name: $name, email: $email, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class $BillingDetailsCopyWith<$Res>  {
  factory $BillingDetailsCopyWith(BillingDetails value, $Res Function(BillingDetails) _then) = _$BillingDetailsCopyWithImpl;
@useResult
$Res call({
 String? name, String? email, String? phone, Address? address
});


$AddressCopyWith<$Res>? get address;

}
/// @nodoc
class _$BillingDetailsCopyWithImpl<$Res>
    implements $BillingDetailsCopyWith<$Res> {
  _$BillingDetailsCopyWithImpl(this._self, this._then);

  final BillingDetails _self;
  final $Res Function(BillingDetails) _then;

/// Create a copy of BillingDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? address = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address?,
  ));
}
/// Create a copy of BillingDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [BillingDetails].
extension BillingDetailsPatterns on BillingDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingDetails value)  $default,){
final _that = this;
switch (_that) {
case _BillingDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingDetails value)?  $default,){
final _that = this;
switch (_that) {
case _BillingDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? email,  String? phone,  Address? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingDetails() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? email,  String? phone,  Address? address)  $default,) {final _that = this;
switch (_that) {
case _BillingDetails():
return $default(_that.name,_that.email,_that.phone,_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? email,  String? phone,  Address? address)?  $default,) {final _that = this;
switch (_that) {
case _BillingDetails() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillingDetails implements BillingDetails {
  const _BillingDetails({this.name, this.email, this.phone, this.address});
  factory _BillingDetails.fromJson(Map<String, dynamic> json) => _$BillingDetailsFromJson(json);

@override final  String? name;
@override final  String? email;
@override final  String? phone;
@override final  Address? address;

/// Create a copy of BillingDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingDetailsCopyWith<_BillingDetails> get copyWith => __$BillingDetailsCopyWithImpl<_BillingDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillingDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingDetails&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,phone,address);

@override
String toString() {
  return 'BillingDetails(name: $name, email: $email, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class _$BillingDetailsCopyWith<$Res> implements $BillingDetailsCopyWith<$Res> {
  factory _$BillingDetailsCopyWith(_BillingDetails value, $Res Function(_BillingDetails) _then) = __$BillingDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? email, String? phone, Address? address
});


@override $AddressCopyWith<$Res>? get address;

}
/// @nodoc
class __$BillingDetailsCopyWithImpl<$Res>
    implements _$BillingDetailsCopyWith<$Res> {
  __$BillingDetailsCopyWithImpl(this._self, this._then);

  final _BillingDetails _self;
  final $Res Function(_BillingDetails) _then;

/// Create a copy of BillingDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? address = freezed,}) {
  return _then(_BillingDetails(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address?,
  ));
}

/// Create a copy of BillingDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$Address {

 String? get line1; String? get line2; String? get city; String? get state; String? get postalCode; String? get country;
/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressCopyWith<Address> get copyWith => _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Address&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,line2,city,state,postalCode,country);

@override
String toString() {
  return 'Address(line1: $line1, line2: $line2, city: $city, state: $state, postalCode: $postalCode, country: $country)';
}


}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res>  {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) = _$AddressCopyWithImpl;
@useResult
$Res call({
 String? line1, String? line2, String? city, String? state, String? postalCode, String? country
});




}
/// @nodoc
class _$AddressCopyWithImpl<$Res>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line1 = freezed,Object? line2 = freezed,Object? city = freezed,Object? state = freezed,Object? postalCode = freezed,Object? country = freezed,}) {
  return _then(_self.copyWith(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Address].
extension AddressPatterns on Address {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Address value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Address() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Address value)  $default,){
final _that = this;
switch (_that) {
case _Address():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Address value)?  $default,){
final _that = this;
switch (_that) {
case _Address() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? line1,  String? line2,  String? city,  String? state,  String? postalCode,  String? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.line1,_that.line2,_that.city,_that.state,_that.postalCode,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? line1,  String? line2,  String? city,  String? state,  String? postalCode,  String? country)  $default,) {final _that = this;
switch (_that) {
case _Address():
return $default(_that.line1,_that.line2,_that.city,_that.state,_that.postalCode,_that.country);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? line1,  String? line2,  String? city,  String? state,  String? postalCode,  String? country)?  $default,) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.line1,_that.line2,_that.city,_that.state,_that.postalCode,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Address implements Address {
  const _Address({this.line1, this.line2, this.city, this.state, this.postalCode, this.country});
  factory _Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

@override final  String? line1;
@override final  String? line2;
@override final  String? city;
@override final  String? state;
@override final  String? postalCode;
@override final  String? country;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressCopyWith<_Address> get copyWith => __$AddressCopyWithImpl<_Address>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Address&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,line2,city,state,postalCode,country);

@override
String toString() {
  return 'Address(line1: $line1, line2: $line2, city: $city, state: $state, postalCode: $postalCode, country: $country)';
}


}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) = __$AddressCopyWithImpl;
@override @useResult
$Res call({
 String? line1, String? line2, String? city, String? state, String? postalCode, String? country
});




}
/// @nodoc
class __$AddressCopyWithImpl<$Res>
    implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line1 = freezed,Object? line2 = freezed,Object? city = freezed,Object? state = freezed,Object? postalCode = freezed,Object? country = freezed,}) {
  return _then(_Address(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
