// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_dashboard_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeDashboardResponse {

/// List of featured jobs to display on home screen
 List<JobDetailsResponse> get featuredJobs;/// Total number of job matches
 int get totalMatches;/// Total number of companies the user has viewed
 int get companiesViewed;/// Number of applications currently in review
 int get inReview;/// Number of interviews scheduled
 int get interviews;/// Number of job offers received
 int get offers;/// Number of applications rejected
 int get rejected;/// Distribution of matches (format: "active | interviewing | offered")
 String get matchDistribution;/// Profile completion percentage (0-100)
 int get profileCompletionPercentage;/// Application success rate percentage (0-100)
 int get applicationSuccessRate;/// Average market salary for user's role
 String? get avgMarketSalary;/// Total number of applications
 int? get totalApplications;/// Job counts by city for location-based statistics
 Map<String, int>? get jobsByCity;/// Monthly job counts for trends
 Map<String, int>? get monthlyJobCounts;
/// Create a copy of HomeDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDashboardResponseCopyWith<HomeDashboardResponse> get copyWith => _$HomeDashboardResponseCopyWithImpl<HomeDashboardResponse>(this as HomeDashboardResponse, _$identity);

  /// Serializes this HomeDashboardResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDashboardResponse&&const DeepCollectionEquality().equals(other.featuredJobs, featuredJobs)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.companiesViewed, companiesViewed) || other.companiesViewed == companiesViewed)&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interviews, interviews) || other.interviews == interviews)&&(identical(other.offers, offers) || other.offers == offers)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.matchDistribution, matchDistribution) || other.matchDistribution == matchDistribution)&&(identical(other.profileCompletionPercentage, profileCompletionPercentage) || other.profileCompletionPercentage == profileCompletionPercentage)&&(identical(other.applicationSuccessRate, applicationSuccessRate) || other.applicationSuccessRate == applicationSuccessRate)&&(identical(other.avgMarketSalary, avgMarketSalary) || other.avgMarketSalary == avgMarketSalary)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&const DeepCollectionEquality().equals(other.jobsByCity, jobsByCity)&&const DeepCollectionEquality().equals(other.monthlyJobCounts, monthlyJobCounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(featuredJobs),totalMatches,companiesViewed,inReview,interviews,offers,rejected,matchDistribution,profileCompletionPercentage,applicationSuccessRate,avgMarketSalary,totalApplications,const DeepCollectionEquality().hash(jobsByCity),const DeepCollectionEquality().hash(monthlyJobCounts));

@override
String toString() {
  return 'HomeDashboardResponse(featuredJobs: $featuredJobs, totalMatches: $totalMatches, companiesViewed: $companiesViewed, inReview: $inReview, interviews: $interviews, offers: $offers, rejected: $rejected, matchDistribution: $matchDistribution, profileCompletionPercentage: $profileCompletionPercentage, applicationSuccessRate: $applicationSuccessRate, avgMarketSalary: $avgMarketSalary, totalApplications: $totalApplications, jobsByCity: $jobsByCity, monthlyJobCounts: $monthlyJobCounts)';
}


}

