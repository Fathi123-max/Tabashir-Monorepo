// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonalDetailsModel {

/// Nationality country code
/// Can be null for users who haven't set it yet
/// When null, it should be initialized from user profile or config
 String? get nationality;/// Selected gender
 Gender? get gender;/// Whether visa sponsorship is required
 bool get requiresVisaSponsorship;
/// Create a copy of PersonalDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDetailsModelCopyWith<PersonalDetailsModel> get copyWith => _$PersonalDetailsModelCopyWithImpl<PersonalDetailsModel>(this as PersonalDetailsModel, _$identity);

  /// Serializes this PersonalDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDetailsModel&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.requiresVisaSponsorship, requiresVisaSponsorship) || other.requiresVisaSponsorship == requiresVisaSponsorship));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nationality,gender,requiresVisaSponsorship);

@override
String toString() {
  return 'PersonalDetailsModel(nationality: $nationality, gender: $gender, requiresVisaSponsorship: $requiresVisaSponsorship)';
}


}

/// @nodoc
abstract mixin class $PersonalDetailsModelCopyWith<$Res>  {
  factory $PersonalDetailsModelCopyWith(PersonalDetailsModel value, $Res Function(PersonalDetailsModel) _then) = _$PersonalDetailsModelCopyWithImpl;
@useResult
$Res call({
 String? nationality, Gender? gender, bool requiresVisaSponsorship
});




}
/// @nodoc
class _$PersonalDetailsModelCopyWithImpl<$Res>
    implements $PersonalDetailsModelCopyWith<$Res> {
  _$PersonalDetailsModelCopyWithImpl(this._self, this._then);

  final PersonalDetailsModel _self;
  final $Res Function(PersonalDetailsModel) _then;

/// Create a copy of PersonalDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nationality = freezed,Object? gender = freezed,Object? requiresVisaSponsorship = null,}) {
  return _then(_self.copyWith(
nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,requiresVisaSponsorship: null == requiresVisaSponsorship ? _self.requiresVisaSponsorship : requiresVisaSponsorship // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalDetailsModel].
extension PersonalDetailsModelPatterns on PersonalDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nationality,  Gender? gender,  bool requiresVisaSponsorship)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDetailsModel() when $default != null:
return $default(_that.nationality,_that.gender,_that.requiresVisaSponsorship);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nationality,  Gender? gender,  bool requiresVisaSponsorship)  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsModel():
return $default(_that.nationality,_that.gender,_that.requiresVisaSponsorship);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nationality,  Gender? gender,  bool requiresVisaSponsorship)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsModel() when $default != null:
return $default(_that.nationality,_that.gender,_that.requiresVisaSponsorship);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalDetailsModel implements PersonalDetailsModel {
  const _PersonalDetailsModel({this.nationality, this.gender, this.requiresVisaSponsorship = false});
  factory _PersonalDetailsModel.fromJson(Map<String, dynamic> json) => _$PersonalDetailsModelFromJson(json);

/// Nationality country code
/// Can be null for users who haven't set it yet
/// When null, it should be initialized from user profile or config
@override final  String? nationality;
/// Selected gender
@override final  Gender? gender;
/// Whether visa sponsorship is required
@override@JsonKey() final  bool requiresVisaSponsorship;

/// Create a copy of PersonalDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalDetailsModelCopyWith<_PersonalDetailsModel> get copyWith => __$PersonalDetailsModelCopyWithImpl<_PersonalDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDetailsModel&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.requiresVisaSponsorship, requiresVisaSponsorship) || other.requiresVisaSponsorship == requiresVisaSponsorship));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nationality,gender,requiresVisaSponsorship);

@override
String toString() {
  return 'PersonalDetailsModel(nationality: $nationality, gender: $gender, requiresVisaSponsorship: $requiresVisaSponsorship)';
}


}

/// @nodoc
abstract mixin class _$PersonalDetailsModelCopyWith<$Res> implements $PersonalDetailsModelCopyWith<$Res> {
  factory _$PersonalDetailsModelCopyWith(_PersonalDetailsModel value, $Res Function(_PersonalDetailsModel) _then) = __$PersonalDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 String? nationality, Gender? gender, bool requiresVisaSponsorship
});




}
/// @nodoc
class __$PersonalDetailsModelCopyWithImpl<$Res>
    implements _$PersonalDetailsModelCopyWith<$Res> {
  __$PersonalDetailsModelCopyWithImpl(this._self, this._then);

  final _PersonalDetailsModel _self;
  final $Res Function(_PersonalDetailsModel) _then;

/// Create a copy of PersonalDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nationality = freezed,Object? gender = freezed,Object? requiresVisaSponsorship = null,}) {
  return _then(_PersonalDetailsModel(
nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,requiresVisaSponsorship: null == requiresVisaSponsorship ? _self.requiresVisaSponsorship : requiresVisaSponsorship // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
