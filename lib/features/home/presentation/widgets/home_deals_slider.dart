import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../data/model/deals_model.dart';

class HomeDealsSlider extends StatelessWidget {
  final List<DealModel> deals;
  final bool isLoading;

  const HomeDealsSlider({
    super.key,
    required this.deals,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    /// Loading state UI (clean skeleton instead of flicker)
    if (isLoading) {
      return Container(
        height: 170,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: deals.length,
      itemBuilder: (context, index, realIndex) {
        final deal = deals[index];

        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  deal.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),

                Container(
                  color: Colors.black.withOpacity(0.35),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (deal.hasOffer)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            deal.offerTitle ?? "Offer",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      const SizedBox(height: 10),

                      Text(
                        deal.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "\$${deal.finalPrice > 0 ? deal.finalPrice : deal.price}",
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 170,
        autoPlay: true,
        viewportFraction: 0.9,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
      ),
    );
  }
}