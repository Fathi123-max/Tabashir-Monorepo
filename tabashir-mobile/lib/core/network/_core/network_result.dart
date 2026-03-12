/// A generic wrapper for network operation results
/// Helps handle success/error states in a type-safe way
sealed class NetworkResult<T> {
  const NetworkResult();
}

/// Represents a successful network operation
class NetworkSuccess<T> extends NetworkResult<T> {
  const NetworkSuccess(this.data);

  /// The data returned from the successful operation
  final T data;
}

/// Represents a failed network operation
class NetworkError<T> extends NetworkResult<T> {
  const NetworkError({
    required this.message,
    this.statusCode,
    this.exception,
  });

  /// Human-readable error message
  final String message;

  /// HTTP status code (if applicable)
  final int? statusCode;

  /// The underlying exception (if any)
  final Exception? exception;
}

/// Helper extension for NetworkResult
extension NetworkResultExtension<T> on NetworkResult<T> {
  /// Returns true if this is a success result
  bool get isSuccess => this is NetworkSuccess<T>;

  /// Returns true if this is an error result
  bool get isError => this is NetworkError<T>;

  /// Returns the data if this is a success, otherwise returns null
  T? get dataOrNull {
    if (this case NetworkSuccess(data: final data)) {
      return data;
    }
    return null;
  }

  /// Returns the error message if this is an error, otherwise returns null
  String? get errorOrNull {
    if (this case NetworkError(message: final message)) {
      return message;
    }
    return null;
  }
}
