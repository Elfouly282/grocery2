import 'package:grocery2/features/profile&setting/data/models/profile_model.dart';

class ProfileState {
  final bool isLoading;
  final bool isUploadingPhoto;
  final bool isLoggingOut;
  final ProfileModel? profile;
  final String? localImagePath;
  final String? errorMessage;
  final bool logoutSuccess;

  const ProfileState({
    this.isLoading = false,
    this.isUploadingPhoto = false,
    this.isLoggingOut = false,
    this.profile,
    this.localImagePath,
    this.errorMessage,
    this.logoutSuccess = false,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isUploadingPhoto,
    bool? isLoggingOut,
    ProfileModel? profile,
    String? localImagePath,
    String? errorMessage,
    bool clearError = false,
    bool? logoutSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isUploadingPhoto: isUploadingPhoto ?? this.isUploadingPhoto,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      profile: profile ?? this.profile,
      localImagePath: localImagePath ?? this.localImagePath,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
    );
  }
}
