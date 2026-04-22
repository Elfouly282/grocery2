import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavoritesLoaded) {
          return const Center(child: Text('Favorites Data'));
        }

        if (state is FavoritesError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
