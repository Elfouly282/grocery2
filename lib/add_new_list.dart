import 'package:flutter/material.dart';
import 'package:grocery2/custom_button.dart';

class AddNewList extends StatefulWidget {
  const AddNewList({super.key});

  @override
  State<AddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<AddNewList> {
  int _activeTab = 0;
  final List<String> _myTabs = ["Smart Lists", "Favorites", "History"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add a new List")),
      body: Column(
        children: [
          TabSelector(
            tabs: _myTabs,
            currentIndex: _activeTab,
            onTabSelected: (index) {
              setState(() {
                _activeTab = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
