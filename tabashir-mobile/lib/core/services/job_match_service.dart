import 'package:injectable/injectable.dart';

/// Service for formatting job match percentages from the backend
@injectable
class JobMatchService {
  /// Formats a match percentage value from the backend into a display string
  /// Expected value is a percentage string (e.g., "85") or numeric (85)
  String formatMatchPercentage(dynamic matchValue) {
    if (matchValue == null) {
      return '50% Match'; // Default if no data provided
    }

    if (matchValue is String) {
      if (matchValue.isEmpty) return '50% Match';
      // If it already has % or Match, return as is
      if (matchValue.contains('%') || matchValue.toLowerCase().contains('match')) {
        return matchValue;
      }
      return '$matchValue% Match';
    }

    if (matchValue is num) {
      return '${matchValue.toInt()}% Match';
    }

    return '50% Match';
  }
}
