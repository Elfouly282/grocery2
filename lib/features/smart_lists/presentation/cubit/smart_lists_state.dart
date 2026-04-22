import 'package:equatable/equatable.dart';

import '../../domain/entities/smart_list_entity.dart';

abstract class SmartListsState extends Equatable {
  const SmartListsState();

  @override
  List<Object?> get props => [];
}

class SmartListsInitial extends SmartListsState {}

class SmartListsLoading extends SmartListsState {}

class SmartListsLoaded extends SmartListsState {
  final List<SmartListEntity> smartLists;

  const SmartListsLoaded(this.smartLists);

  @override
  List<Object?> get props => [smartLists];
}

class SmartListsError extends SmartListsState {
  final String message;

  const SmartListsError(this.message);

  @override
  List<Object?> get props => [message];
}
