import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tabashir/core/network/services/job/saved_jobs_api_service.dart';

/// Service for managing saved jobs using SharedPreferences
class IsarService {
  factory IsarService() => _instance;
  IsarService._internal();
  static final IsarService _instance = IsarService._internal();

  SharedPreferences? _prefs;

  /// Initialize the service
  Future<void> init() async {
    if (_prefs != null) return;
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get the SharedPreferences instance
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('Service not initialized. Call init() first.');
    }
    return _prefs!;
  }

  /// Close the service
  Future<void> close() async {
    _prefs = null;
  }
}

/// Saved jobs repository using local storage only
class SavedJobsRepository {
  SavedJobsRepository(this._apiService);
  final SavedJobsApiService? _apiService;

  final _savedJobsController = StreamController<Set<String>>.broadcast();
  Stream<Set<String>> get savedJobsStream => _savedJobsController.stream;
  Set<String> _cachedSavedIds = {};

  Future<void> saveJob(String jobId) async {
    try {
      print('[SAVED_JOBS_REPO] Saving job $jobId...');

      // Optimistic update for UI responsiveness
      _cachedSavedIds.add(jobId);
      _savedJobsController.add(_cachedSavedIds);

      // 1. Save to API first to ensure backend persistence
      if (_apiService != null) {
        await _apiService.saveJob({'jobId': jobId});
        print('[SAVED_JOBS_REPO] Successfully saved job $jobId to API');
      }

      // 2. Save to local storage for offline access and fallback
      await _saveJobLocally(jobId);
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error saving job: $e');
      // Revert on failure to keep UI consistent with reality
      _cachedSavedIds.remove(jobId);
      _savedJobsController.add(_cachedSavedIds);
      rethrow;
    }
  }

  Future<void> removeSavedJob(String jobId) async {
    try {
      print('[SAVED_JOBS_REPO] Removing saved job $jobId...');

      // Optimistic update
      _cachedSavedIds.remove(jobId);
      _savedJobsController.add(_cachedSavedIds);

      // 1. Remove from API
      if (_apiService != null) {
        await _apiService.unsaveJob(jobId);
        print('[SAVED_JOBS_REPO] Successfully removed job $jobId from API');
      }

      // 2. Remove from local storage
      await _removeJobLocally(jobId);
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error removing saved job: $e');
      // Revert on failure
      _cachedSavedIds.add(jobId);
      _savedJobsController.add(_cachedSavedIds);
      rethrow;
    }
  }

  Future<bool> isJobSaved(String jobId) async {
    if (_cachedSavedIds.isEmpty) {
      // If cache is empty, try to load (this will try API first)
      await getAllSavedJobIds();
    }
    return _cachedSavedIds.contains(jobId);
  }

  Future<List<String>> getAllSavedJobIds() async {
    try {
      print('[SAVED_JOBS_REPO] getAllSavedJobIds() called');

      // 1. Try to fetch from API - this is our source of truth
      if (_apiService != null) {
        print(
          '[SAVED_JOBS_REPO] Fetching latest saved jobs from Python API...',
        );
        final response = await _apiService.getSavedJobs();

        if (response.success) {
          final rawSavedJobs = response.savedJobs;
          print('[SAVED_JOBS_REPO] API returned ${rawSavedJobs.length} items');

          // Python backend returns objects, extract IDs
          final savedJobIds = <String>[];
          for (final item in rawSavedJobs) {
            if (item is String) {
              savedJobIds.add(item);
            } else if (item is Map) {
              final dynamic id = item['id'] ?? item['jobId'];
              if (id != null) {
                savedJobIds.add(id.toString());
              }
            }
          }

          print(
            '[SAVED_JOBS_REPO] ✅ Extracted ${savedJobIds.length} saved job IDs',
          );

          // Update local cache and persistent storage to match API
          await _saveSavedJobIds(savedJobIds);
          _cachedSavedIds = savedJobIds.toSet();
          _savedJobsController.add(_cachedSavedIds);

          return savedJobIds;
        }
      }

      // 2. Fallback to local storage if API is null or call fails
      print('[SAVED_JOBS_REPO] Falling back to local storage...');
      final savedJobIds = await _loadSavedJobIds();
      print(
        '[SAVED_JOBS_REPO] Fetched ${savedJobIds.length} saved jobs from local storage',
      );
      _cachedSavedIds = savedJobIds.toSet();
      _savedJobsController.add(_cachedSavedIds);
      return savedJobIds;
    } catch (e) {
      print('[SAVED_JOBS_REPO] ❌ Error fetching saved jobs: $e');

      // Final fallback to whatever is in local storage
      final savedJobIds = await _loadSavedJobIds();
      _cachedSavedIds = savedJobIds.toSet();
      _savedJobsController.add(_cachedSavedIds);
      return savedJobIds;
    }
  }

  Future<void> clearAllSavedJobs() async {
    // Note: We only clear locally for now as there's no "clear all" API endpoint
    await _clearAllSavedJobsLocally();
    _cachedSavedIds.clear();
    _savedJobsController.add(_cachedSavedIds);
  }

  Future<void> syncJobs(List<Map<String, dynamic>> jobs) async {
    // For now, just sync to local storage or API if needed
    print('[SAVED_JOBS_REPO] Syncing ${jobs.length} jobs to local cache');
    // Implementation could be added here for background synchronization
  }

  // Local storage methods (Private)
  Future<void> _saveJobLocally(String jobId) async {
    final savedJobIds = await _loadSavedJobIds();
    if (!savedJobIds.contains(jobId)) {
      savedJobIds.add(jobId);
      await _saveSavedJobIds(savedJobIds);
    }
  }

  Future<void> _removeJobLocally(String jobId) async {
    final savedJobIds = await _loadSavedJobIds();
    if (savedJobIds.contains(jobId)) {
      savedJobIds.remove(jobId);
      await _saveSavedJobIds(savedJobIds);
    }
  }

  Future<List<String>> _loadSavedJobIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('saved_job_ids') ?? [];
  }

  Future<void> _saveSavedJobIds(List<String> jobIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_job_ids', jobIds);
  }

  Future<void> _clearAllSavedJobsLocally() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_job_ids');
  }
}
