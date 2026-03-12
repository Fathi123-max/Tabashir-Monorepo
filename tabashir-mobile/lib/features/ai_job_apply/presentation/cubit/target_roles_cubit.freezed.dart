// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_roles_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TargetRolesState {

/// List of available roles to select from
 List<TargetRoleModel> get availableRoles;/// Currently selected roles
 List<TargetRoleModel> get selectedRoles;/// Current custom role input
 String get customRoleTitle;/// AI suggestion for additional role
 TargetRoleModel? get aiSuggestion;/// Submitting state
 bool get isSubmitting;/// Error state
 bool get hasError;/// Error message
 String get errorMessage;
/// Create a copy of TargetRolesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetRolesStateCopyWith<TargetRolesState> get copyWith => _$TargetRolesStateCopyWithImpl<TargetRolesState>(this as TargetRolesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetRolesState&&const DeepCollectionEquality().equals(other.availableRoles, availableRoles)&&const DeepCollectionEquality().equals(other.selectedRoles, selectedRoles)&&(identical(other.customRoleTitle, customRoleTitle) || other.customRoleTitle == customRoleTitle)&&(identical(other.aiSuggestion, aiSuggestion) || other.aiSuggestion == aiSuggestion)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(availableRoles),const DeepCollectionEquality().hash(selectedRoles),customRoleTitle,aiSuggestion,isSubmitting,hasError,errorMessage);

@override
String toString() {
  return 'TargetRolesState(availableRoles: $availableRoles, selectedRoles: $selectedRoles, customRoleTitle: $customRoleTitle, aiSuggestion: $aiSuggestion, isSubmitting: $isSubmitting, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TargetRolesStateCopyWith<$Res>  {
  factory $TargetRolesStateCopyWith(TargetRolesState value, $Res Function(TargetRolesState) _then) = _$TargetRolesStateCopyWithImpl;
@useResult
$Res call({
 List<TargetRoleModel> availableRoles, List<TargetRoleModel> selectedRoles, String customRoleTitle, TargetRoleModel? aiSuggestion, bool isSubmitting, bool hasError, String errorMessage
});


$TargetRoleModelCopyWith<$Res>? get aiSuggestion;

}
/// @nodoc
class _$TargetRolesStateCopyWithImpl<$Res>
    implements $TargetRolesStateCopyWith<$Res> {
  _$TargetRolesStateCopyWithImpl(this._self, this._then);

  final TargetRolesState _self;
  final $Res Function(TargetRolesState) _then;

/// Create a copy of TargetRolesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableRoles = null,Object? selectedRoles = null,Object? customRoleTitle = null,Object? aiSuggestion = freezed,Object? isSubmitting = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
availableRoles: null == availableRoles ? _self.availableRoles : availableRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,selectedRoles: null == selectedRoles ? _self.selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,customRoleTitle: null == customRoleTitle ? _self.customRoleTitle : customRoleTitle // ignore: cast_nullable_to_non_nullable
as String,aiSuggestion: freezed == aiSuggestion ? _self.aiSuggestion : aiSuggestion // ignore: cast_nullable_to_non_nullable
as TargetRoleModel?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of TargetRolesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetRoleModelCopyWith<$Res>? get aiSuggestion {
    if (_self.aiSuggestion == null) {
    return null;
  }

  return $TargetRoleModelCopyWith<$Res>(_self.aiSuggestion!, (value) {
    return _then(_self.copyWith(aiSuggestion: value));
  });
}
}


