// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompanyState {

 CompanyStatus get status; String get errorMessage; List<CompanyProfile> get companies; CompanyProfile? get currentCompany; List<CompanyReview> get reviews;
/// Create a copy of CompanyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyStateCopyWith<CompanyState> get copyWith => _$CompanyStateCopyWithImpl<CompanyState>(this as CompanyState, _$identity);

  /// Serializes this CompanyState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.companies, companies)&&(identical(other.currentCompany, currentCompany) || other.currentCompany == currentCompany)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(companies),currentCompany,const DeepCollectionEquality().hash(reviews));

@override
String toString() {
  return 'CompanyState(status: $status, errorMessage: $errorMessage, companies: $companies, currentCompany: $currentCompany, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $CompanyStateCopyWith<$Res>  {
  factory $CompanyStateCopyWith(CompanyState value, $Res Function(CompanyState) _then) = _$CompanyStateCopyWithImpl;
@useResult
$Res call({
 CompanyStatus status, String errorMessage, List<CompanyProfile> companies, CompanyProfile? currentCompany, List<CompanyReview> reviews
});


$CompanyProfileCopyWith<$Res>? get currentCompany;

}
/// @nodoc
class _$CompanyStateCopyWithImpl<$Res>
    implements $CompanyStateCopyWith<$Res> {
  _$CompanyStateCopyWithImpl(this._self, this._then);

  final CompanyState _self;
  final $Res Function(CompanyState) _then;

/// Create a copy of CompanyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? companies = null,Object? currentCompany = freezed,Object? reviews = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompanyStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,companies: null == companies ? _self.companies : companies // ignore: cast_nullable_to_non_nullable
as List<CompanyProfile>,currentCompany: freezed == currentCompany ? _self.currentCompany : currentCompany // ignore: cast_nullable_to_non_nullable
as CompanyProfile?,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<CompanyReview>,
  ));
}
/// Create a copy of CompanyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyProfileCopyWith<$Res>? get currentCompany {
    if (_self.currentCompany == null) {
    return null;
  }

  return $CompanyProfileCopyWith<$Res>(_self.currentCompany!, (value) {
    return _then(_self.copyWith(currentCompany: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompanyState].
extension CompanyStatePatterns on CompanyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyState value)  $default,){
final _that = this;
switch (_that) {
case _CompanyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyState value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CompanyStatus status,  String errorMessage,  List<CompanyProfile> companies,  CompanyProfile? currentCompany,  List<CompanyReview> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.companies,_that.currentCompany,_that.reviews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CompanyStatus status,  String errorMessage,  List<CompanyProfile> companies,  CompanyProfile? currentCompany,  List<CompanyReview> reviews)  $default,) {final _that = this;
switch (_that) {
case _CompanyState():
return $default(_that.status,_that.errorMessage,_that.companies,_that.currentCompany,_that.reviews);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CompanyStatus status,  String errorMessage,  List<CompanyProfile> companies,  CompanyProfile? currentCompany,  List<CompanyReview> reviews)?  $default,) {final _that = this;
switch (_that) {
case _CompanyState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.companies,_that.currentCompany,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyState implements CompanyState {
  const _CompanyState({this.status = CompanyStatus.initial, this.errorMessage = '', final  List<CompanyProfile> companies = const [], this.currentCompany, final  List<CompanyReview> reviews = const []}): _companies = companies,_reviews = reviews;
  factory _CompanyState.fromJson(Map<String, dynamic> json) => _$CompanyStateFromJson(json);

@override@JsonKey() final  CompanyStatus status;
@override@JsonKey() final  String errorMessage;
 final  List<CompanyProfile> _companies;
@override@JsonKey() List<CompanyProfile> get companies {
  if (_companies is EqualUnmodifiableListView) return _companies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companies);
}

@override final  CompanyProfile? currentCompany;
 final  List<CompanyReview> _reviews;
@override@JsonKey() List<CompanyReview> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of CompanyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyStateCopyWith<_CompanyState> get copyWith => __$CompanyStateCopyWithImpl<_CompanyState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._companies, _companies)&&(identical(other.currentCompany, currentCompany) || other.currentCompany == currentCompany)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(_companies),currentCompany,const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'CompanyState(status: $status, errorMessage: $errorMessage, companies: $companies, currentCompany: $currentCompany, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$CompanyStateCopyWith<$Res> implements $CompanyStateCopyWith<$Res> {
  factory _$CompanyStateCopyWith(_CompanyState value, $Res Function(_CompanyState) _then) = __$CompanyStateCopyWithImpl;
@override @useResult
$Res call({
 CompanyStatus status, String errorMessage, List<CompanyProfile> companies, CompanyProfile? currentCompany, List<CompanyReview> reviews
});


@override $CompanyProfileCopyWith<$Res>? get currentCompany;

}
/// @nodoc
class __$CompanyStateCopyWithImpl<$Res>
    implements _$CompanyStateCopyWith<$Res> {
  __$CompanyStateCopyWithImpl(this._self, this._then);

  final _CompanyState _self;
  final $Res Function(_CompanyState) _then;

/// Create a copy of CompanyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? companies = null,Object? currentCompany = freezed,Object? reviews = null,}) {
  return _then(_CompanyState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CompanyStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,companies: null == companies ? _self._companies : companies // ignore: cast_nullable_to_non_nullable
as List<CompanyProfile>,currentCompany: freezed == currentCompany ? _self.currentCompany : currentCompany // ignore: cast_nullable_to_non_nullable
as CompanyProfile?,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<CompanyReview>,
  ));
}

/// Create a copy of CompanyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyProfileCopyWith<$Res>? get currentCompany {
    if (_self.currentCompany == null) {
    return null;
  }

  return $CompanyProfileCopyWith<$Res>(_self.currentCompany!, (value) {
    return _then(_self.copyWith(currentCompany: value));
  });
}
}

// dart format on
