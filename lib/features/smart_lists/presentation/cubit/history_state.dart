import 'package:equatable/equatable.dart';

import '../../../product_details/domain/entities/product_entity.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<ProductEntity> products;

  const HistoryLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}