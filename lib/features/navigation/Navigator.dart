import 'package:flutter/material.dart';
import 'package:grocery2/features/Home/presentation/UI/Home.dart';
import 'package:grocery2/features/my%20list/presentation/UI/mylist.dart';
import 'package:grocery2/features/myorder/presentation/UI/myorder.dart';
import 'package:grocery2/features/profile/presentation/UI/profile.dart';

 
class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0; // متغير لمتابعة العنصر المختار
  List<Widget>screens=[
    Home(),
    Mylist(),
    Myorder(),
    Profile()
  ];
   final Color primaryColor = const Color(0xFF004667); // اللون الأزرق الغامق

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: Colors.grey[100], // لون خلفية الصفحة
     
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
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
               });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black87,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.home_outlined, 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.list_alt_rounded, 1),
                label: 'My List',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.directions_car_outlined, 2),
                label: 'My Order',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.person_outline, 3),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // "Widget" مخصص لرسم الدائرة الزرقاء حول الأيقونة المختارة
  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = currentIndex == index;
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