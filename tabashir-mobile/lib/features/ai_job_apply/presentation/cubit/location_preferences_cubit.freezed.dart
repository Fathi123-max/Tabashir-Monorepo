// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_preferences_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationPreferencesState {

/// List of available locations to select from
 List<LocationPreferenceModel> get availableLocations;/// Currently selected locations
 List<LocationPreferenceModel> get selectedLocations;/// Current dropdown selection
 String get dropdownSelection;/// AI suggestion for additional location
 LocationPreferenceModel? get aiSuggestion;/// Submitting state
 bool get isSubmitting;/// Error state
 bool get hasError;/// Error message
 String get errorMessage;
/// Create a copy of LocationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationPreferencesStateCopyWith<LocationPreferencesState> get copyWith => _$LocationPreferencesStateCopyWithImpl<LocationPreferencesState>(this as LocationPreferencesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationPreferencesState&&const DeepCollectionEquality().equals(other.availableLocations, availableLocations)&&const DeepCollectionEquality().equals(other.selectedLocations, selectedLocations)&&(identical(other.dropdownSelection, dropdownSelection) || other.dropdownSelection == dropdownSelection)&&(identical(other.aiSuggestion, aiSuggestion) || other.aiSuggestion == aiSuggestion)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(availableLocations),const DeepCollectionEquality().hash(selectedLocations),dropdownSelection,aiSuggestion,isSubmitting,hasError,errorMessage);

