// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_job_apply_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiJobApplyState {

// ============ Resume Selection ============
/// List of available resumes
 List<ResumeSelectionModel> get resumes;/// Currently selected resume ID
 String? get selectedResumeId;/// Loading state
 bool get isLoading;/// Submitting state
 bool get isSubmitting;/// Creating new resume state
 bool get isCreatingNew;/// Error state
 bool get hasError;/// Error message
 String get errorMessage;// ============ Target Roles ============
/// List of available roles to select from
 List<TargetRoleModel> get availableRoles;/// Currently selected roles
 List<TargetRoleModel> get selectedRoles;/// Current custom role input
 String get customRoleTitle;/// AI suggestion for additional role
 TargetRoleModel? get aiSuggestionRole;/// Submitting state
 bool get isSubmittingRole;/// Error state
 bool get hasErrorRole;/// Error message
 String get errorMessageRole;// ============ Location Preferences ============
/// List of available locations to select from
 List<LocationPreferenceModel> get availableLocations;/// Currently selected locations
 List<LocationPreferenceModel> get selectedLocations;/// Current dropdown selection
 String get dropdownSelection;/// AI suggestion for additional location
 LocationPreferenceModel? get aiSuggestionLocation;/// Submitting state
 bool get isSubmittingLocation;/// Error state
 bool get hasErrorLocation;/// Error message
 String get errorMessageLocation;// ============ Personal Details ============
/// Selected nationality
/// Can be null if not set by user
/// When null, should be initialized from user profile or config
 String? get nationality;/// Selected gender
 Gender? get gender;/// Whether visa sponsorship is required
 bool get requiresVisaSponsorship;/// Submitting state
 bool get isSubmittingDetails;/// Error state
 bool get hasErrorDetails;/// Error message
 String get errorMessageDetails;// ============ Final Submission ============
/// Result of the job application submission
 JobsMatchResponse? get submissionResult;/// Submitting application state
 bool get isSubmittingApplication;/// Submission error message
 String get submissionError;
/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiJobApplyStateCopyWith<AiJobApplyState> get copyWith => _$AiJobApplyStateCopyWithImpl<AiJobApplyState>(this as AiJobApplyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiJobApplyState&&const DeepCollectionEquality().equals(other.resumes, resumes)&&(identical(other.selectedResumeId, selectedResumeId) || other.selectedResumeId == selectedResumeId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isCreatingNew, isCreatingNew) || other.isCreatingNew == isCreatingNew)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.availableRoles, availableRoles)&&const DeepCollectionEquality().equals(other.selectedRoles, selectedRoles)&&(identical(other.customRoleTitle, customRoleTitle) || other.customRoleTitle == customRoleTitle)&&(identical(other.aiSuggestionRole, aiSuggestionRole) || other.aiSuggestionRole == aiSuggestionRole)&&(identical(other.isSubmittingRole, isSubmittingRole) || other.isSubmittingRole == isSubmittingRole)&&(identical(other.hasErrorRole, hasErrorRole) || other.hasErrorRole == hasErrorRole)&&(identical(other.errorMessageRole, errorMessageRole) || other.errorMessageRole == errorMessageRole)&&const DeepCollectionEquality().equals(other.availableLocations, availableLocations)&&const DeepCollectionEquality().equals(other.selectedLocations, selectedLocations)&&(identical(other.dropdownSelection, dropdownSelection) || other.dropdownSelection == dropdownSelection)&&(identical(other.aiSuggestionLocation, aiSuggestionLocation) || other.aiSuggestionLocation == aiSuggestionLocation)&&(identical(other.isSubmittingLocation, isSubmittingLocation) || other.isSubmittingLocation == isSubmittingLocation)&&(identical(other.hasErrorLocation, hasErrorLocation) || other.hasErrorLocation == hasErrorLocation)&&(identical(other.errorMessageLocation, errorMessageLocation) || other.errorMessageLocation == errorMessageLocation)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.requiresVisaSponsorship, requiresVisaSponsorship) || other.requiresVisaSponsorship == requiresVisaSponsorship)&&(identical(other.isSubmittingDetails, isSubmittingDetails) || other.isSubmittingDetails == isSubmittingDetails)&&(identical(other.hasErrorDetails, hasErrorDetails) || other.hasErrorDetails == hasErrorDetails)&&(identical(other.errorMessageDetails, errorMessageDetails) || other.errorMessageDetails == errorMessageDetails)&&(identical(other.submissionResult, submissionResult) || other.submissionResult == submissionResult)&&(identical(other.isSubmittingApplication, isSubmittingApplication) || other.isSubmittingApplication == isSubmittingApplication)&&(identical(other.submissionError, submissionError) || other.submissionError == submissionError));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(resumes),selectedResumeId,isLoading,isSubmitting,isCreatingNew,hasError,errorMessage,const DeepCollectionEquality().hash(availableRoles),const DeepCollectionEquality().hash(selectedRoles),customRoleTitle,aiSuggestionRole,isSubmittingRole,hasErrorRole,errorMessageRole,const DeepCollectionEquality().hash(availableLocations),const DeepCollectionEquality().hash(selectedLocations),dropdownSelection,aiSuggestionLocation,isSubmittingLocation,hasErrorLocation,errorMessageLocation,nationality,gender,requiresVisaSponsorship,isSubmittingDetails,hasErrorDetails,errorMessageDetails,submissionResult,isSubmittingApplication,submissionError]);

