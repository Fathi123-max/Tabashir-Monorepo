// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'formatted_cv_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormattedCVInput {

/// Output CV language type
 String? get outputLanguage;
/// Create a copy of FormattedCVInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormattedCVInputCopyWith<FormattedCVInput> get copyWith => _$FormattedCVInputCopyWithImpl<FormattedCVInput>(this as FormattedCVInput, _$identity);

  /// Serializes this FormattedCVInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormattedCVInput&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,outputLanguage);

@override
String toString() {
  return 'FormattedCVInput(outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class $FormattedCVInputCopyWith<$Res>  {
  factory $FormattedCVInputCopyWith(FormattedCVInput value, $Res Function(FormattedCVInput) _then) = _$FormattedCVInputCopyWithImpl;
@useResult
$Res call({
 String? outputLanguage
});




}
/// @nodoc
class _$FormattedCVInputCopyWithImpl<$Res>
    implements $FormattedCVInputCopyWith<$Res> {
  _$FormattedCVInputCopyWithImpl(this._self, this._then);

  final FormattedCVInput _self;
  final $Res Function(FormattedCVInput) _then;

/// Create a copy of FormattedCVInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? outputLanguage = freezed,}) {
  return _then(_self.copyWith(
outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FormattedCVInput].
extension FormattedCVInputPatterns on FormattedCVInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormattedCVInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormattedCVInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormattedCVInput value)  $default,){
final _that = this;
switch (_that) {
case _FormattedCVInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormattedCVInput value)?  $default,){
final _that = this;
switch (_that) {
case _FormattedCVInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? outputLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormattedCVInput() when $default != null:
return $default(_that.outputLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? outputLanguage)  $default,) {final _that = this;
switch (_that) {
case _FormattedCVInput():
return $default(_that.outputLanguage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? outputLanguage)?  $default,) {final _that = this;
switch (_that) {
case _FormattedCVInput() when $default != null:
return $default(_that.outputLanguage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormattedCVInput implements FormattedCVInput {
  const _FormattedCVInput({this.outputLanguage});
  factory _FormattedCVInput.fromJson(Map<String, dynamic> json) => _$FormattedCVInputFromJson(json);

/// Output CV language type
@override final  String? outputLanguage;

/// Create a copy of FormattedCVInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormattedCVInputCopyWith<_FormattedCVInput> get copyWith => __$FormattedCVInputCopyWithImpl<_FormattedCVInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormattedCVInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormattedCVInput&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,outputLanguage);

@override
String toString() {
  return 'FormattedCVInput(outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class _$FormattedCVInputCopyWith<$Res> implements $FormattedCVInputCopyWith<$Res> {
  factory _$FormattedCVInputCopyWith(_FormattedCVInput value, $Res Function(_FormattedCVInput) _then) = __$FormattedCVInputCopyWithImpl;
@override @useResult
$Res call({
 String? outputLanguage
});




}
/// @nodoc
class __$FormattedCVInputCopyWithImpl<$Res>
    implements _$FormattedCVInputCopyWith<$Res> {
  __$FormattedCVInputCopyWithImpl(this._self, this._then);

  final _FormattedCVInput _self;
  final $Res Function(_FormattedCVInput) _then;

/// Create a copy of FormattedCVInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? outputLanguage = freezed,}) {
  return _then(_FormattedCVInput(
outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
