// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobsState()';
}


}

/// @nodoc
class $JobsStateCopyWith<$Res>  {
$JobsStateCopyWith(JobsState _, $Res Function(JobsState) __);
}


/// Adds pattern-matching-related methods to [JobsState].
extension JobsStatePatterns on JobsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JobsStateInitial value)?  initial,TResult Function( JobsStateLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JobsStateInitial() when initial != null:
return initial(_that);case JobsStateLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JobsStateInitial value)  initial,required TResult Function( JobsStateLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case JobsStateInitial():
return initial(_that);case JobsStateLoaded():
return loaded(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JobsStateInitial value)?  initial,TResult? Function( JobsStateLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case JobsStateInitial() when initial != null:
return initial(_that);case JobsStateLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String selectedSort,  bool isGridView,  bool showBanner,  String searchQuery,  String cardStyle,  List<JobUI> jobs,  List<String> selectedLocations,  List<String> selectedJobTypes,  List<String> selectedExperienceLevels,  int minSalary,  int maxSalary,  List<String> selectedSkills,  Set<String> savedJobs,  int currentPage,  int totalJobs,  int itemsPerPage,  bool hasMoreData,  bool isLoadingMore)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JobsStateInitial() when initial != null:
return initial();case JobsStateLoaded() when loaded != null:
return loaded(_that.selectedSort,_that.isGridView,_that.showBanner,_that.searchQuery,_that.cardStyle,_that.jobs,_that.selectedLocations,_that.selectedJobTypes,_that.selectedExperienceLevels,_that.minSalary,_that.maxSalary,_that.selectedSkills,_that.savedJobs,_that.currentPage,_that.totalJobs,_that.itemsPerPage,_that.hasMoreData,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String selectedSort,  bool isGridView,  bool showBanner,  String searchQuery,  String cardStyle,  List<JobUI> jobs,  List<String> selectedLocations,  List<String> selectedJobTypes,  List<String> selectedExperienceLevels,  int minSalary,  int maxSalary,  List<String> selectedSkills,  Set<String> savedJobs,  int currentPage,  int totalJobs,  int itemsPerPage,  bool hasMoreData,  bool isLoadingMore)  loaded,}) {final _that = this;
switch (_that) {
case JobsStateInitial():
return initial();case JobsStateLoaded():
return loaded(_that.selectedSort,_that.isGridView,_that.showBanner,_that.searchQuery,_that.cardStyle,_that.jobs,_that.selectedLocations,_that.selectedJobTypes,_that.selectedExperienceLevels,_that.minSalary,_that.maxSalary,_that.selectedSkills,_that.savedJobs,_that.currentPage,_that.totalJobs,_that.itemsPerPage,_that.hasMoreData,_that.isLoadingMore);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String selectedSort,  bool isGridView,  bool showBanner,  String searchQuery,  String cardStyle,  List<JobUI> jobs,  List<String> selectedLocations,  List<String> selectedJobTypes,  List<String> selectedExperienceLevels,  int minSalary,  int maxSalary,  List<String> selectedSkills,  Set<String> savedJobs,  int currentPage,  int totalJobs,  int itemsPerPage,  bool hasMoreData,  bool isLoadingMore)?  loaded,}) {final _that = this;
switch (_that) {
case JobsStateInitial() when initial != null:
return initial();case JobsStateLoaded() when loaded != null:
return loaded(_that.selectedSort,_that.isGridView,_that.showBanner,_that.searchQuery,_that.cardStyle,_that.jobs,_that.selectedLocations,_that.selectedJobTypes,_that.selectedExperienceLevels,_that.minSalary,_that.maxSalary,_that.selectedSkills,_that.savedJobs,_that.currentPage,_that.totalJobs,_that.itemsPerPage,_that.hasMoreData,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class JobsStateInitial implements JobsState {
  const JobsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobsState.initial()';
}


}




/// @nodoc


class JobsStateLoaded implements JobsState {
  const JobsStateLoaded({this.selectedSort = 'Relevance', this.isGridView = true, this.showBanner = true, this.searchQuery = '', this.cardStyle = 'standard', final  List<JobUI> jobs = const [], final  List<String> selectedLocations = const [], final  List<String> selectedJobTypes = const [], final  List<String> selectedExperienceLevels = const [], this.minSalary = 0, this.maxSalary = 500000, final  List<String> selectedSkills = const [], final  Set<String> savedJobs = const <String>{}, this.currentPage = 0, this.totalJobs = 0, this.itemsPerPage = 20, this.hasMoreData = true, this.isLoadingMore = false}): _jobs = jobs,_selectedLocations = selectedLocations,_selectedJobTypes = selectedJobTypes,_selectedExperienceLevels = selectedExperienceLevels,_selectedSkills = selectedSkills,_savedJobs = savedJobs;
  

@JsonKey() final  String selectedSort;
@JsonKey() final  bool isGridView;
@JsonKey() final  bool showBanner;
@JsonKey() final  String searchQuery;
@JsonKey() final  String cardStyle;
 final  List<JobUI> _jobs;
@JsonKey() List<JobUI> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}

 final  List<String> _selectedLocations;
@JsonKey() List<String> get selectedLocations {
  if (_selectedLocations is EqualUnmodifiableListView) return _selectedLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedLocations);
}

 final  List<String> _selectedJobTypes;
@JsonKey() List<String> get selectedJobTypes {
  if (_selectedJobTypes is EqualUnmodifiableListView) return _selectedJobTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedJobTypes);
}

 final  List<String> _selectedExperienceLevels;
