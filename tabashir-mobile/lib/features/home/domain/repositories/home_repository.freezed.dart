// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardData {

 String get userId; String get userName; String get userEmail; String? get userAvatar; List<QuickAction> get quickActions; List<RecentActivity> get recentActivities; List<JobRecommendation> get jobRecommendations; int get totalApplications; int get savedJobs; int get profileViews;
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<DashboardData> get copyWith => _$DashboardDataCopyWithImpl<DashboardData>(this as DashboardData, _$identity);

  /// Serializes this DashboardData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardData&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&const DeepCollectionEquality().equals(other.quickActions, quickActions)&&const DeepCollectionEquality().equals(other.recentActivities, recentActivities)&&const DeepCollectionEquality().equals(other.jobRecommendations, jobRecommendations)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.savedJobs, savedJobs) || other.savedJobs == savedJobs)&&(identical(other.profileViews, profileViews) || other.profileViews == profileViews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,userEmail,userAvatar,const DeepCollectionEquality().hash(quickActions),const DeepCollectionEquality().hash(recentActivities),const DeepCollectionEquality().hash(jobRecommendations),totalApplications,savedJobs,profileViews);

@override
String toString() {
  return 'DashboardData(userId: $userId, userName: $userName, userEmail: $userEmail, userAvatar: $userAvatar, quickActions: $quickActions, recentActivities: $recentActivities, jobRecommendations: $jobRecommendations, totalApplications: $totalApplications, savedJobs: $savedJobs, profileViews: $profileViews)';
}


}

/// @nodoc
abstract mixin class $DashboardDataCopyWith<$Res>  {
  factory $DashboardDataCopyWith(DashboardData value, $Res Function(DashboardData) _then) = _$DashboardDataCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, String userEmail, String? userAvatar, List<QuickAction> quickActions, List<RecentActivity> recentActivities, List<JobRecommendation> jobRecommendations, int totalApplications, int savedJobs, int profileViews
});




}
/// @nodoc
class _$DashboardDataCopyWithImpl<$Res>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._self, this._then);

  final DashboardData _self;
  final $Res Function(DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? userEmail = null,Object? userAvatar = freezed,Object? quickActions = null,Object? recentActivities = null,Object? jobRecommendations = null,Object? totalApplications = null,Object? savedJobs = null,Object? profileViews = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,quickActions: null == quickActions ? _self.quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,recentActivities: null == recentActivities ? _self.recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<RecentActivity>,jobRecommendations: null == jobRecommendations ? _self.jobRecommendations : jobRecommendations // ignore: cast_nullable_to_non_nullable
as List<JobRecommendation>,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,savedJobs: null == savedJobs ? _self.savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as int,profileViews: null == profileViews ? _self.profileViews : profileViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardData].
extension DashboardDataPatterns on DashboardData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardData value)  $default,){
final _that = this;
switch (_that) {
case _DashboardData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardData value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  String userEmail,  String? userAvatar,  List<QuickAction> quickActions,  List<RecentActivity> recentActivities,  List<JobRecommendation> jobRecommendations,  int totalApplications,  int savedJobs,  int profileViews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.userId,_that.userName,_that.userEmail,_that.userAvatar,_that.quickActions,_that.recentActivities,_that.jobRecommendations,_that.totalApplications,_that.savedJobs,_that.profileViews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  String userEmail,  String? userAvatar,  List<QuickAction> quickActions,  List<RecentActivity> recentActivities,  List<JobRecommendation> jobRecommendations,  int totalApplications,  int savedJobs,  int profileViews)  $default,) {final _that = this;
switch (_that) {
case _DashboardData():
return $default(_that.userId,_that.userName,_that.userEmail,_that.userAvatar,_that.quickActions,_that.recentActivities,_that.jobRecommendations,_that.totalApplications,_that.savedJobs,_that.profileViews);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  String userEmail,  String? userAvatar,  List<QuickAction> quickActions,  List<RecentActivity> recentActivities,  List<JobRecommendation> jobRecommendations,  int totalApplications,  int savedJobs,  int profileViews)?  $default,) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.userId,_that.userName,_that.userEmail,_that.userAvatar,_that.quickActions,_that.recentActivities,_that.jobRecommendations,_that.totalApplications,_that.savedJobs,_that.profileViews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardData implements DashboardData {
  const _DashboardData({required this.userId, required this.userName, required this.userEmail, this.userAvatar, final  List<QuickAction> quickActions = const [], final  List<RecentActivity> recentActivities = const [], final  List<JobRecommendation> jobRecommendations = const [], this.totalApplications = 0, this.savedJobs = 0, this.profileViews = 0}): _quickActions = quickActions,_recentActivities = recentActivities,_jobRecommendations = jobRecommendations;
  factory _DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);

