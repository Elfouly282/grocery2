import 'package:grocery2/features/Home/data/today_deal.dart';

abstract class DealsState {}

class DealsInitial extends DealsState {}

class DealsLoading extends DealsState {}

class DealsSuccess extends DealsState {
  final List<DealModel> deals;
  DealsSuccess(this.deals);
}

class DealsError extends DealsState {
  final String message;
  DealsError(this.message);
}