/// @nodoc
abstract mixin class $HomeDashboardResponseCopyWith<$Res>  {
  factory $HomeDashboardResponseCopyWith(HomeDashboardResponse value, $Res Function(HomeDashboardResponse) _then) = _$HomeDashboardResponseCopyWithImpl;
@useResult
$Res call({
 List<JobDetailsResponse> featuredJobs, int totalMatches, int companiesViewed, int inReview, int interviews, int offers, int rejected, String matchDistribution, int profileCompletionPercentage, int applicationSuccessRate, String? avgMarketSalary, int? totalApplications, Map<String, int>? jobsByCity, Map<String, int>? monthlyJobCounts
});




}
/// @nodoc
class _$HomeDashboardResponseCopyWithImpl<$Res>
    implements $HomeDashboardResponseCopyWith<$Res> {
  _$HomeDashboardResponseCopyWithImpl(this._self, this._then);

  final HomeDashboardResponse _self;
  final $Res Function(HomeDashboardResponse) _then;

/// Create a copy of HomeDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? featuredJobs = null,Object? totalMatches = null,Object? companiesViewed = null,Object? inReview = null,Object? interviews = null,Object? offers = null,Object? rejected = null,Object? matchDistribution = null,Object? profileCompletionPercentage = null,Object? applicationSuccessRate = null,Object? avgMarketSalary = freezed,Object? totalApplications = freezed,Object? jobsByCity = freezed,Object? monthlyJobCounts = freezed,}) {
  return _then(_self.copyWith(
featuredJobs: null == featuredJobs ? _self.featuredJobs : featuredJobs // ignore: cast_nullable_to_non_nullable
as List<JobDetailsResponse>,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,companiesViewed: null == companiesViewed ? _self.companiesViewed : companiesViewed // ignore: cast_nullable_to_non_nullable
as int,inReview: null == inReview ? _self.inReview : inReview // ignore: cast_nullable_to_non_nullable
as int,interviews: null == interviews ? _self.interviews : interviews // ignore: cast_nullable_to_non_nullable
as int,offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,matchDistribution: null == matchDistribution ? _self.matchDistribution : matchDistribution // ignore: cast_nullable_to_non_nullable
as String,profileCompletionPercentage: null == profileCompletionPercentage ? _self.profileCompletionPercentage : profileCompletionPercentage // ignore: cast_nullable_to_non_nullable
as int,applicationSuccessRate: null == applicationSuccessRate ? _self.applicationSuccessRate : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
as int,avgMarketSalary: freezed == avgMarketSalary ? _self.avgMarketSalary : avgMarketSalary // ignore: cast_nullable_to_non_nullable
as String?,totalApplications: freezed == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int?,jobsByCity: freezed == jobsByCity ? _self.jobsByCity : jobsByCity // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,monthlyJobCounts: freezed == monthlyJobCounts ? _self.monthlyJobCounts : monthlyJobCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeDashboardResponse].
extension HomeDashboardResponsePatterns on HomeDashboardResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeDashboardResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeDashboardResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeDashboardResponse value)  $default,){
final _that = this;
switch (_that) {
case _HomeDashboardResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeDashboardResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HomeDashboardResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<JobDetailsResponse> featuredJobs,  int totalMatches,  int companiesViewed,  int inReview,  int interviews,  int offers,  int rejected,  String matchDistribution,  int profileCompletionPercentage,  int applicationSuccessRate,  String? avgMarketSalary,  int? totalApplications,  Map<String, int>? jobsByCity,  Map<String, int>? monthlyJobCounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeDashboardResponse() when $default != null:
return $default(_that.featuredJobs,_that.totalMatches,_that.companiesViewed,_that.inReview,_that.interviews,_that.offers,_that.rejected,_that.matchDistribution,_that.profileCompletionPercentage,_that.applicationSuccessRate,_that.avgMarketSalary,_that.totalApplications,_that.jobsByCity,_that.monthlyJobCounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<JobDetailsResponse> featuredJobs,  int totalMatches,  int companiesViewed,  int inReview,  int interviews,  int offers,  int rejected,  String matchDistribution,  int profileCompletionPercentage,  int applicationSuccessRate,  String? avgMarketSalary,  int? totalApplications,  Map<String, int>? jobsByCity,  Map<String, int>? monthlyJobCounts)  $default,) {final _that = this;
switch (_that) {
case _HomeDashboardResponse():
return $default(_that.featuredJobs,_that.totalMatches,_that.companiesViewed,_that.inReview,_that.interviews,_that.offers,_that.rejected,_that.matchDistribution,_that.profileCompletionPercentage,_that.applicationSuccessRate,_that.avgMarketSalary,_that.totalApplications,_that.jobsByCity,_that.monthlyJobCounts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<JobDetailsResponse> featuredJobs,  int totalMatches,  int companiesViewed,  int inReview,  int interviews,  int offers,  int rejected,  String matchDistribution,  int profileCompletionPercentage,  int applicationSuccessRate,  String? avgMarketSalary,  int? totalApplications,  Map<String, int>? jobsByCity,  Map<String, int>? monthlyJobCounts)?  $default,) {final _that = this;
switch (_that) {
case _HomeDashboardResponse() when $default != null:
return $default(_that.featuredJobs,_that.totalMatches,_that.companiesViewed,_that.inReview,_that.interviews,_that.offers,_that.rejected,_that.matchDistribution,_that.profileCompletionPercentage,_that.applicationSuccessRate,_that.avgMarketSalary,_that.totalApplications,_that.jobsByCity,_that.monthlyJobCounts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeDashboardResponse implements HomeDashboardResponse {
  const _HomeDashboardResponse({required final  List<JobDetailsResponse> featuredJobs, required this.totalMatches, required this.companiesViewed, required this.inReview, required this.interviews, required this.offers, required this.rejected, required this.matchDistribution, required this.profileCompletionPercentage, required this.applicationSuccessRate, this.avgMarketSalary, this.totalApplications, final  Map<String, int>? jobsByCity, final  Map<String, int>? monthlyJobCounts}): _featuredJobs = featuredJobs,_jobsByCity = jobsByCity,_monthlyJobCounts = monthlyJobCounts;
  factory _HomeDashboardResponse.fromJson(Map<String, dynamic> json) => _$HomeDashboardResponseFromJson(json);

/// List of featured jobs to display on home screen
 final  List<JobDetailsResponse> _featuredJobs;
/// List of featured jobs to display on home screen
@override List<JobDetailsResponse> get featuredJobs {
  if (_featuredJobs is EqualUnmodifiableListView) return _featuredJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredJobs);
}

/// Total number of job matches
@override final  int totalMatches;
/// Total number of companies the user has viewed
@override final  int companiesViewed;
/// Number of applications currently in review
@override final  int inReview;
/// Number of interviews scheduled
@override final  int interviews;
/// Number of job offers received
@override final  int offers;
/// Number of applications rejected
@override final  int rejected;
/// Distribution of matches (format: "active | interviewing | offered")
@override final  String matchDistribution;
/// Profile completion percentage (0-100)
@override final  int profileCompletionPercentage;
/// Application success rate percentage (0-100)
@override final  int applicationSuccessRate;
/// Average market salary for user's role
@override final  String? avgMarketSalary;
/// Total number of applications
@override final  int? totalApplications;
/// Job counts by city for location-based statistics
 final  Map<String, int>? _jobsByCity;
/// Job counts by city for location-based statistics
@override Map<String, int>? get jobsByCity {
  final value = _jobsByCity;
  if (value == null) return null;
  if (_jobsByCity is EqualUnmodifiableMapView) return _jobsByCity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Monthly job counts for trends
 final  Map<String, int>? _monthlyJobCounts;
/// Monthly job counts for trends
@override Map<String, int>? get monthlyJobCounts {
  final value = _monthlyJobCounts;
  if (value == null) return null;
  if (_monthlyJobCounts is EqualUnmodifiableMapView) return _monthlyJobCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of HomeDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeDashboardResponseCopyWith<_HomeDashboardResponse> get copyWith => __$HomeDashboardResponseCopyWithImpl<_HomeDashboardResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeDashboardResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeDashboardResponse&&const DeepCollectionEquality().equals(other._featuredJobs, _featuredJobs)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.companiesViewed, companiesViewed) || other.companiesViewed == companiesViewed)&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interviews, interviews) || other.interviews == interviews)&&(identical(other.offers, offers) || other.offers == offers)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.matchDistribution, matchDistribution) || other.matchDistribution == matchDistribution)&&(identical(other.profileCompletionPercentage, profileCompletionPercentage) || other.profileCompletionPercentage == profileCompletionPercentage)&&(identical(other.applicationSuccessRate, applicationSuccessRate) || other.applicationSuccessRate == applicationSuccessRate)&&(identical(other.avgMarketSalary, avgMarketSalary) || other.avgMarketSalary == avgMarketSalary)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&const DeepCollectionEquality().equals(other._jobsByCity, _jobsByCity)&&const DeepCollectionEquality().equals(other._monthlyJobCounts, _monthlyJobCounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_featuredJobs),totalMatches,companiesViewed,inReview,interviews,offers,rejected,matchDistribution,profileCompletionPercentage,applicationSuccessRate,avgMarketSalary,totalApplications,const DeepCollectionEquality().hash(_jobsByCity),const DeepCollectionEquality().hash(_monthlyJobCounts));

@override
String toString() {
  return 'HomeDashboardResponse(featuredJobs: $featuredJobs, totalMatches: $totalMatches, companiesViewed: $companiesViewed, inReview: $inReview, interviews: $interviews, offers: $offers, rejected: $rejected, matchDistribution: $matchDistribution, profileCompletionPercentage: $profileCompletionPercentage, applicationSuccessRate: $applicationSuccessRate, avgMarketSalary: $avgMarketSalary, totalApplications: $totalApplications, jobsByCity: $jobsByCity, monthlyJobCounts: $monthlyJobCounts)';
}


}

