// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_count_by_city_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobsCountByCityResponse {

/// Success status
 bool get success;/// Data containing city counts
 List<CityCount> get data;
/// Create a copy of JobsCountByCityResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobsCountByCityResponseCopyWith<JobsCountByCityResponse> get copyWith => _$JobsCountByCityResponseCopyWithImpl<JobsCountByCityResponse>(this as JobsCountByCityResponse, _$identity);

  /// Serializes this JobsCountByCityResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsCountByCityResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'JobsCountByCityResponse(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class $JobsCountByCityResponseCopyWith<$Res>  {
  factory $JobsCountByCityResponseCopyWith(JobsCountByCityResponse value, $Res Function(JobsCountByCityResponse) _then) = _$JobsCountByCityResponseCopyWithImpl;
@useResult
$Res call({
 bool success, List<CityCount> data
});




}
/// @nodoc
class _$JobsCountByCityResponseCopyWithImpl<$Res>
    implements $JobsCountByCityResponseCopyWith<$Res> {
  _$JobsCountByCityResponseCopyWithImpl(this._self, this._then);

  final JobsCountByCityResponse _self;
  final $Res Function(JobsCountByCityResponse) _then;

/// Create a copy of JobsCountByCityResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<CityCount>,
  ));
}

}


/// Adds pattern-matching-related methods to [JobsCountByCityResponse].
extension JobsCountByCityResponsePatterns on JobsCountByCityResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobsCountByCityResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobsCountByCityResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobsCountByCityResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobsCountByCityResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobsCountByCityResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobsCountByCityResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  List<CityCount> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobsCountByCityResponse() when $default != null:
return $default(_that.success,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  List<CityCount> data)  $default,) {final _that = this;
switch (_that) {
case _JobsCountByCityResponse():
return $default(_that.success,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  List<CityCount> data)?  $default,) {final _that = this;
switch (_that) {
case _JobsCountByCityResponse() when $default != null:
return $default(_that.success,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobsCountByCityResponse implements JobsCountByCityResponse {
  const _JobsCountByCityResponse({required this.success, required final  List<CityCount> data}): _data = data;
  factory _JobsCountByCityResponse.fromJson(Map<String, dynamic> json) => _$JobsCountByCityResponseFromJson(json);

/// Success status
@override final  bool success;
/// Data containing city counts
 final  List<CityCount> _data;
/// Data containing city counts
@override List<CityCount> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of JobsCountByCityResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobsCountByCityResponseCopyWith<_JobsCountByCityResponse> get copyWith => __$JobsCountByCityResponseCopyWithImpl<_JobsCountByCityResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobsCountByCityResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobsCountByCityResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'JobsCountByCityResponse(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class _$JobsCountByCityResponseCopyWith<$Res> implements $JobsCountByCityResponseCopyWith<$Res> {
  factory _$JobsCountByCityResponseCopyWith(_JobsCountByCityResponse value, $Res Function(_JobsCountByCityResponse) _then) = __$JobsCountByCityResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, List<CityCount> data
});




}
/// @nodoc
class __$JobsCountByCityResponseCopyWithImpl<$Res>
    implements _$JobsCountByCityResponseCopyWith<$Res> {
  __$JobsCountByCityResponseCopyWithImpl(this._self, this._then);

  final _JobsCountByCityResponse _self;
  final $Res Function(_JobsCountByCityResponse) _then;

/// Create a copy of JobsCountByCityResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? data = null,}) {
  return _then(_JobsCountByCityResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<CityCount>,
  ));
}


}


/// @nodoc
mixin _$CityCount {

/// City name
@JsonKey(name: 'vacancy_city') String get vacancyCity;/// Number of jobs in this city
 int get count;
/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCountCopyWith<CityCount> get copyWith => _$CityCountCopyWithImpl<CityCount>(this as CityCount, _$identity);

  /// Serializes this CityCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityCount&&(identical(other.vacancyCity, vacancyCity) || other.vacancyCity == vacancyCity)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vacancyCity,count);

@override
String toString() {
  return 'CityCount(vacancyCity: $vacancyCity, count: $count)';
}


}

/// @nodoc
abstract mixin class $CityCountCopyWith<$Res>  {
  factory $CityCountCopyWith(CityCount value, $Res Function(CityCount) _then) = _$CityCountCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'vacancy_city') String vacancyCity, int count
});




}
/// @nodoc
class _$CityCountCopyWithImpl<$Res>
    implements $CityCountCopyWith<$Res> {
  _$CityCountCopyWithImpl(this._self, this._then);

  final CityCount _self;
  final $Res Function(CityCount) _then;

/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vacancyCity = null,Object? count = null,}) {
  return _then(_self.copyWith(
vacancyCity: null == vacancyCity ? _self.vacancyCity : vacancyCity // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CityCount].
extension CityCountPatterns on CityCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityCount value)  $default,){
final _that = this;
switch (_that) {
case _CityCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityCount value)?  $default,){
final _that = this;
switch (_that) {
case _CityCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'vacancy_city')  String vacancyCity,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityCount() when $default != null:
return $default(_that.vacancyCity,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'vacancy_city')  String vacancyCity,  int count)  $default,) {final _that = this;
switch (_that) {
case _CityCount():
return $default(_that.vacancyCity,_that.count);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'vacancy_city')  String vacancyCity,  int count)?  $default,) {final _that = this;
switch (_that) {
case _CityCount() when $default != null:
return $default(_that.vacancyCity,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityCount implements CityCount {
  const _CityCount({@JsonKey(name: 'vacancy_city') required this.vacancyCity, required this.count});
  factory _CityCount.fromJson(Map<String, dynamic> json) => _$CityCountFromJson(json);

/// City name
@override@JsonKey(name: 'vacancy_city') final  String vacancyCity;
/// Number of jobs in this city
@override final  int count;

/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityCountCopyWith<_CityCount> get copyWith => __$CityCountCopyWithImpl<_CityCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityCount&&(identical(other.vacancyCity, vacancyCity) || other.vacancyCity == vacancyCity)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vacancyCity,count);

@override
String toString() {
  return 'CityCount(vacancyCity: $vacancyCity, count: $count)';
}


}

/// @nodoc
abstract mixin class _$CityCountCopyWith<$Res> implements $CityCountCopyWith<$Res> {
  factory _$CityCountCopyWith(_CityCount value, $Res Function(_CityCount) _then) = __$CityCountCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'vacancy_city') String vacancyCity, int count
});




}
/// @nodoc
class __$CityCountCopyWithImpl<$Res>
    implements _$CityCountCopyWith<$Res> {
  __$CityCountCopyWithImpl(this._self, this._then);

  final _CityCount _self;
  final $Res Function(_CityCount) _then;

/// Create a copy of CityCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vacancyCity = null,Object? count = null,}) {
  return _then(_CityCount(
vacancyCity: null == vacancyCity ? _self.vacancyCity : vacancyCity // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
