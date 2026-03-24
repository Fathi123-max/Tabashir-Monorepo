import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_vault_cubit.dart';
import 'resume_review_state.dart';

@injectable
class ResumeReviewCubit extends Cubit<ResumeReviewState> {
  final ProfileCubit profileCubit;
  final ResumeVaultCubit resumeVaultCubit;

  ResumeReviewCubit({
    required this.profileCubit,
    required this.resumeVaultCubit,
    @factoryParam Map<String, dynamic>? initialData,
  }) : super(ResumeReviewState(data: initialData ?? {}));

  void updatePersonalInfo({
    String? name,
    String? email,
    String? phone,
    String? location,
    String? linkedin,
  }) {
    if (isClosed) return;
    final newData = Map<String, dynamic>.from(state.data);
    if (name != null) newData['name'] = name;
    if (email != null) newData['email'] = email;
    if (phone != null) newData['phone'] = phone;
    if (location != null) newData['location'] = location;
    if (linkedin != null) newData['linkedin'] = linkedin;
    emit(state.copyWith(
      data: newData,
      status: ResumeReviewStatus.editing,
      profileSynced: false,
      vaultSynced: false,
    ));
  }

  void updateSummary(String summary) {
    if (isClosed) return;
    final newData = Map<String, dynamic>.from(state.data);
    newData['summary'] = summary;
    emit(state.copyWith(
      data: newData,
      status: ResumeReviewStatus.editing,
      profileSynced: false,
      vaultSynced: false,
    ));
  }

  void addExperience(Map<String, dynamic> experience) {
    if (isClosed) return;
    final newData = Map<String, dynamic>.from(state.data);
    final experiences = List<Map<String, dynamic>>.from(newData['experience'] ?? []);
    experiences.add(experience);
    newData['experience'] = experiences;
    emit(state.copyWith(
      data: newData,
      status: ResumeReviewStatus.editing,
      profileSynced: false,
      vaultSynced: false,
    ));
  }

  void removeExperience(int index) {
    if (isClosed) return;
    final newData = Map<String, dynamic>.from(state.data);
    final experiences = List<Map<String, dynamic>>.from(newData['experience'] ?? []);
    if (index >= 0 && index < experiences.length) {
      experiences.removeAt(index);
      newData['experience'] = experiences;
      emit(state.copyWith(
        data: newData,
        status: ResumeReviewStatus.editing,
        profileSynced: false,
        vaultSynced: false,
      ));
    }
  }

  void updateSkills(List<String> skills) {
    if (isClosed) return;
    final newData = Map<String, dynamic>.from(state.data);
    newData['skills'] = skills;
    emit(state.copyWith(
      data: newData,
      status: ResumeReviewStatus.editing,
      profileSynced: false,
      vaultSynced: false,
    ));
  }

  Future<void> confirmAndSave() async {
    if (isClosed) return;
    emit(state.copyWith(status: ResumeReviewStatus.syncing, errorMessage: null));

    // 1. Sync Profile
    if (!state.profileSynced) {
      try {
        await profileCubit.prefillFromParsedResume(state.data);
        if (!isClosed) {
          emit(state.copyWith(profileSynced: true));
        }
      } catch (e) {
        if (!isClosed) {
          emit(state.copyWith(
            status: ResumeReviewStatus.failure,
            errorMessage: 'Profile sync failed: ${e.toString()}',
          ));
        }
        return;
      }
    }

    // 2. Sync Vault (refreshing the list)
    if (!state.vaultSynced) {
      try {
        await resumeVaultCubit.loadResumes(force: true);
        if (!isClosed) {
          emit(state.copyWith(vaultSynced: true));
        }
      } catch (e) {
        if (!isClosed) {
          emit(state.copyWith(
            status: ResumeReviewStatus.failure,
            errorMessage: 'Vault sync failed: ${e.toString()}',
          ));
        }
        return;
      }
    }

    if (!isClosed && state.profileSynced && state.vaultSynced) {
      emit(state.copyWith(status: ResumeReviewStatus.success));
    }
  }
}
