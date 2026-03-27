// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_match_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobsMatchResponse {

/// List of matched jobs
 List<MatchedJob>? get matchedJobs;/// Total count
 int? get total;
/// Create a copy of JobsMatchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobsMatchResponseCopyWith<JobsMatchResponse> get copyWith => _$JobsMatchResponseCopyWithImpl<JobsMatchResponse>(this as JobsMatchResponse, _$identity);

  /// Serializes this JobsMatchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsMatchResponse&&const DeepCollectionEquality().equals(other.matchedJobs, matchedJobs)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(matchedJobs),total);

@override
String toString() {
  return 'JobsMatchResponse(matchedJobs: $matchedJobs, total: $total)';
}


}

/// @nodoc
abstract mixin class $JobsMatchResponseCopyWith<$Res>  {
  factory $JobsMatchResponseCopyWith(JobsMatchResponse value, $Res Function(JobsMatchResponse) _then) = _$JobsMatchResponseCopyWithImpl;
@useResult
$Res call({
 List<MatchedJob>? matchedJobs, int? total
});




}
/// @nodoc
class _$JobsMatchResponseCopyWithImpl<$Res>
    implements $JobsMatchResponseCopyWith<$Res> {
  _$JobsMatchResponseCopyWithImpl(this._self, this._then);

  final JobsMatchResponse _self;
  final $Res Function(JobsMatchResponse) _then;

/// Create a copy of JobsMatchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchedJobs = freezed,Object? total = freezed,}) {
  return _then(_self.copyWith(
matchedJobs: freezed == matchedJobs ? _self.matchedJobs : matchedJobs // ignore: cast_nullable_to_non_nullable
as List<MatchedJob>?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobsMatchResponse].
extension JobsMatchResponsePatterns on JobsMatchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobsMatchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobsMatchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobsMatchResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobsMatchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobsMatchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobsMatchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MatchedJob>? matchedJobs,  int? total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobsMatchResponse() when $default != null:
return $default(_that.matchedJobs,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MatchedJob>? matchedJobs,  int? total)  $default,) {final _that = this;
switch (_that) {
case _JobsMatchResponse():
return $default(_that.matchedJobs,_that.total);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MatchedJob>? matchedJobs,  int? total)?  $default,) {final _that = this;
switch (_that) {
case _JobsMatchResponse() when $default != null:
return $default(_that.matchedJobs,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobsMatchResponse implements JobsMatchResponse {
  const _JobsMatchResponse({final  List<MatchedJob>? matchedJobs, this.total}): _matchedJobs = matchedJobs;
  factory _JobsMatchResponse.fromJson(Map<String, dynamic> json) => _$JobsMatchResponseFromJson(json);

/// List of matched jobs
 final  List<MatchedJob>? _matchedJobs;
/// List of matched jobs
@override List<MatchedJob>? get matchedJobs {
  final value = _matchedJobs;
  if (value == null) return null;
  if (_matchedJobs is EqualUnmodifiableListView) return _matchedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Total count
@override final  int? total;

/// Create a copy of JobsMatchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobsMatchResponseCopyWith<_JobsMatchResponse> get copyWith => __$JobsMatchResponseCopyWithImpl<_JobsMatchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobsMatchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobsMatchResponse&&const DeepCollectionEquality().equals(other._matchedJobs, _matchedJobs)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_matchedJobs),total);

@override
String toString() {
  return 'JobsMatchResponse(matchedJobs: $matchedJobs, total: $total)';
}


}

/// @nodoc
abstract mixin class _$JobsMatchResponseCopyWith<$Res> implements $JobsMatchResponseCopyWith<$Res> {
  factory _$JobsMatchResponseCopyWith(_JobsMatchResponse value, $Res Function(_JobsMatchResponse) _then) = __$JobsMatchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<MatchedJob>? matchedJobs, int? total
});




}
/// @nodoc
class __$JobsMatchResponseCopyWithImpl<$Res>
    implements _$JobsMatchResponseCopyWith<$Res> {
  __$JobsMatchResponseCopyWithImpl(this._self, this._then);

  final _JobsMatchResponse _self;
  final $Res Function(_JobsMatchResponse) _then;

/// Create a copy of JobsMatchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchedJobs = freezed,Object? total = freezed,}) {
  return _then(_JobsMatchResponse(
matchedJobs: freezed == matchedJobs ? _self._matchedJobs : matchedJobs // ignore: cast_nullable_to_non_nullable
as List<MatchedJob>?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$MatchedJob {

/// Job ID
 String? get jobId;/// Job title
 String? get jobTitle;/// Company name
 String? get companyName;/// Match score
 double? get matchScore;/// Match percentage
 String? get matchPercentage;
/// Create a copy of MatchedJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchedJobCopyWith<MatchedJob> get copyWith => _$MatchedJobCopyWithImpl<MatchedJob>(this as MatchedJob, _$identity);

  /// Serializes this MatchedJob to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchedJob&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobId,jobTitle,companyName,matchScore,matchPercentage);

@override
String toString() {
  return 'MatchedJob(jobId: $jobId, jobTitle: $jobTitle, companyName: $companyName, matchScore: $matchScore, matchPercentage: $matchPercentage)';
}


}

/// @nodoc
abstract mixin class $MatchedJobCopyWith<$Res>  {
  factory $MatchedJobCopyWith(MatchedJob value, $Res Function(MatchedJob) _then) = _$MatchedJobCopyWithImpl;
@useResult
$Res call({
 String? jobId, String? jobTitle, String? companyName, double? matchScore, String? matchPercentage
});




}
/// @nodoc
class _$MatchedJobCopyWithImpl<$Res>
    implements $MatchedJobCopyWith<$Res> {
  _$MatchedJobCopyWithImpl(this._self, this._then);

  final MatchedJob _self;
  final $Res Function(MatchedJob) _then;

/// Create a copy of MatchedJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobId = freezed,Object? jobTitle = freezed,Object? companyName = freezed,Object? matchScore = freezed,Object? matchPercentage = freezed,}) {
  return _then(_self.copyWith(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as double?,matchPercentage: freezed == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchedJob].
extension MatchedJobPatterns on MatchedJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchedJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchedJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchedJob value)  $default,){
final _that = this;
switch (_that) {
case _MatchedJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchedJob value)?  $default,){
final _that = this;
switch (_that) {
case _MatchedJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? jobId,  String? jobTitle,  String? companyName,  double? matchScore,  String? matchPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchedJob() when $default != null:
return $default(_that.jobId,_that.jobTitle,_that.companyName,_that.matchScore,_that.matchPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? jobId,  String? jobTitle,  String? companyName,  double? matchScore,  String? matchPercentage)  $default,) {final _that = this;
switch (_that) {
case _MatchedJob():
return $default(_that.jobId,_that.jobTitle,_that.companyName,_that.matchScore,_that.matchPercentage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? jobId,  String? jobTitle,  String? companyName,  double? matchScore,  String? matchPercentage)?  $default,) {final _that = this;
switch (_that) {
case _MatchedJob() when $default != null:
return $default(_that.jobId,_that.jobTitle,_that.companyName,_that.matchScore,_that.matchPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchedJob implements MatchedJob {
  const _MatchedJob({this.jobId, this.jobTitle, this.companyName, this.matchScore, this.matchPercentage});
  factory _MatchedJob.fromJson(Map<String, dynamic> json) => _$MatchedJobFromJson(json);

/// Job ID
@override final  String? jobId;
/// Job title
@override final  String? jobTitle;
/// Company name
@override final  String? companyName;
/// Match score
@override final  double? matchScore;
/// Match percentage
@override final  String? matchPercentage;

/// Create a copy of MatchedJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchedJobCopyWith<_MatchedJob> get copyWith => __$MatchedJobCopyWithImpl<_MatchedJob>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchedJobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchedJob&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobId,jobTitle,companyName,matchScore,matchPercentage);

@override
String toString() {
  return 'MatchedJob(jobId: $jobId, jobTitle: $jobTitle, companyName: $companyName, matchScore: $matchScore, matchPercentage: $matchPercentage)';
}


}

/// @nodoc
abstract mixin class _$MatchedJobCopyWith<$Res> implements $MatchedJobCopyWith<$Res> {
  factory _$MatchedJobCopyWith(_MatchedJob value, $Res Function(_MatchedJob) _then) = __$MatchedJobCopyWithImpl;
@override @useResult
$Res call({
 String? jobId, String? jobTitle, String? companyName, double? matchScore, String? matchPercentage
});




}
/// @nodoc
class __$MatchedJobCopyWithImpl<$Res>
    implements _$MatchedJobCopyWith<$Res> {
  __$MatchedJobCopyWithImpl(this._self, this._then);

  final _MatchedJob _self;
  final $Res Function(_MatchedJob) _then;

/// Create a copy of MatchedJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobId = freezed,Object? jobTitle = freezed,Object? companyName = freezed,Object? matchScore = freezed,Object? matchPercentage = freezed,}) {
  return _then(_MatchedJob(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as double?,matchPercentage: freezed == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ApplyJobsResponse {

/// Response message
 String get message;/// Success status
 bool get success;/// Summary containing apply and ranking results
 ApplySummary get summary;
/// Create a copy of ApplyJobsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyJobsResponseCopyWith<ApplyJobsResponse> get copyWith => _$ApplyJobsResponseCopyWithImpl<ApplyJobsResponse>(this as ApplyJobsResponse, _$identity);

  /// Serializes this ApplyJobsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyJobsResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.success, success) || other.success == success)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,success,summary);

@override
String toString() {
  return 'ApplyJobsResponse(message: $message, success: $success, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ApplyJobsResponseCopyWith<$Res>  {
  factory $ApplyJobsResponseCopyWith(ApplyJobsResponse value, $Res Function(ApplyJobsResponse) _then) = _$ApplyJobsResponseCopyWithImpl;
@useResult
$Res call({
 String message, bool success, ApplySummary summary
});


$ApplySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$ApplyJobsResponseCopyWithImpl<$Res>
    implements $ApplyJobsResponseCopyWith<$Res> {
  _$ApplyJobsResponseCopyWithImpl(this._self, this._then);

  final ApplyJobsResponse _self;
  final $Res Function(ApplyJobsResponse) _then;

/// Create a copy of ApplyJobsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? success = null,Object? summary = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ApplySummary,
  ));
}
/// Create a copy of ApplyJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplySummaryCopyWith<$Res> get summary {
  
  return $ApplySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApplyJobsResponse].
extension ApplyJobsResponsePatterns on ApplyJobsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplyJobsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplyJobsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplyJobsResponse value)  $default,){
final _that = this;
switch (_that) {
case _ApplyJobsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplyJobsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ApplyJobsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  bool success,  ApplySummary summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplyJobsResponse() when $default != null:
return $default(_that.message,_that.success,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  bool success,  ApplySummary summary)  $default,) {final _that = this;
switch (_that) {
case _ApplyJobsResponse():
return $default(_that.message,_that.success,_that.summary);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  bool success,  ApplySummary summary)?  $default,) {final _that = this;
switch (_that) {
case _ApplyJobsResponse() when $default != null:
return $default(_that.message,_that.success,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplyJobsResponse implements ApplyJobsResponse {
  const _ApplyJobsResponse({required this.message, required this.success, required this.summary});
  factory _ApplyJobsResponse.fromJson(Map<String, dynamic> json) => _$ApplyJobsResponseFromJson(json);

/// Response message
@override final  String message;
/// Success status
@override final  bool success;
/// Summary containing apply and ranking results
@override final  ApplySummary summary;

/// Create a copy of ApplyJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyJobsResponseCopyWith<_ApplyJobsResponse> get copyWith => __$ApplyJobsResponseCopyWithImpl<_ApplyJobsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplyJobsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyJobsResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.success, success) || other.success == success)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,success,summary);

@override
String toString() {
  return 'ApplyJobsResponse(message: $message, success: $success, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$ApplyJobsResponseCopyWith<$Res> implements $ApplyJobsResponseCopyWith<$Res> {
  factory _$ApplyJobsResponseCopyWith(_ApplyJobsResponse value, $Res Function(_ApplyJobsResponse) _then) = __$ApplyJobsResponseCopyWithImpl;
@override @useResult
$Res call({
 String message, bool success, ApplySummary summary
});


@override $ApplySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$ApplyJobsResponseCopyWithImpl<$Res>
    implements _$ApplyJobsResponseCopyWith<$Res> {
  __$ApplyJobsResponseCopyWithImpl(this._self, this._then);

  final _ApplyJobsResponse _self;
  final $Res Function(_ApplyJobsResponse) _then;

/// Create a copy of ApplyJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? success = null,Object? summary = null,}) {
  return _then(_ApplyJobsResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ApplySummary,
  ));
}

/// Create a copy of ApplyJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplySummaryCopyWith<$Res> get summary {
  
  return $ApplySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$ApplySummary {

/// Apply result
@JsonKey(name: 'apply_result') ApplyResult? get applyResult;/// Client email
 String get email;/// Ranking result
@JsonKey(name: 'ranking_result') RankingResult get rankingResult;
/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplySummaryCopyWith<ApplySummary> get copyWith => _$ApplySummaryCopyWithImpl<ApplySummary>(this as ApplySummary, _$identity);

  /// Serializes this ApplySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplySummary&&(identical(other.applyResult, applyResult) || other.applyResult == applyResult)&&(identical(other.email, email) || other.email == email)&&(identical(other.rankingResult, rankingResult) || other.rankingResult == rankingResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,applyResult,email,rankingResult);

@override
String toString() {
  return 'ApplySummary(applyResult: $applyResult, email: $email, rankingResult: $rankingResult)';
}


}

/// @nodoc
abstract mixin class $ApplySummaryCopyWith<$Res>  {
  factory $ApplySummaryCopyWith(ApplySummary value, $Res Function(ApplySummary) _then) = _$ApplySummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'apply_result') ApplyResult? applyResult, String email,@JsonKey(name: 'ranking_result') RankingResult rankingResult
});


$ApplyResultCopyWith<$Res>? get applyResult;$RankingResultCopyWith<$Res> get rankingResult;

}
/// @nodoc
class _$ApplySummaryCopyWithImpl<$Res>
    implements $ApplySummaryCopyWith<$Res> {
  _$ApplySummaryCopyWithImpl(this._self, this._then);

  final ApplySummary _self;
  final $Res Function(ApplySummary) _then;

/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? applyResult = freezed,Object? email = null,Object? rankingResult = null,}) {
  return _then(_self.copyWith(
applyResult: freezed == applyResult ? _self.applyResult : applyResult // ignore: cast_nullable_to_non_nullable
as ApplyResult?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,rankingResult: null == rankingResult ? _self.rankingResult : rankingResult // ignore: cast_nullable_to_non_nullable
as RankingResult,
  ));
}
/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplyResultCopyWith<$Res>? get applyResult {
    if (_self.applyResult == null) {
    return null;
  }

  return $ApplyResultCopyWith<$Res>(_self.applyResult!, (value) {
    return _then(_self.copyWith(applyResult: value));
  });
}/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingResultCopyWith<$Res> get rankingResult {
  
  return $RankingResultCopyWith<$Res>(_self.rankingResult, (value) {
    return _then(_self.copyWith(rankingResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApplySummary].
extension ApplySummaryPatterns on ApplySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplySummary value)  $default,){
final _that = this;
switch (_that) {
case _ApplySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplySummary value)?  $default,){
final _that = this;
switch (_that) {
case _ApplySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'apply_result')  ApplyResult? applyResult,  String email, @JsonKey(name: 'ranking_result')  RankingResult rankingResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplySummary() when $default != null:
return $default(_that.applyResult,_that.email,_that.rankingResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'apply_result')  ApplyResult? applyResult,  String email, @JsonKey(name: 'ranking_result')  RankingResult rankingResult)  $default,) {final _that = this;
switch (_that) {
case _ApplySummary():
return $default(_that.applyResult,_that.email,_that.rankingResult);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'apply_result')  ApplyResult? applyResult,  String email, @JsonKey(name: 'ranking_result')  RankingResult rankingResult)?  $default,) {final _that = this;
switch (_that) {
case _ApplySummary() when $default != null:
return $default(_that.applyResult,_that.email,_that.rankingResult);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplySummary implements ApplySummary {
  const _ApplySummary({@JsonKey(name: 'apply_result') this.applyResult, required this.email, @JsonKey(name: 'ranking_result') required this.rankingResult});
  factory _ApplySummary.fromJson(Map<String, dynamic> json) => _$ApplySummaryFromJson(json);

/// Apply result
@override@JsonKey(name: 'apply_result') final  ApplyResult? applyResult;
/// Client email
@override final  String email;
/// Ranking result
@override@JsonKey(name: 'ranking_result') final  RankingResult rankingResult;

/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplySummaryCopyWith<_ApplySummary> get copyWith => __$ApplySummaryCopyWithImpl<_ApplySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplySummary&&(identical(other.applyResult, applyResult) || other.applyResult == applyResult)&&(identical(other.email, email) || other.email == email)&&(identical(other.rankingResult, rankingResult) || other.rankingResult == rankingResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,applyResult,email,rankingResult);

@override
String toString() {
  return 'ApplySummary(applyResult: $applyResult, email: $email, rankingResult: $rankingResult)';
}


}

/// @nodoc
abstract mixin class _$ApplySummaryCopyWith<$Res> implements $ApplySummaryCopyWith<$Res> {
  factory _$ApplySummaryCopyWith(_ApplySummary value, $Res Function(_ApplySummary) _then) = __$ApplySummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'apply_result') ApplyResult? applyResult, String email,@JsonKey(name: 'ranking_result') RankingResult rankingResult
});


@override $ApplyResultCopyWith<$Res>? get applyResult;@override $RankingResultCopyWith<$Res> get rankingResult;

}
/// @nodoc
class __$ApplySummaryCopyWithImpl<$Res>
    implements _$ApplySummaryCopyWith<$Res> {
  __$ApplySummaryCopyWithImpl(this._self, this._then);

  final _ApplySummary _self;
  final $Res Function(_ApplySummary) _then;

/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? applyResult = freezed,Object? email = null,Object? rankingResult = null,}) {
  return _then(_ApplySummary(
applyResult: freezed == applyResult ? _self.applyResult : applyResult // ignore: cast_nullable_to_non_nullable
as ApplyResult?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,rankingResult: null == rankingResult ? _self.rankingResult : rankingResult // ignore: cast_nullable_to_non_nullable
as RankingResult,
  ));
}

/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplyResultCopyWith<$Res>? get applyResult {
    if (_self.applyResult == null) {
    return null;
  }

  return $ApplyResultCopyWith<$Res>(_self.applyResult!, (value) {
    return _then(_self.copyWith(applyResult: value));
  });
}/// Create a copy of ApplySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingResultCopyWith<$Res> get rankingResult {
  
  return $RankingResultCopyWith<$Res>(_self.rankingResult, (value) {
    return _then(_self.copyWith(rankingResult: value));
  });
}
}


/// @nodoc
mixin _$ApplyResult {

/// Application date
 String get date;/// Applicant email
 String get email;/// Number of matches processed
@JsonKey(name: 'matches_processed') int get matchesProcessed;
/// Create a copy of ApplyResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyResultCopyWith<ApplyResult> get copyWith => _$ApplyResultCopyWithImpl<ApplyResult>(this as ApplyResult, _$identity);

  /// Serializes this ApplyResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyResult&&(identical(other.date, date) || other.date == date)&&(identical(other.email, email) || other.email == email)&&(identical(other.matchesProcessed, matchesProcessed) || other.matchesProcessed == matchesProcessed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,email,matchesProcessed);

@override
String toString() {
  return 'ApplyResult(date: $date, email: $email, matchesProcessed: $matchesProcessed)';
}


}

/// @nodoc
abstract mixin class $ApplyResultCopyWith<$Res>  {
  factory $ApplyResultCopyWith(ApplyResult value, $Res Function(ApplyResult) _then) = _$ApplyResultCopyWithImpl;
@useResult
$Res call({
 String date, String email,@JsonKey(name: 'matches_processed') int matchesProcessed
});




}
/// @nodoc
class _$ApplyResultCopyWithImpl<$Res>
    implements $ApplyResultCopyWith<$Res> {
  _$ApplyResultCopyWithImpl(this._self, this._then);

  final ApplyResult _self;
  final $Res Function(ApplyResult) _then;

/// Create a copy of ApplyResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? email = null,Object? matchesProcessed = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,matchesProcessed: null == matchesProcessed ? _self.matchesProcessed : matchesProcessed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplyResult].
extension ApplyResultPatterns on ApplyResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplyResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplyResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplyResult value)  $default,){
final _that = this;
switch (_that) {
case _ApplyResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplyResult value)?  $default,){
final _that = this;
switch (_that) {
case _ApplyResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String email, @JsonKey(name: 'matches_processed')  int matchesProcessed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplyResult() when $default != null:
return $default(_that.date,_that.email,_that.matchesProcessed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String email, @JsonKey(name: 'matches_processed')  int matchesProcessed)  $default,) {final _that = this;
switch (_that) {
case _ApplyResult():
return $default(_that.date,_that.email,_that.matchesProcessed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String email, @JsonKey(name: 'matches_processed')  int matchesProcessed)?  $default,) {final _that = this;
switch (_that) {
case _ApplyResult() when $default != null:
return $default(_that.date,_that.email,_that.matchesProcessed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplyResult implements ApplyResult {
  const _ApplyResult({required this.date, required this.email, @JsonKey(name: 'matches_processed') required this.matchesProcessed});
  factory _ApplyResult.fromJson(Map<String, dynamic> json) => _$ApplyResultFromJson(json);

/// Application date
@override final  String date;
/// Applicant email
@override final  String email;
/// Number of matches processed
@override@JsonKey(name: 'matches_processed') final  int matchesProcessed;

/// Create a copy of ApplyResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyResultCopyWith<_ApplyResult> get copyWith => __$ApplyResultCopyWithImpl<_ApplyResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplyResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyResult&&(identical(other.date, date) || other.date == date)&&(identical(other.email, email) || other.email == email)&&(identical(other.matchesProcessed, matchesProcessed) || other.matchesProcessed == matchesProcessed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,email,matchesProcessed);

@override
String toString() {
  return 'ApplyResult(date: $date, email: $email, matchesProcessed: $matchesProcessed)';
}


}

/// @nodoc
abstract mixin class _$ApplyResultCopyWith<$Res> implements $ApplyResultCopyWith<$Res> {
  factory _$ApplyResultCopyWith(_ApplyResult value, $Res Function(_ApplyResult) _then) = __$ApplyResultCopyWithImpl;
@override @useResult
$Res call({
 String date, String email,@JsonKey(name: 'matches_processed') int matchesProcessed
});




}
/// @nodoc
class __$ApplyResultCopyWithImpl<$Res>
    implements _$ApplyResultCopyWith<$Res> {
  __$ApplyResultCopyWithImpl(this._self, this._then);

  final _ApplyResult _self;
  final $Res Function(_ApplyResult) _then;

/// Create a copy of ApplyResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? email = null,Object? matchesProcessed = null,}) {
  return _then(_ApplyResult(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,matchesProcessed: null == matchesProcessed ? _self.matchesProcessed : matchesProcessed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RankingResult {

/// Number of blocked pairs
@JsonKey(name: 'blocked_pairs_count') int get blockedPairsCount;/// Client email
@JsonKey(name: 'client_email') String get clientEmail;/// Number of clients processed
@JsonKey(name: 'clients_processed') int get clientsProcessed;/// Execution time in seconds
@JsonKey(name: 'execution_time_seconds') double get executionTimeSeconds;/// Number of existing matches skipped
@JsonKey(name: 'existing_matches_skipped') int get existingMatchesSkipped;/// Number of jobs processed
@JsonKey(name: 'jobs_processed') int get jobsProcessed;/// Number of matches found
@JsonKey(name: 'matches_found') int get matchesFound;/// Number of matches inserted
@JsonKey(name: 'matches_inserted') int get matchesInserted;/// Processing date
@JsonKey(name: 'processing_date') String get processingDate;
/// Create a copy of RankingResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingResultCopyWith<RankingResult> get copyWith => _$RankingResultCopyWithImpl<RankingResult>(this as RankingResult, _$identity);

  /// Serializes this RankingResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingResult&&(identical(other.blockedPairsCount, blockedPairsCount) || other.blockedPairsCount == blockedPairsCount)&&(identical(other.clientEmail, clientEmail) || other.clientEmail == clientEmail)&&(identical(other.clientsProcessed, clientsProcessed) || other.clientsProcessed == clientsProcessed)&&(identical(other.executionTimeSeconds, executionTimeSeconds) || other.executionTimeSeconds == executionTimeSeconds)&&(identical(other.existingMatchesSkipped, existingMatchesSkipped) || other.existingMatchesSkipped == existingMatchesSkipped)&&(identical(other.jobsProcessed, jobsProcessed) || other.jobsProcessed == jobsProcessed)&&(identical(other.matchesFound, matchesFound) || other.matchesFound == matchesFound)&&(identical(other.matchesInserted, matchesInserted) || other.matchesInserted == matchesInserted)&&(identical(other.processingDate, processingDate) || other.processingDate == processingDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,blockedPairsCount,clientEmail,clientsProcessed,executionTimeSeconds,existingMatchesSkipped,jobsProcessed,matchesFound,matchesInserted,processingDate);

@override
String toString() {
  return 'RankingResult(blockedPairsCount: $blockedPairsCount, clientEmail: $clientEmail, clientsProcessed: $clientsProcessed, executionTimeSeconds: $executionTimeSeconds, existingMatchesSkipped: $existingMatchesSkipped, jobsProcessed: $jobsProcessed, matchesFound: $matchesFound, matchesInserted: $matchesInserted, processingDate: $processingDate)';
}


}

/// @nodoc
abstract mixin class $RankingResultCopyWith<$Res>  {
  factory $RankingResultCopyWith(RankingResult value, $Res Function(RankingResult) _then) = _$RankingResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'blocked_pairs_count') int blockedPairsCount,@JsonKey(name: 'client_email') String clientEmail,@JsonKey(name: 'clients_processed') int clientsProcessed,@JsonKey(name: 'execution_time_seconds') double executionTimeSeconds,@JsonKey(name: 'existing_matches_skipped') int existingMatchesSkipped,@JsonKey(name: 'jobs_processed') int jobsProcessed,@JsonKey(name: 'matches_found') int matchesFound,@JsonKey(name: 'matches_inserted') int matchesInserted,@JsonKey(name: 'processing_date') String processingDate
});




}
/// @nodoc
class _$RankingResultCopyWithImpl<$Res>
    implements $RankingResultCopyWith<$Res> {
  _$RankingResultCopyWithImpl(this._self, this._then);

  final RankingResult _self;
  final $Res Function(RankingResult) _then;

/// Create a copy of RankingResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? blockedPairsCount = null,Object? clientEmail = null,Object? clientsProcessed = null,Object? executionTimeSeconds = null,Object? existingMatchesSkipped = null,Object? jobsProcessed = null,Object? matchesFound = null,Object? matchesInserted = null,Object? processingDate = null,}) {
  return _then(_self.copyWith(
blockedPairsCount: null == blockedPairsCount ? _self.blockedPairsCount : blockedPairsCount // ignore: cast_nullable_to_non_nullable
as int,clientEmail: null == clientEmail ? _self.clientEmail : clientEmail // ignore: cast_nullable_to_non_nullable
as String,clientsProcessed: null == clientsProcessed ? _self.clientsProcessed : clientsProcessed // ignore: cast_nullable_to_non_nullable
as int,executionTimeSeconds: null == executionTimeSeconds ? _self.executionTimeSeconds : executionTimeSeconds // ignore: cast_nullable_to_non_nullable
as double,existingMatchesSkipped: null == existingMatchesSkipped ? _self.existingMatchesSkipped : existingMatchesSkipped // ignore: cast_nullable_to_non_nullable
as int,jobsProcessed: null == jobsProcessed ? _self.jobsProcessed : jobsProcessed // ignore: cast_nullable_to_non_nullable
as int,matchesFound: null == matchesFound ? _self.matchesFound : matchesFound // ignore: cast_nullable_to_non_nullable
as int,matchesInserted: null == matchesInserted ? _self.matchesInserted : matchesInserted // ignore: cast_nullable_to_non_nullable
as int,processingDate: null == processingDate ? _self.processingDate : processingDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingResult].
extension RankingResultPatterns on RankingResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingResult value)  $default,){
final _that = this;
switch (_that) {
case _RankingResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingResult value)?  $default,){
final _that = this;
switch (_that) {
case _RankingResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'blocked_pairs_count')  int blockedPairsCount, @JsonKey(name: 'client_email')  String clientEmail, @JsonKey(name: 'clients_processed')  int clientsProcessed, @JsonKey(name: 'execution_time_seconds')  double executionTimeSeconds, @JsonKey(name: 'existing_matches_skipped')  int existingMatchesSkipped, @JsonKey(name: 'jobs_processed')  int jobsProcessed, @JsonKey(name: 'matches_found')  int matchesFound, @JsonKey(name: 'matches_inserted')  int matchesInserted, @JsonKey(name: 'processing_date')  String processingDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingResult() when $default != null:
return $default(_that.blockedPairsCount,_that.clientEmail,_that.clientsProcessed,_that.executionTimeSeconds,_that.existingMatchesSkipped,_that.jobsProcessed,_that.matchesFound,_that.matchesInserted,_that.processingDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'blocked_pairs_count')  int blockedPairsCount, @JsonKey(name: 'client_email')  String clientEmail, @JsonKey(name: 'clients_processed')  int clientsProcessed, @JsonKey(name: 'execution_time_seconds')  double executionTimeSeconds, @JsonKey(name: 'existing_matches_skipped')  int existingMatchesSkipped, @JsonKey(name: 'jobs_processed')  int jobsProcessed, @JsonKey(name: 'matches_found')  int matchesFound, @JsonKey(name: 'matches_inserted')  int matchesInserted, @JsonKey(name: 'processing_date')  String processingDate)  $default,) {final _that = this;
switch (_that) {
case _RankingResult():
return $default(_that.blockedPairsCount,_that.clientEmail,_that.clientsProcessed,_that.executionTimeSeconds,_that.existingMatchesSkipped,_that.jobsProcessed,_that.matchesFound,_that.matchesInserted,_that.processingDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'blocked_pairs_count')  int blockedPairsCount, @JsonKey(name: 'client_email')  String clientEmail, @JsonKey(name: 'clients_processed')  int clientsProcessed, @JsonKey(name: 'execution_time_seconds')  double executionTimeSeconds, @JsonKey(name: 'existing_matches_skipped')  int existingMatchesSkipped, @JsonKey(name: 'jobs_processed')  int jobsProcessed, @JsonKey(name: 'matches_found')  int matchesFound, @JsonKey(name: 'matches_inserted')  int matchesInserted, @JsonKey(name: 'processing_date')  String processingDate)?  $default,) {final _that = this;
switch (_that) {
case _RankingResult() when $default != null:
return $default(_that.blockedPairsCount,_that.clientEmail,_that.clientsProcessed,_that.executionTimeSeconds,_that.existingMatchesSkipped,_that.jobsProcessed,_that.matchesFound,_that.matchesInserted,_that.processingDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingResult implements RankingResult {
  const _RankingResult({@JsonKey(name: 'blocked_pairs_count') required this.blockedPairsCount, @JsonKey(name: 'client_email') required this.clientEmail, @JsonKey(name: 'clients_processed') required this.clientsProcessed, @JsonKey(name: 'execution_time_seconds') required this.executionTimeSeconds, @JsonKey(name: 'existing_matches_skipped') required this.existingMatchesSkipped, @JsonKey(name: 'jobs_processed') required this.jobsProcessed, @JsonKey(name: 'matches_found') required this.matchesFound, @JsonKey(name: 'matches_inserted') required this.matchesInserted, @JsonKey(name: 'processing_date') required this.processingDate});
  factory _RankingResult.fromJson(Map<String, dynamic> json) => _$RankingResultFromJson(json);

/// Number of blocked pairs
@override@JsonKey(name: 'blocked_pairs_count') final  int blockedPairsCount;
/// Client email
@override@JsonKey(name: 'client_email') final  String clientEmail;
/// Number of clients processed
@override@JsonKey(name: 'clients_processed') final  int clientsProcessed;
/// Execution time in seconds
@override@JsonKey(name: 'execution_time_seconds') final  double executionTimeSeconds;
/// Number of existing matches skipped
@override@JsonKey(name: 'existing_matches_skipped') final  int existingMatchesSkipped;
/// Number of jobs processed
@override@JsonKey(name: 'jobs_processed') final  int jobsProcessed;
/// Number of matches found
@override@JsonKey(name: 'matches_found') final  int matchesFound;
/// Number of matches inserted
@override@JsonKey(name: 'matches_inserted') final  int matchesInserted;
/// Processing date
@override@JsonKey(name: 'processing_date') final  String processingDate;

/// Create a copy of RankingResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingResultCopyWith<_RankingResult> get copyWith => __$RankingResultCopyWithImpl<_RankingResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingResult&&(identical(other.blockedPairsCount, blockedPairsCount) || other.blockedPairsCount == blockedPairsCount)&&(identical(other.clientEmail, clientEmail) || other.clientEmail == clientEmail)&&(identical(other.clientsProcessed, clientsProcessed) || other.clientsProcessed == clientsProcessed)&&(identical(other.executionTimeSeconds, executionTimeSeconds) || other.executionTimeSeconds == executionTimeSeconds)&&(identical(other.existingMatchesSkipped, existingMatchesSkipped) || other.existingMatchesSkipped == existingMatchesSkipped)&&(identical(other.jobsProcessed, jobsProcessed) || other.jobsProcessed == jobsProcessed)&&(identical(other.matchesFound, matchesFound) || other.matchesFound == matchesFound)&&(identical(other.matchesInserted, matchesInserted) || other.matchesInserted == matchesInserted)&&(identical(other.processingDate, processingDate) || other.processingDate == processingDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,blockedPairsCount,clientEmail,clientsProcessed,executionTimeSeconds,existingMatchesSkipped,jobsProcessed,matchesFound,matchesInserted,processingDate);

@override
String toString() {
  return 'RankingResult(blockedPairsCount: $blockedPairsCount, clientEmail: $clientEmail, clientsProcessed: $clientsProcessed, executionTimeSeconds: $executionTimeSeconds, existingMatchesSkipped: $existingMatchesSkipped, jobsProcessed: $jobsProcessed, matchesFound: $matchesFound, matchesInserted: $matchesInserted, processingDate: $processingDate)';
}


}

/// @nodoc
abstract mixin class _$RankingResultCopyWith<$Res> implements $RankingResultCopyWith<$Res> {
  factory _$RankingResultCopyWith(_RankingResult value, $Res Function(_RankingResult) _then) = __$RankingResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'blocked_pairs_count') int blockedPairsCount,@JsonKey(name: 'client_email') String clientEmail,@JsonKey(name: 'clients_processed') int clientsProcessed,@JsonKey(name: 'execution_time_seconds') double executionTimeSeconds,@JsonKey(name: 'existing_matches_skipped') int existingMatchesSkipped,@JsonKey(name: 'jobs_processed') int jobsProcessed,@JsonKey(name: 'matches_found') int matchesFound,@JsonKey(name: 'matches_inserted') int matchesInserted,@JsonKey(name: 'processing_date') String processingDate
});




}
/// @nodoc
class __$RankingResultCopyWithImpl<$Res>
    implements _$RankingResultCopyWith<$Res> {
  __$RankingResultCopyWithImpl(this._self, this._then);

  final _RankingResult _self;
  final $Res Function(_RankingResult) _then;

/// Create a copy of RankingResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? blockedPairsCount = null,Object? clientEmail = null,Object? clientsProcessed = null,Object? executionTimeSeconds = null,Object? existingMatchesSkipped = null,Object? jobsProcessed = null,Object? matchesFound = null,Object? matchesInserted = null,Object? processingDate = null,}) {
  return _then(_RankingResult(
blockedPairsCount: null == blockedPairsCount ? _self.blockedPairsCount : blockedPairsCount // ignore: cast_nullable_to_non_nullable
as int,clientEmail: null == clientEmail ? _self.clientEmail : clientEmail // ignore: cast_nullable_to_non_nullable
as String,clientsProcessed: null == clientsProcessed ? _self.clientsProcessed : clientsProcessed // ignore: cast_nullable_to_non_nullable
as int,executionTimeSeconds: null == executionTimeSeconds ? _self.executionTimeSeconds : executionTimeSeconds // ignore: cast_nullable_to_non_nullable
as double,existingMatchesSkipped: null == existingMatchesSkipped ? _self.existingMatchesSkipped : existingMatchesSkipped // ignore: cast_nullable_to_non_nullable
as int,jobsProcessed: null == jobsProcessed ? _self.jobsProcessed : jobsProcessed // ignore: cast_nullable_to_non_nullable
as int,matchesFound: null == matchesFound ? _self.matchesFound : matchesFound // ignore: cast_nullable_to_non_nullable
as int,matchesInserted: null == matchesInserted ? _self.matchesInserted : matchesInserted // ignore: cast_nullable_to_non_nullable
as int,processingDate: null == processingDate ? _self.processingDate : processingDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ApplyToJobResponse {

/// Applied job ID
 int get appliedJobId;/// Applicant email
 String get email;/// Response message
 String get message;/// Success status
 bool get success;/// User application details
 ApplyToJobUser get user;
/// Create a copy of ApplyToJobResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyToJobResponseCopyWith<ApplyToJobResponse> get copyWith => _$ApplyToJobResponseCopyWithImpl<ApplyToJobResponse>(this as ApplyToJobResponse, _$identity);

  /// Serializes this ApplyToJobResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyToJobResponse&&(identical(other.appliedJobId, appliedJobId) || other.appliedJobId == appliedJobId)&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message)&&(identical(other.success, success) || other.success == success)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appliedJobId,email,message,success,user);

@override
String toString() {
  return 'ApplyToJobResponse(appliedJobId: $appliedJobId, email: $email, message: $message, success: $success, user: $user)';
}


}

/// @nodoc
abstract mixin class $ApplyToJobResponseCopyWith<$Res>  {
  factory $ApplyToJobResponseCopyWith(ApplyToJobResponse value, $Res Function(ApplyToJobResponse) _then) = _$ApplyToJobResponseCopyWithImpl;
@useResult
$Res call({
 int appliedJobId, String email, String message, bool success, ApplyToJobUser user
});


$ApplyToJobUserCopyWith<$Res> get user;

}
/// @nodoc
class _$ApplyToJobResponseCopyWithImpl<$Res>
    implements $ApplyToJobResponseCopyWith<$Res> {
  _$ApplyToJobResponseCopyWithImpl(this._self, this._then);

  final ApplyToJobResponse _self;
  final $Res Function(ApplyToJobResponse) _then;

/// Create a copy of ApplyToJobResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appliedJobId = null,Object? email = null,Object? message = null,Object? success = null,Object? user = null,}) {
  return _then(_self.copyWith(
appliedJobId: null == appliedJobId ? _self.appliedJobId : appliedJobId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ApplyToJobUser,
  ));
}
/// Create a copy of ApplyToJobResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplyToJobUserCopyWith<$Res> get user {
  
  return $ApplyToJobUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApplyToJobResponse].
extension ApplyToJobResponsePatterns on ApplyToJobResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplyToJobResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplyToJobResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplyToJobResponse value)  $default,){
final _that = this;
switch (_that) {
case _ApplyToJobResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplyToJobResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ApplyToJobResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int appliedJobId,  String email,  String message,  bool success,  ApplyToJobUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplyToJobResponse() when $default != null:
return $default(_that.appliedJobId,_that.email,_that.message,_that.success,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int appliedJobId,  String email,  String message,  bool success,  ApplyToJobUser user)  $default,) {final _that = this;
switch (_that) {
case _ApplyToJobResponse():
return $default(_that.appliedJobId,_that.email,_that.message,_that.success,_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int appliedJobId,  String email,  String message,  bool success,  ApplyToJobUser user)?  $default,) {final _that = this;
switch (_that) {
case _ApplyToJobResponse() when $default != null:
return $default(_that.appliedJobId,_that.email,_that.message,_that.success,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplyToJobResponse implements ApplyToJobResponse {
  const _ApplyToJobResponse({required this.appliedJobId, required this.email, required this.message, required this.success, required this.user});
  factory _ApplyToJobResponse.fromJson(Map<String, dynamic> json) => _$ApplyToJobResponseFromJson(json);

/// Applied job ID
@override final  int appliedJobId;
/// Applicant email
@override final  String email;
/// Response message
@override final  String message;
/// Success status
@override final  bool success;
/// User application details
@override final  ApplyToJobUser user;

/// Create a copy of ApplyToJobResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyToJobResponseCopyWith<_ApplyToJobResponse> get copyWith => __$ApplyToJobResponseCopyWithImpl<_ApplyToJobResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplyToJobResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyToJobResponse&&(identical(other.appliedJobId, appliedJobId) || other.appliedJobId == appliedJobId)&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message)&&(identical(other.success, success) || other.success == success)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appliedJobId,email,message,success,user);

@override
String toString() {
  return 'ApplyToJobResponse(appliedJobId: $appliedJobId, email: $email, message: $message, success: $success, user: $user)';
}


}

/// @nodoc
abstract mixin class _$ApplyToJobResponseCopyWith<$Res> implements $ApplyToJobResponseCopyWith<$Res> {
  factory _$ApplyToJobResponseCopyWith(_ApplyToJobResponse value, $Res Function(_ApplyToJobResponse) _then) = __$ApplyToJobResponseCopyWithImpl;
@override @useResult
$Res call({
 int appliedJobId, String email, String message, bool success, ApplyToJobUser user
});


@override $ApplyToJobUserCopyWith<$Res> get user;

}
/// @nodoc
class __$ApplyToJobResponseCopyWithImpl<$Res>
    implements _$ApplyToJobResponseCopyWith<$Res> {
  __$ApplyToJobResponseCopyWithImpl(this._self, this._then);

  final _ApplyToJobResponse _self;
  final $Res Function(_ApplyToJobResponse) _then;

/// Create a copy of ApplyToJobResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appliedJobId = null,Object? email = null,Object? message = null,Object? success = null,Object? user = null,}) {
  return _then(_ApplyToJobResponse(
appliedJobId: null == appliedJobId ? _self.appliedJobId : appliedJobId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ApplyToJobUser,
  ));
}

/// Create a copy of ApplyToJobResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplyToJobUserCopyWith<$Res> get user {
  
  return $ApplyToJobUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$ApplyToJobUser {

/// Application date
 String get date;/// Applicant email
 String get email;/// Job applied to
 int get jobApplied;/// Ranking ID
 int get rankingId;
/// Create a copy of ApplyToJobUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyToJobUserCopyWith<ApplyToJobUser> get copyWith => _$ApplyToJobUserCopyWithImpl<ApplyToJobUser>(this as ApplyToJobUser, _$identity);

  /// Serializes this ApplyToJobUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyToJobUser&&(identical(other.date, date) || other.date == date)&&(identical(other.email, email) || other.email == email)&&(identical(other.jobApplied, jobApplied) || other.jobApplied == jobApplied)&&(identical(other.rankingId, rankingId) || other.rankingId == rankingId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,email,jobApplied,rankingId);

@override
String toString() {
  return 'ApplyToJobUser(date: $date, email: $email, jobApplied: $jobApplied, rankingId: $rankingId)';
}


}

/// @nodoc
abstract mixin class $ApplyToJobUserCopyWith<$Res>  {
  factory $ApplyToJobUserCopyWith(ApplyToJobUser value, $Res Function(ApplyToJobUser) _then) = _$ApplyToJobUserCopyWithImpl;
@useResult
$Res call({
 String date, String email, int jobApplied, int rankingId
});




}
/// @nodoc
class _$ApplyToJobUserCopyWithImpl<$Res>
    implements $ApplyToJobUserCopyWith<$Res> {
  _$ApplyToJobUserCopyWithImpl(this._self, this._then);

  final ApplyToJobUser _self;
  final $Res Function(ApplyToJobUser) _then;

/// Create a copy of ApplyToJobUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? email = null,Object? jobApplied = null,Object? rankingId = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,jobApplied: null == jobApplied ? _self.jobApplied : jobApplied // ignore: cast_nullable_to_non_nullable
as int,rankingId: null == rankingId ? _self.rankingId : rankingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplyToJobUser].
extension ApplyToJobUserPatterns on ApplyToJobUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplyToJobUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplyToJobUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplyToJobUser value)  $default,){
final _that = this;
switch (_that) {
case _ApplyToJobUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplyToJobUser value)?  $default,){
final _that = this;
switch (_that) {
case _ApplyToJobUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String email,  int jobApplied,  int rankingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplyToJobUser() when $default != null:
return $default(_that.date,_that.email,_that.jobApplied,_that.rankingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String email,  int jobApplied,  int rankingId)  $default,) {final _that = this;
switch (_that) {
case _ApplyToJobUser():
return $default(_that.date,_that.email,_that.jobApplied,_that.rankingId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String email,  int jobApplied,  int rankingId)?  $default,) {final _that = this;
switch (_that) {
case _ApplyToJobUser() when $default != null:
return $default(_that.date,_that.email,_that.jobApplied,_that.rankingId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplyToJobUser implements ApplyToJobUser {
  const _ApplyToJobUser({required this.date, required this.email, required this.jobApplied, required this.rankingId});
  factory _ApplyToJobUser.fromJson(Map<String, dynamic> json) => _$ApplyToJobUserFromJson(json);

/// Application date
@override final  String date;
/// Applicant email
@override final  String email;
/// Job applied to
@override final  int jobApplied;
/// Ranking ID
@override final  int rankingId;

/// Create a copy of ApplyToJobUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyToJobUserCopyWith<_ApplyToJobUser> get copyWith => __$ApplyToJobUserCopyWithImpl<_ApplyToJobUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplyToJobUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyToJobUser&&(identical(other.date, date) || other.date == date)&&(identical(other.email, email) || other.email == email)&&(identical(other.jobApplied, jobApplied) || other.jobApplied == jobApplied)&&(identical(other.rankingId, rankingId) || other.rankingId == rankingId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,email,jobApplied,rankingId);

@override
String toString() {
  return 'ApplyToJobUser(date: $date, email: $email, jobApplied: $jobApplied, rankingId: $rankingId)';
}


}

/// @nodoc
abstract mixin class _$ApplyToJobUserCopyWith<$Res> implements $ApplyToJobUserCopyWith<$Res> {
  factory _$ApplyToJobUserCopyWith(_ApplyToJobUser value, $Res Function(_ApplyToJobUser) _then) = __$ApplyToJobUserCopyWithImpl;
@override @useResult
$Res call({
 String date, String email, int jobApplied, int rankingId
});




}
/// @nodoc
class __$ApplyToJobUserCopyWithImpl<$Res>
    implements _$ApplyToJobUserCopyWith<$Res> {
  __$ApplyToJobUserCopyWithImpl(this._self, this._then);

  final _ApplyToJobUser _self;
  final $Res Function(_ApplyToJobUser) _then;

/// Create a copy of ApplyToJobUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? email = null,Object? jobApplied = null,Object? rankingId = null,}) {
  return _then(_ApplyToJobUser(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,jobApplied: null == jobApplied ? _self.jobApplied : jobApplied // ignore: cast_nullable_to_non_nullable
as int,rankingId: null == rankingId ? _self.rankingId : rankingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
