part of 'payment_details_cubit.dart';

enum PaymentStatus { initial, success, failed }

class PaymentDetailsState extends Equatable {
  final PaymentStatus paymentStatus;
  final PaymentReceiptModel? model;
  final String? errorMessage;

  const PaymentDetailsState({
    this.paymentStatus = PaymentStatus.initial,
    this.model,
    this.errorMessage,
  });

  PaymentDetailsState copyWith({
    PaymentStatus? paymentStatus,
    PaymentReceiptModel? model,
    String? errorMessage,
  }) {
    return PaymentDetailsState(
      paymentStatus: paymentStatus ?? this.paymentStatus,
      model: model ?? this.model,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [paymentStatus, model, errorMessage];
}
