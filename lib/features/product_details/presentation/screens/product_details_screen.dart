import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/di/service_locator.dart';
import 'package:grocery2/features/product_details/presentation/widgets/product_details.dart';
import 'package:grocery2/features/smart_lists/presentation/cubit/favorites_cubit.dart';
import 'package:grocery2/features/smart_lists/presentation/cubit/favorites_state.dart';

import '../../../../core/constants/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_description.dart';
import '../widgets/product_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

@override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailsCubit>(
          create: (_) => sl<ProductDetailsCubit>()..getProductDetails(productId),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => sl<FavoritesCubit>()..load(),
        ),
      ],
      child: const _ProductDetailsView(),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  const _ProductDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'Product Details'),

      body: MultiBlocListener(
        listeners: [
          BlocListener<ProductDetailsCubit, ProductDetailsState>(
            listener: (context, state) {
              if (state is ProductDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
          ),
          BlocListener<FavoritesCubit, FavoritesState>(
            listener: (context, state) {
              if (state is FavoritesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsSuccess) {
              final product = state.product;
              final favState = context.watch<FavoritesCubit>().state;
              final isFavorited = favState is FavoritesLoaded 
                  && favState.favorites.any((f) => f.id == product.id);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
children: [
                      ProductImage(
                        imageUrl: product.image,
                        product: product,
                        isFavorite: isFavorited,
                        onToggleFavorite: () {
                          context
                              .read<FavoritesCubit>()
                              .toggleFavorite(product.id);
                        },
                      ),
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
      ),
    );
  }
}
