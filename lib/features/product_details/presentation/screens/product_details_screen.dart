import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/product_details/presentation/widgets/product_details.dart';

import '../../../../core/constants/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_description.dart';
import '../widgets/product_image.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'Product Details'),

      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsSuccess) {
            final product = state.product;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImage(imageUrl: product.image),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductDetails(
                            includes: product.includes,
                            size: product.size,
                            expiryDate: product.expiryDate,
                            isExpired: product.isExpired,
                            title: product.title,
                            price: product.price,
                            discountPrice: product.discountPrice,
                            finalPrice: product.finalPrice,
                            hasOffer: product.hasOffer,
                            offerTitle: product.offerTitle,
                            rating: product.rating,
                            ratingCount: product.ratingCount,
                          ),
                          const SizedBox(height: 16),
                          ProductDescription(product: product),
                          const SizedBox(height: 16),
                          const ProductBottomBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
