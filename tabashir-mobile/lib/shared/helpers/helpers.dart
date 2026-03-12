import 'dart:convert';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:tabashir/core/constants/app_constants.dart' show AppConstants;
import 'package:url_launcher/url_launcher.dart';

/// Utility class for common helper functions
class Helpers {
  /// Format currency based on locale
  static String formatCurrency(num amount, {String currency = 'USD'}) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$', // Can be changed based on currency
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format date based on locale
  static String formatDate(DateTime date, {String pattern = 'MMM dd, yyyy'}) {
    final formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  /// Format date as relative time (e.g., "2 hours ago")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(AppConstants.emailPattern);
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number format
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(AppConstants.phonePattern);
    return phoneRegex.hasMatch(phone);
  }

  /// Format phone number
  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');

    // Add formatting based on length
    if (cleanPhone.length == 10) {
      return '(${cleanPhone.substring(0, 3)}) ${cleanPhone.substring(3, 6)}-${cleanPhone.substring(6)}';
    } else if (cleanPhone.length == 11 && cleanPhone.startsWith('1')) {
      return '+1 (${cleanPhone.substring(1, 4)}) ${cleanPhone.substring(4, 7)}-${cleanPhone.substring(7)}';
    }

    return phone;
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength - 3)}...';
  }

  /// Extract filename from URL
  static String extractFileName(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        return pathSegments.last;
      }
      return 'file';
    } catch (e) {
      return 'file';
    }
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Debounce function implementation
  static void debounce(Duration duration, void Function() callback) {
    Future.delayed(duration, callback);
  }

  // /// Deep copy of a map
  // static Map<String, dynamic>?? deepCopyMap(Map<String, dynamic> original) =>
  //     jsonDecode(jsonEncode(original));

  /// Launch URL in browser
  static Future<void> launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Check if string contains URL
  static bool containsUrl(String text) {
    final urlRegex = RegExp(
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(text);
  }

  /// Extract URLs from text
  static List<String> extractUrls(String text) {
    final urlRegex = RegExp(
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );
    return urlRegex.allMatches(text).map((match) => match.group(0)!).toList();
  }

  /// Sanitize HTML from text
  static String sanitizeHtml(String html) =>
      html.replaceAll(RegExp('<[^>]*>'), '');

  /// Generate random string
  static String generateRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final random = List.generate(
      length,
      (index) => chars[DateTime.now().millisecond % chars.length],
    );
    return random.join();
  }

  /// Calculate age from birth date
  static int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Check if year is leap year
  static bool isLeapYear(int year) =>
      (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);

  /// Convert camelCase to snake_case
  static String camelToSnakeCase(String camelCase) => camelCase
      .replaceAllMapped(
        RegExp('[A-Z]'),
        (match) => '_${match.group(0)!.toLowerCase()}',
      )
      .replaceAll(RegExp('^_'), '');

  /// Convert snake_case to camelCase
  static String snakeToCamelCase(String snakeCase) =>
      snakeCase.split('_').asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        if (index == 0) return value;
        return '${value[0].toUpperCase()}${value.substring(1)}';
      }).join();
}
