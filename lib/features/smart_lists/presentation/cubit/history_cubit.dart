import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_order_history.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetOrderHistory getOrderHistoryUseCase;

  HistoryCubit({required this.getOrderHistoryUseCase})
    : super(HistoryInitial());

  Future<void> load() async {
    emit(HistoryLoading());
    final result = await getOrderHistoryUseCase();
    result.fold(
      (failure) => emit(HistoryError(failure.message)),
      (history) => emit(HistoryLoaded(history)),
    );
  }
}
