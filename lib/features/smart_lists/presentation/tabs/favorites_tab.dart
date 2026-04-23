import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import '../widgets/favorite_card.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  void initState() {
    super.initState();
    // Load favorites on tab initiation
    context.read<FavoritesCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: AppColors.error,
                  ),
                  SizedBox(height: 16.h),
                  Text(state.message, style: AppTextStyles.bodyLarge),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () => context.read<FavoritesCubit>().load(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80.sp,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No favorites yet',
                      style: AppTextStyles.headlineSmall,
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Text(
                        'Start adding products to your wishlist to see them here!',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final product = state.favorites[index];
                return FavoriteCard(
                  product: product,
                  onToggleFavorite: () {
                    context.read<FavoritesCubit>().toggleFavorite(product.id);
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
