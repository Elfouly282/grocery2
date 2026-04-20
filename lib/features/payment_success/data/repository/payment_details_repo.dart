
import 'package:grocery2/features/payment_success/data/datasource/remote_datasource/payment_details_datasource.dart';
import 'package:grocery2/features/payment_success/data/model/payment_receipt_model.dart';

abstract class BasePaymentDetailsRepo {
  Future<PaymentReceiptModel> getPaymentReceipt(int orderId);
}


class PaymentDetailsRepo extends BasePaymentDetailsRepo{
  final BasePaymentDetailsDatasource paymentDetailsDatasource ;
  PaymentDetailsRepo(this.paymentDetailsDatasource);
  @override
  Future<PaymentReceiptModel> getPaymentReceipt(int orderId) async {
    final result = await paymentDetailsDatasource.getPaymentReceipt(orderId);
    try{
      return result;
    }catch(e){
      rethrow;
    }


  }

}