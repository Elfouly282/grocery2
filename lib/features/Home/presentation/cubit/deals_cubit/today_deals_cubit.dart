import 'package:bloc/bloc.dart';
import 'package:grocery2/features/Home/data/repo.dart';
import 'package:grocery2/features/Home/presentation/cubit/deals_cubit/today_deals_state.dart';
 
class DealsCubit extends Cubit<DealsState> {
  final DealsRepository _repository;

  DealsCubit(this._repository) : super(DealsInitial());

  Future<void> fetchDeals() async {
    emit(DealsLoading());
    try {
      final deals = await _repository.getDeals();
      emit(DealsSuccess(deals));
    } catch (e) {
      emit(DealsError(e.toString()));
    }
  }
}

