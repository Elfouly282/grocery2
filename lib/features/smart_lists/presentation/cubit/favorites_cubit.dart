import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_favorites.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavorites getFavoritesUseCase;

  FavoritesCubit({required this.getFavoritesUseCase})
    : super(FavoritesInitial());

  void load() async {
    emit(FavoritesLoading());
    try {
      final favorites = await getFavoritesUseCase();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
