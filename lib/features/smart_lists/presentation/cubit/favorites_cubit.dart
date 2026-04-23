import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/toggle_favorite.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavorites getFavoritesUseCase;
  final ToggleFavorite toggleFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesInitial());

  Future<void> load() async {
    emit(FavoritesLoading());
    final result = await getFavoritesUseCase();
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> toggleFavorite(int productId) async {
    final result = await toggleFavoriteUseCase(productId);
    result.fold(
      (failure) =>
          emit(FavoritesError(failure.message)), // Emit error to notify UI
      (isFavorited) {
        if (state is FavoritesLoaded) {
          final currentList = (state as FavoritesLoaded).favorites;
          if (!isFavorited) {
            // Optimistically remove from list if toggled off
            final updatedList = currentList
                .where((p) => p.id != productId)
                .toList();
            emit(FavoritesLoaded(updatedList));
          } else {
            // Re-load if added back to ensure fresh data
            load();
          }
        }
      },
    );
  }
}
