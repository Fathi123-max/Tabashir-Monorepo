// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Service {

 String get id; String get name; String get description; String get category; String get icon; double get price; bool get isAvailable; List<String> get features;
/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCopyWith<Service> get copyWith => _$ServiceCopyWithImpl<Service>(this as Service, _$identity);

  /// Serializes this Service to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Service&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.price, price) || other.price == price)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&const DeepCollectionEquality().equals(other.features, features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,icon,price,isAvailable,const DeepCollectionEquality().hash(features));

@override
String toString() {
  return 'Service(id: $id, name: $name, description: $description, category: $category, icon: $icon, price: $price, isAvailable: $isAvailable, features: $features)';
}


}

/// @nodoc
abstract mixin class $ServiceCopyWith<$Res>  {
  factory $ServiceCopyWith(Service value, $Res Function(Service) _then) = _$ServiceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String category, String icon, double price, bool isAvailable, List<String> features
});




}
/// @nodoc
class _$ServiceCopyWithImpl<$Res>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._self, this._then);

  final Service _self;
  final $Res Function(Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? icon = null,Object? price = null,Object? isAvailable = null,Object? features = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Service].
extension ServicePatterns on Service {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Service value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Service() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Service value)  $default,){
final _that = this;
switch (_that) {
case _Service():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Service value)?  $default,){
final _that = this;
switch (_that) {
case _Service() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String category,  String icon,  double price,  bool isAvailable,  List<String> features)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.icon,_that.price,_that.isAvailable,_that.features);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String category,  String icon,  double price,  bool isAvailable,  List<String> features)  $default,) {final _that = this;
switch (_that) {
case _Service():
return $default(_that.id,_that.name,_that.description,_that.category,_that.icon,_that.price,_that.isAvailable,_that.features);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String category,  String icon,  double price,  bool isAvailable,  List<String> features)?  $default,) {final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.icon,_that.price,_that.isAvailable,_that.features);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Service implements Service {
  const _Service({required this.id, required this.name, required this.description, required this.category, required this.icon, this.price = 0.0, this.isAvailable = true, final  List<String> features = const []}): _features = features;
  factory _Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String category;
@override final  String icon;
@override@JsonKey() final  double price;
@override@JsonKey() final  bool isAvailable;
 final  List<String> _features;
@override@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}


/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCopyWith<_Service> get copyWith => __$ServiceCopyWithImpl<_Service>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Service&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.price, price) || other.price == price)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&const DeepCollectionEquality().equals(other._features, _features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,icon,price,isAvailable,const DeepCollectionEquality().hash(_features));

@override
String toString() {
  return 'Service(id: $id, name: $name, description: $description, category: $category, icon: $icon, price: $price, isAvailable: $isAvailable, features: $features)';
}


}

