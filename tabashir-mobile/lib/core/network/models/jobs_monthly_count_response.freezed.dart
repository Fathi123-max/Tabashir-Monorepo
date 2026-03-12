// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_monthly_count_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobsMonthlyCountResponse {

/// Success status
 bool get success;/// Data containing monthly counts
 List<MonthlyCount> get data;
/// Create a copy of JobsMonthlyCountResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobsMonthlyCountResponseCopyWith<JobsMonthlyCountResponse> get copyWith => _$JobsMonthlyCountResponseCopyWithImpl<JobsMonthlyCountResponse>(this as JobsMonthlyCountResponse, _$identity);

  /// Serializes this JobsMonthlyCountResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsMonthlyCountResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'JobsMonthlyCountResponse(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class $JobsMonthlyCountResponseCopyWith<$Res>  {
  factory $JobsMonthlyCountResponseCopyWith(JobsMonthlyCountResponse value, $Res Function(JobsMonthlyCountResponse) _then) = _$JobsMonthlyCountResponseCopyWithImpl;
@useResult
$Res call({
 bool success, List<MonthlyCount> data
});




}
/// @nodoc
class _$JobsMonthlyCountResponseCopyWithImpl<$Res>
    implements $JobsMonthlyCountResponseCopyWith<$Res> {
  _$JobsMonthlyCountResponseCopyWithImpl(this._self, this._then);

  final JobsMonthlyCountResponse _self;
  final $Res Function(JobsMonthlyCountResponse) _then;

/// Create a copy of JobsMonthlyCountResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<MonthlyCount>,
  ));
}

}


/// Adds pattern-matching-related methods to [JobsMonthlyCountResponse].
extension JobsMonthlyCountResponsePatterns on JobsMonthlyCountResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobsMonthlyCountResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobsMonthlyCountResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobsMonthlyCountResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobsMonthlyCountResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobsMonthlyCountResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobsMonthlyCountResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  List<MonthlyCount> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobsMonthlyCountResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  List<MonthlyCount> data)  $default,) {final _that = this;
switch (_that) {
case _JobsMonthlyCountResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  List<MonthlyCount> data)?  $default,) {final _that = this;
switch (_that) {
case _JobsMonthlyCountResponse() when $default != null:
return $default(_that.success,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobsMonthlyCountResponse implements JobsMonthlyCountResponse {
  const _JobsMonthlyCountResponse({required this.success, required final  List<MonthlyCount> data}): _data = data;
  factory _JobsMonthlyCountResponse.fromJson(Map<String, dynamic> json) => _$JobsMonthlyCountResponseFromJson(json);

/// Success status
@override final  bool success;
/// Data containing monthly counts
 final  List<MonthlyCount> _data;
/// Data containing monthly counts
@override List<MonthlyCount> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of JobsMonthlyCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobsMonthlyCountResponseCopyWith<_JobsMonthlyCountResponse> get copyWith => __$JobsMonthlyCountResponseCopyWithImpl<_JobsMonthlyCountResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobsMonthlyCountResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobsMonthlyCountResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'JobsMonthlyCountResponse(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class _$JobsMonthlyCountResponseCopyWith<$Res> implements $JobsMonthlyCountResponseCopyWith<$Res> {
  factory _$JobsMonthlyCountResponseCopyWith(_JobsMonthlyCountResponse value, $Res Function(_JobsMonthlyCountResponse) _then) = __$JobsMonthlyCountResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, List<MonthlyCount> data
});




}
/// @nodoc
class __$JobsMonthlyCountResponseCopyWithImpl<$Res>
    implements _$JobsMonthlyCountResponseCopyWith<$Res> {
  __$JobsMonthlyCountResponseCopyWithImpl(this._self, this._then);

  final _JobsMonthlyCountResponse _self;
  final $Res Function(_JobsMonthlyCountResponse) _then;

/// Create a copy of JobsMonthlyCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? data = null,}) {
  return _then(_JobsMonthlyCountResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<MonthlyCount>,
  ));
}


}


/// @nodoc
mixin _$MonthlyCount {

/// Month (YYYY-MM format)
 String get month;/// Number of jobs in this month
 int get count;
/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyCountCopyWith<MonthlyCount> get copyWith => _$MonthlyCountCopyWithImpl<MonthlyCount>(this as MonthlyCount, _$identity);

  /// Serializes this MonthlyCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyCount&&(identical(other.month, month) || other.month == month)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,count);

@override
String toString() {
  return 'MonthlyCount(month: $month, count: $count)';
}


}

/// @nodoc
abstract mixin class $MonthlyCountCopyWith<$Res>  {
  factory $MonthlyCountCopyWith(MonthlyCount value, $Res Function(MonthlyCount) _then) = _$MonthlyCountCopyWithImpl;
@useResult
$Res call({
 String month, int count
});




}
/// @nodoc
class _$MonthlyCountCopyWithImpl<$Res>
    implements $MonthlyCountCopyWith<$Res> {
  _$MonthlyCountCopyWithImpl(this._self, this._then);

  final MonthlyCount _self;
  final $Res Function(MonthlyCount) _then;

/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? count = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyCount].
extension MonthlyCountPatterns on MonthlyCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyCount value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyCount value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
return $default(_that.month,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  int count)  $default,) {final _that = this;
switch (_that) {
case _MonthlyCount():
return $default(_that.month,_that.count);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  int count)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
return $default(_that.month,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyCount implements MonthlyCount {
  const _MonthlyCount({required this.month, required this.count});
  factory _MonthlyCount.fromJson(Map<String, dynamic> json) => _$MonthlyCountFromJson(json);

/// Month (YYYY-MM format)
@override final  String month;
/// Number of jobs in this month
@override final  int count;

/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyCountCopyWith<_MonthlyCount> get copyWith => __$MonthlyCountCopyWithImpl<_MonthlyCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyCount&&(identical(other.month, month) || other.month == month)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,count);

@override
String toString() {
  return 'MonthlyCount(month: $month, count: $count)';
}


}

/// @nodoc
abstract mixin class _$MonthlyCountCopyWith<$Res> implements $MonthlyCountCopyWith<$Res> {
  factory _$MonthlyCountCopyWith(_MonthlyCount value, $Res Function(_MonthlyCount) _then) = __$MonthlyCountCopyWithImpl;
@override @useResult
$Res call({
 String month, int count
});




}
/// @nodoc
class __$MonthlyCountCopyWithImpl<$Res>
    implements _$MonthlyCountCopyWith<$Res> {
  __$MonthlyCountCopyWithImpl(this._self, this._then);

  final _MonthlyCount _self;
  final $Res Function(_MonthlyCount) _then;

/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? count = null,}) {
  return _then(_MonthlyCount(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
