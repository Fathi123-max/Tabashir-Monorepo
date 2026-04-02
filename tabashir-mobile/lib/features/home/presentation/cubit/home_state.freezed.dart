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

 bool get isLoading; bool get error; String get errorMessage; List<Map<String, dynamic>> get jobs; int get matches; int get companiesViewed; String get matchDistribution; int get inReview; int get interview; int get offer; int get rejected; int get pending; int get unreadNotificationCount; UserData? get user;// Data from recommendations API (used in UI)
 Map<String, dynamic>? get recommendationsData;// Metrics from dashboard API
 int get profileCompletionPercentage; int get applicationSuccessRate; String get avgMarketSalary; int get totalApplications;// AI Enhanced Native Fields
 Map<String, dynamic>? get clientProfile; int? get jobsToApplyNumber; int? get jobMatching; List<CityJobCount> get cityJobCounts; List<Map<String, dynamic>> get latestJobsList; List<JobRecommendation> get matchedJobsList; List<JobRecommendation> get allMatchedJobsList; List<AppliedJob> get appliedJobsList;// Pagination for Matched Jobs
 int get matchedJobsPage; int get matchedJobsTotal; int get matchedJobsLimit; bool get matchedJobsHasMore; bool get isLoadingMoreMatched;// Pagination for Applied Jobs
 int get appliedJobsPage; int get appliedJobsTotal; int get appliedJobsLimit; bool get appliedJobsHasMore; bool get isLoadingMoreApplied;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.jobs, jobs)&&(identical(other.matches, matches) || other.matches == matches)&&(identical(other.companiesViewed, companiesViewed) || other.companiesViewed == companiesViewed)&&(identical(other.matchDistribution, matchDistribution) || other.matchDistribution == matchDistribution)&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interview, interview) || other.interview == interview)&&(identical(other.offer, offer) || other.offer == offer)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.unreadNotificationCount, unreadNotificationCount) || other.unreadNotificationCount == unreadNotificationCount)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.recommendationsData, recommendationsData)&&(identical(other.profileCompletionPercentage, profileCompletionPercentage) || other.profileCompletionPercentage == profileCompletionPercentage)&&(identical(other.applicationSuccessRate, applicationSuccessRate) || other.applicationSuccessRate == applicationSuccessRate)&&(identical(other.avgMarketSalary, avgMarketSalary) || other.avgMarketSalary == avgMarketSalary)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&const DeepCollectionEquality().equals(other.clientProfile, clientProfile)&&(identical(other.jobsToApplyNumber, jobsToApplyNumber) || other.jobsToApplyNumber == jobsToApplyNumber)&&(identical(other.jobMatching, jobMatching) || other.jobMatching == jobMatching)&&const DeepCollectionEquality().equals(other.cityJobCounts, cityJobCounts)&&const DeepCollectionEquality().equals(other.latestJobsList, latestJobsList)&&const DeepCollectionEquality().equals(other.matchedJobsList, matchedJobsList)&&const DeepCollectionEquality().equals(other.allMatchedJobsList, allMatchedJobsList)&&const DeepCollectionEquality().equals(other.appliedJobsList, appliedJobsList)&&(identical(other.matchedJobsPage, matchedJobsPage) || other.matchedJobsPage == matchedJobsPage)&&(identical(other.matchedJobsTotal, matchedJobsTotal) || other.matchedJobsTotal == matchedJobsTotal)&&(identical(other.matchedJobsLimit, matchedJobsLimit) || other.matchedJobsLimit == matchedJobsLimit)&&(identical(other.matchedJobsHasMore, matchedJobsHasMore) || other.matchedJobsHasMore == matchedJobsHasMore)&&(identical(other.isLoadingMoreMatched, isLoadingMoreMatched) || other.isLoadingMoreMatched == isLoadingMoreMatched)&&(identical(other.appliedJobsPage, appliedJobsPage) || other.appliedJobsPage == appliedJobsPage)&&(identical(other.appliedJobsTotal, appliedJobsTotal) || other.appliedJobsTotal == appliedJobsTotal)&&(identical(other.appliedJobsLimit, appliedJobsLimit) || other.appliedJobsLimit == appliedJobsLimit)&&(identical(other.appliedJobsHasMore, appliedJobsHasMore) || other.appliedJobsHasMore == appliedJobsHasMore)&&(identical(other.isLoadingMoreApplied, isLoadingMoreApplied) || other.isLoadingMoreApplied == isLoadingMoreApplied));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,error,errorMessage,const DeepCollectionEquality().hash(jobs),matches,companiesViewed,matchDistribution,inReview,interview,offer,rejected,pending,unreadNotificationCount,user,const DeepCollectionEquality().hash(recommendationsData),profileCompletionPercentage,applicationSuccessRate,avgMarketSalary,totalApplications,const DeepCollectionEquality().hash(clientProfile),jobsToApplyNumber,jobMatching,const DeepCollectionEquality().hash(cityJobCounts),const DeepCollectionEquality().hash(latestJobsList),const DeepCollectionEquality().hash(matchedJobsList),const DeepCollectionEquality().hash(allMatchedJobsList),const DeepCollectionEquality().hash(appliedJobsList),matchedJobsPage,matchedJobsTotal,matchedJobsLimit,matchedJobsHasMore,isLoadingMoreMatched,appliedJobsPage,appliedJobsTotal,appliedJobsLimit,appliedJobsHasMore,isLoadingMoreApplied]);

