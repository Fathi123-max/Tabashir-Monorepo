// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonalDetailsState {

/// Selected nationality
 String get nationality;/// Selected gender
 Gender? get gender;/// Whether visa sponsorship is required
 bool get requiresVisaSponsorship;/// Submitting state
 bool get isSubmitting;/// Error state
 bool get hasError;/// Error message
 String get errorMessage;
/// Create a copy of PersonalDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDetailsStateCopyWith<PersonalDetailsState> get copyWith => _$PersonalDetailsStateCopyWithImpl<PersonalDetailsState>(this as PersonalDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDetailsState&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.requiresVisaSponsorship, requiresVisaSponsorship) || other.requiresVisaSponsorship == requiresVisaSponsorship)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,nationality,gender,requiresVisaSponsorship,isSubmitting,hasError,errorMessage);

@override
String toString() {
  return 'PersonalDetailsState(nationality: $nationality, gender: $gender, requiresVisaSponsorship: $requiresVisaSponsorship, isSubmitting: $isSubmitting, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PersonalDetailsStateCopyWith<$Res>  {
  factory $PersonalDetailsStateCopyWith(PersonalDetailsState value, $Res Function(PersonalDetailsState) _then) = _$PersonalDetailsStateCopyWithImpl;
@useResult
$Res call({
 String nationality, Gender? gender, bool requiresVisaSponsorship, bool isSubmitting, bool hasError, String errorMessage
});




}
/// @nodoc
class _$PersonalDetailsStateCopyWithImpl<$Res>
    implements $PersonalDetailsStateCopyWith<$Res> {
  _$PersonalDetailsStateCopyWithImpl(this._self, this._then);

  final PersonalDetailsState _self;
  final $Res Function(PersonalDetailsState) _then;

/// Create a copy of PersonalDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nationality = null,Object? gender = freezed,Object? requiresVisaSponsorship = null,Object? isSubmitting = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,requiresVisaSponsorship: null == requiresVisaSponsorship ? _self.requiresVisaSponsorship : requiresVisaSponsorship // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalDetailsState].
extension PersonalDetailsStatePatterns on PersonalDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nationality,  Gender? gender,  bool requiresVisaSponsorship,  bool isSubmitting,  bool hasError,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDetailsState() when $default != null:
return $default(_that.nationality,_that.gender,_that.requiresVisaSponsorship,_that.isSubmitting,_that.hasError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nationality,  Gender? gender,  bool requiresVisaSponsorship,  bool isSubmitting,  bool hasError,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsState():
return $default(_that.nationality,_that.gender,_that.requiresVisaSponsorship,_that.isSubmitting,_that.hasError,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nationality,  Gender? gender,  bool requiresVisaSponsorship,  bool isSubmitting,  bool hasError,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsState() when $default != null:
return $default(_that.nationality,_that.gender,_that.requiresVisaSponsorship,_that.isSubmitting,_that.hasError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PersonalDetailsState implements PersonalDetailsState {
  const _PersonalDetailsState({this.nationality = 'usa', this.gender, this.requiresVisaSponsorship = false, this.isSubmitting = false, this.hasError = false, this.errorMessage = ''});
  

/// Selected nationality
@override@JsonKey() final  String nationality;
/// Selected gender
@override final  Gender? gender;
/// Whether visa sponsorship is required
@override@JsonKey() final  bool requiresVisaSponsorship;
/// Submitting state
@override@JsonKey() final  bool isSubmitting;
/// Error state
@override@JsonKey() final  bool hasError;
/// Error message
@override@JsonKey() final  String errorMessage;

/// Create a copy of PersonalDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalDetailsStateCopyWith<_PersonalDetailsState> get copyWith => __$PersonalDetailsStateCopyWithImpl<_PersonalDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDetailsState&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.requiresVisaSponsorship, requiresVisaSponsorship) || other.requiresVisaSponsorship == requiresVisaSponsorship)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,nationality,gender,requiresVisaSponsorship,isSubmitting,hasError,errorMessage);

@override
String toString() {
  return 'PersonalDetailsState(nationality: $nationality, gender: $gender, requiresVisaSponsorship: $requiresVisaSponsorship, isSubmitting: $isSubmitting, hasError: $hasError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PersonalDetailsStateCopyWith<$Res> implements $PersonalDetailsStateCopyWith<$Res> {
  factory _$PersonalDetailsStateCopyWith(_PersonalDetailsState value, $Res Function(_PersonalDetailsState) _then) = __$PersonalDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 String nationality, Gender? gender, bool requiresVisaSponsorship, bool isSubmitting, bool hasError, String errorMessage
});




}
/// @nodoc
class __$PersonalDetailsStateCopyWithImpl<$Res>
    implements _$PersonalDetailsStateCopyWith<$Res> {
  __$PersonalDetailsStateCopyWithImpl(this._self, this._then);

  final _PersonalDetailsState _self;
  final $Res Function(_PersonalDetailsState) _then;

/// Create a copy of PersonalDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nationality = null,Object? gender = freezed,Object? requiresVisaSponsorship = null,Object? isSubmitting = null,Object? hasError = null,Object? errorMessage = null,}) {
  return _then(_PersonalDetailsState(
nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,requiresVisaSponsorship: null == requiresVisaSponsorship ? _self.requiresVisaSponsorship : requiresVisaSponsorship // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