/// Adds pattern-matching-related methods to [TargetRolesState].
extension TargetRolesStatePatterns on TargetRolesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TargetRolesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TargetRolesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TargetRolesState value)  $default,){
final _that = this;
switch (_that) {
case _TargetRolesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TargetRolesState value)?  $default,){
final _that = this;
switch (_that) {
case _TargetRolesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TargetRoleModel> availableRoles,  List<TargetRoleModel> selectedRoles,  String customRoleTitle,  TargetRoleModel? aiSuggestion,  bool isSubmitting,  bool hasError,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TargetRolesState() when $default != null:
return $default(_that.availableRoles,_that.selectedRoles,_that.customRoleTitle,_that.aiSuggestion,_that.isSubmitting,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TargetRoleModel> availableRoles,  List<TargetRoleModel> selectedRoles,  String customRoleTitle,  TargetRoleModel? aiSuggestion,  bool isSubmitting,  bool hasError,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TargetRolesState():
return $default(_that.availableRoles,_that.selectedRoles,_that.customRoleTitle,_that.aiSuggestion,_that.isSubmitting,_that.hasError,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TargetRoleModel> availableRoles,  List<TargetRoleModel> selectedRoles,  String customRoleTitle,  TargetRoleModel? aiSuggestion,  bool isSubmitting,  bool hasError,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TargetRolesState() when $default != null:
return $default(_that.availableRoles,_that.selectedRoles,_that.customRoleTitle,_that.aiSuggestion,_that.isSubmitting,_that.hasError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TargetRolesState implements TargetRolesState {
  const _TargetRolesState({final  List<TargetRoleModel> availableRoles = const [], final  List<TargetRoleModel> selectedRoles = const [], this.customRoleTitle = '', this.aiSuggestion, this.isSubmitting = false, this.hasError = false, this.errorMessage = ''}): _availableRoles = availableRoles,_selectedRoles = selectedRoles;
  

/// List of available roles to select from
 final  List<TargetRoleModel> _availableRoles;
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
@override final  TargetRoleModel? aiSuggestion;
/// Submitting state
@override@JsonKey() final  bool isSubmitting;
/// Error state
@override@JsonKey() final  bool hasError;
/// Error message
@override@JsonKey() final  String errorMessage;

/// Create a copy of TargetRolesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TargetRolesStateCopyWith<_TargetRolesState> get copyWith => __$TargetRolesStateCopyWithImpl<_TargetRolesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetRolesState&&const DeepCollectionEquality().equals(other._availableRoles, _availableRoles)&&const DeepCollectionEquality().equals(other._selectedRoles, _selectedRoles)&&(identical(other.customRoleTitle, customRoleTitle) || other.customRoleTitle == customRoleTitle)&&(identical(other.aiSuggestion, aiSuggestion) || other.aiSuggestion == aiSuggestion)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableRoles),const DeepCollectionEquality().hash(_selectedRoles),customRoleTitle,aiSuggestion,isSubmitting,hasError,errorMessage);

@override
String toString() {
  return 'TargetRolesState(availableRoles: $availableRoles, selectedRoles: $selectedRoles, customRoleTitle: $customRoleTitle, aiSuggestion: $aiSuggestion, isSubmitting: $isSubmitting, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TargetRolesStateCopyWith<$Res> implements $TargetRolesStateCopyWith<$Res> {
  factory _$TargetRolesStateCopyWith(_TargetRolesState value, $Res Function(_TargetRolesState) _then) = __$TargetRolesStateCopyWithImpl;
@override @useResult
$Res call({
 List<TargetRoleModel> availableRoles, List<TargetRoleModel> selectedRoles, String customRoleTitle, TargetRoleModel? aiSuggestion, bool isSubmitting, bool hasError, String errorMessage
});


@override $TargetRoleModelCopyWith<$Res>? get aiSuggestion;

}
/// @nodoc
class __$TargetRolesStateCopyWithImpl<$Res>
    implements _$TargetRolesStateCopyWith<$Res> {
  __$TargetRolesStateCopyWithImpl(this._self, this._then);

  final _TargetRolesState _self;
  final $Res Function(_TargetRolesState) _then;

/// Create a copy of TargetRolesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availableRoles = null,Object? selectedRoles = null,Object? customRoleTitle = null,Object? aiSuggestion = freezed,Object? isSubmitting = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_TargetRolesState(
availableRoles: null == availableRoles ? _self._availableRoles : availableRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,selectedRoles: null == selectedRoles ? _self._selectedRoles : selectedRoles // ignore: cast_nullable_to_non_nullable
as List<TargetRoleModel>,customRoleTitle: null == customRoleTitle ? _self.customRoleTitle : customRoleTitle // ignore: cast_nullable_to_non_nullable
as String,aiSuggestion: freezed == aiSuggestion ? _self.aiSuggestion : aiSuggestion // ignore: cast_nullable_to_non_nullable
as TargetRoleModel?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of TargetRolesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetRoleModelCopyWith<$Res>? get aiSuggestion {
    if (_self.aiSuggestion == null) {
    return null;
  }

  return $TargetRoleModelCopyWith<$Res>(_self.aiSuggestion!, (value) {
    return _then(_self.copyWith(aiSuggestion: value));
  });
}
}

// dart format on