@override final  String userId;
@override final  String userName;
@override final  String userEmail;
@override final  String? userAvatar;
 final  List<QuickAction> _quickActions;
@override@JsonKey() List<QuickAction> get quickActions {
  if (_quickActions is EqualUnmodifiableListView) return _quickActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quickActions);
}

 final  List<RecentActivity> _recentActivities;
@override@JsonKey() List<RecentActivity> get recentActivities {
  if (_recentActivities is EqualUnmodifiableListView) return _recentActivities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentActivities);
}

 final  List<JobRecommendation> _jobRecommendations;
@override@JsonKey() List<JobRecommendation> get jobRecommendations {
  if (_jobRecommendations is EqualUnmodifiableListView) return _jobRecommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobRecommendations);
}

@override@JsonKey() final  int totalApplications;
@override@JsonKey() final  int savedJobs;
@override@JsonKey() final  int profileViews;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDataCopyWith<_DashboardData> get copyWith => __$DashboardDataCopyWithImpl<_DashboardData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardData&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&const DeepCollectionEquality().equals(other._quickActions, _quickActions)&&const DeepCollectionEquality().equals(other._recentActivities, _recentActivities)&&const DeepCollectionEquality().equals(other._jobRecommendations, _jobRecommendations)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.savedJobs, savedJobs) || other.savedJobs == savedJobs)&&(identical(other.profileViews, profileViews) || other.profileViews == profileViews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,userEmail,userAvatar,const DeepCollectionEquality().hash(_quickActions),const DeepCollectionEquality().hash(_recentActivities),const DeepCollectionEquality().hash(_jobRecommendations),totalApplications,savedJobs,profileViews);

@override
String toString() {
  return 'DashboardData(userId: $userId, userName: $userName, userEmail: $userEmail, userAvatar: $userAvatar, quickActions: $quickActions, recentActivities: $recentActivities, jobRecommendations: $jobRecommendations, totalApplications: $totalApplications, savedJobs: $savedJobs, profileViews: $profileViews)';
}


}

