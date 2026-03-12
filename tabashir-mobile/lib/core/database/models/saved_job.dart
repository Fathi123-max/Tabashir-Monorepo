import 'package:isar/isar.dart';

// part 'saved_job.g.dart';

/// Model for storing saved jobs in Isar database
@collection
@Index()
class SavedJob {
  /// Constructor
  SavedJob({
    this.jobId,
    this.savedAt,
  });

  /// Unique identifier for the saved job
  Id id = Isar.autoIncrement;

  /// Job ID reference
  @Index(unique: true)
  String? jobId;

  /// When the job was saved
  DateTime? savedAt;
}
