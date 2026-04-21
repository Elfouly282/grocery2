import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/on_boarding/presentation/cubit/cubit/on_boarding_cubit_cubit.dart';

class FirstBoard extends StatelessWidget {
  FirstBoard({super.key});

  final PageController _pageController = PageController();

  final List<Map<String, String>> data = [
    {
      'image': 'assets/images/empty_cart.png',
      'title': 'Fresh Groceries At Your Fingertips',
      'subtitle':
          'Discover a wide variety of fresh and high-quality groceries delivered right to your doorstep.',
    },
    {
      'image': 'assets/images/moto.png',
      'title': 'Fast Delivery To Your Doorstep',
      'subtitle':
          'Experience swift and reliable delivery of your groceries right to your doorstep.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnBoardingCubitCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<OnBoardingCubitCubit, OnBoardingCubitState>(
            builder: (context, state) {
              final currentIndex = state.currentIndex;

              return Column(
                children: [
                  /// Skip
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        _pageController.animateToPage(
                          data.length - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Color(0xFF014162)),
                      ),
                    ),
                  ),

                  /// Pages
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: data.length,
                      onPageChanged: (index) {
                        context
                            .read<OnBoardingCubitCubit>()
                            .pageChanged(index);
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(data[index]['image']!, height: 250),
                              const SizedBox(height: 30),
                              Text(
                                data[index]['title']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                data[index]['subtitle']!,
                                textAlign: TextAlign.center,
                                style:
                                    const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  /// Indicator
                 
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      data.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(4),
                        width: currentIndex == index ? 10 : 6,
                        height: currentIndex == index ? 10 : 6,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.teal
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          /// Back
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: currentIndex == 0
                                  ? Colors.grey.shade300
                                  : Colors.teal,
                              child: IconButton(
                                onPressed: currentIndex == 0
                                    ? null
                                    : () {
                                        _pageController.previousPage(
                                          duration: const Duration(
                                              milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                              ),
                            ),
                          ),

                          /// Next
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.teal,
                              child: IconButton(
                                onPressed: () {
                                  if (currentIndex <
                                      data.length - 1) {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (_) =>
                                    //         const SecondBoard(),
                                    //   ),
                                    // );
                                    // navigate to login or home screen
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}