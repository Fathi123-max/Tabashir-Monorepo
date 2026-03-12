// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 bool get isLoading; bool get error; String get errorMessage; List<Map<String, dynamic>> get jobs; int get matches; int get companiesViewed; String get matchDistribution; int get inReview; int get interview; int get offer; int get rejected; int get pending; int get unreadNotificationCount; UserData? get user;// New fields for enhanced data
 Map<String, dynamic>? get trendingData; Map<String, dynamic>? get marketInsights; Map<String, dynamic>? get analyticsData; Map<String, dynamic>? get recommendationsData; Map<String, dynamic>? get dashboardData;// Metrics from dashboard API
 int get profileCompletionPercentage; int get applicationSuccessRate;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.jobs, jobs)&&(identical(other.matches, matches) || other.matches == matches)&&(identical(other.companiesViewed, companiesViewed) || other.companiesViewed == companiesViewed)&&(identical(other.matchDistribution, matchDistribution) || other.matchDistribution == matchDistribution)&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interview, interview) || other.interview == interview)&&(identical(other.offer, offer) || other.offer == offer)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.unreadNotificationCount, unreadNotificationCount) || other.unreadNotificationCount == unreadNotificationCount)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.trendingData, trendingData)&&const DeepCollectionEquality().equals(other.marketInsights, marketInsights)&&const DeepCollectionEquality().equals(other.analyticsData, analyticsData)&&const DeepCollectionEquality().equals(other.recommendationsData, recommendationsData)&&const DeepCollectionEquality().equals(other.dashboardData, dashboardData)&&(identical(other.profileCompletionPercentage, profileCompletionPercentage) || other.profileCompletionPercentage == profileCompletionPercentage)&&(identical(other.applicationSuccessRate, applicationSuccessRate) || other.applicationSuccessRate == applicationSuccessRate));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,error,errorMessage,const DeepCollectionEquality().hash(jobs),matches,companiesViewed,matchDistribution,inReview,interview,offer,rejected,pending,unreadNotificationCount,user,const DeepCollectionEquality().hash(trendingData),const DeepCollectionEquality().hash(marketInsights),const DeepCollectionEquality().hash(analyticsData),const DeepCollectionEquality().hash(recommendationsData),const DeepCollectionEquality().hash(dashboardData),profileCompletionPercentage,applicationSuccessRate]);

@override
String toString() {
  return 'HomeState(isLoading: $isLoading, error: $error, errorMessage: $errorMessage, jobs: $jobs, matches: $matches, companiesViewed: $companiesViewed, matchDistribution: $matchDistribution, inReview: $inReview, interview: $interview, offer: $offer, rejected: $rejected, pending: $pending, unreadNotificationCount: $unreadNotificationCount, user: $user, trendingData: $trendingData, marketInsights: $marketInsights, analyticsData: $analyticsData, recommendationsData: $recommendationsData, dashboardData: $dashboardData, profileCompletionPercentage: $profileCompletionPercentage, applicationSuccessRate: $applicationSuccessRate)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool error, String errorMessage, List<Map<String, dynamic>> jobs, int matches, int companiesViewed, String matchDistribution, int inReview, int interview, int offer, int rejected, int pending, int unreadNotificationCount, UserData? user, Map<String, dynamic>? trendingData, Map<String, dynamic>? marketInsights, Map<String, dynamic>? analyticsData, Map<String, dynamic>? recommendationsData, Map<String, dynamic>? dashboardData, int profileCompletionPercentage, int applicationSuccessRate
});


