// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_resume_builder_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiResumeBuilderState {

 ResumeData get resumeData; bool get isLoading; List<String> get errors;
/// Create a copy of AiResumeBuilderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResumeBuilderStateCopyWith<AiResumeBuilderState> get copyWith => _$AiResumeBuilderStateCopyWithImpl<AiResumeBuilderState>(this as AiResumeBuilderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResumeBuilderState&&(identical(other.resumeData, resumeData) || other.resumeData == resumeData)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.errors, errors));
}


@override
int get hashCode => Object.hash(runtimeType,resumeData,isLoading,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'AiResumeBuilderState(resumeData: $resumeData, isLoading: $isLoading, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $AiResumeBuilderStateCopyWith<$Res>  {
  factory $AiResumeBuilderStateCopyWith(AiResumeBuilderState value, $Res Function(AiResumeBuilderState) _then) = _$AiResumeBuilderStateCopyWithImpl;
@useResult
$Res call({
 ResumeData resumeData, bool isLoading, List<String> errors
});


$ResumeDataCopyWith<$Res> get resumeData;

}
/// @nodoc
class _$AiResumeBuilderStateCopyWithImpl<$Res>
    implements $AiResumeBuilderStateCopyWith<$Res> {
  _$AiResumeBuilderStateCopyWithImpl(this._self, this._then);

  final AiResumeBuilderState _self;
  final $Res Function(AiResumeBuilderState) _then;

/// Create a copy of AiResumeBuilderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resumeData = null,Object? isLoading = null,Object? errors = null,}) {
  return _then(_self.copyWith(
resumeData: null == resumeData ? _self.resumeData : resumeData // ignore: cast_nullable_to_non_nullable
as ResumeData,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of AiResumeBuilderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<$Res> get resumeData {
  
  return $ResumeDataCopyWith<$Res>(_self.resumeData, (value) {
    return _then(_self.copyWith(resumeData: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiResumeBuilderState].
extension AiResumeBuilderStatePatterns on AiResumeBuilderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiResumeBuilderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiResumeBuilderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiResumeBuilderState value)  $default,){
final _that = this;
switch (_that) {
case _AiResumeBuilderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiResumeBuilderState value)?  $default,){
final _that = this;
switch (_that) {
case _AiResumeBuilderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ResumeData resumeData,  bool isLoading,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiResumeBuilderState() when $default != null:
return $default(_that.resumeData,_that.isLoading,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ResumeData resumeData,  bool isLoading,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _AiResumeBuilderState():
return $default(_that.resumeData,_that.isLoading,_that.errors);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ResumeData resumeData,  bool isLoading,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _AiResumeBuilderState() when $default != null:
return $default(_that.resumeData,_that.isLoading,_that.errors);case _:
  return null;

}
}

}

/// @nodoc


class _AiResumeBuilderState extends AiResumeBuilderState {
  const _AiResumeBuilderState({this.resumeData = const ResumeData(), this.isLoading = false, final  List<String> errors = const <String>[]}): _errors = errors,super._();
  

@override@JsonKey() final  ResumeData resumeData;
@override@JsonKey() final  bool isLoading;
 final  List<String> _errors;
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of AiResumeBuilderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiResumeBuilderStateCopyWith<_AiResumeBuilderState> get copyWith => __$AiResumeBuilderStateCopyWithImpl<_AiResumeBuilderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiResumeBuilderState&&(identical(other.resumeData, resumeData) || other.resumeData == resumeData)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,resumeData,isLoading,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'AiResumeBuilderState(resumeData: $resumeData, isLoading: $isLoading, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$AiResumeBuilderStateCopyWith<$Res> implements $AiResumeBuilderStateCopyWith<$Res> {
  factory _$AiResumeBuilderStateCopyWith(_AiResumeBuilderState value, $Res Function(_AiResumeBuilderState) _then) = __$AiResumeBuilderStateCopyWithImpl;
@override @useResult
$Res call({
 ResumeData resumeData, bool isLoading, List<String> errors
});


@override $ResumeDataCopyWith<$Res> get resumeData;

}
/// @nodoc
class __$AiResumeBuilderStateCopyWithImpl<$Res>
    implements _$AiResumeBuilderStateCopyWith<$Res> {
  __$AiResumeBuilderStateCopyWithImpl(this._self, this._then);

  final _AiResumeBuilderState _self;
  final $Res Function(_AiResumeBuilderState) _then;

/// Create a copy of AiResumeBuilderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resumeData = null,Object? isLoading = null,Object? errors = null,}) {
  return _then(_AiResumeBuilderState(
resumeData: null == resumeData ? _self.resumeData : resumeData // ignore: cast_nullable_to_non_nullable
as ResumeData,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of AiResumeBuilderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<$Res> get resumeData {
  
  return $ResumeDataCopyWith<$Res>(_self.resumeData, (value) {
    return _then(_self.copyWith(resumeData: value));
  });
}
}

// dart format on
