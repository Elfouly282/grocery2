import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_product_details.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetails getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase)
      : super(ProductDetailsInitial());

  void getProductDetails(int id) async {
    emit(ProductDetailsLoading());

    final result = await getProductDetailsUseCase(id);
    result.fold(
      (failure) => emit(ProductDetailsError(failure.message)),
      (product) => emit(ProductDetailsSuccess(product)),
    );
  }

  void toggleFavoriteStatus() {
    if (state is ProductDetailsSuccess) {
      final product = (state as ProductDetailsSuccess).product;
      product.isFavorited = !product.isFavorited;
      emit(ProductDetailsSuccess(product));
    }
  }
}