/// @nodoc
abstract mixin class _$HomeDashboardResponseCopyWith<$Res> implements $HomeDashboardResponseCopyWith<$Res> {
  factory _$HomeDashboardResponseCopyWith(_HomeDashboardResponse value, $Res Function(_HomeDashboardResponse) _then) = __$HomeDashboardResponseCopyWithImpl;
@override @useResult
$Res call({
 List<JobDetailsResponse> featuredJobs, int totalMatches, int companiesViewed, int inReview, int interviews, int offers, int rejected, String matchDistribution, int profileCompletionPercentage, int applicationSuccessRate, String? avgMarketSalary, int? totalApplications, Map<String, int>? jobsByCity, Map<String, int>? monthlyJobCounts
});




}
/// @nodoc
class __$HomeDashboardResponseCopyWithImpl<$Res>
    implements _$HomeDashboardResponseCopyWith<$Res> {
  __$HomeDashboardResponseCopyWithImpl(this._self, this._then);

  final _HomeDashboardResponse _self;
  final $Res Function(_HomeDashboardResponse) _then;

/// Create a copy of HomeDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? featuredJobs = null,Object? totalMatches = null,Object? companiesViewed = null,Object? inReview = null,Object? interviews = null,Object? offers = null,Object? rejected = null,Object? matchDistribution = null,Object? profileCompletionPercentage = null,Object? applicationSuccessRate = null,Object? avgMarketSalary = freezed,Object? totalApplications = freezed,Object? jobsByCity = freezed,Object? monthlyJobCounts = freezed,}) {
  return _then(_HomeDashboardResponse(
featuredJobs: null == featuredJobs ? _self._featuredJobs : featuredJobs // ignore: cast_nullable_to_non_nullable
as List<JobDetailsResponse>,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,companiesViewed: null == companiesViewed ? _self.companiesViewed : companiesViewed // ignore: cast_nullable_to_non_nullable
as int,inReview: null == inReview ? _self.inReview : inReview // ignore: cast_nullable_to_non_nullable
as int,interviews: null == interviews ? _self.interviews : interviews // ignore: cast_nullable_to_non_nullable
as int,offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,matchDistribution: null == matchDistribution ? _self.matchDistribution : matchDistribution // ignore: cast_nullable_to_non_nullable
as String,profileCompletionPercentage: null == profileCompletionPercentage ? _self.profileCompletionPercentage : profileCompletionPercentage // ignore: cast_nullable_to_non_nullable
as int,applicationSuccessRate: null == applicationSuccessRate ? _self.applicationSuccessRate : applicationSuccessRate // ignore: cast_nullable_to_non_nullable
as int,avgMarketSalary: freezed == avgMarketSalary ? _self.avgMarketSalary : avgMarketSalary // ignore: cast_nullable_to_non_nullable
as String?,totalApplications: freezed == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int?,jobsByCity: freezed == jobsByCity ? _self._jobsByCity : jobsByCity // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,monthlyJobCounts: freezed == monthlyJobCounts ? _self._monthlyJobCounts : monthlyJobCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}


}

// dart format on