$UserDataCopyWith<$Res>? get user;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? errorMessage = null,Object? jobs = null,Object? matches = null,Object? companiesViewed = null,Object? matchDistribution = null,Object? inReview = null,Object? interview = null,Object? offer = null,Object? rejected = null,Object? pending = null,Object? unreadNotificationCount = null,Object? user = freezed,Object? trendingData = freezed,Object? marketInsights = freezed,Object? analyticsData = freezed,Object? recommendationsData = freezed,Object? dashboardData = freezed,Object? profileCompletionPercentage = null,Object? applicationSuccessRate = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as int,companiesViewed: null == companiesViewed ? _self.companiesViewed : companiesViewed // ignore: cast_nullable_to_non_nullable
as int,matchDistribution: null == matchDistribution ? _self.matchDistribution : matchDistribution // ignore: cast_nullable_to_non_nullable
as String,inReview: null == inReview ? _self.inReview : inReview // ignore: cast_nullable_to_non_nullable
as int,interview: null == interview ? _self.interview : interview // ignore: cast_nullable_to_non_nullable
as int,offer: null == offer ? _self.offer : offer // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,unreadNotificationCount: null == unreadNotificationCount ? _self.unreadNotificationCount : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
as int,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserData?,trendingData: freezed == trendingData ? _self.trendingData : trendingData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,marketInsights: freezed == marketInsights ? _self.marketInsights : marketInsights // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,analyticsData: freezed == analyticsData ? _self.analyticsData : analyticsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,recommendationsData: freezed == recommendationsData ? _self.recommendationsData : recommendationsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,dashboardData: freezed == dashboardData ? _self.dashboardData : dashboardData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,profileCompletionPercentage: null == profileCompletionPercentage ? _self.profileCompletionPercentage : profileCompletionPercentage // ignore: cast_nullable_to_non_nullable
as int,applicationSuccessRate: null == applicationSuccessRate ? _self.applicationSuccessRate : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserDataCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool error,  String errorMessage,  List<Map<String, dynamic>> jobs,  int matches,  int companiesViewed,  String matchDistribution,  int inReview,  int interview,  int offer,  int rejected,  int pending,  int unreadNotificationCount,  UserData? user,  Map<String, dynamic>? trendingData,  Map<String, dynamic>? marketInsights,  Map<String, dynamic>? analyticsData,  Map<String, dynamic>? recommendationsData,  Map<String, dynamic>? dashboardData,  int profileCompletionPercentage,  int applicationSuccessRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isLoading,_that.error,_that.errorMessage,_that.jobs,_that.matches,_that.companiesViewed,_that.matchDistribution,_that.inReview,_that.interview,_that.offer,_that.rejected,_that.pending,_that.unreadNotificationCount,_that.user,_that.trendingData,_that.marketInsights,_that.analyticsData,_that.recommendationsData,_that.dashboardData,_that.profileCompletionPercentage,_that.applicationSuccessRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool error,  String errorMessage,  List<Map<String, dynamic>> jobs,  int matches,  int companiesViewed,  String matchDistribution,  int inReview,  int interview,  int offer,  int rejected,  int pending,  int unreadNotificationCount,  UserData? user,  Map<String, dynamic>? trendingData,  Map<String, dynamic>? marketInsights,  Map<String, dynamic>? analyticsData,  Map<String, dynamic>? recommendationsData,  Map<String, dynamic>? dashboardData,  int profileCompletionPercentage,  int applicationSuccessRate)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.isLoading,_that.error,_that.errorMessage,_that.jobs,_that.matches,_that.companiesViewed,_that.matchDistribution,_that.inReview,_that.interview,_that.offer,_that.rejected,_that.pending,_that.unreadNotificationCount,_that.user,_that.trendingData,_that.marketInsights,_that.analyticsData,_that.recommendationsData,_that.dashboardData,_that.profileCompletionPercentage,_that.applicationSuccessRate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool error,  String errorMessage,  List<Map<String, dynamic>> jobs,  int matches,  int companiesViewed,  String matchDistribution,  int inReview,  int interview,  int offer,  int rejected,  int pending,  int unreadNotificationCount,  UserData? user,  Map<String, dynamic>? trendingData,  Map<String, dynamic>? marketInsights,  Map<String, dynamic>? analyticsData,  Map<String, dynamic>? recommendationsData,  Map<String, dynamic>? dashboardData,  int profileCompletionPercentage,  int applicationSuccessRate)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isLoading,_that.error,_that.errorMessage,_that.jobs,_that.matches,_that.companiesViewed,_that.matchDistribution,_that.inReview,_that.interview,_that.offer,_that.rejected,_that.pending,_that.unreadNotificationCount,_that.user,_that.trendingData,_that.marketInsights,_that.analyticsData,_that.recommendationsData,_that.dashboardData,_that.profileCompletionPercentage,_that.applicationSuccessRate);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.isLoading = false, this.error = false, this.errorMessage = '', final  List<Map<String, dynamic>> jobs = const [], this.matches = 0, this.companiesViewed = 0, this.matchDistribution = '', this.inReview = 0, this.interview = 0, this.offer = 0, this.rejected = 0, this.pending = 0, this.unreadNotificationCount = 0, this.user, final  Map<String, dynamic>? trendingData, final  Map<String, dynamic>? marketInsights, final  Map<String, dynamic>? analyticsData, final  Map<String, dynamic>? recommendationsData, final  Map<String, dynamic>? dashboardData, this.profileCompletionPercentage = 0, this.applicationSuccessRate = 0}): _jobs = jobs,_trendingData = trendingData,_marketInsights = marketInsights,_analyticsData = analyticsData,_recommendationsData = recommendationsData,_dashboardData = dashboardData;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool error;
@override@JsonKey() final  String errorMessage;
 final  List<Map<String, dynamic>> _jobs;
