import 'package:equatable/equatable.dart';

class PaymentReceiptModel extends Equatable {
  final String transactionId;
  final String date;
  final String paymentType;
  final double total;
  final String status;

  const PaymentReceiptModel({
    required this.transactionId,
    required this.date,
    required this.paymentType,
    required this.total,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "transactionId": transactionId,
      "date": date,
      "paymentType": paymentType,
      "total": total,
      "status": status,
    };
  }

  factory PaymentReceiptModel.fromJson(Map<String, dynamic> json) {
    return PaymentReceiptModel(
      transactionId: json["transactionId"] as String,
      date: json["date"] as String,
      paymentType: json["paymentType"] as String,
      total: (json["total"] as num).toDouble(),
      status: json["status"] as String,
    );
  }

  PaymentReceiptModel copyWith({
    String? transactionId,
    String? date,
    String? paymentType,
    double? total,
    String? status,
  }) {
    return PaymentReceiptModel(
      transactionId: transactionId ?? this.transactionId,
      date: date ?? this.date,
      paymentType: paymentType ?? this.paymentType,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [transactionId, date, paymentType, total, status];
}
