// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_apply_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiApplyState {

/// List of available resumes
 List<ResumeSelectionModel> get resumes;/// Currently selected resume ID
 String? get selectedResumeId;/// Loading state
 bool get isLoading;/// Submitting state
 bool get isSubmitting;/// Creating new resume state
 bool get isCreatingNew;/// Error state
 bool get hasError;/// Error message
 String get errorMessage;
/// Create a copy of AiApplyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiApplyStateCopyWith<AiApplyState> get copyWith => _$AiApplyStateCopyWithImpl<AiApplyState>(this as AiApplyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiApplyState&&const DeepCollectionEquality().equals(other.resumes, resumes)&&(identical(other.selectedResumeId, selectedResumeId) || other.selectedResumeId == selectedResumeId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isCreatingNew, isCreatingNew) || other.isCreatingNew == isCreatingNew)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(resumes),selectedResumeId,isLoading,isSubmitting,isCreatingNew,hasError,errorMessage);

@override
String toString() {
  return 'AiApplyState(resumes: $resumes, selectedResumeId: $selectedResumeId, isLoading: $isLoading, isSubmitting: $isSubmitting, isCreatingNew: $isCreatingNew, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AiApplyStateCopyWith<$Res>  {
  factory $AiApplyStateCopyWith(AiApplyState value, $Res Function(AiApplyState) _then) = _$AiApplyStateCopyWithImpl;
@useResult
$Res call({
 List<ResumeSelectionModel> resumes, String? selectedResumeId, bool isLoading, bool isSubmitting, bool isCreatingNew, bool hasError, String errorMessage
});




}
/// @nodoc
class _$AiApplyStateCopyWithImpl<$Res>
    implements $AiApplyStateCopyWith<$Res> {
  _$AiApplyStateCopyWithImpl(this._self, this._then);

  final AiApplyState _self;
  final $Res Function(AiApplyState) _then;

/// Create a copy of AiApplyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resumes = null,Object? selectedResumeId = freezed,Object? isLoading = null,Object? isSubmitting = null,Object? isCreatingNew = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
resumes: null == resumes ? _self.resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeSelectionModel>,selectedResumeId: freezed == selectedResumeId ? _self.selectedResumeId : selectedResumeId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isCreatingNew: null == isCreatingNew ? _self.isCreatingNew : isCreatingNew // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiApplyState].
extension AiApplyStatePatterns on AiApplyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiApplyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiApplyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiApplyState value)  $default,){
final _that = this;
switch (_that) {
case _AiApplyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiApplyState value)?  $default,){
final _that = this;
switch (_that) {
case _AiApplyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ResumeSelectionModel> resumes,  String? selectedResumeId,  bool isLoading,  bool isSubmitting,  bool isCreatingNew,  bool hasError,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiApplyState() when $default != null:
return $default(_that.resumes,_that.selectedResumeId,_that.isLoading,_that.isSubmitting,_that.isCreatingNew,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ResumeSelectionModel> resumes,  String? selectedResumeId,  bool isLoading,  bool isSubmitting,  bool isCreatingNew,  bool hasError,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AiApplyState():
return $default(_that.resumes,_that.selectedResumeId,_that.isLoading,_that.isSubmitting,_that.isCreatingNew,_that.hasError,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ResumeSelectionModel> resumes,  String? selectedResumeId,  bool isLoading,  bool isSubmitting,  bool isCreatingNew,  bool hasError,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AiApplyState() when $default != null:
return $default(_that.resumes,_that.selectedResumeId,_that.isLoading,_that.isSubmitting,_that.isCreatingNew,_that.hasError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AiApplyState implements AiApplyState {
  const _AiApplyState({final  List<ResumeSelectionModel> resumes = const [], this.selectedResumeId, this.isLoading = false, this.isSubmitting = false, this.isCreatingNew = false, this.hasError = false, this.errorMessage = ''}): _resumes = resumes;
  

/// List of available resumes
 final  List<ResumeSelectionModel> _resumes;
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

/// Create a copy of AiApplyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiApplyStateCopyWith<_AiApplyState> get copyWith => __$AiApplyStateCopyWithImpl<_AiApplyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiApplyState&&const DeepCollectionEquality().equals(other._resumes, _resumes)&&(identical(other.selectedResumeId, selectedResumeId) || other.selectedResumeId == selectedResumeId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isCreatingNew, isCreatingNew) || other.isCreatingNew == isCreatingNew)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_resumes),selectedResumeId,isLoading,isSubmitting,isCreatingNew,hasError,errorMessage);

@override
String toString() {
  return 'AiApplyState(resumes: $resumes, selectedResumeId: $selectedResumeId, isLoading: $isLoading, isSubmitting: $isSubmitting, isCreatingNew: $isCreatingNew, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AiApplyStateCopyWith<$Res> implements $AiApplyStateCopyWith<$Res> {
  factory _$AiApplyStateCopyWith(_AiApplyState value, $Res Function(_AiApplyState) _then) = __$AiApplyStateCopyWithImpl;
@override @useResult
$Res call({
 List<ResumeSelectionModel> resumes, String? selectedResumeId, bool isLoading, bool isSubmitting, bool isCreatingNew, bool hasError, String errorMessage
});




}
/// @nodoc
class __$AiApplyStateCopyWithImpl<$Res>
    implements _$AiApplyStateCopyWith<$Res> {
  __$AiApplyStateCopyWithImpl(this._self, this._then);

  final _AiApplyState _self;
  final $Res Function(_AiApplyState) _then;

/// Create a copy of AiApplyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resumes = null,Object? selectedResumeId = freezed,Object? isLoading = null,Object? isSubmitting = null,Object? isCreatingNew = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_AiApplyState(
resumes: null == resumes ? _self._resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeSelectionModel>,selectedResumeId: freezed == selectedResumeId ? _self.selectedResumeId : selectedResumeId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isCreatingNew: null == isCreatingNew ? _self.isCreatingNew : isCreatingNew // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
