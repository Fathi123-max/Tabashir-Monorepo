// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminState {

 AdminStatus get status; String get errorMessage; AdminUser? get adminProfile; AdminStats? get dashboardStats; List<Map<String, dynamic>> get users; List<Map<String, dynamic>> get jobs; List<Map<String, dynamic>> get applications; List<Map<String, dynamic>> get systemLogs; Map<String, dynamic>? get analytics; String? get exportDataUrl;
/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminStateCopyWith<AdminState> get copyWith => _$AdminStateCopyWithImpl<AdminState>(this as AdminState, _$identity);

  /// Serializes this AdminState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.adminProfile, adminProfile) || other.adminProfile == adminProfile)&&(identical(other.dashboardStats, dashboardStats) || other.dashboardStats == dashboardStats)&&const DeepCollectionEquality().equals(other.users, users)&&const DeepCollectionEquality().equals(other.jobs, jobs)&&const DeepCollectionEquality().equals(other.applications, applications)&&const DeepCollectionEquality().equals(other.systemLogs, systemLogs)&&const DeepCollectionEquality().equals(other.analytics, analytics)&&(identical(other.exportDataUrl, exportDataUrl) || other.exportDataUrl == exportDataUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,adminProfile,dashboardStats,const DeepCollectionEquality().hash(users),const DeepCollectionEquality().hash(jobs),const DeepCollectionEquality().hash(applications),const DeepCollectionEquality().hash(systemLogs),const DeepCollectionEquality().hash(analytics),exportDataUrl);

@override
String toString() {
  return 'AdminState(status: $status, errorMessage: $errorMessage, adminProfile: $adminProfile, dashboardStats: $dashboardStats, users: $users, jobs: $jobs, applications: $applications, systemLogs: $systemLogs, analytics: $analytics, exportDataUrl: $exportDataUrl)';
}


}