@override
String toString() {
  return 'HomeState(isLoading: $isLoading, error: $error, errorMessage: $errorMessage, jobs: $jobs, matches: $matches, companiesViewed: $companiesViewed, matchDistribution: $matchDistribution, inReview: $inReview, interview: $interview, offer: $offer, rejected: $rejected, pending: $pending, unreadNotificationCount: $unreadNotificationCount, user: $user, recommendationsData: $recommendationsData, profileCompletionPercentage: $profileCompletionPercentage, applicationSuccessRate: $applicationSuccessRate, avgMarketSalary: $avgMarketSalary, totalApplications: $totalApplications, clientProfile: $clientProfile, jobsToApplyNumber: $jobsToApplyNumber, jobMatching: $jobMatching, cityJobCounts: $cityJobCounts, latestJobsList: $latestJobsList, matchedJobsList: $matchedJobsList, allMatchedJobsList: $allMatchedJobsList, appliedJobsList: $appliedJobsList, matchedJobsPage: $matchedJobsPage, matchedJobsTotal: $matchedJobsTotal, matchedJobsLimit: $matchedJobsLimit, matchedJobsHasMore: $matchedJobsHasMore, isLoadingMoreMatched: $isLoadingMoreMatched, appliedJobsPage: $appliedJobsPage, appliedJobsTotal: $appliedJobsTotal, appliedJobsLimit: $appliedJobsLimit, appliedJobsHasMore: $appliedJobsHasMore, isLoadingMoreApplied: $isLoadingMoreApplied)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool error, String errorMessage, List<Map<String, dynamic>> jobs, int matches, int companiesViewed, String matchDistribution, int inReview, int interview, int offer, int rejected, int pending, int unreadNotificationCount, UserData? user, Map<String, dynamic>? recommendationsData, int profileCompletionPercentage, int applicationSuccessRate, String avgMarketSalary, int totalApplications, Map<String, dynamic>? clientProfile, int? jobsToApplyNumber, int? jobMatching, List<CityJobCount> cityJobCounts, List<Map<String, dynamic>> latestJobsList, List<JobRecommendation> matchedJobsList, List<JobRecommendation> allMatchedJobsList, List<AppliedJob> appliedJobsList, int matchedJobsPage, int matchedJobsTotal, int matchedJobsLimit, bool matchedJobsHasMore, bool isLoadingMoreMatched, int appliedJobsPage, int appliedJobsTotal, int appliedJobsLimit, bool appliedJobsHasMore, bool isLoadingMoreApplied
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? errorMessage = null,Object? jobs = null,Object? matches = null,Object? companiesViewed = null,Object? matchDistribution = null,Object? inReview = null,Object? interview = null,Object? offer = null,Object? rejected = null,Object? pending = null,Object? unreadNotificationCount = null,Object? user = freezed,Object? recommendationsData = freezed,Object? profileCompletionPercentage = null,Object? applicationSuccessRate = null,Object? avgMarketSalary = null,Object? totalApplications = null,Object? clientProfile = freezed,Object? jobsToApplyNumber = freezed,Object? jobMatching = freezed,Object? cityJobCounts = null,Object? latestJobsList = null,Object? matchedJobsList = null,Object? allMatchedJobsList = null,Object? appliedJobsList = null,Object? matchedJobsPage = null,Object? matchedJobsTotal = null,Object? matchedJobsLimit = null,Object? matchedJobsHasMore = null,Object? isLoadingMoreMatched = null,Object? appliedJobsPage = null,Object? appliedJobsTotal = null,Object? appliedJobsLimit = null,Object? appliedJobsHasMore = null,Object? isLoadingMoreApplied = null,}) {
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
as UserData?,recommendationsData: freezed == recommendationsData ? _self.recommendationsData : recommendationsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,profileCompletionPercentage: null == profileCompletionPercentage ? _self.profileCompletionPercentage : profileCompletionPercentage // ignore: cast_nullable_to_non_nullable
as int,applicationSuccessRate: null == applicationSuccessRate ? _self.applicationSuccessRate : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
as int,avgMarketSalary: null == avgMarketSalary ? _self.avgMarketSalary : avgMarketSalary // ignore: cast_nullable_to_non_nullable
as String,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,clientProfile: freezed == clientProfile ? _self.clientProfile : clientProfile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,jobsToApplyNumber: freezed == jobsToApplyNumber ? _self.jobsToApplyNumber : jobsToApplyNumber // ignore: cast_nullable_to_non_nullable
as int?,jobMatching: freezed == jobMatching ? _self.jobMatching : jobMatching // ignore: cast_nullable_to_non_nullable
as int?,cityJobCounts: null == cityJobCounts ? _self.cityJobCounts : cityJobCounts // ignore: cast_nullable_to_non_nullable
as List<CityJobCount>,latestJobsList: null == latestJobsList ? _self.latestJobsList : latestJobsList // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,matchedJobsList: null == matchedJobsList ? _self.matchedJobsList : matchedJobsList // ignore: cast_nullable_to_non_nullable
as List<JobRecommendation>,allMatchedJobsList: null == allMatchedJobsList ? _self.allMatchedJobsList : allMatchedJobsList // ignore: cast_nullable_to_non_nullable
as List<JobRecommendation>,appliedJobsList: null == appliedJobsList ? _self.appliedJobsList : appliedJobsList // ignore: cast_nullable_to_non_nullable
as List<AppliedJob>,matchedJobsPage: null == matchedJobsPage ? _self.matchedJobsPage : matchedJobsPage // ignore: cast_nullable_to_non_nullable
as int,matchedJobsTotal: null == matchedJobsTotal ? _self.matchedJobsTotal : matchedJobsTotal // ignore: cast_nullable_to_non_nullable
as int,matchedJobsLimit: null == matchedJobsLimit ? _self.matchedJobsLimit : matchedJobsLimit // ignore: cast_nullable_to_non_nullable
as int,matchedJobsHasMore: null == matchedJobsHasMore ? _self.matchedJobsHasMore : matchedJobsHasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreMatched: null == isLoadingMoreMatched ? _self.isLoadingMoreMatched : isLoadingMoreMatched // ignore: cast_nullable_to_non_nullable
as bool,appliedJobsPage: null == appliedJobsPage ? _self.appliedJobsPage : appliedJobsPage // ignore: cast_nullable_to_non_nullable
as int,appliedJobsTotal: null == appliedJobsTotal ? _self.appliedJobsTotal : appliedJobsTotal // ignore: cast_nullable_to_non_nullable
as int,appliedJobsLimit: null == appliedJobsLimit ? _self.appliedJobsLimit : appliedJobsLimit // ignore: cast_nullable_to_non_nullable
as int,appliedJobsHasMore: null == appliedJobsHasMore ? _self.appliedJobsHasMore : appliedJobsHasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreApplied: null == isLoadingMoreApplied ? _self.isLoadingMoreApplied : isLoadingMoreApplied // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool error,  String errorMessage,  List<Map<String, dynamic>> jobs,  int matches,  int companiesViewed,  String matchDistribution,  int inReview,  int interview,  int offer,  int rejected,  int pending,  int unreadNotificationCount,  UserData? user,  Map<String, dynamic>? recommendationsData,  int profileCompletionPercentage,  int applicationSuccessRate,  String avgMarketSalary,  int totalApplications,  Map<String, dynamic>? clientProfile,  int? jobsToApplyNumber,  int? jobMatching,  List<CityJobCount> cityJobCounts,  List<Map<String, dynamic>> latestJobsList,  List<JobRecommendation> matchedJobsList,  List<JobRecommendation> allMatchedJobsList,  List<AppliedJob> appliedJobsList,  int matchedJobsPage,  int matchedJobsTotal,  int matchedJobsLimit,  bool matchedJobsHasMore,  bool isLoadingMoreMatched,  int appliedJobsPage,  int appliedJobsTotal,  int appliedJobsLimit,  bool appliedJobsHasMore,  bool isLoadingMoreApplied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isLoading,_that.error,_that.errorMessage,_that.jobs,_that.matches,_that.companiesViewed,_that.matchDistribution,_that.inReview,_that.interview,_that.offer,_that.rejected,_that.pending,_that.unreadNotificationCount,_that.user,_that.recommendationsData,_that.profileCompletionPercentage,_that.applicationSuccessRate,_that.avgMarketSalary,_that.totalApplications,_that.clientProfile,_that.jobsToApplyNumber,_that.jobMatching,_that.cityJobCounts,_that.latestJobsList,_that.matchedJobsList,_that.allMatchedJobsList,_that.appliedJobsList,_that.matchedJobsPage,_that.matchedJobsTotal,_that.matchedJobsLimit,_that.matchedJobsHasMore,_that.isLoadingMoreMatched,_that.appliedJobsPage,_that.appliedJobsTotal,_that.appliedJobsLimit,_that.appliedJobsHasMore,_that.isLoadingMoreApplied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool error,  String errorMessage,  List<Map<String, dynamic>> jobs,  int matches,  int companiesViewed,  String matchDistribution,  int inReview,  int interview,  int offer,  int rejected,  int pending,  int unreadNotificationCount,  UserData? user,  Map<String, dynamic>? recommendationsData,  int profileCompletionPercentage,  int applicationSuccessRate,  String avgMarketSalary,  int totalApplications,  Map<String, dynamic>? clientProfile,  int? jobsToApplyNumber,  int? jobMatching,  List<CityJobCount> cityJobCounts,  List<Map<String, dynamic>> latestJobsList,  List<JobRecommendation> matchedJobsList,  List<JobRecommendation> allMatchedJobsList,  List<AppliedJob> appliedJobsList,  int matchedJobsPage,  int matchedJobsTotal,  int matchedJobsLimit,  bool matchedJobsHasMore,  bool isLoadingMoreMatched,  int appliedJobsPage,  int appliedJobsTotal,  int appliedJobsLimit,  bool appliedJobsHasMore,  bool isLoadingMoreApplied)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.isLoading,_that.error,_that.errorMessage,_that.jobs,_that.matches,_that.companiesViewed,_that.matchDistribution,_that.inReview,_that.interview,_that.offer,_that.rejected,_that.pending,_that.unreadNotificationCount,_that.user,_that.recommendationsData,_that.profileCompletionPercentage,_that.applicationSuccessRate,_that.avgMarketSalary,_that.totalApplications,_that.clientProfile,_that.jobsToApplyNumber,_that.jobMatching,_that.cityJobCounts,_that.latestJobsList,_that.matchedJobsList,_that.allMatchedJobsList,_that.appliedJobsList,_that.matchedJobsPage,_that.matchedJobsTotal,_that.matchedJobsLimit,_that.matchedJobsHasMore,_that.isLoadingMoreMatched,_that.appliedJobsPage,_that.appliedJobsTotal,_that.appliedJobsLimit,_that.appliedJobsHasMore,_that.isLoadingMoreApplied);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool error,  String errorMessage,  List<Map<String, dynamic>> jobs,  int matches,  int companiesViewed,  String matchDistribution,  int inReview,  int interview,  int offer,  int rejected,  int pending,  int unreadNotificationCount,  UserData? user,  Map<String, dynamic>? recommendationsData,  int profileCompletionPercentage,  int applicationSuccessRate,  String avgMarketSalary,  int totalApplications,  Map<String, dynamic>? clientProfile,  int? jobsToApplyNumber,  int? jobMatching,  List<CityJobCount> cityJobCounts,  List<Map<String, dynamic>> latestJobsList,  List<JobRecommendation> matchedJobsList,  List<JobRecommendation> allMatchedJobsList,  List<AppliedJob> appliedJobsList,  int matchedJobsPage,  int matchedJobsTotal,  int matchedJobsLimit,  bool matchedJobsHasMore,  bool isLoadingMoreMatched,  int appliedJobsPage,  int appliedJobsTotal,  int appliedJobsLimit,  bool appliedJobsHasMore,  bool isLoadingMoreApplied)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isLoading,_that.error,_that.errorMessage,_that.jobs,_that.matches,_that.companiesViewed,_that.matchDistribution,_that.inReview,_that.interview,_that.offer,_that.rejected,_that.pending,_that.unreadNotificationCount,_that.user,_that.recommendationsData,_that.profileCompletionPercentage,_that.applicationSuccessRate,_that.avgMarketSalary,_that.totalApplications,_that.clientProfile,_that.jobsToApplyNumber,_that.jobMatching,_that.cityJobCounts,_that.latestJobsList,_that.matchedJobsList,_that.allMatchedJobsList,_that.appliedJobsList,_that.matchedJobsPage,_that.matchedJobsTotal,_that.matchedJobsLimit,_that.matchedJobsHasMore,_that.isLoadingMoreMatched,_that.appliedJobsPage,_that.appliedJobsTotal,_that.appliedJobsLimit,_that.appliedJobsHasMore,_that.isLoadingMoreApplied);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.isLoading = false, this.error = false, this.errorMessage = '', final  List<Map<String, dynamic>> jobs = const [], this.matches = 0, this.companiesViewed = 0, this.matchDistribution = '', this.inReview = 0, this.interview = 0, this.offer = 0, this.rejected = 0, this.pending = 0, this.unreadNotificationCount = 0, this.user, final  Map<String, dynamic>? recommendationsData, this.profileCompletionPercentage = 0, this.applicationSuccessRate = 0, this.avgMarketSalary = 'N/A', this.totalApplications = 0, final  Map<String, dynamic>? clientProfile, this.jobsToApplyNumber = 0, this.jobMatching = 0, final  List<CityJobCount> cityJobCounts = const [], final  List<Map<String, dynamic>> latestJobsList = const [], final  List<JobRecommendation> matchedJobsList = const [], final  List<JobRecommendation> allMatchedJobsList = const [], final  List<AppliedJob> appliedJobsList = const [], this.matchedJobsPage = 1, this.matchedJobsTotal = 0, this.matchedJobsLimit = 20, this.matchedJobsHasMore = true, this.isLoadingMoreMatched = false, this.appliedJobsPage = 1, this.appliedJobsTotal = 0, this.appliedJobsLimit = 20, this.appliedJobsHasMore = true, this.isLoadingMoreApplied = false}): _jobs = jobs,_recommendationsData = recommendationsData,_clientProfile = clientProfile,_cityJobCounts = cityJobCounts,_latestJobsList = latestJobsList,_matchedJobsList = matchedJobsList,_allMatchedJobsList = allMatchedJobsList,_appliedJobsList = appliedJobsList;
  

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
// Data from recommendations API (used in UI)
 final  Map<String, dynamic>? _recommendationsData;
// Data from recommendations API (used in UI)
@override Map<String, dynamic>? get recommendationsData {
  final value = _recommendationsData;
  if (value == null) return null;
  if (_recommendationsData is EqualUnmodifiableMapView) return _recommendationsData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Metrics from dashboard API
@override@JsonKey() final  int profileCompletionPercentage;
@override@JsonKey() final  int applicationSuccessRate;
@override@JsonKey() final  String avgMarketSalary;
@override@JsonKey() final  int totalApplications;
// AI Enhanced Native Fields
 final  Map<String, dynamic>? _clientProfile;
// AI Enhanced Native Fields
@override Map<String, dynamic>? get clientProfile {
  final value = _clientProfile;
  if (value == null) return null;
  if (_clientProfile is EqualUnmodifiableMapView) return _clientProfile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  int? jobsToApplyNumber;
@override@JsonKey() final  int? jobMatching;
 final  List<CityJobCount> _cityJobCounts;
@override@JsonKey() List<CityJobCount> get cityJobCounts {
  if (_cityJobCounts is EqualUnmodifiableListView) return _cityJobCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cityJobCounts);
}

 final  List<Map<String, dynamic>> _latestJobsList;
@override@JsonKey() List<Map<String, dynamic>> get latestJobsList {
  if (_latestJobsList is EqualUnmodifiableListView) return _latestJobsList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_latestJobsList);
}

 final  List<JobRecommendation> _matchedJobsList;
@override@JsonKey() List<JobRecommendation> get matchedJobsList {
  if (_matchedJobsList is EqualUnmodifiableListView) return _matchedJobsList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matchedJobsList);
}

 final  List<JobRecommendation> _allMatchedJobsList;
