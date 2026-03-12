import '../../data/models/review_model.dart';

/// Base class for all review states
abstract class ReviewState {
  const ReviewState();

  bool get isLoading;
  bool get hasError;
  String get errorMessage;
  bool get isSubmitting;
  ReviewModel? get reviewData;
}

/// Initial state
class ReviewStateInitial extends ReviewState {
  const ReviewStateInitial();

  @override
  bool get isLoading => false;

  @override
  bool get hasError => false;

  @override
  String get errorMessage => '';

  @override
  bool get isSubmitting => false;

  @override
  ReviewModel? get reviewData => null;
}

/// Loading state
class ReviewStateLoading extends ReviewState {
  const ReviewStateLoading();

  @override
  bool get isLoading => true;

  @override
  bool get hasError => false;

  @override
  String get errorMessage => '';

  @override
  bool get isSubmitting => false;

  @override
  ReviewModel? get reviewData => null;
}

/// Loaded state with review data
class ReviewStateLoaded extends ReviewState {
  const ReviewStateLoaded(this.reviewData);

  @override
  final ReviewModel reviewData;

  @override
  bool get isLoading => false;

  @override
  bool get hasError => false;

  @override
  String get errorMessage => '';

  @override
  bool get isSubmitting => false;
}

/// Submitting state
class ReviewStateSubmitting extends ReviewState {
  const ReviewStateSubmitting(this.reviewData);

  @override
  final ReviewModel reviewData;

  @override
  bool get isLoading => false;

  @override
  bool get hasError => false;

  @override
  String get errorMessage => '';

  @override
  bool get isSubmitting => true;
}

/// Success state
class ReviewStateSuccess extends ReviewState {
  const ReviewStateSuccess(this.reviewData);

  @override
  final ReviewModel reviewData;

  @override
  bool get isLoading => false;

  @override
  bool get hasError => false;

  @override
  String get errorMessage => '';

  @override
  bool get isSubmitting => false;
}

/// Error state
class ReviewStateError extends ReviewState {
  const ReviewStateError(this.errorMessage, {this.reviewData});

  @override
  final String errorMessage;

  @override
  final ReviewModel? reviewData;

  @override
  bool get isLoading => false;

  @override
  bool get hasError => true;

  @override
  bool get isSubmitting => false;
}