@override
String toString() {
  return 'AiJobApplyState(resumes: $resumes, selectedResumeId: $selectedResumeId, isLoading: $isLoading, isSubmitting: $isSubmitting, isCreatingNew: $isCreatingNew, hasError: $hasError, errorMessage: $errorMessage, availableRoles: $availableRoles, selectedRoles: $selectedRoles, customRoleTitle: $customRoleTitle, aiSuggestionRole: $aiSuggestionRole, isSubmittingRole: $isSubmittingRole, hasErrorRole: $hasErrorRole, errorMessageRole: $errorMessageRole, availableLocations: $availableLocations, selectedLocations: $selectedLocations, dropdownSelection: $dropdownSelection, aiSuggestionLocation: $aiSuggestionLocation, isSubmittingLocation: $isSubmittingLocation, hasErrorLocation: $hasErrorLocation, errorMessageLocation: $errorMessageLocation, nationality: $nationality, gender: $gender, requiresVisaSponsorship: $requiresVisaSponsorship, isSubmittingDetails: $isSubmittingDetails, hasErrorDetails: $hasErrorDetails, errorMessageDetails: $errorMessageDetails, submissionResult: $submissionResult, isSubmittingApplication: $isSubmittingApplication, submissionError: $submissionError)';
}


}

/// @nodoc
abstract mixin class $AiJobApplyStateCopyWith<$Res>  {
  factory $AiJobApplyStateCopyWith(AiJobApplyState value, $Res Function(AiJobApplyState) _then) = _$AiJobApplyStateCopyWithImpl;
@useResult
$Res call({
 List<ResumeSelectionModel> resumes, String? selectedResumeId, bool isLoading, bool isSubmitting, bool isCreatingNew, bool hasError, String errorMessage, List<TargetRoleModel> availableRoles, List<TargetRoleModel> selectedRoles, String customRoleTitle, TargetRoleModel? aiSuggestionRole, bool isSubmittingRole, bool hasErrorRole, String errorMessageRole, List<LocationPreferenceModel> availableLocations, List<LocationPreferenceModel> selectedLocations, String dropdownSelection, LocationPreferenceModel? aiSuggestionLocation, bool isSubmittingLocation, bool hasErrorLocation, String errorMessageLocation, String? nationality, Gender? gender, bool requiresVisaSponsorship, bool isSubmittingDetails, bool hasErrorDetails, String errorMessageDetails, JobsMatchResponse? submissionResult, bool isSubmittingApplication, String submissionError
});


$TargetRoleModelCopyWith<$Res>? get aiSuggestionRole;$LocationPreferenceModelCopyWith<$Res>? get aiSuggestionLocation;$JobsMatchResponseCopyWith<$Res>? get submissionResult;

}
/// @nodoc
class _$AiJobApplyStateCopyWithImpl<$Res>
    implements $AiJobApplyStateCopyWith<$Res> {
  _$AiJobApplyStateCopyWithImpl(this._self, this._then);

  final AiJobApplyState _self;
  final $Res Function(AiJobApplyState) _then;

/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resumes = null,Object? selectedResumeId = freezed,Object? isLoading = null,Object? isSubmitting = null,Object? isCreatingNew = null,Object? hasError = null,Object? errorMessage = null,Object? availableRoles = null,Object? selectedRoles = null,Object? customRoleTitle = null,Object? aiSuggestionRole = freezed,Object? isSubmittingRole = null,Object? hasErrorRole = null,Object? errorMessageRole = null,Object? availableLocations = null,Object? selectedLocations = null,Object? dropdownSelection = null,Object? aiSuggestionLocation = freezed,Object? isSubmittingLocation = null,Object? hasErrorLocation = null,Object? errorMessageLocation = null,Object? nationality = freezed,Object? gender = freezed,Object? requiresVisaSponsorship = null,Object? isSubmittingDetails = null,Object? hasErrorDetails = null,Object? errorMessageDetails = null,Object? submissionResult = freezed,Object? isSubmittingApplication = null,Object? submissionError = null,}) {
  return _then(_self.copyWith(
resumes: null == resumes ? _self.resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeSelectionModel>,selectedResumeId: freezed == selectedResumeId ? _self.selectedResumeId : selectedResumeId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isCreatingNew: null == isCreatingNew ? _self.isCreatingNew : isCreatingNew // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,availableRoles: null == availableRoles ? _self.availableRoles : availableRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,selectedRoles: null == selectedRoles ? _self.selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,customRoleTitle: null == customRoleTitle ? _self.customRoleTitle : customRoleTitle // ignore: cast_nullable_to_non_nullable
as String,aiSuggestionRole: freezed == aiSuggestionRole ? _self.aiSuggestionRole : aiSuggestionRole // ignore: cast_nullable_to_non_nullable
as TargetRoleModel?,isSubmittingRole: null == isSubmittingRole ? _self.isSubmittingRole : isSubmittingRole // ignore: cast_nullable_to_non_nullable
as bool,hasErrorRole: null == hasErrorRole ? _self.hasErrorRole : hasErrorRole // ignore: cast_nullable_to_non_nullable
as bool,errorMessageRole: null == errorMessageRole ? _self.errorMessageRole : errorMessageRole // ignore: cast_nullable_to_non_nullable
as String,availableLocations: null == availableLocations ? _self.availableLocations : availableLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,selectedLocations: null == selectedLocations ? _self.selectedLocations : selectedLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,dropdownSelection: null == dropdownSelection ? _self.dropdownSelection : dropdownSelection // ignore: cast_nullable_to_non_nullable
as String,aiSuggestionLocation: freezed == aiSuggestionLocation ? _self.aiSuggestionLocation : aiSuggestionLocation // ignore: cast_nullable_to_non_nullable
as LocationPreferenceModel?,isSubmittingLocation: null == isSubmittingLocation ? _self.isSubmittingLocation : isSubmittingLocation // ignore: cast_nullable_to_non_nullable
as bool,hasErrorLocation: null == hasErrorLocation ? _self.hasErrorLocation : hasErrorLocation // ignore: cast_nullable_to_non_nullable
as bool,errorMessageLocation: null == errorMessageLocation ? _self.errorMessageLocation : errorMessageLocation // ignore: cast_nullable_to_non_nullable
as String,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,requiresVisaSponsorship: null == requiresVisaSponsorship ? _self.requiresVisaSponsorship : requiresVisaSponsorship // ignore: cast_nullable_to_non_nullable
as bool,isSubmittingDetails: null == isSubmittingDetails ? _self.isSubmittingDetails : isSubmittingDetails // ignore: cast_nullable_to_non_nullable
as bool,hasErrorDetails: null == hasErrorDetails ? _self.hasErrorDetails : hasErrorDetails // ignore: cast_nullable_to_non_nullable
as bool,errorMessageDetails: null == errorMessageDetails ? _self.errorMessageDetails : errorMessageDetails // ignore: cast_nullable_to_non_nullable
as String,submissionResult: freezed == submissionResult ? _self.submissionResult : submissionResult // ignore: cast_nullable_to_non_nullable
as JobsMatchResponse?,isSubmittingApplication: null == isSubmittingApplication ? _self.isSubmittingApplication : isSubmittingApplication // ignore: cast_nullable_to_non_nullable
as bool,submissionError: null == submissionError ? _self.submissionError : submissionError // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetRoleModelCopyWith<$Res>? get aiSuggestionRole {
    if (_self.aiSuggestionRole == null) {
    return null;
  }

  return $TargetRoleModelCopyWith<$Res>(_self.aiSuggestionRole!, (value) {
    return _then(_self.copyWith(aiSuggestionRole: value));
  });
}/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPreferenceModelCopyWith<$Res>? get aiSuggestionLocation {
    if (_self.aiSuggestionLocation == null) {
    return null;
  }

  return $LocationPreferenceModelCopyWith<$Res>(_self.aiSuggestionLocation!, (value) {
    return _then(_self.copyWith(aiSuggestionLocation: value));
  });
}/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobsMatchResponseCopyWith<$Res>? get submissionResult {
    if (_self.submissionResult == null) {
    return null;
  }

  return $JobsMatchResponseCopyWith<$Res>(_self.submissionResult!, (value) {
    return _then(_self.copyWith(submissionResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiJobApplyState].
extension AiJobApplyStatePatterns on AiJobApplyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiJobApplyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiJobApplyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiJobApplyState value)  $default,){
final _that = this;
switch (_that) {
case _AiJobApplyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiJobApplyState value)?  $default,){
final _that = this;
switch (_that) {
case _AiJobApplyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ResumeSelectionModel> resumes,  String? selectedResumeId,  bool isLoading,  bool isSubmitting,  bool isCreatingNew,  bool hasError,  String errorMessage,  List<TargetRoleModel> availableRoles,  List<TargetRoleModel> selectedRoles,  String customRoleTitle,  TargetRoleModel? aiSuggestionRole,  bool isSubmittingRole,  bool hasErrorRole,  String errorMessageRole,  List<LocationPreferenceModel> availableLocations,  List<LocationPreferenceModel> selectedLocations,  String dropdownSelection,  LocationPreferenceModel? aiSuggestionLocation,  bool isSubmittingLocation,  bool hasErrorLocation,  String errorMessageLocation,  String? nationality,  Gender? gender,  bool requiresVisaSponsorship,  bool isSubmittingDetails,  bool hasErrorDetails,  String errorMessageDetails,  JobsMatchResponse? submissionResult,  bool isSubmittingApplication,  String submissionError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiJobApplyState() when $default != null:
return $default(_that.resumes,_that.selectedResumeId,_that.isLoading,_that.isSubmitting,_that.isCreatingNew,_that.hasError,_that.errorMessage,_that.availableRoles,_that.selectedRoles,_that.customRoleTitle,_that.aiSuggestionRole,_that.isSubmittingRole,_that.hasErrorRole,_that.errorMessageRole,_that.availableLocations,_that.selectedLocations,_that.dropdownSelection,_that.aiSuggestionLocation,_that.isSubmittingLocation,_that.hasErrorLocation,_that.errorMessageLocation,_that.nationality,_that.gender,_that.requiresVisaSponsorship,_that.isSubmittingDetails,_that.hasErrorDetails,_that.errorMessageDetails,_that.submissionResult,_that.isSubmittingApplication,_that.submissionError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ResumeSelectionModel> resumes,  String? selectedResumeId,  bool isLoading,  bool isSubmitting,  bool isCreatingNew,  bool hasError,  String errorMessage,  List<TargetRoleModel> availableRoles,  List<TargetRoleModel> selectedRoles,  String customRoleTitle,  TargetRoleModel? aiSuggestionRole,  bool isSubmittingRole,  bool hasErrorRole,  String errorMessageRole,  List<LocationPreferenceModel> availableLocations,  List<LocationPreferenceModel> selectedLocations,  String dropdownSelection,  LocationPreferenceModel? aiSuggestionLocation,  bool isSubmittingLocation,  bool hasErrorLocation,  String errorMessageLocation,  String? nationality,  Gender? gender,  bool requiresVisaSponsorship,  bool isSubmittingDetails,  bool hasErrorDetails,  String errorMessageDetails,  JobsMatchResponse? submissionResult,  bool isSubmittingApplication,  String submissionError)  $default,) {final _that = this;
switch (_that) {
case _AiJobApplyState():
return $default(_that.resumes,_that.selectedResumeId,_that.isLoading,_that.isSubmitting,_that.isCreatingNew,_that.hasError,_that.errorMessage,_that.availableRoles,_that.selectedRoles,_that.customRoleTitle,_that.aiSuggestionRole,_that.isSubmittingRole,_that.hasErrorRole,_that.errorMessageRole,_that.availableLocations,_that.selectedLocations,_that.dropdownSelection,_that.aiSuggestionLocation,_that.isSubmittingLocation,_that.hasErrorLocation,_that.errorMessageLocation,_that.nationality,_that.gender,_that.requiresVisaSponsorship,_that.isSubmittingDetails,_that.hasErrorDetails,_that.errorMessageDetails,_that.submissionResult,_that.isSubmittingApplication,_that.submissionError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ResumeSelectionModel> resumes,  String? selectedResumeId,  bool isLoading,  bool isSubmitting,  bool isCreatingNew,  bool hasError,  String errorMessage,  List<TargetRoleModel> availableRoles,  List<TargetRoleModel> selectedRoles,  String customRoleTitle,  TargetRoleModel? aiSuggestionRole,  bool isSubmittingRole,  bool hasErrorRole,  String errorMessageRole,  List<LocationPreferenceModel> availableLocations,  List<LocationPreferenceModel> selectedLocations,  String dropdownSelection,  LocationPreferenceModel? aiSuggestionLocation,  bool isSubmittingLocation,  bool hasErrorLocation,  String errorMessageLocation,  String? nationality,  Gender? gender,  bool requiresVisaSponsorship,  bool isSubmittingDetails,  bool hasErrorDetails,  String errorMessageDetails,  JobsMatchResponse? submissionResult,  bool isSubmittingApplication,  String submissionError)?  $default,) {final _that = this;
switch (_that) {
case _AiJobApplyState() when $default != null:
return $default(_that.resumes,_that.selectedResumeId,_that.isLoading,_that.isSubmitting,_that.isCreatingNew,_that.hasError,_that.errorMessage,_that.availableRoles,_that.selectedRoles,_that.customRoleTitle,_that.aiSuggestionRole,_that.isSubmittingRole,_that.hasErrorRole,_that.errorMessageRole,_that.availableLocations,_that.selectedLocations,_that.dropdownSelection,_that.aiSuggestionLocation,_that.isSubmittingLocation,_that.hasErrorLocation,_that.errorMessageLocation,_that.nationality,_that.gender,_that.requiresVisaSponsorship,_that.isSubmittingDetails,_that.hasErrorDetails,_that.errorMessageDetails,_that.submissionResult,_that.isSubmittingApplication,_that.submissionError);case _:
  return null;

}
}

}

/// @nodoc


class _AiJobApplyState implements AiJobApplyState {
  const _AiJobApplyState({final  List<ResumeSelectionModel> resumes = const [], this.selectedResumeId, this.isLoading = false, this.isSubmitting = false, this.isCreatingNew = false, this.hasError = false, this.errorMessage = '', final  List<TargetRoleModel> availableRoles = const [], final  List<TargetRoleModel> selectedRoles = const [], this.customRoleTitle = '', this.aiSuggestionRole, this.isSubmittingRole = false, this.hasErrorRole = false, this.errorMessageRole = '', final  List<LocationPreferenceModel> availableLocations = const [], final  List<LocationPreferenceModel> selectedLocations = const [], this.dropdownSelection = '', this.aiSuggestionLocation, this.isSubmittingLocation = false, this.hasErrorLocation = false, this.errorMessageLocation = '', this.nationality, this.gender, this.requiresVisaSponsorship = false, this.isSubmittingDetails = false, this.hasErrorDetails = false, this.errorMessageDetails = '', this.submissionResult, this.isSubmittingApplication = false, this.submissionError = ''}): _resumes = resumes,_availableRoles = availableRoles,_selectedRoles = selectedRoles,_availableLocations = availableLocations,_selectedLocations = selectedLocations;
  

// ============ Resume Selection ============
/// List of available resumes
 final  List<ResumeSelectionModel> _resumes;
// ============ Resume Selection ============
/// List of available resumes
@override@JsonKey() List<ResumeSelectionModel> get resumes {
  if (_resumes is EqualUnmodifiableListView) return _resumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resumes);
}

/// Currently selected resume ID
@override final  String? selectedResumeId;
/// Loading state
@override@JsonKey() final  bool isLoading;
/// Submitting state
@override@JsonKey() final  bool isSubmitting;
/// Creating new resume state
@override@JsonKey() final  bool isCreatingNew;
/// Error state
@override@JsonKey() final  bool hasError;
/// Error message
@override@JsonKey() final  String errorMessage;
// ============ Target Roles ============
/// List of available roles to select from
 final  List<TargetRoleModel> _availableRoles;
// ============ Target Roles ============
/// List of available roles to select from
@override@JsonKey() List<TargetRoleModel> get availableRoles {
  if (_availableRoles is EqualUnmodifiableListView) return _availableRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableRoles);
}

/// Currently selected roles
 final  List<TargetRoleModel> _selectedRoles;
/// Currently selected roles
@override@JsonKey() List<TargetRoleModel> get selectedRoles {
  if (_selectedRoles is EqualUnmodifiableListView) return _selectedRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedRoles);
}

/// Current custom role input
@override@JsonKey() final  String customRoleTitle;
/// AI suggestion for additional role
@override final  TargetRoleModel? aiSuggestionRole;
/// Submitting state
@override@JsonKey() final  bool isSubmittingRole;
/// Error state
@override@JsonKey() final  bool hasErrorRole;
/// Error message
@override@JsonKey() final  String errorMessageRole;
// ============ Location Preferences ============
/// List of available locations to select from
 final  List<LocationPreferenceModel> _availableLocations;
// ============ Location Preferences ============
/// List of available locations to select from
@override@JsonKey() List<LocationPreferenceModel> get availableLocations {
  if (_availableLocations is EqualUnmodifiableListView) return _availableLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableLocations);
}

/// Currently selected locations
 final  List<LocationPreferenceModel> _selectedLocations;
/// Currently selected locations
@override@JsonKey() List<LocationPreferenceModel> get selectedLocations {
  if (_selectedLocations is EqualUnmodifiableListView) return _selectedLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedLocations);
}

/// Current dropdown selection
@override@JsonKey() final  String dropdownSelection;
/// AI suggestion for additional location
@override final  LocationPreferenceModel? aiSuggestionLocation;
/// Submitting state
@override@JsonKey() final  bool isSubmittingLocation;
/// Error state
@override@JsonKey() final  bool hasErrorLocation;
/// Error message
@override@JsonKey() final  String errorMessageLocation;
// ============ Personal Details ============
/// Selected nationality
/// Can be null if not set by user
/// When null, should be initialized from user profile or config
@override final  String? nationality;
/// Selected gender
@override final  Gender? gender;
/// Whether visa sponsorship is required
@override@JsonKey() final  bool requiresVisaSponsorship;
/// Submitting state
@override@JsonKey() final  bool isSubmittingDetails;
/// Error state
@override@JsonKey() final  bool hasErrorDetails;
/// Error message
@override@JsonKey() final  String errorMessageDetails;
// ============ Final Submission ============
/// Result of the job application submission
@override final  JobsMatchResponse? submissionResult;
/// Submitting application state
@override@JsonKey() final  bool isSubmittingApplication;
/// Submission error message
@override@JsonKey() final  String submissionError;

/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiJobApplyStateCopyWith<_AiJobApplyState> get copyWith => __$AiJobApplyStateCopyWithImpl<_AiJobApplyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiJobApplyState&&const DeepCollectionEquality().equals(other._resumes, _resumes)&&(identical(other.selectedResumeId, selectedResumeId) || other.selectedResumeId == selectedResumeId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isCreatingNew, isCreatingNew) || other.isCreatingNew == isCreatingNew)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._availableRoles, _availableRoles)&&const DeepCollectionEquality().equals(other._selectedRoles, _selectedRoles)&&(identical(other.customRoleTitle, customRoleTitle) || other.customRoleTitle == customRoleTitle)&&(identical(other.aiSuggestionRole, aiSuggestionRole) || other.aiSuggestionRole == aiSuggestionRole)&&(identical(other.isSubmittingRole, isSubmittingRole) || other.isSubmittingRole == isSubmittingRole)&&(identical(other.hasErrorRole, hasErrorRole) || other.hasErrorRole == hasErrorRole)&&(identical(other.errorMessageRole, errorMessageRole) || other.errorMessageRole == errorMessageRole)&&const DeepCollectionEquality().equals(other._availableLocations, _availableLocations)&&const DeepCollectionEquality().equals(other._selectedLocations, _selectedLocations)&&(identical(other.dropdownSelection, dropdownSelection) || other.dropdownSelection == dropdownSelection)&&(identical(other.aiSuggestionLocation, aiSuggestionLocation) || other.aiSuggestionLocation == aiSuggestionLocation)&&(identical(other.isSubmittingLocation, isSubmittingLocation) || other.isSubmittingLocation == isSubmittingLocation)&&(identical(other.hasErrorLocation, hasErrorLocation) || other.hasErrorLocation == hasErrorLocation)&&(identical(other.errorMessageLocation, errorMessageLocation) || other.errorMessageLocation == errorMessageLocation)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.requiresVisaSponsorship, requiresVisaSponsorship) || other.requiresVisaSponsorship == requiresVisaSponsorship)&&(identical(other.isSubmittingDetails, isSubmittingDetails) || other.isSubmittingDetails == isSubmittingDetails)&&(identical(other.hasErrorDetails, hasErrorDetails) || other.hasErrorDetails == hasErrorDetails)&&(identical(other.errorMessageDetails, errorMessageDetails) || other.errorMessageDetails == errorMessageDetails)&&(identical(other.submissionResult, submissionResult) || other.submissionResult == submissionResult)&&(identical(other.isSubmittingApplication, isSubmittingApplication) || other.isSubmittingApplication == isSubmittingApplication)&&(identical(other.submissionError, submissionError) || other.submissionError == submissionError));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_resumes),selectedResumeId,isLoading,isSubmitting,isCreatingNew,hasError,errorMessage,const DeepCollectionEquality().hash(_availableRoles),const DeepCollectionEquality().hash(_selectedRoles),customRoleTitle,aiSuggestionRole,isSubmittingRole,hasErrorRole,errorMessageRole,const DeepCollectionEquality().hash(_availableLocations),const DeepCollectionEquality().hash(_selectedLocations),dropdownSelection,aiSuggestionLocation,isSubmittingLocation,hasErrorLocation,errorMessageLocation,nationality,gender,requiresVisaSponsorship,isSubmittingDetails,hasErrorDetails,errorMessageDetails,submissionResult,isSubmittingApplication,submissionError]);