@override@JsonKey() List<JobRecommendation> get allMatchedJobsList {
  if (_allMatchedJobsList is EqualUnmodifiableListView) return _allMatchedJobsList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allMatchedJobsList);
}

 final  List<AppliedJob> _appliedJobsList;
@override@JsonKey() List<AppliedJob> get appliedJobsList {
  if (_appliedJobsList is EqualUnmodifiableListView) return _appliedJobsList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appliedJobsList);
}

// Pagination for Matched Jobs
@override@JsonKey() final  int matchedJobsPage;
@override@JsonKey() final  int matchedJobsTotal;
@override@JsonKey() final  int matchedJobsLimit;
@override@JsonKey() final  bool matchedJobsHasMore;
@override@JsonKey() final  bool isLoadingMoreMatched;
// Pagination for Applied Jobs
@override@JsonKey() final  int appliedJobsPage;
@override@JsonKey() final  int appliedJobsTotal;
@override@JsonKey() final  int appliedJobsLimit;
@override@JsonKey() final  bool appliedJobsHasMore;
@override@JsonKey() final  bool isLoadingMoreApplied;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&(identical(other.matches, matches) || other.matches == matches)&&(identical(other.companiesViewed, companiesViewed) || other.companiesViewed == companiesViewed)&&(identical(other.matchDistribution, matchDistribution) || other.matchDistribution == matchDistribution)&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interview, interview) || other.interview == interview)&&(identical(other.offer, offer) || other.offer == offer)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.unreadNotificationCount, unreadNotificationCount) || other.unreadNotificationCount == unreadNotificationCount)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._recommendationsData, _recommendationsData)&&(identical(other.profileCompletionPercentage, profileCompletionPercentage) || other.profileCompletionPercentage == profileCompletionPercentage)&&(identical(other.applicationSuccessRate, applicationSuccessRate) || other.applicationSuccessRate == applicationSuccessRate)&&(identical(other.avgMarketSalary, avgMarketSalary) || other.avgMarketSalary == avgMarketSalary)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&const DeepCollectionEquality().equals(other._clientProfile, _clientProfile)&&(identical(other.jobsToApplyNumber, jobsToApplyNumber) || other.jobsToApplyNumber == jobsToApplyNumber)&&(identical(other.jobMatching, jobMatching) || other.jobMatching == jobMatching)&&const DeepCollectionEquality().equals(other._cityJobCounts, _cityJobCounts)&&const DeepCollectionEquality().equals(other._latestJobsList, _latestJobsList)&&const DeepCollectionEquality().equals(other._matchedJobsList, _matchedJobsList)&&const DeepCollectionEquality().equals(other._allMatchedJobsList, _allMatchedJobsList)&&const DeepCollectionEquality().equals(other._appliedJobsList, _appliedJobsList)&&(identical(other.matchedJobsPage, matchedJobsPage) || other.matchedJobsPage == matchedJobsPage)&&(identical(other.matchedJobsTotal, matchedJobsTotal) || other.matchedJobsTotal == matchedJobsTotal)&&(identical(other.matchedJobsLimit, matchedJobsLimit) || other.matchedJobsLimit == matchedJobsLimit)&&(identical(other.matchedJobsHasMore, matchedJobsHasMore) || other.matchedJobsHasMore == matchedJobsHasMore)&&(identical(other.isLoadingMoreMatched, isLoadingMoreMatched) || other.isLoadingMoreMatched == isLoadingMoreMatched)&&(identical(other.appliedJobsPage, appliedJobsPage) || other.appliedJobsPage == appliedJobsPage)&&(identical(other.appliedJobsTotal, appliedJobsTotal) || other.appliedJobsTotal == appliedJobsTotal)&&(identical(other.appliedJobsLimit, appliedJobsLimit) || other.appliedJobsLimit == appliedJobsLimit)&&(identical(other.appliedJobsHasMore, appliedJobsHasMore) || other.appliedJobsHasMore == appliedJobsHasMore)&&(identical(other.isLoadingMoreApplied, isLoadingMoreApplied) || other.isLoadingMoreApplied == isLoadingMoreApplied));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoading,error,errorMessage,const DeepCollectionEquality().hash(_jobs),matches,companiesViewed,matchDistribution,inReview,interview,offer,rejected,pending,unreadNotificationCount,user,const DeepCollectionEquality().hash(_recommendationsData),profileCompletionPercentage,applicationSuccessRate,avgMarketSalary,totalApplications,const DeepCollectionEquality().hash(_clientProfile),jobsToApplyNumber,jobMatching,const DeepCollectionEquality().hash(_cityJobCounts),const DeepCollectionEquality().hash(_latestJobsList),const DeepCollectionEquality().hash(_matchedJobsList),const DeepCollectionEquality().hash(_allMatchedJobsList),const DeepCollectionEquality().hash(_appliedJobsList),matchedJobsPage,matchedJobsTotal,matchedJobsLimit,matchedJobsHasMore,isLoadingMoreMatched,appliedJobsPage,appliedJobsTotal,appliedJobsLimit,appliedJobsHasMore,isLoadingMoreApplied]);

