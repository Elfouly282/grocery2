import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_smart_lists.dart';
import 'smart_lists_state.dart';

class SmartListsCubit extends Cubit<SmartListsState> {
  final GetSmartLists getSmartListsUseCase;

  SmartListsCubit(this.getSmartListsUseCase) : super(SmartListsInitial());

  void load() async {
    emit(SmartListsLoading());
    try {
      final smartLists = await getSmartListsUseCase();
      emit(SmartListsLoaded(smartLists));
    } catch (e) {
      emit(SmartListsError(e.toString()));
    }
  }
}
