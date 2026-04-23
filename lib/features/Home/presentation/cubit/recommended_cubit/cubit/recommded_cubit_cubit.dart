import 'package:bloc/bloc.dart';
import 'package:grocery2/features/Home/data/recomended_repo/repo_recommendation.dart';
import 'package:grocery2/features/Home/presentation/cubit/recommended_cubit/cubit/recommded_cubit_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  final RecommendationRepository _repo;
  RecommendationCubit(this._repo) : super(RecommendationInitial());
 
  Future<void> loadRecommendations() async {
    emit(RecommendationLoading());
    try {
      final meals =  await _repo.getRecommendations(); 
      emit(RecommendationSuccess(  meals));
    } catch (e) {
      emit(RecommendationError(e.toString()));
    }
  }
}