@override@JsonKey() List<Map<String, dynamic>> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}

@override@JsonKey() final  int matches;
@override@JsonKey() final  int companiesViewed;
@override@JsonKey() final  String matchDistribution;
@override@JsonKey() final  int inReview;
@override@JsonKey() final  int interview;
@override@JsonKey() final  int offer;
@override@JsonKey() final  int rejected;
@override@JsonKey() final  int pending;
@override@JsonKey() final  int unreadNotificationCount;
@override final  UserData? user;
// New fields for enhanced data
 final  Map<String, dynamic>? _trendingData;
// New fields for enhanced data
@override Map<String, dynamic>? get trendingData {
  final value = _trendingData;
  if (value == null) return null;
  if (_trendingData is EqualUnmodifiableMapView) return _trendingData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _marketInsights;
@override Map<String, dynamic>? get marketInsights {
  final value = _marketInsights;
  if (value == null) return null;
  if (_marketInsights is EqualUnmodifiableMapView) return _marketInsights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _analyticsData;
@override Map<String, dynamic>? get analyticsData {
  final value = _analyticsData;
  if (value == null) return null;
  if (_analyticsData is EqualUnmodifiableMapView) return _analyticsData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _recommendationsData;
@override Map<String, dynamic>? get recommendationsData {
  final value = _recommendationsData;
  if (value == null) return null;
  if (_recommendationsData is EqualUnmodifiableMapView) return _recommendationsData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _dashboardData;
@override Map<String, dynamic>? get dashboardData {
  final value = _dashboardData;
  if (value == null) return null;
  if (_dashboardData is EqualUnmodifiableMapView) return _dashboardData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Metrics from dashboard API
@override@JsonKey() final  int profileCompletionPercentage;
@override@JsonKey() final  int applicationSuccessRate;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&(identical(other.matches, matches) || other.matches == matches)&&(identical(other.companiesViewed, companiesViewed) || other.companiesViewed == companiesViewed)&&(identical(other.matchDistribution, matchDistribution) || other.matchDistribution == matchDistribution)&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interview, interview) || other.interview == interview)&&(identical(other.offer, offer) || other.offer == offer)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.unreadNotificationCount, unreadNotificationCount) || other.unreadNotificationCount == unreadNotificationCount)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._trendingData, _trendingData)&&const DeepCollectionEquality().equals(other._marketInsights, _marketInsights)&&const DeepCollectionEquality().equals(other._analyticsData, _analyticsData)&&const DeepCollectionEquality().equals(other._recommendationsData, _recommendationsData)&&const DeepCollectionEquality().equals(other._dashboardData, _dashboardData)&&(identical(other.profileCompletionPercentage, profileCompletionPercentage) || other.profileCompletionPercentage == profileCompletionPercentage)&&(identical(other.applicationSuccessRate, applicationSuccessRate) || other.applicationSuccessRate == applicationSuccessRate));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,error,errorMessage,const DeepCollectionEquality().hash(_jobs),matches,companiesViewed,matchDistribution,inReview,interview,offer,rejected,pending,unreadNotificationCount,user,const DeepCollectionEquality().hash(_trendingData),const DeepCollectionEquality().hash(_marketInsights),const DeepCollectionEquality().hash(_analyticsData),const DeepCollectionEquality().hash(_recommendationsData),const DeepCollectionEquality().hash(_dashboardData),profileCompletionPercentage,applicationSuccessRate]);

