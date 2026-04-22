import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/smart_lists_cubit.dart';
import '../cubit/smart_lists_state.dart';

class SmartListsTab extends StatelessWidget {
  const SmartListsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartListsCubit, SmartListsState>(
      builder: (context, state) {
        if (state is SmartListsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SmartListsLoaded) {
          return const Center(child: Text('Smart Lists Data'));
        }

        if (state is SmartListsError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
