// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_wizard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingWizardState {

 int get currentStep; Uint8List? get fileBytes; String? get fileName; List<String> get suggestedRoles; List<String> get selectedRoles; List<String> get selectedLocations; String get nationality; String get gender; bool get isLoading; bool get isProcessing; String? get errorMessage; JobsMatchResponse? get submissionResult;
/// Create a copy of OnboardingWizardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingWizardStateCopyWith<OnboardingWizardState> get copyWith => _$OnboardingWizardStateCopyWithImpl<OnboardingWizardState>(this as OnboardingWizardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingWizardState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&const DeepCollectionEquality().equals(other.fileBytes, fileBytes)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other.suggestedRoles, suggestedRoles)&&const DeepCollectionEquality().equals(other.selectedRoles, selectedRoles)&&const DeepCollectionEquality().equals(other.selectedLocations, selectedLocations)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.submissionResult, submissionResult) || other.submissionResult == submissionResult));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,const DeepCollectionEquality().hash(fileBytes),fileName,const DeepCollectionEquality().hash(suggestedRoles),const DeepCollectionEquality().hash(selectedRoles),const DeepCollectionEquality().hash(selectedLocations),nationality,gender,isLoading,isProcessing,errorMessage,submissionResult);

@override
String toString() {
  return 'OnboardingWizardState(currentStep: $currentStep, fileBytes: $fileBytes, fileName: $fileName, suggestedRoles: $suggestedRoles, selectedRoles: $selectedRoles, selectedLocations: $selectedLocations, nationality: $nationality, gender: $gender, isLoading: $isLoading, isProcessing: $isProcessing, errorMessage: $errorMessage, submissionResult: $submissionResult)';
}


}

/// @nodoc
abstract mixin class $OnboardingWizardStateCopyWith<$Res>  {
  factory $OnboardingWizardStateCopyWith(OnboardingWizardState value, $Res Function(OnboardingWizardState) _then) = _$OnboardingWizardStateCopyWithImpl;
@useResult
$Res call({
 int currentStep, Uint8List? fileBytes, String? fileName, List<String> suggestedRoles, List<String> selectedRoles, List<String> selectedLocations, String nationality, String gender, bool isLoading, bool isProcessing, String? errorMessage, JobsMatchResponse? submissionResult
});


$JobsMatchResponseCopyWith<$Res>? get submissionResult;

}
/// @nodoc
class _$OnboardingWizardStateCopyWithImpl<$Res>
    implements $OnboardingWizardStateCopyWith<$Res> {
  _$OnboardingWizardStateCopyWithImpl(this._self, this._then);

  final OnboardingWizardState _self;
  final $Res Function(OnboardingWizardState) _then;

/// Create a copy of OnboardingWizardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? fileBytes = freezed,Object? fileName = freezed,Object? suggestedRoles = null,Object? selectedRoles = null,Object? selectedLocations = null,Object? nationality = null,Object? gender = null,Object? isLoading = null,Object? isProcessing = null,Object? errorMessage = freezed,Object? submissionResult = freezed,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,fileBytes: freezed == fileBytes ? _self.fileBytes : fileBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,suggestedRoles: null == suggestedRoles ? _self.suggestedRoles : suggestedRoles // ignore: cast_nullable_to_non_nullable
as List<String>,selectedRoles: null == selectedRoles ? _self.selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<String>,selectedLocations: null == selectedLocations ? _self.selectedLocations : selectedLocations // ignore: cast_nullable_to_non_nullable
as List<String>,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,submissionResult: freezed == submissionResult ? _self.submissionResult : submissionResult // ignore: cast_nullable_to_non_nullable
as JobsMatchResponse?,
  ));
}
/// Create a copy of OnboardingWizardState
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


/// Adds pattern-matching-related methods to [OnboardingWizardState].
extension OnboardingWizardStatePatterns on OnboardingWizardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingWizardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingWizardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingWizardState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingWizardState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingWizardState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingWizardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStep,  Uint8List? fileBytes,  String? fileName,  List<String> suggestedRoles,  List<String> selectedRoles,  List<String> selectedLocations,  String nationality,  String gender,  bool isLoading,  bool isProcessing,  String? errorMessage,  JobsMatchResponse? submissionResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingWizardState() when $default != null:
return $default(_that.currentStep,_that.fileBytes,_that.fileName,_that.suggestedRoles,_that.selectedRoles,_that.selectedLocations,_that.nationality,_that.gender,_that.isLoading,_that.isProcessing,_that.errorMessage,_that.submissionResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStep,  Uint8List? fileBytes,  String? fileName,  List<String> suggestedRoles,  List<String> selectedRoles,  List<String> selectedLocations,  String nationality,  String gender,  bool isLoading,  bool isProcessing,  String? errorMessage,  JobsMatchResponse? submissionResult)  $default,) {final _that = this;
switch (_that) {
case _OnboardingWizardState():
return $default(_that.currentStep,_that.fileBytes,_that.fileName,_that.suggestedRoles,_that.selectedRoles,_that.selectedLocations,_that.nationality,_that.gender,_that.isLoading,_that.isProcessing,_that.errorMessage,_that.submissionResult);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStep,  Uint8List? fileBytes,  String? fileName,  List<String> suggestedRoles,  List<String> selectedRoles,  List<String> selectedLocations,  String nationality,  String gender,  bool isLoading,  bool isProcessing,  String? errorMessage,  JobsMatchResponse? submissionResult)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingWizardState() when $default != null:
return $default(_that.currentStep,_that.fileBytes,_that.fileName,_that.suggestedRoles,_that.selectedRoles,_that.selectedLocations,_that.nationality,_that.gender,_that.isLoading,_that.isProcessing,_that.errorMessage,_that.submissionResult);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingWizardState implements OnboardingWizardState {
  const _OnboardingWizardState({this.currentStep = 1, this.fileBytes, this.fileName, final  List<String> suggestedRoles = const [], final  List<String> selectedRoles = const [], final  List<String> selectedLocations = const ['Dubai', 'Abu Dhabi', 'Sharjah', 'Ajman', 'Umm Al Quwain', 'Ras Al Khaimah', 'Fujairah'], this.nationality = 'ae', this.gender = 'male', this.isLoading = false, this.isProcessing = false, this.errorMessage, this.submissionResult}): _suggestedRoles = suggestedRoles,_selectedRoles = selectedRoles,_selectedLocations = selectedLocations;
  

@override@JsonKey() final  int currentStep;
@override final  Uint8List? fileBytes;
@override final  String? fileName;
 final  List<String> _suggestedRoles;
@override@JsonKey() List<String> get suggestedRoles {
  if (_suggestedRoles is EqualUnmodifiableListView) return _suggestedRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestedRoles);
}

 final  List<String> _selectedRoles;
@override@JsonKey() List<String> get selectedRoles {
  if (_selectedRoles is EqualUnmodifiableListView) return _selectedRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedRoles);
}

 final  List<String> _selectedLocations;
