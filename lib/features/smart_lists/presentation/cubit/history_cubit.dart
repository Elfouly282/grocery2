import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_history.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory getHistoryUseCase;

  HistoryCubit({required this.getHistoryUseCase}) : super(HistoryInitial());

  void load() async {
    emit(HistoryLoading());
    try {
      final history = await getHistoryUseCase();
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
