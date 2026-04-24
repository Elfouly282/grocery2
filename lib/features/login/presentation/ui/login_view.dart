import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/login/presentation/cubit/login_cubit.dart';
import 'package:grocery2/core/constants/preference_manager.dart';
import '../../data/repo/repoImpl.dart';
import 'login_screen.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        AuthRepoImpl(preferenceManager: PreferenceManager()),
        preferenceManager: PreferenceManager(),
      ),
      child: const LoginScreen(),
    );
  }
}
