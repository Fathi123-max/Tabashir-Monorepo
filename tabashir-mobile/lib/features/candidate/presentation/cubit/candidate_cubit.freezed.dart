// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CandidateState {

 CandidateStatus get status; String get errorMessage; CandidateProfile? get profile; List<CandidateProfile> get allCandidates; List<CandidateProfile> get searchResults; List<String> get resumes; List<String> get jobApplications;
/// Create a copy of CandidateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateStateCopyWith<CandidateState> get copyWith => _$CandidateStateCopyWithImpl<CandidateState>(this as CandidateState, _$identity);

  /// Serializes this CandidateState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.allCandidates, allCandidates)&&const DeepCollectionEquality().equals(other.searchResults, searchResults)&&const DeepCollectionEquality().equals(other.resumes, resumes)&&const DeepCollectionEquality().equals(other.jobApplications, jobApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,profile,const DeepCollectionEquality().hash(allCandidates),const DeepCollectionEquality().hash(searchResults),const DeepCollectionEquality().hash(resumes),const DeepCollectionEquality().hash(jobApplications));

@override
String toString() {
  return 'CandidateState(status: $status, errorMessage: $errorMessage, profile: $profile, allCandidates: $allCandidates, searchResults: $searchResults, resumes: $resumes, jobApplications: $jobApplications)';
}


}

/// @nodoc
abstract mixin class $CandidateStateCopyWith<$Res>  {
  factory $CandidateStateCopyWith(CandidateState value, $Res Function(CandidateState) _then) = _$CandidateStateCopyWithImpl;
@useResult
$Res call({
 CandidateStatus status, String errorMessage, CandidateProfile? profile, List<CandidateProfile> allCandidates, List<CandidateProfile> searchResults, List<String> resumes, List<String> jobApplications
});


$CandidateProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class _$CandidateStateCopyWithImpl<$Res>
    implements $CandidateStateCopyWith<$Res> {
  _$CandidateStateCopyWithImpl(this._self, this._then);

  final CandidateState _self;
  final $Res Function(CandidateState) _then;

/// Create a copy of CandidateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? profile = freezed,Object? allCandidates = null,Object? searchResults = null,Object? resumes = null,Object? jobApplications = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidateStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CandidateProfile?,allCandidates: null == allCandidates ? _self.allCandidates : allCandidates // ignore: cast_nullable_to_non_nullable
as List<CandidateProfile>,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<CandidateProfile>,resumes: null == resumes ? _self.resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<String>,jobApplications: null == jobApplications ? _self.jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of CandidateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CandidateProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $CandidateProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [CandidateState].
extension CandidateStatePatterns on CandidateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidateState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidateState value)  $default,){
final _that = this;
switch (_that) {
case _CandidateState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidateState value)?  $default,){
final _that = this;
switch (_that) {
case _CandidateState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CandidateStatus status,  String errorMessage,  CandidateProfile? profile,  List<CandidateProfile> allCandidates,  List<CandidateProfile> searchResults,  List<String> resumes,  List<String> jobApplications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidateState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.profile,_that.allCandidates,_that.searchResults,_that.resumes,_that.jobApplications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CandidateStatus status,  String errorMessage,  CandidateProfile? profile,  List<CandidateProfile> allCandidates,  List<CandidateProfile> searchResults,  List<String> resumes,  List<String> jobApplications)  $default,) {final _that = this;
switch (_that) {
case _CandidateState():
return $default(_that.status,_that.errorMessage,_that.profile,_that.allCandidates,_that.searchResults,_that.resumes,_that.jobApplications);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CandidateStatus status,  String errorMessage,  CandidateProfile? profile,  List<CandidateProfile> allCandidates,  List<CandidateProfile> searchResults,  List<String> resumes,  List<String> jobApplications)?  $default,) {final _that = this;
switch (_that) {
case _CandidateState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.profile,_that.allCandidates,_that.searchResults,_that.resumes,_that.jobApplications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CandidateState implements CandidateState {
  const _CandidateState({this.status = CandidateStatus.initial, this.errorMessage = '', this.profile, final  List<CandidateProfile> allCandidates = const [], final  List<CandidateProfile> searchResults = const [], final  List<String> resumes = const [], final  List<String> jobApplications = const []}): _allCandidates = allCandidates,_searchResults = searchResults,_resumes = resumes,_jobApplications = jobApplications;
  factory _CandidateState.fromJson(Map<String, dynamic> json) => _$CandidateStateFromJson(json);

@override@JsonKey() final  CandidateStatus status;
@override@JsonKey() final  String errorMessage;
@override final  CandidateProfile? profile;
 final  List<CandidateProfile> _allCandidates;
@override@JsonKey() List<CandidateProfile> get allCandidates {
  if (_allCandidates is EqualUnmodifiableListView) return _allCandidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allCandidates);
}

 final  List<CandidateProfile> _searchResults;
@override@JsonKey() List<CandidateProfile> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}

 final  List<String> _resumes;
@override@JsonKey() List<String> get resumes {
  if (_resumes is EqualUnmodifiableListView) return _resumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resumes);
}

 final  List<String> _jobApplications;
@override@JsonKey() List<String> get jobApplications {
  if (_jobApplications is EqualUnmodifiableListView) return _jobApplications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobApplications);
}


/// Create a copy of CandidateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateStateCopyWith<_CandidateState> get copyWith => __$CandidateStateCopyWithImpl<_CandidateState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other._allCandidates, _allCandidates)&&const DeepCollectionEquality().equals(other._searchResults, _searchResults)&&const DeepCollectionEquality().equals(other._resumes, _resumes)&&const DeepCollectionEquality().equals(other._jobApplications, _jobApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,profile,const DeepCollectionEquality().hash(_allCandidates),const DeepCollectionEquality().hash(_searchResults),const DeepCollectionEquality().hash(_resumes),const DeepCollectionEquality().hash(_jobApplications));

@override
String toString() {
  return 'CandidateState(status: $status, errorMessage: $errorMessage, profile: $profile, allCandidates: $allCandidates, searchResults: $searchResults, resumes: $resumes, jobApplications: $jobApplications)';
}


}

/// @nodoc
abstract mixin class _$CandidateStateCopyWith<$Res> implements $CandidateStateCopyWith<$Res> {
  factory _$CandidateStateCopyWith(_CandidateState value, $Res Function(_CandidateState) _then) = __$CandidateStateCopyWithImpl;
@override @useResult
$Res call({
 CandidateStatus status, String errorMessage, CandidateProfile? profile, List<CandidateProfile> allCandidates, List<CandidateProfile> searchResults, List<String> resumes, List<String> jobApplications
});


@override $CandidateProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$CandidateStateCopyWithImpl<$Res>
    implements _$CandidateStateCopyWith<$Res> {
  __$CandidateStateCopyWithImpl(this._self, this._then);

  final _CandidateState _self;
  final $Res Function(_CandidateState) _then;

/// Create a copy of CandidateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? profile = freezed,Object? allCandidates = null,Object? searchResults = null,Object? resumes = null,Object? jobApplications = null,}) {
  return _then(_CandidateState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidateStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CandidateProfile?,allCandidates: null == allCandidates ? _self._allCandidates : allCandidates // ignore: cast_nullable_to_non_nullable
as List<CandidateProfile>,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<CandidateProfile>,resumes: null == resumes ? _self._resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<String>,jobApplications: null == jobApplications ? _self._jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of CandidateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CandidateProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $CandidateProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
