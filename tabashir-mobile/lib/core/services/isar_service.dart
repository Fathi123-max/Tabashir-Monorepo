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
      // Optimistic update
      _cachedSavedIds.add(jobId);
      _savedJobsController.add(_cachedSavedIds);

      // Save to local storage only
      await _saveJobLocally(jobId);
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error saving job locally: $e');
      // Revert on failure
      _cachedSavedIds.remove(jobId);
      _savedJobsController.add(_cachedSavedIds);
      rethrow;
    }
  }

  Future<void> removeSavedJob(String jobId) async {
    try {
      // Optimistic update
      _cachedSavedIds.remove(jobId);
      _savedJobsController.add(_cachedSavedIds);

      // Remove from local storage only
      await _removeJobLocally(jobId);
    } catch (e) {
      print('[SAVED_JOBS_REPO] Error removing saved job locally: $e');
      // Revert on failure
      _cachedSavedIds.add(jobId);
      _savedJobsController.add(_cachedSavedIds);
      rethrow;
    }
  }

  Future<bool> isJobSaved(String jobId) async {
    if (_cachedSavedIds.isEmpty) {
      await getAllSavedJobIds();
    }
    return _cachedSavedIds.contains(jobId);
  }

  Future<List<String>> getAllSavedJobIds() async {
    try {
      // Load from local storage only
      final savedJobIds = await _loadSavedJobIds();
      print(
        '[SAVED_JOBS_REPO] Fetched ${savedJobIds.length} saved jobs from local storage',
      );
      _cachedSavedIds = savedJobIds.toSet();
      _savedJobsController.add(_cachedSavedIds);
      return savedJobIds;
    } catch (e) {
      print(
        '[SAVED_JOBS_REPO] Error fetching saved jobs from local storage: $e',
      );
      return [];
    }
  }

  Future<void> clearAllSavedJobs() async {
    // Clear locally only
    await _clearAllSavedJobsLocally();
    _cachedSavedIds.clear();
    _savedJobsController.add(_cachedSavedIds);
  }

  Future<void> syncJobs(List<Map<String, dynamic>> jobs) async {
    // For now, just sync to local storage
    print('[SAVED_JOBS_REPO] Synced ${jobs.length} jobs to local storage');
  }

  // Local storage methods
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
