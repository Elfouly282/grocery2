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

  Future<bool> toggleFavorite(int productId) async {
    final result = await toggleFavoriteUseCase(productId);
    return result.fold(
      (failure) {
        emit(FavoritesError(failure.message));
        return false;
      },
      (isFavorited) {
        if (state is FavoritesLoaded) {
          if (!isFavorited) {
            final updatedList = (state as FavoritesLoaded)
                .favorites
                .where((p) => p.id != productId)
                .toList();
            emit(FavoritesLoaded(updatedList));
          } else {
            load();
          }
        }
        return true;
      },
    );
  }
}
