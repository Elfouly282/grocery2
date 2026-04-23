import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/delete_smart_list.dart';
import '../../domain/usecases/get_smart_list_details.dart';
import '../../domain/usecases/get_smart_lists.dart';
import '../../domain/usecases/update_smart_list.dart';
import 'smart_lists_state.dart';

class SmartListsCubit extends Cubit<SmartListsState> {
  final GetSmartLists getSmartListsUseCase;
  final GetSmartListDetails getSmartListDetailsUseCase;
  final UpdateSmartList updateSmartListUseCase;
  final DeleteSmartList deleteSmartListUseCase;

  SmartListsCubit({
    required this.getSmartListsUseCase,
    required this.getSmartListDetailsUseCase,
    required this.updateSmartListUseCase,
    required this.deleteSmartListUseCase,
  }) : super(SmartListsInitial());

  Future<void> load() => fetchSmartLists();

  Future<void> fetchSmartLists() async {
    emit(SmartListsLoading());
    final result = await getSmartListsUseCase();
    result.fold(
      (failure) => emit(SmartListsError(failure.message)),
      (smartLists) => emit(SmartListsLoaded(smartLists)),
    );
  }

  Future<void> fetchSmartListDetails(int id) async {
    emit(SmartListsLoading());
    final result = await getSmartListDetailsUseCase(id);
    result.fold(
      (failure) => emit(SmartListsError(failure.message)),
      (smartList) => emit(SmartListDetailsSuccess(smartList)),
    );
  }

  Future<void> updateSmartList({
    required int id,
    String? name,
    String? description,
    File? image,
    List<int>? mealIds,
  }) async {
    emit(SmartListsLoading());
    final result = await updateSmartListUseCase(
      id: id,
      name: name,
      description: description,
      image: image,
      mealIds: mealIds,
    );
    result.fold(
      (failure) => emit(SmartListsError(failure.message)),
      (_) =>
          emit(const SmartListActionSuccess("Smart list updated successfully")),
    );
  }

  Future<void> deleteSmartList(int id) async {
    emit(SmartListsLoading());
    final result = await deleteSmartListUseCase(id);
    result.fold(
      (failure) => emit(SmartListsError(failure.message)),
      (_) =>
          emit(const SmartListActionSuccess("Smart list deleted successfully")),
    );
  }
}