@override@JsonKey() List<String> get selectedLocations {
  if (_selectedLocations is EqualUnmodifiableListView) return _selectedLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedLocations);
}

@override@JsonKey() final  String nationality;
@override@JsonKey() final  String gender;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isProcessing;
@override final  String? errorMessage;
@override final  JobsMatchResponse? submissionResult;

/// Create a copy of OnboardingWizardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingWizardStateCopyWith<_OnboardingWizardState> get copyWith => __$OnboardingWizardStateCopyWithImpl<_OnboardingWizardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingWizardState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&const DeepCollectionEquality().equals(other.fileBytes, fileBytes)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other._suggestedRoles, _suggestedRoles)&&const DeepCollectionEquality().equals(other._selectedRoles, _selectedRoles)&&const DeepCollectionEquality().equals(other._selectedLocations, _selectedLocations)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.submissionResult, submissionResult) || other.submissionResult == submissionResult));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,const DeepCollectionEquality().hash(fileBytes),fileName,const DeepCollectionEquality().hash(_suggestedRoles),const DeepCollectionEquality().hash(_selectedRoles),const DeepCollectionEquality().hash(_selectedLocations),nationality,gender,isLoading,isProcessing,errorMessage,submissionResult);

@override
String toString() {
  return 'OnboardingWizardState(currentStep: $currentStep, fileBytes: $fileBytes, fileName: $fileName, suggestedRoles: $suggestedRoles, selectedRoles: $selectedRoles, selectedLocations: $selectedLocations, nationality: $nationality, gender: $gender, isLoading: $isLoading, isProcessing: $isProcessing, errorMessage: $errorMessage, submissionResult: $submissionResult)';
}


}

/// @nodoc
abstract mixin class _$OnboardingWizardStateCopyWith<$Res> implements $OnboardingWizardStateCopyWith<$Res> {
  factory _$OnboardingWizardStateCopyWith(_OnboardingWizardState value, $Res Function(_OnboardingWizardState) _then) = __$OnboardingWizardStateCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, Uint8List? fileBytes, String? fileName, List<String> suggestedRoles, List<String> selectedRoles, List<String> selectedLocations, String nationality, String gender, bool isLoading, bool isProcessing, String? errorMessage, JobsMatchResponse? submissionResult
});


@override $JobsMatchResponseCopyWith<$Res>? get submissionResult;

}
/// @nodoc
class __$OnboardingWizardStateCopyWithImpl<$Res>
    implements _$OnboardingWizardStateCopyWith<$Res> {
  __$OnboardingWizardStateCopyWithImpl(this._self, this._then);

  final _OnboardingWizardState _self;
  final $Res Function(_OnboardingWizardState) _then;

/// Create a copy of OnboardingWizardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? fileBytes = freezed,Object? fileName = freezed,Object? suggestedRoles = null,Object? selectedRoles = null,Object? selectedLocations = null,Object? nationality = null,Object? gender = null,Object? isLoading = null,Object? isProcessing = null,Object? errorMessage = freezed,Object? submissionResult = freezed,}) {
  return _then(_OnboardingWizardState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,fileBytes: freezed == fileBytes ? _self.fileBytes : fileBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,suggestedRoles: null == suggestedRoles ? _self._suggestedRoles : suggestedRoles // ignore: cast_nullable_to_non_nullable
as List<String>,selectedRoles: null == selectedRoles ? _self._selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<String>,selectedLocations: null == selectedLocations ? _self._selectedLocations : selectedLocations // ignore: cast_nullable_to_non_nullable
as List<String>,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,submissionResult: freezed == submissionResult ? _self.submissionResult : submissionResult // ignore: cast_nullable_to_non_nullable
as JobsMatchResponse?,
  ));
}

/// Create a copy of OnboardingWizardState
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