/// @nodoc
abstract mixin class _$DashboardDataCopyWith<$Res> implements $DashboardDataCopyWith<$Res> {
  factory _$DashboardDataCopyWith(_DashboardData value, $Res Function(_DashboardData) _then) = __$DashboardDataCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, String userEmail, String? userAvatar, List<QuickAction> quickActions, List<RecentActivity> recentActivities, List<JobRecommendation> jobRecommendations, int totalApplications, int savedJobs, int profileViews
});




}
/// @nodoc
class __$DashboardDataCopyWithImpl<$Res>
    implements _$DashboardDataCopyWith<$Res> {
  __$DashboardDataCopyWithImpl(this._self, this._then);

  final _DashboardData _self;
  final $Res Function(_DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? userEmail = null,Object? userAvatar = freezed,Object? quickActions = null,Object? recentActivities = null,Object? jobRecommendations = null,Object? totalApplications = null,Object? savedJobs = null,Object? profileViews = null,}) {
  return _then(_DashboardData(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,quickActions: null == quickActions ? _self._quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,recentActivities: null == recentActivities ? _self._recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<RecentActivity>,jobRecommendations: null == jobRecommendations ? _self._jobRecommendations : jobRecommendations // ignore: cast_nullable_to_non_nullable
as List<JobRecommendation>,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,savedJobs: null == savedJobs ? _self.savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as int,profileViews: null == profileViews ? _self.profileViews : profileViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$QuickAction {

 String get id; String get title; String get icon; String get route;
/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickActionCopyWith<QuickAction> get copyWith => _$QuickActionCopyWithImpl<QuickAction>(this as QuickAction, _$identity);

  /// Serializes this QuickAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickAction&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.route, route) || other.route == route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,icon,route);

@override
String toString() {
  return 'QuickAction(id: $id, title: $title, icon: $icon, route: $route)';
}


}

/// @nodoc
abstract mixin class $QuickActionCopyWith<$Res>  {
  factory $QuickActionCopyWith(QuickAction value, $Res Function(QuickAction) _then) = _$QuickActionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String icon, String route
});




}
/// @nodoc
class _$QuickActionCopyWithImpl<$Res>
    implements $QuickActionCopyWith<$Res> {
  _$QuickActionCopyWithImpl(this._self, this._then);

  final QuickAction _self;
  final $Res Function(QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? icon = null,Object? route = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickAction].
extension QuickActionPatterns on QuickAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickAction value)  $default,){
final _that = this;
switch (_that) {
case _QuickAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickAction value)?  $default,){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String icon,  String route)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.id,_that.title,_that.icon,_that.route);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String icon,  String route)  $default,) {final _that = this;
switch (_that) {
case _QuickAction():
return $default(_that.id,_that.title,_that.icon,_that.route);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String icon,  String route)?  $default,) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.id,_that.title,_that.icon,_that.route);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuickAction implements QuickAction {
  const _QuickAction({required this.id, required this.title, required this.icon, required this.route});
  factory _QuickAction.fromJson(Map<String, dynamic> json) => _$QuickActionFromJson(json);

@override final  String id;
@override final  String title;
@override final  String icon;
@override final  String route;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickActionCopyWith<_QuickAction> get copyWith => __$QuickActionCopyWithImpl<_QuickAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuickActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickAction&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.route, route) || other.route == route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,icon,route);

@override
String toString() {
  return 'QuickAction(id: $id, title: $title, icon: $icon, route: $route)';
}


}

