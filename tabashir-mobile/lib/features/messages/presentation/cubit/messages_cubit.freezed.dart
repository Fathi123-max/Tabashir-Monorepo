// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessagesState {

 MessagesStatus get status; List<NotificationModel> get messages; int get unreadCount; bool get isLoading; bool get hasError; String get errorMessage; List<String> get blockedUsers;
/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesStateCopyWith<MessagesState> get copyWith => _$MessagesStateCopyWithImpl<MessagesState>(this as MessagesState, _$identity);

  /// Serializes this MessagesState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.blockedUsers, blockedUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(messages),unreadCount,isLoading,hasError,errorMessage,const DeepCollectionEquality().hash(blockedUsers));

@override
String toString() {
  return 'MessagesState(status: $status, messages: $messages, unreadCount: $unreadCount, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, blockedUsers: $blockedUsers)';
}


}

/// @nodoc
abstract mixin class $MessagesStateCopyWith<$Res>  {
  factory $MessagesStateCopyWith(MessagesState value, $Res Function(MessagesState) _then) = _$MessagesStateCopyWithImpl;
@useResult
$Res call({
 MessagesStatus status, List<NotificationModel> messages, int unreadCount, bool isLoading, bool hasError, String errorMessage, List<String> blockedUsers
});




}
/// @nodoc
class _$MessagesStateCopyWithImpl<$Res>
    implements $MessagesStateCopyWith<$Res> {
  _$MessagesStateCopyWithImpl(this._self, this._then);

  final MessagesState _self;
  final $Res Function(MessagesState) _then;

/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? messages = null,Object? unreadCount = null,Object? isLoading = null,Object? hasError = null,Object? errorMessage = null,Object? blockedUsers = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessagesStatus,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,blockedUsers: null == blockedUsers ? _self.blockedUsers : blockedUsers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MessagesState].
extension MessagesStatePatterns on MessagesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessagesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessagesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessagesState value)  $default,){
final _that = this;
switch (_that) {
case _MessagesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessagesState value)?  $default,){
final _that = this;
switch (_that) {
case _MessagesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MessagesStatus status,  List<NotificationModel> messages,  int unreadCount,  bool isLoading,  bool hasError,  String errorMessage,  List<String> blockedUsers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessagesState() when $default != null:
return $default(_that.status,_that.messages,_that.unreadCount,_that.isLoading,_that.hasError,_that.errorMessage,_that.blockedUsers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MessagesStatus status,  List<NotificationModel> messages,  int unreadCount,  bool isLoading,  bool hasError,  String errorMessage,  List<String> blockedUsers)  $default,) {final _that = this;
switch (_that) {
case _MessagesState():
return $default(_that.status,_that.messages,_that.unreadCount,_that.isLoading,_that.hasError,_that.errorMessage,_that.blockedUsers);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MessagesStatus status,  List<NotificationModel> messages,  int unreadCount,  bool isLoading,  bool hasError,  String errorMessage,  List<String> blockedUsers)?  $default,) {final _that = this;
switch (_that) {
case _MessagesState() when $default != null:
return $default(_that.status,_that.messages,_that.unreadCount,_that.isLoading,_that.hasError,_that.errorMessage,_that.blockedUsers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessagesState implements MessagesState {
  const _MessagesState({this.status = MessagesStatus.initial, final  List<NotificationModel> messages = const [], this.unreadCount = 0, this.isLoading = false, this.hasError = false, this.errorMessage = '', final  List<String> blockedUsers = const []}): _messages = messages,_blockedUsers = blockedUsers;
  factory _MessagesState.fromJson(Map<String, dynamic> json) => _$MessagesStateFromJson(json);

@override@JsonKey() final  MessagesStatus status;
 final  List<NotificationModel> _messages;
@override@JsonKey() List<NotificationModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  String errorMessage;
 final  List<String> _blockedUsers;
@override@JsonKey() List<String> get blockedUsers {
  if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blockedUsers);
}


/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesStateCopyWith<_MessagesState> get copyWith => __$MessagesStateCopyWithImpl<_MessagesState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagesStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._blockedUsers, _blockedUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_messages),unreadCount,isLoading,hasError,errorMessage,const DeepCollectionEquality().hash(_blockedUsers));

@override
String toString() {
  return 'MessagesState(status: $status, messages: $messages, unreadCount: $unreadCount, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, blockedUsers: $blockedUsers)';
}


}

/// @nodoc
abstract mixin class _$MessagesStateCopyWith<$Res> implements $MessagesStateCopyWith<$Res> {
  factory _$MessagesStateCopyWith(_MessagesState value, $Res Function(_MessagesState) _then) = __$MessagesStateCopyWithImpl;
@override @useResult
$Res call({
 MessagesStatus status, List<NotificationModel> messages, int unreadCount, bool isLoading, bool hasError, String errorMessage, List<String> blockedUsers
});




}
/// @nodoc
class __$MessagesStateCopyWithImpl<$Res>
    implements _$MessagesStateCopyWith<$Res> {
  __$MessagesStateCopyWithImpl(this._self, this._then);

  final _MessagesState _self;
  final $Res Function(_MessagesState) _then;

/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? messages = null,Object? unreadCount = null,Object? isLoading = null,Object? hasError = null,Object? errorMessage = null,Object? blockedUsers = null,}) {
  return _then(_MessagesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessagesStatus,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,blockedUsers: null == blockedUsers ? _self._blockedUsers : blockedUsers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
