import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/constants/preference_manager.dart';
import 'package:grocery2/core/constants/storage_keys.dart';
import 'package:grocery2/features/profile&setting/data/repo/profile_repo.dart';
import 'package:grocery2/features/profile&setting/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  final PreferenceManager preferenceManager;

  ProfileCubit({required this.repo, required this.preferenceManager})
    : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(
      state.copyWith(isLoading: true, clearError: true, logoutSuccess: false),
    );

    try {
      final profile = await repo.getProfile();
      emit(
        state.copyWith(isLoading: false, profile: profile, clearError: true),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> uploadPhoto(File file) async {
    emit(
      state.copyWith(
        isUploadingPhoto: true,
        localImagePath: file.path,
        clearError: true,
      ),
    );

    try {
      final profile = await repo.uploadProfilePhoto(file);
      emit(
        state.copyWith(
          isUploadingPhoto: false,
          profile: profile,
          localImagePath: file.path,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isUploadingPhoto: false, errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(
      state.copyWith(
        isLoggingOut: true,
        clearError: true,
        logoutSuccess: false,
      ),
    );

    try {
      await repo.logout();
      await _clearSession();
      emit(
        state.copyWith(
          isLoggingOut: false,
          logoutSuccess: true,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoggingOut: false, errorMessage: e.toString()));
    }
  }

  void clearTransientState() {
    emit(state.copyWith(clearError: true, logoutSuccess: false));
  }

  Future<void> _clearSession() async {
    await preferenceManager.setBool('isLoggedIn', false);
    await preferenceManager.remove(StorageKeys.authToken);
    await preferenceManager.remove('token');
  }
}