@JsonKey() List<String> get selectedExperienceLevels {
  if (_selectedExperienceLevels is EqualUnmodifiableListView) return _selectedExperienceLevels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedExperienceLevels);
}

@JsonKey() final  int minSalary;
@JsonKey() final  int maxSalary;
 final  List<String> _selectedSkills;
@JsonKey() List<String> get selectedSkills {
  if (_selectedSkills is EqualUnmodifiableListView) return _selectedSkills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedSkills);
}

 final  Set<String> _savedJobs;
@JsonKey() Set<String> get savedJobs {
  if (_savedJobs is EqualUnmodifiableSetView) return _savedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_savedJobs);
}

// Pagination fields
@JsonKey() final  int currentPage;
@JsonKey() final  int totalJobs;
@JsonKey() final  int itemsPerPage;
@JsonKey() final  bool hasMoreData;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of JobsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobsStateLoadedCopyWith<JobsStateLoaded> get copyWith => _$JobsStateLoadedCopyWithImpl<JobsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsStateLoaded&&(identical(other.selectedSort, selectedSort) || other.selectedSort == selectedSort)&&(identical(other.isGridView, isGridView) || other.isGridView == isGridView)&&(identical(other.showBanner, showBanner) || other.showBanner == showBanner)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.cardStyle, cardStyle) || other.cardStyle == cardStyle)&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&const DeepCollectionEquality().equals(other._selectedLocations, _selectedLocations)&&const DeepCollectionEquality().equals(other._selectedJobTypes, _selectedJobTypes)&&const DeepCollectionEquality().equals(other._selectedExperienceLevels, _selectedExperienceLevels)&&(identical(other.minSalary, minSalary) || other.minSalary == minSalary)&&(identical(other.maxSalary, maxSalary) || other.maxSalary == maxSalary)&&const DeepCollectionEquality().equals(other._selectedSkills, _selectedSkills)&&const DeepCollectionEquality().equals(other._savedJobs, _savedJobs)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalJobs, totalJobs) || other.totalJobs == totalJobs)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage)&&(identical(other.hasMoreData, hasMoreData) || other.hasMoreData == hasMoreData)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,selectedSort,isGridView,showBanner,searchQuery,cardStyle,const DeepCollectionEquality().hash(_jobs),const DeepCollectionEquality().hash(_selectedLocations),const DeepCollectionEquality().hash(_selectedJobTypes),const DeepCollectionEquality().hash(_selectedExperienceLevels),minSalary,maxSalary,const DeepCollectionEquality().hash(_selectedSkills),const DeepCollectionEquality().hash(_savedJobs),currentPage,totalJobs,itemsPerPage,hasMoreData,isLoadingMore);

