import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/core/di/get_it.dart';
import 'package:grocery2/features/on_boarding/presentation/UI/first_board.dart';
import 'package:grocery2/features/profile&setting/presentation/cubit/profile_cubit.dart';
import 'package:grocery2/features/profile&setting/presentation/cubit/profile_state.dart';
import 'package:grocery2/features/profile&setting/presentation/UI/settings.dart';
import 'package:grocery2/features/profile&setting/presentation/widgets/custom_list_tile.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickAndUploadPhoto() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null || !mounted) return;

    context.read<ProfileCubit>().uploadPhoto(File(image.path));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final avatarBgColor = isDark
        ? Colors.grey.shade800
        : const Color(0xFFEBEBF2);
    final textColor = isDark ? Colors.white : AppColor.text;

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<ProfileCubit>().clearTransientState();
        }

        if (state.logoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => FirstBoard()),
            (route) => false,
          );
          context.read<ProfileCubit>().clearTransientState();
        }
      },
      builder: (context, state) {
        final profile = state.profile;
        final displayName = profile?.displayName ?? 'Guest User';
        final displayEmail = profile?.email ?? '';
        final remoteImageUrl = profile?.imageUrl?.trim();
        final hasRemoteImage =
            remoteImageUrl != null && remoteImageUrl.isNotEmpty;

        ImageProvider<Object>? avatarImage;
        if (state.localImagePath != null && state.localImagePath!.isNotEmpty) {
          avatarImage = FileImage(File(state.localImagePath!));
        } else if (hasRemoteImage) {
          avatarImage = NetworkImage(remoteImageUrl);
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: avatarBgColor,
            title: const Text('My Profile'),

            centerTitle: true,
            actions: [
              IconButton(
                onPressed: state.isLoading
                    ? null
                    : () => context.read<ProfileCubit>().loadProfile(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: state.isLoading && profile == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: avatarBgColor,
                          backgroundImage: avatarImage,
                          child: avatarImage == null
                              ? Icon(
                                  Icons.person_outline_sharp,
                                  size: 60,
                                  color: textColor,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        displayName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (displayEmail.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          displayEmail,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Center(
                        child: InkWell(
                          onTap: state.isUploadingPhoto
                              ? null
                              : _pickAndUploadPhoto,
                          child: Text(
                            state.isUploadingPhoto
                                ? 'Uploading photo...'
                                : 'Edit Profile Photo',
                            style: TextStyle(fontSize: 16, color: textColor),
                          ),
                        ),
                      ),
                      customListTile(
                        context: context,
                        icon: const Icon(Icons.person_outline_outlined),
                        title: Text(displayName),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      customListTile(
                        context: context,
                        icon: const Icon(Icons.email_outlined),
                        title: Text(
                          displayEmail.isEmpty
                              ? 'No email found'
                              : displayEmail,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      customListTile(
                        context: context,
                        icon: const Icon(Icons.phone_outlined),
                        title: Text(
                          (profile?.phone.isNotEmpty ?? false)
                              ? profile!.phone
                              : 'No phone found',
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      customListTile(
                        context: context,
                        icon: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Settings(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      customListTile(
                        context: context,
                        icon: const Icon(Icons.help_outline),
                        title: const Text('Help & Support'),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: state.isLoggingOut
                            ? null
                            : () => context.read<ProfileCubit>().logout(),
                        leading: suffixIcon(
                          context: context,
                          icon: const Icon(Icons.logout),
                        ),
                        title: Text(
                          state.isLoggingOut ? 'Logging out...' : 'Logout',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
