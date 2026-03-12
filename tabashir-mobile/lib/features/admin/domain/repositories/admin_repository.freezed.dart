// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminUser {

 String get id; String get name; String get email; String get role; List<String> get permissions; DateTime? get lastLogin; bool get isActive;
/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminUserCopyWith<AdminUser> get copyWith => _$AdminUserCopyWithImpl<AdminUser>(this as AdminUser, _$identity);

  /// Serializes this AdminUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,role,const DeepCollectionEquality().hash(permissions),lastLogin,isActive);

@override
String toString() {
  return 'AdminUser(id: $id, name: $name, email: $email, role: $role, permissions: $permissions, lastLogin: $lastLogin, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $AdminUserCopyWith<$Res>  {
  factory $AdminUserCopyWith(AdminUser value, $Res Function(AdminUser) _then) = _$AdminUserCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String role, List<String> permissions, DateTime? lastLogin, bool isActive
});




}
/// @nodoc
class _$AdminUserCopyWithImpl<$Res>
    implements $AdminUserCopyWith<$Res> {
  _$AdminUserCopyWithImpl(this._self, this._then);

  final AdminUser _self;
  final $Res Function(AdminUser) _then;

/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? role = null,Object? permissions = null,Object? lastLogin = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminUser].
extension AdminUserPatterns on AdminUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminUser value)  $default,){
final _that = this;
switch (_that) {
case _AdminUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminUser value)?  $default,){
final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String role,  List<String> permissions,  DateTime? lastLogin,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.role,_that.permissions,_that.lastLogin,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String role,  List<String> permissions,  DateTime? lastLogin,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _AdminUser():
return $default(_that.id,_that.name,_that.email,_that.role,_that.permissions,_that.lastLogin,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email,  String role,  List<String> permissions,  DateTime? lastLogin,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.role,_that.permissions,_that.lastLogin,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminUser implements AdminUser {
  const _AdminUser({required this.id, required this.name, required this.email, required this.role, final  List<String> permissions = const [], this.lastLogin, this.isActive = true}): _permissions = permissions;
  factory _AdminUser.fromJson(Map<String, dynamic> json) => _$AdminUserFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String role;
 final  List<String> _permissions;
@override@JsonKey() List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

@override final  DateTime? lastLogin;
@override@JsonKey() final  bool isActive;

/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminUserCopyWith<_AdminUser> get copyWith => __$AdminUserCopyWithImpl<_AdminUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,role,const DeepCollectionEquality().hash(_permissions),lastLogin,isActive);

@override
String toString() {
  return 'AdminUser(id: $id, name: $name, email: $email, role: $role, permissions: $permissions, lastLogin: $lastLogin, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$AdminUserCopyWith<$Res> implements $AdminUserCopyWith<$Res> {
  factory _$AdminUserCopyWith(_AdminUser value, $Res Function(_AdminUser) _then) = __$AdminUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String role, List<String> permissions, DateTime? lastLogin, bool isActive
});




}
/// @nodoc
class __$AdminUserCopyWithImpl<$Res>
    implements _$AdminUserCopyWith<$Res> {
  __$AdminUserCopyWithImpl(this._self, this._then);

  final _AdminUser _self;
  final $Res Function(_AdminUser) _then;

/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? role = null,Object? permissions = null,Object? lastLogin = freezed,Object? isActive = null,}) {
  return _then(_AdminUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AdminStats {

 int get totalUsers; int get totalJobs; int get totalApplications; int get activeSubscriptions; List<Map<String, int>> get dailySignups; List<Map<String, int>> get jobPostingStats;
/// Create a copy of AdminStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminStatsCopyWith<AdminStats> get copyWith => _$AdminStatsCopyWithImpl<AdminStats>(this as AdminStats, _$identity);

  /// Serializes this AdminStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminStats&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.totalJobs, totalJobs) || other.totalJobs == totalJobs)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.activeSubscriptions, activeSubscriptions) || other.activeSubscriptions == activeSubscriptions)&&const DeepCollectionEquality().equals(other.dailySignups, dailySignups)&&const DeepCollectionEquality().equals(other.jobPostingStats, jobPostingStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUsers,totalJobs,totalApplications,activeSubscriptions,const DeepCollectionEquality().hash(dailySignups),const DeepCollectionEquality().hash(jobPostingStats));

@override
String toString() {
  return 'AdminStats(totalUsers: $totalUsers, totalJobs: $totalJobs, totalApplications: $totalApplications, activeSubscriptions: $activeSubscriptions, dailySignups: $dailySignups, jobPostingStats: $jobPostingStats)';
}


}

/// @nodoc
abstract mixin class $AdminStatsCopyWith<$Res>  {
  factory $AdminStatsCopyWith(AdminStats value, $Res Function(AdminStats) _then) = _$AdminStatsCopyWithImpl;
@useResult
$Res call({
 int totalUsers, int totalJobs, int totalApplications, int activeSubscriptions, List<Map<String, int>> dailySignups, List<Map<String, int>> jobPostingStats
});




}
/// @nodoc
class _$AdminStatsCopyWithImpl<$Res>
    implements $AdminStatsCopyWith<$Res> {
  _$AdminStatsCopyWithImpl(this._self, this._then);

  final AdminStats _self;
  final $Res Function(AdminStats) _then;

/// Create a copy of AdminStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalUsers = null,Object? totalJobs = null,Object? totalApplications = null,Object? activeSubscriptions = null,Object? dailySignups = null,Object? jobPostingStats = null,}) {
  return _then(_self.copyWith(
totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,totalJobs: null == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,activeSubscriptions: null == activeSubscriptions ? _self.activeSubscriptions : activeSubscriptions // ignore: cast_nullable_to_non_nullable
as int,dailySignups: null == dailySignups ? _self.dailySignups : dailySignups // ignore: cast_nullable_to_non_nullable
as List<Map<String, int>>,jobPostingStats: null == jobPostingStats ? _self.jobPostingStats : jobPostingStats // ignore: cast_nullable_to_non_nullable
as List<Map<String, int>>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminStats].
extension AdminStatsPatterns on AdminStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminStats value)  $default,){
final _that = this;
switch (_that) {
case _AdminStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminStats value)?  $default,){
final _that = this;
switch (_that) {
case _AdminStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalUsers,  int totalJobs,  int totalApplications,  int activeSubscriptions,  List<Map<String, int>> dailySignups,  List<Map<String, int>> jobPostingStats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminStats() when $default != null:
return $default(_that.totalUsers,_that.totalJobs,_that.totalApplications,_that.activeSubscriptions,_that.dailySignups,_that.jobPostingStats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalUsers,  int totalJobs,  int totalApplications,  int activeSubscriptions,  List<Map<String, int>> dailySignups,  List<Map<String, int>> jobPostingStats)  $default,) {final _that = this;
switch (_that) {
case _AdminStats():
return $default(_that.totalUsers,_that.totalJobs,_that.totalApplications,_that.activeSubscriptions,_that.dailySignups,_that.jobPostingStats);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalUsers,  int totalJobs,  int totalApplications,  int activeSubscriptions,  List<Map<String, int>> dailySignups,  List<Map<String, int>> jobPostingStats)?  $default,) {final _that = this;
switch (_that) {
case _AdminStats() when $default != null:
return $default(_that.totalUsers,_that.totalJobs,_that.totalApplications,_that.activeSubscriptions,_that.dailySignups,_that.jobPostingStats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminStats implements AdminStats {
  const _AdminStats({required this.totalUsers, required this.totalJobs, required this.totalApplications, required this.activeSubscriptions, final  List<Map<String, int>> dailySignups = const [], final  List<Map<String, int>> jobPostingStats = const []}): _dailySignups = dailySignups,_jobPostingStats = jobPostingStats;
  factory _AdminStats.fromJson(Map<String, dynamic> json) => _$AdminStatsFromJson(json);

@override final  int totalUsers;
@override final  int totalJobs;
@override final  int totalApplications;
@override final  int activeSubscriptions;
 final  List<Map<String, int>> _dailySignups;
@override@JsonKey() List<Map<String, int>> get dailySignups {
  if (_dailySignups is EqualUnmodifiableListView) return _dailySignups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailySignups);
}

 final  List<Map<String, int>> _jobPostingStats;
@override@JsonKey() List<Map<String, int>> get jobPostingStats {
  if (_jobPostingStats is EqualUnmodifiableListView) return _jobPostingStats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobPostingStats);
}


/// Create a copy of AdminStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminStatsCopyWith<_AdminStats> get copyWith => __$AdminStatsCopyWithImpl<_AdminStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminStats&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.totalJobs, totalJobs) || other.totalJobs == totalJobs)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.activeSubscriptions, activeSubscriptions) || other.activeSubscriptions == activeSubscriptions)&&const DeepCollectionEquality().equals(other._dailySignups, _dailySignups)&&const DeepCollectionEquality().equals(other._jobPostingStats, _jobPostingStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUsers,totalJobs,totalApplications,activeSubscriptions,const DeepCollectionEquality().hash(_dailySignups),const DeepCollectionEquality().hash(_jobPostingStats));

@override
String toString() {
  return 'AdminStats(totalUsers: $totalUsers, totalJobs: $totalJobs, totalApplications: $totalApplications, activeSubscriptions: $activeSubscriptions, dailySignups: $dailySignups, jobPostingStats: $jobPostingStats)';
}


}

/// @nodoc
abstract mixin class _$AdminStatsCopyWith<$Res> implements $AdminStatsCopyWith<$Res> {
  factory _$AdminStatsCopyWith(_AdminStats value, $Res Function(_AdminStats) _then) = __$AdminStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalUsers, int totalJobs, int totalApplications, int activeSubscriptions, List<Map<String, int>> dailySignups, List<Map<String, int>> jobPostingStats
});




}
/// @nodoc
class __$AdminStatsCopyWithImpl<$Res>
    implements _$AdminStatsCopyWith<$Res> {
  __$AdminStatsCopyWithImpl(this._self, this._then);

  final _AdminStats _self;
  final $Res Function(_AdminStats) _then;

/// Create a copy of AdminStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalUsers = null,Object? totalJobs = null,Object? totalApplications = null,Object? activeSubscriptions = null,Object? dailySignups = null,Object? jobPostingStats = null,}) {
  return _then(_AdminStats(
totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,totalJobs: null == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,activeSubscriptions: null == activeSubscriptions ? _self.activeSubscriptions : activeSubscriptions // ignore: cast_nullable_to_non_nullable
as int,dailySignups: null == dailySignups ? _self._dailySignups : dailySignups // ignore: cast_nullable_to_non_nullable
as List<Map<String, int>>,jobPostingStats: null == jobPostingStats ? _self._jobPostingStats : jobPostingStats // ignore: cast_nullable_to_non_nullable
as List<Map<String, int>>,
  ));
}


}

// dart format on
