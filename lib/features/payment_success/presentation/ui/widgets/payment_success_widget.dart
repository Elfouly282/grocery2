import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/payment_success/presentation/logic/payment_details_cubit.dart';

import 'Detail_row_widget.dart';

class PaymentSuccessWidget extends StatelessWidget {
  const PaymentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentDetailsCubit, PaymentDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 117),
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF0A610E), width: 5.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.check, color: Color(0xFF0A610E), size: 70),
                ),
                const SizedBox(height: 24),
                Text(
                  "Payment Successful",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A610E),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card title
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: RichText(
                          text: const TextSpan(
                            children: [

                              TextSpan(
                                text: 'Payment Details',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      DetailRow(
                        label: 'Transaction ID',
                        value: state.model != null
                            ? _maskTransactionId(state.model!.transactionId)
                            : '**** **** ****',
                        isMasked: true,
                      ),
                      DetailRow(
                        label: 'Date',
                        value: state.model?.date ?? '—',
                      ),
                      DetailRow(
                        label: 'Type of Transaction',
                        value: state.model?.paymentType ?? '—',
                      ),
                      DetailRow(
                        label: 'Total',
                        value: state.model != null
                            ? '${state.model?.total.toStringAsFixed(0)}£'
                            : '—',
                      ),
                      DetailRow(
                        label: 'State',
                        value: state.model?.status ?? '—',
                        isSuccess: true,
                        isLast: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to order tracking
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF014162),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Track Your Order',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Navigate to home
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1A3A2A),
                      side: const BorderSide(
                        color: Color(0xFF1A3A2A),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Return Home',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
String _maskTransactionId(String id) {
  if (id.length <= 4) return '**** **** ****';
  return '**** **** ${id.substring(id.length - 4)}';
}




