import 'package:json_annotation/json_annotation.dart';

part 'profile_isar.g.dart';

/// Model for storing user profile data in SharedPreferences
/// This provides offline caching of profile information
@JsonSerializable()
class ProfileIsar {
  /// Constructor
  ProfileIsar({
    this.name,
    this.email,
    this.phone,
    this.nationality,
    this.gender,
    this.jobTitle,
    this.location,
    this.company,
    this.education,
    this.linkedin,
    this.userType,
    this.profileStrength,
    this.updatedAt,
  });

  /// Create from JSON
  factory ProfileIsar.fromJson(Map<String, dynamic> json) =>
      _$ProfileIsarFromJson(json);

  /// User's full name
  String? name;

  /// Email address
  String? email;

  /// Phone number
  String? phone;

  /// Nationality
  String? nationality;

  /// Gender
  String? gender;

  /// Job title
  String? jobTitle;

  /// Location
  String? location;

  /// Company
  String? company;

  /// Education
  String? education;

  /// LinkedIn profile URL
  String? linkedin;

  /// User type (CANDIDATE, RECRUITER, ADMIN)
  String? userType;

  /// Profile strength score
  int? profileStrength;

  /// When the profile was last updated
  DateTime? updatedAt;

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$ProfileIsarToJson(this);
}