/// @nodoc
abstract mixin class $AdminStateCopyWith<$Res>  {
  factory $AdminStateCopyWith(AdminState value, $Res Function(AdminState) _then) = _$AdminStateCopyWithImpl;
@useResult
$Res call({
 AdminStatus status, String errorMessage, AdminUser? adminProfile, AdminStats? dashboardStats, List<Map<String, dynamic>> users, List<Map<String, dynamic>> jobs, List<Map<String, dynamic>> applications, List<Map<String, dynamic>> systemLogs, Map<String, dynamic>? analytics, String? exportDataUrl
});


$AdminUserCopyWith<$Res>? get adminProfile;$AdminStatsCopyWith<$Res>? get dashboardStats;

}
/// @nodoc
class _$AdminStateCopyWithImpl<$Res>
    implements $AdminStateCopyWith<$Res> {
  _$AdminStateCopyWithImpl(this._self, this._then);

  final AdminState _self;
  final $Res Function(AdminState) _then;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? adminProfile = freezed,Object? dashboardStats = freezed,Object? users = null,Object? jobs = null,Object? applications = null,Object? systemLogs = null,Object? analytics = freezed,Object? exportDataUrl = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AdminStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,adminProfile: freezed == adminProfile ? _self.adminProfile : adminProfile // ignore: cast_nullable_to_non_nullable
as AdminUser?,dashboardStats: freezed == dashboardStats ? _self.dashboardStats : dashboardStats // ignore: cast_nullable_to_non_nullable
as AdminStats?,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,applications: null == applications ? _self.applications : applications // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,systemLogs: null == systemLogs ? _self.systemLogs : systemLogs // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,analytics: freezed == analytics ? _self.analytics : analytics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,exportDataUrl: freezed == exportDataUrl ? _self.exportDataUrl : exportDataUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminUserCopyWith<$Res>? get adminProfile {
    if (_self.adminProfile == null) {
    return null;
  }

  return $AdminUserCopyWith<$Res>(_self.adminProfile!, (value) {
    return _then(_self.copyWith(adminProfile: value));
  });
}/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminStatsCopyWith<$Res>? get dashboardStats {
    if (_self.dashboardStats == null) {
    return null;
  }

  return $AdminStatsCopyWith<$Res>(_self.dashboardStats!, (value) {
    return _then(_self.copyWith(dashboardStats: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminState].
extension AdminStatePatterns on AdminState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminState value)  $default,){
final _that = this;
switch (_that) {
case _AdminState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdminStatus status,  String errorMessage,  AdminUser? adminProfile,  AdminStats? dashboardStats,  List<Map<String, dynamic>> users,  List<Map<String, dynamic>> jobs,  List<Map<String, dynamic>> applications,  List<Map<String, dynamic>> systemLogs,  Map<String, dynamic>? analytics,  String? exportDataUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.adminProfile,_that.dashboardStats,_that.users,_that.jobs,_that.applications,_that.systemLogs,_that.analytics,_that.exportDataUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdminStatus status,  String errorMessage,  AdminUser? adminProfile,  AdminStats? dashboardStats,  List<Map<String, dynamic>> users,  List<Map<String, dynamic>> jobs,  List<Map<String, dynamic>> applications,  List<Map<String, dynamic>> systemLogs,  Map<String, dynamic>? analytics,  String? exportDataUrl)  $default,) {final _that = this;
switch (_that) {
case _AdminState():
return $default(_that.status,_that.errorMessage,_that.adminProfile,_that.dashboardStats,_that.users,_that.jobs,_that.applications,_that.systemLogs,_that.analytics,_that.exportDataUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdminStatus status,  String errorMessage,  AdminUser? adminProfile,  AdminStats? dashboardStats,  List<Map<String, dynamic>> users,  List<Map<String, dynamic>> jobs,  List<Map<String, dynamic>> applications,  List<Map<String, dynamic>> systemLogs,  Map<String, dynamic>? analytics,  String? exportDataUrl)?  $default,) {final _that = this;
switch (_that) {
case _AdminState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.adminProfile,_that.dashboardStats,_that.users,_that.jobs,_that.applications,_that.systemLogs,_that.analytics,_that.exportDataUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminState implements AdminState {
  const _AdminState({this.status = AdminStatus.initial, this.errorMessage = '', this.adminProfile, this.dashboardStats, final  List<Map<String, dynamic>> users = const [], final  List<Map<String, dynamic>> jobs = const [], final  List<Map<String, dynamic>> applications = const [], final  List<Map<String, dynamic>> systemLogs = const [], final  Map<String, dynamic>? analytics, this.exportDataUrl}): _users = users,_jobs = jobs,_applications = applications,_systemLogs = systemLogs,_analytics = analytics;
  factory _AdminState.fromJson(Map<String, dynamic> json) => _$AdminStateFromJson(json);

@override@JsonKey() final  AdminStatus status;
@override@JsonKey() final  String errorMessage;
@override final  AdminUser? adminProfile;
@override final  AdminStats? dashboardStats;
 final  List<Map<String, dynamic>> _users;
@override@JsonKey() List<Map<String, dynamic>> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

 final  List<Map<String, dynamic>> _jobs;
@override@JsonKey() List<Map<String, dynamic>> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}

 final  List<Map<String, dynamic>> _applications;
@override@JsonKey() List<Map<String, dynamic>> get applications {
  if (_applications is EqualUnmodifiableListView) return _applications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_applications);
}

 final  List<Map<String, dynamic>> _systemLogs;
@override@JsonKey() List<Map<String, dynamic>> get systemLogs {
  if (_systemLogs is EqualUnmodifiableListView) return _systemLogs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_systemLogs);
}

 final  Map<String, dynamic>? _analytics;
@override Map<String, dynamic>? get analytics {
  final value = _analytics;
  if (value == null) return null;
  if (_analytics is EqualUnmodifiableMapView) return _analytics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? exportDataUrl;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminStateCopyWith<_AdminState> get copyWith => __$AdminStateCopyWithImpl<_AdminState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.adminProfile, adminProfile) || other.adminProfile == adminProfile)&&(identical(other.dashboardStats, dashboardStats) || other.dashboardStats == dashboardStats)&&const DeepCollectionEquality().equals(other._users, _users)&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&const DeepCollectionEquality().equals(other._applications, _applications)&&const DeepCollectionEquality().equals(other._systemLogs, _systemLogs)&&const DeepCollectionEquality().equals(other._analytics, _analytics)&&(identical(other.exportDataUrl, exportDataUrl) || other.exportDataUrl == exportDataUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,adminProfile,dashboardStats,const DeepCollectionEquality().hash(_users),const DeepCollectionEquality().hash(_jobs),const DeepCollectionEquality().hash(_applications),const DeepCollectionEquality().hash(_systemLogs),const DeepCollectionEquality().hash(_analytics),exportDataUrl);

@override
String toString() {
  return 'AdminState(status: $status, errorMessage: $errorMessage, adminProfile: $adminProfile, dashboardStats: $dashboardStats, users: $users, jobs: $jobs, applications: $applications, systemLogs: $systemLogs, analytics: $analytics, exportDataUrl: $exportDataUrl)';
}


}

/// @nodoc
abstract mixin class _$AdminStateCopyWith<$Res> implements $AdminStateCopyWith<$Res> {
  factory _$AdminStateCopyWith(_AdminState value, $Res Function(_AdminState) _then) = __$AdminStateCopyWithImpl;
@override @useResult
$Res call({
 AdminStatus status, String errorMessage, AdminUser? adminProfile, AdminStats? dashboardStats, List<Map<String, dynamic>> users, List<Map<String, dynamic>> jobs, List<Map<String, dynamic>> applications, List<Map<String, dynamic>> systemLogs, Map<String, dynamic>? analytics, String? exportDataUrl
});


@override $AdminUserCopyWith<$Res>? get adminProfile;@override $AdminStatsCopyWith<$Res>? get dashboardStats;

}
/// @nodoc
class __$AdminStateCopyWithImpl<$Res>
    implements _$AdminStateCopyWith<$Res> {
  __$AdminStateCopyWithImpl(this._self, this._then);

  final _AdminState _self;
  final $Res Function(_AdminState) _then;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? adminProfile = freezed,Object? dashboardStats = freezed,Object? users = null,Object? jobs = null,Object? applications = null,Object? systemLogs = null,Object? analytics = freezed,Object? exportDataUrl = freezed,}) {
  return _then(_AdminState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AdminStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,adminProfile: freezed == adminProfile ? _self.adminProfile : adminProfile // ignore: cast_nullable_to_non_nullable
as AdminUser?,dashboardStats: freezed == dashboardStats ? _self.dashboardStats : dashboardStats // ignore: cast_nullable_to_non_nullable
as AdminStats?,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,applications: null == applications ? _self._applications : applications // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,systemLogs: null == systemLogs ? _self._systemLogs : systemLogs // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,analytics: freezed == analytics ? _self._analytics : analytics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,exportDataUrl: freezed == exportDataUrl ? _self.exportDataUrl : exportDataUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminUserCopyWith<$Res>? get adminProfile {
    if (_self.adminProfile == null) {
    return null;
  }

  return $AdminUserCopyWith<$Res>(_self.adminProfile!, (value) {
    return _then(_self.copyWith(adminProfile: value));
  });
}/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminStatsCopyWith<$Res>? get dashboardStats {
    if (_self.dashboardStats == null) {
    return null;
  }

  return $AdminStatsCopyWith<$Res>(_self.dashboardStats!, (value) {
    return _then(_self.copyWith(dashboardStats: value));
  });
}
}

// dart format on
