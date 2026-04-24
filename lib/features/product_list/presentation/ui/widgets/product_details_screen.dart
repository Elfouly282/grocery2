import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/product_details/data/datasources/product_remote_datasource.dart';
import 'package:grocery2/features/product_details/data/repositories/product_repository_impl.dart';
 import 'package:grocery2/features/product_details/domain/usecases/get_product_details.dart'; // Assuming this exists
import 'package:grocery2/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:grocery2/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:grocery2/features/product_details/presentation/widgets/product_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        GetProductDetails(ProductRepositoryImpl(remoteDataSource:ProductRemoteDataSourceImpl()
        )), // Assuming repo is registered with GetIt
      )..getProductDetails(productId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProductDetailsSuccess) {
              final product = state.product;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImage(
                      imageUrl: product.image,
                      isFavorite: false, // You'd manage this state elsewhere
                      onFavoriteTap: () {
                        // Handle favorite tap
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: \$${product.finalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.green,
                          ),
                    ),
                    if (product.hasOffer && product.discountPrice != null)
                      Text(
                        'Original Price: \$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Description:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(product.description),
                    const SizedBox(height: 16),
                    Text(
                      'Features:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(product.features),
                    // Add more product details here as needed
                  ],
                ),
              );
            }
            return const Center(child: Text('Select a product to see details.'));
          },
        ),
      ),
    );
  }
}