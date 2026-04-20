import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_product_details.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetails getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase)
      : super(ProductDetailsInitial());

  void getProductDetails(int id) async {
    emit(ProductDetailsLoading());

    try {
      final product = await getProductDetailsUseCase(id);
      emit(ProductDetailsSuccess(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