@override
String toString() {
  return 'LocationPreferencesState(availableLocations: $availableLocations, selectedLocations: $selectedLocations, dropdownSelection: $dropdownSelection, aiSuggestion: $aiSuggestion, isSubmitting: $isSubmitting, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LocationPreferencesStateCopyWith<$Res>  {
  factory $LocationPreferencesStateCopyWith(LocationPreferencesState value, $Res Function(LocationPreferencesState) _then) = _$LocationPreferencesStateCopyWithImpl;
@useResult
$Res call({
 List<LocationPreferenceModel> availableLocations, List<LocationPreferenceModel> selectedLocations, String dropdownSelection, LocationPreferenceModel? aiSuggestion, bool isSubmitting, bool hasError, String errorMessage
});


$LocationPreferenceModelCopyWith<$Res>? get aiSuggestion;

}
/// @nodoc
class _$LocationPreferencesStateCopyWithImpl<$Res>
    implements $LocationPreferencesStateCopyWith<$Res> {
  _$LocationPreferencesStateCopyWithImpl(this._self, this._then);

  final LocationPreferencesState _self;
  final $Res Function(LocationPreferencesState) _then;

/// Create a copy of LocationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableLocations = null,Object? selectedLocations = null,Object? dropdownSelection = null,Object? aiSuggestion = freezed,Object? isSubmitting = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
availableLocations: null == availableLocations ? _self.availableLocations : availableLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,selectedLocations: null == selectedLocations ? _self.selectedLocations : selectedLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,dropdownSelection: null == dropdownSelection ? _self.dropdownSelection : dropdownSelection // ignore: cast_nullable_to_non_nullable
as String,aiSuggestion: freezed == aiSuggestion ? _self.aiSuggestion : aiSuggestion // ignore: cast_nullable_to_non_nullable
as LocationPreferenceModel?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of LocationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPreferenceModelCopyWith<$Res>? get aiSuggestion {
    if (_self.aiSuggestion == null) {
    return null;
  }

  return $LocationPreferenceModelCopyWith<$Res>(_self.aiSuggestion!, (value) {
    return _then(_self.copyWith(aiSuggestion: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationPreferencesState].
extension LocationPreferencesStatePatterns on LocationPreferencesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationPreferencesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationPreferencesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationPreferencesState value)  $default,){
final _that = this;
switch (_that) {
case _LocationPreferencesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationPreferencesState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationPreferencesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LocationPreferenceModel> availableLocations,  List<LocationPreferenceModel> selectedLocations,  String dropdownSelection,  LocationPreferenceModel? aiSuggestion,  bool isSubmitting,  bool hasError,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationPreferencesState() when $default != null:
return $default(_that.availableLocations,_that.selectedLocations,_that.dropdownSelection,_that.aiSuggestion,_that.isSubmitting,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LocationPreferenceModel> availableLocations,  List<LocationPreferenceModel> selectedLocations,  String dropdownSelection,  LocationPreferenceModel? aiSuggestion,  bool isSubmitting,  bool hasError,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LocationPreferencesState():
return $default(_that.availableLocations,_that.selectedLocations,_that.dropdownSelection,_that.aiSuggestion,_that.isSubmitting,_that.hasError,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LocationPreferenceModel> availableLocations,  List<LocationPreferenceModel> selectedLocations,  String dropdownSelection,  LocationPreferenceModel? aiSuggestion,  bool isSubmitting,  bool hasError,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LocationPreferencesState() when $default != null:
return $default(_that.availableLocations,_that.selectedLocations,_that.dropdownSelection,_that.aiSuggestion,_that.isSubmitting,_that.hasError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LocationPreferencesState implements LocationPreferencesState {
  const _LocationPreferencesState({final  List<LocationPreferenceModel> availableLocations = const [], final  List<LocationPreferenceModel> selectedLocations = const [], this.dropdownSelection = '', this.aiSuggestion, this.isSubmitting = false, this.hasError = false, this.errorMessage = ''}): _availableLocations = availableLocations,_selectedLocations = selectedLocations;
  

/// List of available locations to select from
 final  List<LocationPreferenceModel> _availableLocations;
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
@override final  LocationPreferenceModel? aiSuggestion;
/// Submitting state
@override@JsonKey() final  bool isSubmitting;
/// Error state
@override@JsonKey() final  bool hasError;
/// Error message
@override@JsonKey() final  String errorMessage;

/// Create a copy of LocationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationPreferencesStateCopyWith<_LocationPreferencesState> get copyWith => __$LocationPreferencesStateCopyWithImpl<_LocationPreferencesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationPreferencesState&&const DeepCollectionEquality().equals(other._availableLocations, _availableLocations)&&const DeepCollectionEquality().equals(other._selectedLocations, _selectedLocations)&&(identical(other.dropdownSelection, dropdownSelection) || other.dropdownSelection == dropdownSelection)&&(identical(other.aiSuggestion, aiSuggestion) || other.aiSuggestion == aiSuggestion)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableLocations),const DeepCollectionEquality().hash(_selectedLocations),dropdownSelection,aiSuggestion,isSubmitting,hasError,errorMessage);

@override
String toString() {
  return 'LocationPreferencesState(availableLocations: $availableLocations, selectedLocations: $selectedLocations, dropdownSelection: $dropdownSelection, aiSuggestion: $aiSuggestion, isSubmitting: $isSubmitting, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LocationPreferencesStateCopyWith<$Res> implements $LocationPreferencesStateCopyWith<$Res> {
  factory _$LocationPreferencesStateCopyWith(_LocationPreferencesState value, $Res Function(_LocationPreferencesState) _then) = __$LocationPreferencesStateCopyWithImpl;
@override @useResult
$Res call({
 List<LocationPreferenceModel> availableLocations, List<LocationPreferenceModel> selectedLocations, String dropdownSelection, LocationPreferenceModel? aiSuggestion, bool isSubmitting, bool hasError, String errorMessage
});


@override $LocationPreferenceModelCopyWith<$Res>? get aiSuggestion;

}
/// @nodoc
class __$LocationPreferencesStateCopyWithImpl<$Res>
    implements _$LocationPreferencesStateCopyWith<$Res> {
  __$LocationPreferencesStateCopyWithImpl(this._self, this._then);

  final _LocationPreferencesState _self;
  final $Res Function(_LocationPreferencesState) _then;

/// Create a copy of LocationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availableLocations = null,Object? selectedLocations = null,Object? dropdownSelection = null,Object? aiSuggestion = freezed,Object? isSubmitting = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_LocationPreferencesState(
availableLocations: null == availableLocations ? _self._availableLocations : availableLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,selectedLocations: null == selectedLocations ? _self._selectedLocations : selectedLocations // ignore: cast_nullable_to_non_nullable
as List<LocationPreferenceModel>,dropdownSelection: null == dropdownSelection ? _self.dropdownSelection : dropdownSelection // ignore: cast_nullable_to_non_nullable
as String,aiSuggestion: freezed == aiSuggestion ? _self.aiSuggestion : aiSuggestion // ignore: cast_nullable_to_non_nullable
as LocationPreferenceModel?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of LocationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationPreferenceModelCopyWith<$Res>? get aiSuggestion {
    if (_self.aiSuggestion == null) {
    return null;
  }

  return $LocationPreferenceModelCopyWith<$Res>(_self.aiSuggestion!, (value) {
    return _then(_self.copyWith(aiSuggestion: value));
  });
}
}

// dart format on
