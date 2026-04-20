import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/utils/app_colors.dart';
import 'package:grocery2/features/payment_success/presentation/logic/payment_details_cubit.dart';
import 'package:grocery2/features/payment_success/presentation/ui/widgets/payment_success_widget.dart';

class PaymentStatusScreen extends StatefulWidget {
  const PaymentStatusScreen({super.key , required this.orderId});
final int orderId ;

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  @override
  void initState() {
super.initState();
context.read<PaymentDetailsCubit>().getPaymentReceipt(widget.orderId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          BlocBuilder<PaymentDetailsCubit, PaymentDetailsState>(
            builder: (context, state) {
              switch (state.paymentStatus) {
                case PaymentStatus.initial:
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  );
                case PaymentStatus.success:
                   return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 12),
                        Text(
                          state.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  );

                case PaymentStatus.failed:
                return PaymentSuccessWidget();
              }
            },
          ),

        ],
      ),
    );
  }


}
