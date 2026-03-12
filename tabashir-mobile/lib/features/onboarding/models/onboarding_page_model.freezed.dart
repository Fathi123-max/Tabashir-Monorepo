// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingPageModel {

 String get icon; String get title; String get description;
/// Create a copy of OnboardingPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingPageModelCopyWith<OnboardingPageModel> get copyWith => _$OnboardingPageModelCopyWithImpl<OnboardingPageModel>(this as OnboardingPageModel, _$identity);

  /// Serializes this OnboardingPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingPageModel&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,title,description);

@override
String toString() {
  return 'OnboardingPageModel(icon: $icon, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $OnboardingPageModelCopyWith<$Res>  {
  factory $OnboardingPageModelCopyWith(OnboardingPageModel value, $Res Function(OnboardingPageModel) _then) = _$OnboardingPageModelCopyWithImpl;
@useResult
$Res call({
 String icon, String title, String description
});




}
/// @nodoc
class _$OnboardingPageModelCopyWithImpl<$Res>
    implements $OnboardingPageModelCopyWith<$Res> {
  _$OnboardingPageModelCopyWithImpl(this._self, this._then);

  final OnboardingPageModel _self;
  final $Res Function(OnboardingPageModel) _then;

/// Create a copy of OnboardingPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icon = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingPageModel].
extension OnboardingPageModelPatterns on OnboardingPageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingPageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingPageModel value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingPageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingPageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String icon,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingPageModel() when $default != null:
return $default(_that.icon,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String icon,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _OnboardingPageModel():
return $default(_that.icon,_that.title,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String icon,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingPageModel() when $default != null:
return $default(_that.icon,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingPageModel implements OnboardingPageModel {
  const _OnboardingPageModel({required this.icon, required this.title, required this.description});
  factory _OnboardingPageModel.fromJson(Map<String, dynamic> json) => _$OnboardingPageModelFromJson(json);

@override final  String icon;
@override final  String title;
@override final  String description;

/// Create a copy of OnboardingPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingPageModelCopyWith<_OnboardingPageModel> get copyWith => __$OnboardingPageModelCopyWithImpl<_OnboardingPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingPageModel&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,title,description);

@override
String toString() {
  return 'OnboardingPageModel(icon: $icon, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$OnboardingPageModelCopyWith<$Res> implements $OnboardingPageModelCopyWith<$Res> {
  factory _$OnboardingPageModelCopyWith(_OnboardingPageModel value, $Res Function(_OnboardingPageModel) _then) = __$OnboardingPageModelCopyWithImpl;
@override @useResult
$Res call({
 String icon, String title, String description
});




}
/// @nodoc
class __$OnboardingPageModelCopyWithImpl<$Res>
    implements _$OnboardingPageModelCopyWith<$Res> {
  __$OnboardingPageModelCopyWithImpl(this._self, this._then);

  final _OnboardingPageModel _self;
  final $Res Function(_OnboardingPageModel) _then;

/// Create a copy of OnboardingPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icon = null,Object? title = null,Object? description = null,}) {
  return _then(_OnboardingPageModel(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
