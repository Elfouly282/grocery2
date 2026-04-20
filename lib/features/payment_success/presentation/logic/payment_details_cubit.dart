import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/payment_success/data/model/payment_receipt_model.dart';
import 'package:grocery2/features/payment_success/data/repository/payment_details_repo.dart';

part 'payment_details_state.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  PaymentDetailsCubit(this.paymentDetailsRepo) : super(PaymentDetailsState());

  final BasePaymentDetailsRepo paymentDetailsRepo;

  Future<void> getPaymentReceipt(int orderId) async {
    try {
      emit(state.copyWith(paymentStatus: PaymentStatus.initial, errorMessage: null));

      final result = await paymentDetailsRepo.getPaymentReceipt(orderId);
      emit(state.copyWith(paymentStatus: PaymentStatus.success, model: result));
    } catch (e) {
      emit(
        state.copyWith(paymentStatus: PaymentStatus.failed, errorMessage: e.toString()),
      );
    }
  }
}
