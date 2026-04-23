import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/features/Home/data/recomended_repo/repo_recommendation.dart';
import 'package:grocery2/features/Home/data/repo.dart';
import 'package:grocery2/features/Home/presentation/cubit/deals_cubit/today_deals_cubit.dart';
import 'package:grocery2/features/Home/presentation/cubit/deals_cubit/today_deals_state.dart';
import 'package:grocery2/features/Home/presentation/cubit/recommended_cubit/cubit/recommded_cubit_cubit.dart';
import 'package:grocery2/features/Home/presentation/cubit/recommended_cubit/cubit/recommded_cubit_state.dart';
import 'package:grocery2/features/Home/presentation/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DealsCubit(DealsRepository())..fetchDeals(),
        ),
        BlocProvider(
          create: (context) =>
              RecommendationCubit(RecommendationRepository())
                ..loadRecommendations(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomTopBar(),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 1. Search Bar
            _buildSearchBar(),

            const SizedBox(height: 20),
            _buildSectionTitle("Today's Deals"),

            // 2. Banner (Today's Deals)
            _buildTodayDealsSection(),

            const SizedBox(height: 24),
            _buildSectionTitle("Categories"),

            // 3. Categories List
            _buildCategoriesList(),

            const SizedBox(height: 24),
            _buildSectionTitle("Recommended For You"),

            // 4. Products Grid (Recommended)
            _buildProductsGrid(),
          ],
        ),
      ),
    );
  }

  // --- Search Bar Widget ---
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.lightBlue.shade50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search for any Product',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: AppColor.primaryColor),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.qr_code_scanner, color: AppColor.primaryColor),
              SizedBox(width: 10),
              Icon(Icons.mic_none, color: AppColor.primaryColor),
            ],
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // --- Section Title Widget ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // --- Today's Deals Banner Section ---
  Widget _buildTodayDealsSection() {
    return BlocBuilder<DealsCubit, DealsState>(
      builder: (context, state) {
        if (state is DealsLoading) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is DealsSuccess) {
          return SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: state.deals.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final dealItem = state.deals[index];
                return Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        dealItem.imageUrl ?? 'https://via.placeholder.com/300',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            dealItem.offerTitle ?? '60% off',
                            style: const TextStyle(
                              color: Color(0xFF003D61),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          dealItem.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          dealItem.description ??
                              'this offer is best offers /n in this seazon',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox(height: 180);
      },
    );
  }

  // --- Categories List Widget ---
  Widget _buildCategoriesList() {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryItem(
            "Meat & Seafood",
            'http://imgs.search.brave.com/eDwl2QQ3ZTC6A9w_9x09z7uox6gjFDHkwbztp5zQC5U/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wNTMv/NjEwLzgwNC9zbWFs/bC9jbG9zZS11cC1v/Zi1jb2xvcmZ1bC1m/cmVzaC12ZWdldGFi/bGVzLXdpdGgtYS1t/aXgtb2YtYnJpZ2h0/LXRvbmVzLXBob3Rv/LmpwZw',
          ),
          _buildCategoryItem(
            "Fresh Produce",
            'https://via.placeholder.com/100',
          ),
          _buildCategoryItem("Dairy & Eggs", 'https://via.placeholder.com/100'),
          _buildCategoryItem(
            "Bakery & Bread",
            'https://via.placeholder.com/100',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey[100],
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // --- Recommended Products Grid Widget ---
  Widget _buildProductsGrid() {
    return BlocBuilder<RecommendationCubit, RecommendationState>(
      builder: (context, state) {
        if (state is RecommendationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecommendationSuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.meals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final meal = state.meals[index];
              return _buildProductItem(
                meal.title,
                meal.categoryName,
                meal.finalPrice.toString(),
                meal.imageUrl,
                oldPrice: meal.hasOffer ? meal.price.toString() : null,
              );
            },
          );
        } else if (state is RecommendationError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  // --- Single Product Item Widget ---
  Widget _buildProductItem(
    String name,
    String weight,
    String price,
    String imageUrl, {
    String? oldPrice,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  weight,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star_border, color: Colors.grey, size: 14),
                    Text(" (4)", style: TextStyle(fontSize: 10)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "£$price",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003D61),
                      ),
                    ),
                    if (oldPrice != null) ...[
                      const SizedBox(width: 5),
                      Text(
                        "£$oldPrice",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003D61),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Add to cart",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
