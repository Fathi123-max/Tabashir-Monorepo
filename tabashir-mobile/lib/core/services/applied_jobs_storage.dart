import 'package:shared_preferences/shared_preferences.dart';

/// Simple persistence helper for storing applied job IDs locally.
class AppliedJobsStorage {
  static const _appliedJobsKey = 'applied_job_ids';

  /// Returns the set of job IDs the user has applied to.
  Future<Set<String>> getAppliedJobIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_appliedJobsKey) ?? <String>[];
    return ids.toSet();
  }

  /// Replaces the stored set with the provided IDs.
  Future<void> setAppliedJobIds(Set<String> jobIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_appliedJobsKey, jobIds.toList());
  }

  /// Adds a job ID to the stored set (no-op if already present).
  Future<void> addAppliedJobId(String jobId) async {
    final currentIds = await getAppliedJobIds();
    if (currentIds.add(jobId)) {
      await setAppliedJobIds(currentIds);
    }
  }

  /// Clears all stored IDs.
  Future<void> clearAppliedJobIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_appliedJobsKey);
  }
}