@override
String toString() {
  return 'JobsState.loaded(selectedSort: $selectedSort, isGridView: $isGridView, showBanner: $showBanner, searchQuery: $searchQuery, cardStyle: $cardStyle, jobs: $jobs, selectedLocations: $selectedLocations, selectedJobTypes: $selectedJobTypes, selectedExperienceLevels: $selectedExperienceLevels, minSalary: $minSalary, maxSalary: $maxSalary, selectedSkills: $selectedSkills, savedJobs: $savedJobs, currentPage: $currentPage, totalJobs: $totalJobs, itemsPerPage: $itemsPerPage, hasMoreData: $hasMoreData, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $JobsStateLoadedCopyWith<$Res> implements $JobsStateCopyWith<$Res> {
  factory $JobsStateLoadedCopyWith(JobsStateLoaded value, $Res Function(JobsStateLoaded) _then) = _$JobsStateLoadedCopyWithImpl;
@useResult
$Res call({
 String selectedSort, bool isGridView, bool showBanner, String searchQuery, String cardStyle, List<JobUI> jobs, List<String> selectedLocations, List<String> selectedJobTypes, List<String> selectedExperienceLevels, int minSalary, int maxSalary, List<String> selectedSkills, Set<String> savedJobs, int currentPage, int totalJobs, int itemsPerPage, bool hasMoreData, bool isLoadingMore
});




}
/// @nodoc
class _$JobsStateLoadedCopyWithImpl<$Res>
    implements $JobsStateLoadedCopyWith<$Res> {
  _$JobsStateLoadedCopyWithImpl(this._self, this._then);

  final JobsStateLoaded _self;
  final $Res Function(JobsStateLoaded) _then;

/// Create a copy of JobsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedSort = null,Object? isGridView = null,Object? showBanner = null,Object? searchQuery = null,Object? cardStyle = null,Object? jobs = null,Object? selectedLocations = null,Object? selectedJobTypes = null,Object? selectedExperienceLevels = null,Object? minSalary = null,Object? maxSalary = null,Object? selectedSkills = null,Object? savedJobs = null,Object? currentPage = null,Object? totalJobs = null,Object? itemsPerPage = null,Object? hasMoreData = null,Object? isLoadingMore = null,}) {
  return _then(JobsStateLoaded(
selectedSort: null == selectedSort ? _self.selectedSort : selectedSort // ignore: cast_nullable_to_non_nullable
as String,isGridView: null == isGridView ? _self.isGridView : isGridView // ignore: cast_nullable_to_non_nullable
as bool,showBanner: null == showBanner ? _self.showBanner : showBanner // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,cardStyle: null == cardStyle ? _self.cardStyle : cardStyle // ignore: cast_nullable_to_non_nullable
as String,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobUI>,selectedLocations: null == selectedLocations ? _self._selectedLocations : selectedLocations // ignore: cast_nullable_to_non_nullable
as List<String>,selectedJobTypes: null == selectedJobTypes ? _self._selectedJobTypes : selectedJobTypes // ignore: cast_nullable_to_non_nullable
as List<String>,selectedExperienceLevels: null == selectedExperienceLevels ? _self._selectedExperienceLevels : selectedExperienceLevels // ignore: cast_nullable_to_non_nullable
as List<String>,minSalary: null == minSalary ? _self.minSalary : minSalary // ignore: cast_nullable_to_non_nullable
as int,maxSalary: null == maxSalary ? _self.maxSalary : maxSalary // ignore: cast_nullable_to_non_nullable
as int,selectedSkills: null == selectedSkills ? _self._selectedSkills : selectedSkills // ignore: cast_nullable_to_non_nullable
as List<String>,savedJobs: null == savedJobs ? _self._savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as Set<String>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalJobs: null == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreData: null == hasMoreData ? _self.hasMoreData : hasMoreData // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