@override
String toString() {
  return 'AiJobApplyState(resumes: $resumes, selectedResumeId: $selectedResumeId, isLoading: $isLoading, isSubmitting: $isSubmitting, isCreatingNew: $isCreatingNew, hasError: $hasError, errorMessage: $errorMessage, availableRoles: $availableRoles, selectedRoles: $selectedRoles, customRoleTitle: $customRoleTitle, aiSuggestionRole: $aiSuggestionRole, isSubmittingRole: $isSubmittingRole, hasErrorRole: $hasErrorRole, errorMessageRole: $errorMessageRole, availableLocations: $availableLocations, selectedLocations: $selectedLocations, dropdownSelection: $dropdownSelection, aiSuggestionLocation: $aiSuggestionLocation, isSubmittingLocation: $isSubmittingLocation, hasErrorLocation: $hasErrorLocation, errorMessageLocation: $errorMessageLocation, nationality: $nationality, gender: $gender, requiresVisaSponsorship: $requiresVisaSponsorship, isSubmittingDetails: $isSubmittingDetails, hasErrorDetails: $hasErrorDetails, errorMessageDetails: $errorMessageDetails, submissionResult: $submissionResult, isSubmittingApplication: $isSubmittingApplication, submissionError: $submissionError)';
}


}

/// @nodoc
abstract mixin class _$AiJobApplyStateCopyWith<$Res> implements $AiJobApplyStateCopyWith<$Res> {
  factory _$AiJobApplyStateCopyWith(_AiJobApplyState value, $Res Function(_AiJobApplyState) _then) = __$AiJobApplyStateCopyWithImpl;
@override @useResult
$Res call({
 List<ResumeSelectionModel> resumes, String? selectedResumeId, bool isLoading, bool isSubmitting, bool isCreatingNew, bool hasError, String errorMessage, List<TargetRoleModel> availableRoles, List<TargetRoleModel> selectedRoles, String customRoleTitle, TargetRoleModel? aiSuggestionRole, bool isSubmittingRole, bool hasErrorRole, String errorMessageRole, List<LocationPreferenceModel> availableLocations, List<LocationPreferenceModel> selectedLocations, String dropdownSelection, LocationPreferenceModel? aiSuggestionLocation, bool isSubmittingLocation, bool hasErrorLocation, String errorMessageLocation, String? nationality, Gender? gender, bool requiresVisaSponsorship, bool isSubmittingDetails, bool hasErrorDetails, String errorMessageDetails, JobsMatchResponse? submissionResult, bool isSubmittingApplication, String submissionError
});


@override $TargetRoleModelCopyWith<$Res>? get aiSuggestionRole;@override $LocationPreferenceModelCopyWith<$Res>? get aiSuggestionLocation;@override $JobsMatchResponseCopyWith<$Res>? get submissionResult;

}
/// @nodoc
class __$AiJobApplyStateCopyWithImpl<$Res>
    implements _$AiJobApplyStateCopyWith<$Res> {
  __$AiJobApplyStateCopyWithImpl(this._self, this._then);

  final _AiJobApplyState _self;
  final $Res Function(_AiJobApplyState) _then;

/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resumes = null,Object? selectedResumeId = freezed,Object? isLoading = null,Object? isSubmitting = null,Object? isCreatingNew = null,Object? hasError = null,Object? errorMessage = null,Object? availableRoles = null,Object? selectedRoles = null,Object? customRoleTitle = null,Object? aiSuggestionRole = freezed,Object? isSubmittingRole = null,Object? hasErrorRole = null,Object? errorMessageRole = null,Object? availableLocations = null,Object? selectedLocations = null,Object? dropdownSelection = null,Object? aiSuggestionLocation = freezed,Object? isSubmittingLocation = null,Object? hasErrorLocation = null,Object? errorMessageLocation = null,Object? nationality = freezed,Object? gender = freezed,Object? requiresVisaSponsorship = null,Object? isSubmittingDetails = null,Object? hasErrorDetails = null,Object? errorMessageDetails = null,Object? submissionResult = freezed,Object? isSubmittingApplication = null,Object? submissionError = null,}) {
  return _then(_AiJobApplyState(
resumes: null == resumes ? _self._resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeSelectionModel>,selectedResumeId: freezed == selectedResumeId ? _self.selectedResumeId : selectedResumeId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isCreatingNew: null == isCreatingNew ? _self.isCreatingNew : isCreatingNew // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,availableRoles: null == availableRoles ? _self._availableRoles : availableRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,selectedRoles: null == selectedRoles ? _self._selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,customRoleTitle: null == customRoleTitle ? _self.customRoleTitle : customRoleTitle // ignore: cast_nullable_to_non_nullable
as String,aiSuggestionRole: freezed == aiSuggestionRole ? _self.aiSuggestionRole : aiSuggestionRole // ignore: cast_nullable_to_non_nullable
as TargetRoleModel?,isSubmittingRole: null == isSubmittingRole ? _self.isSubmittingRole : isSubmittingRole // ignore: cast_nullable_to_non_nullable
as bool,hasErrorRole: null == hasErrorRole ? _self.hasErrorRole : hasErrorRole // ignore: cast_nullable_to_non_nullable
as bool,errorMessageRole: null == errorMessageRole ? _self.errorMessageRole : errorMessageRole // ignore: cast_nullable_to_non_nullable
as String,availableLocations: null == availableLocations ? _self._availableLocations : availableLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,selectedLocations: null == selectedLocations ? _self._selectedLocations : selectedLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,dropdownSelection: null == dropdownSelection ? _self.dropdownSelection : dropdownSelection // ignore: cast_nullable_to_non_nullable
as String,aiSuggestionLocation: freezed == aiSuggestionLocation ? _self.aiSuggestionLocation : aiSuggestionLocation // ignore: cast_nullable_to_non_nullable
as LocationPreferenceModel?,isSubmittingLocation: null == isSubmittingLocation ? _self.isSubmittingLocation : isSubmittingLocation // ignore: cast_nullable_to_non_nullable
as bool,hasErrorLocation: null == hasErrorLocation ? _self.hasErrorLocation : hasErrorLocation // ignore: cast_nullable_to_non_nullable
as bool,errorMessageLocation: null == errorMessageLocation ? _self.errorMessageLocation : errorMessageLocation // ignore: cast_nullable_to_non_nullable
as String,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,requiresVisaSponsorship: null == requiresVisaSponsorship ? _self.requiresVisaSponsorship : requiresVisaSponsorship // ignore: cast_nullable_to_non_nullable
as bool,isSubmittingDetails: null == isSubmittingDetails ? _self.isSubmittingDetails : isSubmittingDetails // ignore: cast_nullable_to_non_nullable
as bool,hasErrorDetails: null == hasErrorDetails ? _self.hasErrorDetails : hasErrorDetails // ignore: cast_nullable_to_non_nullable
as bool,errorMessageDetails: null == errorMessageDetails ? _self.errorMessageDetails : errorMessageDetails // ignore: cast_nullable_to_non_nullable
as String,submissionResult: freezed == submissionResult ? _self.submissionResult : submissionResult // ignore: cast_nullable_to_non_nullable
as JobsMatchResponse?,isSubmittingApplication: null == isSubmittingApplication ? _self.isSubmittingApplication : isSubmittingApplication // ignore: cast_nullable_to_non_nullable
as bool,submissionError: null == submissionError ? _self.submissionError : submissionError // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetRoleModelCopyWith<$Res>? get aiSuggestionRole {
    if (_self.aiSuggestionRole == null) {
    return null;
  }

  return $TargetRoleModelCopyWith<$Res>(_self.aiSuggestionRole!, (value) {
    return _then(_self.copyWith(aiSuggestionRole: value));
  });
}/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPreferenceModelCopyWith<$Res>? get aiSuggestionLocation {
    if (_self.aiSuggestionLocation == null) {
    return null;
  }

  return $LocationPreferenceModelCopyWith<$Res>(_self.aiSuggestionLocation!, (value) {
    return _then(_self.copyWith(aiSuggestionLocation: value));
  });
}/// Create a copy of AiJobApplyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobsMatchResponseCopyWith<$Res>? get submissionResult {
    if (_self.submissionResult == null) {
    return null;
  }

  return $JobsMatchResponseCopyWith<$Res>(_self.submissionResult!, (value) {
    return _then(_self.copyWith(submissionResult: value));
  });
}
}

// dart format on
