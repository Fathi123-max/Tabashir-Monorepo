// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_initialization_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppInitializationState {

 bool get isInitialized; bool get isLoading; String? get errorMessage; UserProfileResponse? get userProfile; List<ResumeItem>? get resumes; HomeDashboardResponse? get homeDashboard;
/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppInitializationStateCopyWith<AppInitializationState> get copyWith => _$AppInitializationStateCopyWithImpl<AppInitializationState>(this as AppInitializationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppInitializationState&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile)&&const DeepCollectionEquality().equals(other.resumes, resumes)&&(identical(other.homeDashboard, homeDashboard) || other.homeDashboard == homeDashboard));
}


@override
int get hashCode => Object.hash(runtimeType,isInitialized,isLoading,errorMessage,userProfile,const DeepCollectionEquality().hash(resumes),homeDashboard);

@override
String toString() {
  return 'AppInitializationState(isInitialized: $isInitialized, isLoading: $isLoading, errorMessage: $errorMessage, userProfile: $userProfile, resumes: $resumes, homeDashboard: $homeDashboard)';
}


}

/// @nodoc
abstract mixin class $AppInitializationStateCopyWith<$Res>  {
  factory $AppInitializationStateCopyWith(AppInitializationState value, $Res Function(AppInitializationState) _then) = _$AppInitializationStateCopyWithImpl;
@useResult
$Res call({
 bool isInitialized, bool isLoading, String? errorMessage, UserProfileResponse? userProfile, List<ResumeItem>? resumes, HomeDashboardResponse? homeDashboard
});


$UserProfileResponseCopyWith<$Res>? get userProfile;$HomeDashboardResponseCopyWith<$Res>? get homeDashboard;

}
/// @nodoc
class _$AppInitializationStateCopyWithImpl<$Res>
    implements $AppInitializationStateCopyWith<$Res> {
  _$AppInitializationStateCopyWithImpl(this._self, this._then);

  final AppInitializationState _self;
  final $Res Function(AppInitializationState) _then;

/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isInitialized = null,Object? isLoading = null,Object? errorMessage = freezed,Object? userProfile = freezed,Object? resumes = freezed,Object? homeDashboard = freezed,}) {
  return _then(_self.copyWith(
isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileResponse?,resumes: freezed == resumes ? _self.resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeItem>?,homeDashboard: freezed == homeDashboard ? _self.homeDashboard : homeDashboard // ignore: cast_nullable_to_non_nullable
as HomeDashboardResponse?,
  ));
}
/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileResponseCopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileResponseCopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeDashboardResponseCopyWith<$Res>? get homeDashboard {
    if (_self.homeDashboard == null) {
    return null;
  }

  return $HomeDashboardResponseCopyWith<$Res>(_self.homeDashboard!, (value) {
    return _then(_self.copyWith(homeDashboard: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppInitializationState].
extension AppInitializationStatePatterns on AppInitializationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppInitializationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppInitializationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppInitializationState value)  $default,){
final _that = this;
switch (_that) {
case _AppInitializationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppInitializationState value)?  $default,){
final _that = this;
switch (_that) {
case _AppInitializationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isInitialized,  bool isLoading,  String? errorMessage,  UserProfileResponse? userProfile,  List<ResumeItem>? resumes,  HomeDashboardResponse? homeDashboard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppInitializationState() when $default != null:
return $default(_that.isInitialized,_that.isLoading,_that.errorMessage,_that.userProfile,_that.resumes,_that.homeDashboard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isInitialized,  bool isLoading,  String? errorMessage,  UserProfileResponse? userProfile,  List<ResumeItem>? resumes,  HomeDashboardResponse? homeDashboard)  $default,) {final _that = this;
switch (_that) {
case _AppInitializationState():
return $default(_that.isInitialized,_that.isLoading,_that.errorMessage,_that.userProfile,_that.resumes,_that.homeDashboard);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isInitialized,  bool isLoading,  String? errorMessage,  UserProfileResponse? userProfile,  List<ResumeItem>? resumes,  HomeDashboardResponse? homeDashboard)?  $default,) {final _that = this;
switch (_that) {
case _AppInitializationState() when $default != null:
return $default(_that.isInitialized,_that.isLoading,_that.errorMessage,_that.userProfile,_that.resumes,_that.homeDashboard);case _:
  return null;

}
}

}

/// @nodoc


class _AppInitializationState implements AppInitializationState {
  const _AppInitializationState({this.isInitialized = false, this.isLoading = false, this.errorMessage, this.userProfile, final  List<ResumeItem>? resumes, this.homeDashboard}): _resumes = resumes;
  

@override@JsonKey() final  bool isInitialized;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;
@override final  UserProfileResponse? userProfile;
 final  List<ResumeItem>? _resumes;
@override List<ResumeItem>? get resumes {
  final value = _resumes;
  if (value == null) return null;
  if (_resumes is EqualUnmodifiableListView) return _resumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  HomeDashboardResponse? homeDashboard;

/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppInitializationStateCopyWith<_AppInitializationState> get copyWith => __$AppInitializationStateCopyWithImpl<_AppInitializationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppInitializationState&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile)&&const DeepCollectionEquality().equals(other._resumes, _resumes)&&(identical(other.homeDashboard, homeDashboard) || other.homeDashboard == homeDashboard));
}


@override
int get hashCode => Object.hash(runtimeType,isInitialized,isLoading,errorMessage,userProfile,const DeepCollectionEquality().hash(_resumes),homeDashboard);

@override
String toString() {
  return 'AppInitializationState(isInitialized: $isInitialized, isLoading: $isLoading, errorMessage: $errorMessage, userProfile: $userProfile, resumes: $resumes, homeDashboard: $homeDashboard)';
}


}

/// @nodoc
abstract mixin class _$AppInitializationStateCopyWith<$Res> implements $AppInitializationStateCopyWith<$Res> {
  factory _$AppInitializationStateCopyWith(_AppInitializationState value, $Res Function(_AppInitializationState) _then) = __$AppInitializationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isInitialized, bool isLoading, String? errorMessage, UserProfileResponse? userProfile, List<ResumeItem>? resumes, HomeDashboardResponse? homeDashboard
});


@override $UserProfileResponseCopyWith<$Res>? get userProfile;@override $HomeDashboardResponseCopyWith<$Res>? get homeDashboard;

}
/// @nodoc
class __$AppInitializationStateCopyWithImpl<$Res>
    implements _$AppInitializationStateCopyWith<$Res> {
  __$AppInitializationStateCopyWithImpl(this._self, this._then);

  final _AppInitializationState _self;
  final $Res Function(_AppInitializationState) _then;

/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isInitialized = null,Object? isLoading = null,Object? errorMessage = freezed,Object? userProfile = freezed,Object? resumes = freezed,Object? homeDashboard = freezed,}) {
  return _then(_AppInitializationState(
isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileResponse?,resumes: freezed == resumes ? _self._resumes : resumes // ignore: cast_nullable_to_non_nullable
as List<ResumeItem>?,homeDashboard: freezed == homeDashboard ? _self.homeDashboard : homeDashboard // ignore: cast_nullable_to_non_nullable
as HomeDashboardResponse?,
  ));
}

/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileResponseCopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileResponseCopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}/// Create a copy of AppInitializationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeDashboardResponseCopyWith<$Res>? get homeDashboard {
    if (_self.homeDashboard == null) {
    return null;
  }

  return $HomeDashboardResponseCopyWith<$Res>(_self.homeDashboard!, (value) {
    return _then(_self.copyWith(homeDashboard: value));
  });
}
}

// dart format on
