// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_api_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationCountResponse {

 int get unreadCount; bool get hasUnread;
/// Create a copy of NotificationCountResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCountResponseCopyWith<NotificationCountResponse> get copyWith => _$NotificationCountResponseCopyWithImpl<NotificationCountResponse>(this as NotificationCountResponse, _$identity);

  /// Serializes this NotificationCountResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationCountResponse&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.hasUnread, hasUnread) || other.hasUnread == hasUnread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount,hasUnread);

@override
String toString() {
  return 'NotificationCountResponse(unreadCount: $unreadCount, hasUnread: $hasUnread)';
}


}

/// @nodoc
abstract mixin class $NotificationCountResponseCopyWith<$Res>  {
  factory $NotificationCountResponseCopyWith(NotificationCountResponse value, $Res Function(NotificationCountResponse) _then) = _$NotificationCountResponseCopyWithImpl;
@useResult
$Res call({
 int unreadCount, bool hasUnread
});




}
/// @nodoc
class _$NotificationCountResponseCopyWithImpl<$Res>
    implements $NotificationCountResponseCopyWith<$Res> {
  _$NotificationCountResponseCopyWithImpl(this._self, this._then);

  final NotificationCountResponse _self;
  final $Res Function(NotificationCountResponse) _then;

/// Create a copy of NotificationCountResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unreadCount = null,Object? hasUnread = null,}) {
  return _then(_self.copyWith(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationCountResponse].
extension NotificationCountResponsePatterns on NotificationCountResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationCountResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationCountResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationCountResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationCountResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationCountResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationCountResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int unreadCount,  bool hasUnread)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationCountResponse() when $default != null:
return $default(_that.unreadCount,_that.hasUnread);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int unreadCount,  bool hasUnread)  $default,) {final _that = this;
switch (_that) {
case _NotificationCountResponse():
return $default(_that.unreadCount,_that.hasUnread);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int unreadCount,  bool hasUnread)?  $default,) {final _that = this;
switch (_that) {
case _NotificationCountResponse() when $default != null:
return $default(_that.unreadCount,_that.hasUnread);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationCountResponse implements NotificationCountResponse {
  const _NotificationCountResponse({required this.unreadCount, required this.hasUnread});
  factory _NotificationCountResponse.fromJson(Map<String, dynamic> json) => _$NotificationCountResponseFromJson(json);

@override final  int unreadCount;
@override final  bool hasUnread;

/// Create a copy of NotificationCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCountResponseCopyWith<_NotificationCountResponse> get copyWith => __$NotificationCountResponseCopyWithImpl<_NotificationCountResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationCountResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationCountResponse&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.hasUnread, hasUnread) || other.hasUnread == hasUnread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount,hasUnread);

@override
String toString() {
  return 'NotificationCountResponse(unreadCount: $unreadCount, hasUnread: $hasUnread)';
}


}

/// @nodoc
abstract mixin class _$NotificationCountResponseCopyWith<$Res> implements $NotificationCountResponseCopyWith<$Res> {
  factory _$NotificationCountResponseCopyWith(_NotificationCountResponse value, $Res Function(_NotificationCountResponse) _then) = __$NotificationCountResponseCopyWithImpl;
@override @useResult
$Res call({
 int unreadCount, bool hasUnread
});




}
/// @nodoc
class __$NotificationCountResponseCopyWithImpl<$Res>
    implements _$NotificationCountResponseCopyWith<$Res> {
  __$NotificationCountResponseCopyWithImpl(this._self, this._then);

  final _NotificationCountResponse _self;
  final $Res Function(_NotificationCountResponse) _then;

/// Create a copy of NotificationCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unreadCount = null,Object? hasUnread = null,}) {
  return _then(_NotificationCountResponse(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