/// @nodoc
abstract mixin class _$QuickActionCopyWith<$Res> implements $QuickActionCopyWith<$Res> {
  factory _$QuickActionCopyWith(_QuickAction value, $Res Function(_QuickAction) _then) = __$QuickActionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String icon, String route
});




}
/// @nodoc
class __$QuickActionCopyWithImpl<$Res>
    implements _$QuickActionCopyWith<$Res> {
  __$QuickActionCopyWithImpl(this._self, this._then);

  final _QuickAction _self;
  final $Res Function(_QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? icon = null,Object? route = null,}) {
  return _then(_QuickAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RecentActivity {

 String get id; String get title; String get description; DateTime get timestamp; String get type;
/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentActivityCopyWith<RecentActivity> get copyWith => _$RecentActivityCopyWithImpl<RecentActivity>(this as RecentActivity, _$identity);

  /// Serializes this RecentActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,timestamp,type);

@override
String toString() {
  return 'RecentActivity(id: $id, title: $title, description: $description, timestamp: $timestamp, type: $type)';
}


}

/// @nodoc
abstract mixin class $RecentActivityCopyWith<$Res>  {
  factory $RecentActivityCopyWith(RecentActivity value, $Res Function(RecentActivity) _then) = _$RecentActivityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, DateTime timestamp, String type
});




}
/// @nodoc
class _$RecentActivityCopyWithImpl<$Res>
    implements $RecentActivityCopyWith<$Res> {
  _$RecentActivityCopyWithImpl(this._self, this._then);

  final RecentActivity _self;
  final $Res Function(RecentActivity) _then;

/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? timestamp = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentActivity].
extension RecentActivityPatterns on RecentActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentActivity value)  $default,){
final _that = this;
switch (_that) {
case _RecentActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentActivity value)?  $default,){
final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  DateTime timestamp,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.timestamp,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  DateTime timestamp,  String type)  $default,) {final _that = this;
switch (_that) {
case _RecentActivity():
return $default(_that.id,_that.title,_that.description,_that.timestamp,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  DateTime timestamp,  String type)?  $default,) {final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.timestamp,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentActivity implements RecentActivity {
  const _RecentActivity({required this.id, required this.title, required this.description, required this.timestamp, required this.type});
  factory _RecentActivity.fromJson(Map<String, dynamic> json) => _$RecentActivityFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  DateTime timestamp;
@override final  String type;

/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentActivityCopyWith<_RecentActivity> get copyWith => __$RecentActivityCopyWithImpl<_RecentActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,timestamp,type);

@override
String toString() {
  return 'RecentActivity(id: $id, title: $title, description: $description, timestamp: $timestamp, type: $type)';
}


}

/// @nodoc
abstract mixin class _$RecentActivityCopyWith<$Res> implements $RecentActivityCopyWith<$Res> {
  factory _$RecentActivityCopyWith(_RecentActivity value, $Res Function(_RecentActivity) _then) = __$RecentActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, DateTime timestamp, String type
});




}
/// @nodoc
class __$RecentActivityCopyWithImpl<$Res>
    implements _$RecentActivityCopyWith<$Res> {
  __$RecentActivityCopyWithImpl(this._self, this._then);

  final _RecentActivity _self;
  final $Res Function(_RecentActivity) _then;

/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? timestamp = null,Object? type = null,}) {
  return _then(_RecentActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$JobRecommendation {

 String get id; String get title; String get company; String get location; int get matchPercentage;
/// Create a copy of JobRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobRecommendationCopyWith<JobRecommendation> get copyWith => _$JobRecommendationCopyWithImpl<JobRecommendation>(this as JobRecommendation, _$identity);

  /// Serializes this JobRecommendation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobRecommendation&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,company,location,matchPercentage);

@override
String toString() {
  return 'JobRecommendation(id: $id, title: $title, company: $company, location: $location, matchPercentage: $matchPercentage)';
}


}

/// @nodoc
abstract mixin class $JobRecommendationCopyWith<$Res>  {
  factory $JobRecommendationCopyWith(JobRecommendation value, $Res Function(JobRecommendation) _then) = _$JobRecommendationCopyWithImpl;
@useResult
$Res call({
 String id, String title, String company, String location, int matchPercentage
});




}
/// @nodoc
class _$JobRecommendationCopyWithImpl<$Res>
    implements $JobRecommendationCopyWith<$Res> {
  _$JobRecommendationCopyWithImpl(this._self, this._then);

  final JobRecommendation _self;
  final $Res Function(JobRecommendation) _then;

/// Create a copy of JobRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? company = null,Object? location = null,Object? matchPercentage = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [JobRecommendation].
extension JobRecommendationPatterns on JobRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _JobRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _JobRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String company,  String location,  int matchPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobRecommendation() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.location,_that.matchPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String company,  String location,  int matchPercentage)  $default,) {final _that = this;
switch (_that) {
case _JobRecommendation():
return $default(_that.id,_that.title,_that.company,_that.location,_that.matchPercentage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String company,  String location,  int matchPercentage)?  $default,) {final _that = this;
switch (_that) {
case _JobRecommendation() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.location,_that.matchPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobRecommendation implements JobRecommendation {
  const _JobRecommendation({required this.id, required this.title, required this.company, required this.location, this.matchPercentage = 0});
  factory _JobRecommendation.fromJson(Map<String, dynamic> json) => _$JobRecommendationFromJson(json);

@override final  String id;
@override final  String title;
@override final  String company;
@override final  String location;
@override@JsonKey() final  int matchPercentage;

/// Create a copy of JobRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobRecommendationCopyWith<_JobRecommendation> get copyWith => __$JobRecommendationCopyWithImpl<_JobRecommendation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobRecommendationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobRecommendation&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,company,location,matchPercentage);

@override
String toString() {
  return 'JobRecommendation(id: $id, title: $title, company: $company, location: $location, matchPercentage: $matchPercentage)';
}


}

/// @nodoc
abstract mixin class _$JobRecommendationCopyWith<$Res> implements $JobRecommendationCopyWith<$Res> {
  factory _$JobRecommendationCopyWith(_JobRecommendation value, $Res Function(_JobRecommendation) _then) = __$JobRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String company, String location, int matchPercentage
});




}
/// @nodoc
class __$JobRecommendationCopyWithImpl<$Res>
    implements _$JobRecommendationCopyWith<$Res> {
  __$JobRecommendationCopyWithImpl(this._self, this._then);

  final _JobRecommendation _self;
  final $Res Function(_JobRecommendation) _then;

/// Create a copy of JobRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? company = null,Object? location = null,Object? matchPercentage = null,}) {
  return _then(_JobRecommendation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CityJobCount {

 String get city; int get count;
/// Create a copy of CityJobCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityJobCountCopyWith<CityJobCount> get copyWith => _$CityJobCountCopyWithImpl<CityJobCount>(this as CityJobCount, _$identity);

  /// Serializes this CityJobCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityJobCount&&(identical(other.city, city) || other.city == city)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,count);

@override
String toString() {
  return 'CityJobCount(city: $city, count: $count)';
}


}

/// @nodoc
abstract mixin class $CityJobCountCopyWith<$Res>  {
  factory $CityJobCountCopyWith(CityJobCount value, $Res Function(CityJobCount) _then) = _$CityJobCountCopyWithImpl;
@useResult
$Res call({
 String city, int count
});




}
/// @nodoc
class _$CityJobCountCopyWithImpl<$Res>
    implements $CityJobCountCopyWith<$Res> {
  _$CityJobCountCopyWithImpl(this._self, this._then);

  final CityJobCount _self;
  final $Res Function(CityJobCount) _then;

/// Create a copy of CityJobCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? count = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CityJobCount].
extension CityJobCountPatterns on CityJobCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityJobCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityJobCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityJobCount value)  $default,){
final _that = this;
switch (_that) {
case _CityJobCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityJobCount value)?  $default,){
final _that = this;
switch (_that) {
case _CityJobCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityJobCount() when $default != null:
return $default(_that.city,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  int count)  $default,) {final _that = this;
switch (_that) {
case _CityJobCount():
return $default(_that.city,_that.count);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  int count)?  $default,) {final _that = this;
switch (_that) {
case _CityJobCount() when $default != null:
return $default(_that.city,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityJobCount implements CityJobCount {
  const _CityJobCount({required this.city, required this.count});
  factory _CityJobCount.fromJson(Map<String, dynamic> json) => _$CityJobCountFromJson(json);

@override final  String city;
@override final  int count;

/// Create a copy of CityJobCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityJobCountCopyWith<_CityJobCount> get copyWith => __$CityJobCountCopyWithImpl<_CityJobCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityJobCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityJobCount&&(identical(other.city, city) || other.city == city)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,count);

@override
String toString() {
  return 'CityJobCount(city: $city, count: $count)';
}


}

/// @nodoc
abstract mixin class _$CityJobCountCopyWith<$Res> implements $CityJobCountCopyWith<$Res> {
  factory _$CityJobCountCopyWith(_CityJobCount value, $Res Function(_CityJobCount) _then) = __$CityJobCountCopyWithImpl;
@override @useResult
$Res call({
 String city, int count
});




}
/// @nodoc
class __$CityJobCountCopyWithImpl<$Res>
    implements _$CityJobCountCopyWith<$Res> {
  __$CityJobCountCopyWithImpl(this._self, this._then);

  final _CityJobCount _self;
  final $Res Function(_CityJobCount) _then;

/// Create a copy of CityJobCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? count = null,}) {
  return _then(_CityJobCount(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
