import 'package:flutter/material.dart';
import 'package:grocery2/features/add_new_list/add_new_list.dart';
import 'package:grocery2/features/home/presentation/ui/home_view.dart';
import 'package:grocery2/features/profile&setting/presentation/UI/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeView(),
    AddNewList(),
    const Center(child: Text('My order')),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomTheme = theme.bottomNavigationBarTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.black12,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: bottomTheme.backgroundColor,
            selectedItemColor: bottomTheme.selectedItemColor,
            unselectedItemColor: bottomTheme.unselectedItemColor,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(context, Icons.home_outlined, 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(context, Icons.list_alt_rounded, 1),
                label: 'My List',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(context, Icons.directions_car_outlined, 2),
                label: 'My Order',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(context, Icons.person_outline, 3),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData iconData, int index) {
    final isSelected = currentIndex == index;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unselectedColor =
        theme.bottomNavigationBarTheme.unselectedItemColor ??
        theme.iconTheme.color ??
        Colors.black87;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: isSelected ? colorScheme.onPrimary : unselectedColor,
        size: 28,
      ),
    );
  }
}