/// @nodoc
abstract mixin class _$ServiceCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$ServiceCopyWith(_Service value, $Res Function(_Service) _then) = __$ServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String category, String icon, double price, bool isAvailable, List<String> features
});




}
/// @nodoc
class __$ServiceCopyWithImpl<$Res>
    implements _$ServiceCopyWith<$Res> {
  __$ServiceCopyWithImpl(this._self, this._then);

  final _Service _self;
  final $Res Function(_Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? icon = null,Object? price = null,Object? isAvailable = null,Object? features = null,}) {
  return _then(_Service(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ServiceBooking {

 String get id; String get serviceId; String get userId; DateTime get bookingDate; String get status;// 'pending', 'confirmed', 'completed', 'cancelled'
 double get totalPrice; Map<String, dynamic>? get details;
/// Create a copy of ServiceBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceBookingCopyWith<ServiceBooking> get copyWith => _$ServiceBookingCopyWithImpl<ServiceBooking>(this as ServiceBooking, _$identity);

  /// Serializes this ServiceBooking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.bookingDate, bookingDate) || other.bookingDate == bookingDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&const DeepCollectionEquality().equals(other.details, details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serviceId,userId,bookingDate,status,totalPrice,const DeepCollectionEquality().hash(details));

@override
String toString() {
  return 'ServiceBooking(id: $id, serviceId: $serviceId, userId: $userId, bookingDate: $bookingDate, status: $status, totalPrice: $totalPrice, details: $details)';
}


}

/// @nodoc
abstract mixin class $ServiceBookingCopyWith<$Res>  {
  factory $ServiceBookingCopyWith(ServiceBooking value, $Res Function(ServiceBooking) _then) = _$ServiceBookingCopyWithImpl;
@useResult
$Res call({
 String id, String serviceId, String userId, DateTime bookingDate, String status, double totalPrice, Map<String, dynamic>? details
});




}
/// @nodoc
class _$ServiceBookingCopyWithImpl<$Res>
    implements $ServiceBookingCopyWith<$Res> {
  _$ServiceBookingCopyWithImpl(this._self, this._then);

  final ServiceBooking _self;
  final $Res Function(ServiceBooking) _then;

/// Create a copy of ServiceBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serviceId = null,Object? userId = null,Object? bookingDate = null,Object? status = null,Object? totalPrice = null,Object? details = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,bookingDate: null == bookingDate ? _self.bookingDate : bookingDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceBooking].
extension ServiceBookingPatterns on ServiceBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceBooking value)  $default,){
final _that = this;
switch (_that) {
case _ServiceBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceBooking value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serviceId,  String userId,  DateTime bookingDate,  String status,  double totalPrice,  Map<String, dynamic>? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceBooking() when $default != null:
return $default(_that.id,_that.serviceId,_that.userId,_that.bookingDate,_that.status,_that.totalPrice,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serviceId,  String userId,  DateTime bookingDate,  String status,  double totalPrice,  Map<String, dynamic>? details)  $default,) {final _that = this;
switch (_that) {
case _ServiceBooking():
return $default(_that.id,_that.serviceId,_that.userId,_that.bookingDate,_that.status,_that.totalPrice,_that.details);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serviceId,  String userId,  DateTime bookingDate,  String status,  double totalPrice,  Map<String, dynamic>? details)?  $default,) {final _that = this;
switch (_that) {
case _ServiceBooking() when $default != null:
return $default(_that.id,_that.serviceId,_that.userId,_that.bookingDate,_that.status,_that.totalPrice,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceBooking implements ServiceBooking {
  const _ServiceBooking({required this.id, required this.serviceId, required this.userId, required this.bookingDate, required this.status, required this.totalPrice, final  Map<String, dynamic>? details}): _details = details;
  factory _ServiceBooking.fromJson(Map<String, dynamic> json) => _$ServiceBookingFromJson(json);

@override final  String id;
@override final  String serviceId;
@override final  String userId;
@override final  DateTime bookingDate;
@override final  String status;
// 'pending', 'confirmed', 'completed', 'cancelled'
@override final  double totalPrice;
 final  Map<String, dynamic>? _details;
@override Map<String, dynamic>? get details {
  final value = _details;
  if (value == null) return null;
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ServiceBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceBookingCopyWith<_ServiceBooking> get copyWith => __$ServiceBookingCopyWithImpl<_ServiceBooking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceBookingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.bookingDate, bookingDate) || other.bookingDate == bookingDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&const DeepCollectionEquality().equals(other._details, _details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serviceId,userId,bookingDate,status,totalPrice,const DeepCollectionEquality().hash(_details));

@override
String toString() {
  return 'ServiceBooking(id: $id, serviceId: $serviceId, userId: $userId, bookingDate: $bookingDate, status: $status, totalPrice: $totalPrice, details: $details)';
}


}

/// @nodoc
abstract mixin class _$ServiceBookingCopyWith<$Res> implements $ServiceBookingCopyWith<$Res> {
  factory _$ServiceBookingCopyWith(_ServiceBooking value, $Res Function(_ServiceBooking) _then) = __$ServiceBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String serviceId, String userId, DateTime bookingDate, String status, double totalPrice, Map<String, dynamic>? details
});




}
/// @nodoc
class __$ServiceBookingCopyWithImpl<$Res>
    implements _$ServiceBookingCopyWith<$Res> {
  __$ServiceBookingCopyWithImpl(this._self, this._then);

  final _ServiceBooking _self;
  final $Res Function(_ServiceBooking) _then;

/// Create a copy of ServiceBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serviceId = null,Object? userId = null,Object? bookingDate = null,Object? status = null,Object? totalPrice = null,Object? details = freezed,}) {
  return _then(_ServiceBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,bookingDate: null == bookingDate ? _self.bookingDate : bookingDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,details: freezed == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