@override
String toString() {
  return 'HomeState(isLoading: $isLoading, error: $error, errorMessage: $errorMessage, jobs: $jobs, matches: $matches, companiesViewed: $companiesViewed, matchDistribution: $matchDistribution, inReview: $inReview, interview: $interview, offer: $offer, rejected: $rejected, pending: $pending, unreadNotificationCount: $unreadNotificationCount, user: $user, trendingData: $trendingData, marketInsights: $marketInsights, analyticsData: $analyticsData, recommendationsData: $recommendationsData, dashboardData: $dashboardData, profileCompletionPercentage: $profileCompletionPercentage, applicationSuccessRate: $applicationSuccessRate)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool error, String errorMessage, List<Map<String, dynamic>> jobs, int matches, int companiesViewed, String matchDistribution, int inReview, int interview, int offer, int rejected, int pending, int unreadNotificationCount, UserData? user, Map<String, dynamic>? trendingData, Map<String, dynamic>? marketInsights, Map<String, dynamic>? analyticsData, Map<String, dynamic>? recommendationsData, Map<String, dynamic>? dashboardData, int profileCompletionPercentage, int applicationSuccessRate
});


@override $UserDataCopyWith<$Res>? get user;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? errorMessage = null,Object? jobs = null,Object? matches = null,Object? companiesViewed = null,Object? matchDistribution = null,Object? inReview = null,Object? interview = null,Object? offer = null,Object? rejected = null,Object? pending = null,Object? unreadNotificationCount = null,Object? user = freezed,Object? trendingData = freezed,Object? marketInsights = freezed,Object? analyticsData = freezed,Object? recommendationsData = freezed,Object? dashboardData = freezed,Object? profileCompletionPercentage = null,Object? applicationSuccessRate = null,}) {
  return _then(_HomeState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as int,companiesViewed: null == companiesViewed ? _self.companiesViewed : companiesViewed // ignore: cast_nullable_to_non_nullable
as int,matchDistribution: null == matchDistribution ? _self.matchDistribution : matchDistribution // ignore: cast_nullable_to_non_nullable
as String,inReview: null == inReview ? _self.inReview : inReview // ignore: cast_nullable_to_non_nullable
as int,interview: null == interview ? _self.interview : interview // ignore: cast_nullable_to_non_nullable
as int,offer: null == offer ? _self.offer : offer // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,unreadNotificationCount: null == unreadNotificationCount ? _self.unreadNotificationCount : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
as int,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserData?,trendingData: freezed == trendingData ? _self._trendingData : trendingData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,marketInsights: freezed == marketInsights ? _self._marketInsights : marketInsights // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,analyticsData: freezed == analyticsData ? _self._analyticsData : analyticsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,recommendationsData: freezed == recommendationsData ? _self._recommendationsData : recommendationsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,dashboardData: freezed == dashboardData ? _self._dashboardData : dashboardData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,profileCompletionPercentage: null == profileCompletionPercentage ? _self.profileCompletionPercentage : profileCompletionPercentage // ignore: cast_nullable_to_non_nullable
as int,applicationSuccessRate: null == applicationSuccessRate ? _self.applicationSuccessRate : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserDataCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
