import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomTopBar(),
      body: HomeView(),
    );
  }
}

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    const Color darkBlue = Color(0xFF003D61);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/apple.png',
                width: 45,
                height: 45,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 15),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: darkBlue,
                    size: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: darkBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Villa 14, Street 23,',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final Color primaryColor = const Color(0xFF004667);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Center(child: Text('Home Content')),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black87,
            items: [
              BottomNavigationBarItem(icon: _buildIcon(Icons.home_outlined, 0), label: 'Home'),
              BottomNavigationBarItem(icon: _buildIcon(Icons.list_alt_rounded, 1), label: 'My List'),
              BottomNavigationBarItem(icon: _buildIcon(Icons.directions_car_outlined, 2), label: 'My Order'),
              BottomNavigationBarItem(icon: _buildIcon(Icons.person_outline, 3), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = _currentIndex == index;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: isSelected ? Colors.white : Colors.black87,
        size: 28,
      ),
    );
  }
}