@override
String toString() {
  return 'HomeState(isLoading: $isLoading, error: $error, errorMessage: $errorMessage, jobs: $jobs, matches: $matches, companiesViewed: $companiesViewed, matchDistribution: $matchDistribution, inReview: $inReview, interview: $interview, offer: $offer, rejected: $rejected, pending: $pending, unreadNotificationCount: $unreadNotificationCount, user: $user, recommendationsData: $recommendationsData, profileCompletionPercentage: $profileCompletionPercentage, applicationSuccessRate: $applicationSuccessRate, avgMarketSalary: $avgMarketSalary, totalApplications: $totalApplications, clientProfile: $clientProfile, jobsToApplyNumber: $jobsToApplyNumber, jobMatching: $jobMatching, cityJobCounts: $cityJobCounts, latestJobsList: $latestJobsList, matchedJobsList: $matchedJobsList, allMatchedJobsList: $allMatchedJobsList, appliedJobsList: $appliedJobsList, matchedJobsPage: $matchedJobsPage, matchedJobsTotal: $matchedJobsTotal, matchedJobsLimit: $matchedJobsLimit, matchedJobsHasMore: $matchedJobsHasMore, isLoadingMoreMatched: $isLoadingMoreMatched, appliedJobsPage: $appliedJobsPage, appliedJobsTotal: $appliedJobsTotal, appliedJobsLimit: $appliedJobsLimit, appliedJobsHasMore: $appliedJobsHasMore, isLoadingMoreApplied: $isLoadingMoreApplied)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool error, String errorMessage, List<Map<String, dynamic>> jobs, int matches, int companiesViewed, String matchDistribution, int inReview, int interview, int offer, int rejected, int pending, int unreadNotificationCount, UserData? user, Map<String, dynamic>? recommendationsData, int profileCompletionPercentage, int applicationSuccessRate, String avgMarketSalary, int totalApplications, Map<String, dynamic>? clientProfile, int? jobsToApplyNumber, int? jobMatching, List<CityJobCount> cityJobCounts, List<Map<String, dynamic>> latestJobsList, List<JobRecommendation> matchedJobsList, List<JobRecommendation> allMatchedJobsList, List<AppliedJob> appliedJobsList, int matchedJobsPage, int matchedJobsTotal, int matchedJobsLimit, bool matchedJobsHasMore, bool isLoadingMoreMatched, int appliedJobsPage, int appliedJobsTotal, int appliedJobsLimit, bool appliedJobsHasMore, bool isLoadingMoreApplied
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
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? errorMessage = null,Object? jobs = null,Object? matches = null,Object? companiesViewed = null,Object? matchDistribution = null,Object? inReview = null,Object? interview = null,Object? offer = null,Object? rejected = null,Object? pending = null,Object? unreadNotificationCount = null,Object? user = freezed,Object? recommendationsData = freezed,Object? profileCompletionPercentage = null,Object? applicationSuccessRate = null,Object? avgMarketSalary = null,Object? totalApplications = null,Object? clientProfile = freezed,Object? jobsToApplyNumber = freezed,Object? jobMatching = freezed,Object? cityJobCounts = null,Object? latestJobsList = null,Object? matchedJobsList = null,Object? allMatchedJobsList = null,Object? appliedJobsList = null,Object? matchedJobsPage = null,Object? matchedJobsTotal = null,Object? matchedJobsLimit = null,Object? matchedJobsHasMore = null,Object? isLoadingMoreMatched = null,Object? appliedJobsPage = null,Object? appliedJobsTotal = null,Object? appliedJobsLimit = null,Object? appliedJobsHasMore = null,Object? isLoadingMoreApplied = null,}) {
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
as UserData?,recommendationsData: freezed == recommendationsData ? _self._recommendationsData : recommendationsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,profileCompletionPercentage: null == profileCompletionPercentage ? _self.profileCompletionPercentage : profileCompletionPercentage // ignore: cast_nullable_to_non_nullable
as int,applicationSuccessRate: null == applicationSuccessRate ? _self.applicationSuccessRate : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
as int,avgMarketSalary: null == avgMarketSalary ? _self.avgMarketSalary : avgMarketSalary // ignore: cast_nullable_to_non_nullable
as String,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,clientProfile: freezed == clientProfile ? _self._clientProfile : clientProfile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,jobsToApplyNumber: freezed == jobsToApplyNumber ? _self.jobsToApplyNumber : jobsToApplyNumber // ignore: cast_nullable_to_non_nullable
as int?,jobMatching: freezed == jobMatching ? _self.jobMatching : jobMatching // ignore: cast_nullable_to_non_nullable
as int?,cityJobCounts: null == cityJobCounts ? _self._cityJobCounts : cityJobCounts // ignore: cast_nullable_to_non_nullable
as List<CityJobCount>,latestJobsList: null == latestJobsList ? _self._latestJobsList : latestJobsList // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,matchedJobsList: null == matchedJobsList ? _self._matchedJobsList : matchedJobsList // ignore: cast_nullable_to_non_nullable
as List<JobRecommendation>,allMatchedJobsList: null == allMatchedJobsList ? _self._allMatchedJobsList : allMatchedJobsList // ignore: cast_nullable_to_non_nullable
as List<JobRecommendation>,appliedJobsList: null == appliedJobsList ? _self._appliedJobsList : appliedJobsList // ignore: cast_nullable_to_non_nullable
as List<AppliedJob>,matchedJobsPage: null == matchedJobsPage ? _self.matchedJobsPage : matchedJobsPage // ignore: cast_nullable_to_non_nullable
as int,matchedJobsTotal: null == matchedJobsTotal ? _self.matchedJobsTotal : matchedJobsTotal // ignore: cast_nullable_to_non_nullable
as int,matchedJobsLimit: null == matchedJobsLimit ? _self.matchedJobsLimit : matchedJobsLimit // ignore: cast_nullable_to_non_nullable
as int,matchedJobsHasMore: null == matchedJobsHasMore ? _self.matchedJobsHasMore : matchedJobsHasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreMatched: null == isLoadingMoreMatched ? _self.isLoadingMoreMatched : isLoadingMoreMatched // ignore: cast_nullable_to_non_nullable
as bool,appliedJobsPage: null == appliedJobsPage ? _self.appliedJobsPage : appliedJobsPage // ignore: cast_nullable_to_non_nullable
as int,appliedJobsTotal: null == appliedJobsTotal ? _self.appliedJobsTotal : appliedJobsTotal // ignore: cast_nullable_to_non_nullable
as int,appliedJobsLimit: null == appliedJobsLimit ? _self.appliedJobsLimit : appliedJobsLimit // ignore: cast_nullable_to_non_nullable
as int,appliedJobsHasMore: null == appliedJobsHasMore ? _self.appliedJobsHasMore : appliedJobsHasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreApplied: null == isLoadingMoreApplied ? _self.isLoadingMoreApplied : isLoadingMoreApplied // ignore: cast_nullable_to_non_nullable
as bool,
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
