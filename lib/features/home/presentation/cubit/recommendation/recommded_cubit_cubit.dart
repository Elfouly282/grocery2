 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/home/data/logic/repo/repo_recommendation.dart';
import 'package:grocery2/features/home/presentation/cubit/recommendation/recommded_cubit_state.dart';

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

 