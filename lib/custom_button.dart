import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final List<String> tabs;
  final int currentIndex;
  final Function(int) onTabSelected;
  const TabSelector({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = currentIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => onTabSelected(index),
              child: Container(
                padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? Color(0xff014162) : Color(0xff888888),
                    ),
                  ),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Color(0xff014162) : Color(0xff888888),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
