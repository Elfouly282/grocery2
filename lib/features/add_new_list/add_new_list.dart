import 'package:flutter/material.dart';
import 'package:grocery2/features/add_new_list/custom_button.dart';
import 'package:grocery2/features/add_new_list/meal_card_widget.dart';
import 'package:grocery2/features/add_new_list/meal_service.dart';
import 'package:grocery2/features/add_new_list/widgets/tap_selector.dart';
import 'package:grocery2/features/add_new_list/data/models/meal.dart';

class AddNewList extends StatefulWidget {
  const AddNewList({super.key});

  @override
  State<AddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<AddNewList> {
  int _activeTab = 0;

  TextEditingController searchBarController = TextEditingController();
  TextEditingController listNameController = TextEditingController();
  final List<String> _myTabs = ["Smart Lists", "Favorites", "History"];

  List<Meal> allMeals = [];
  List<Meal> filteredMeals = [];
  Set<String> selectedMeals = {};
  bool isLoading = true;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  Future<void> loadMeals() async {
    try {
      final MealService mealService = MealService();
      final meals = await mealService.fetchMeals();

      setState(() {
        allMeals = meals;
        filteredMeals = meals;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  // // TODO: Connect this to "My List" Screen
  void _createList() {
    final selectedItems = allMeals
        .where((meal) => selectedMeals.contains(meal.id))
        .toList();
  }

  // Live Search (Local-side filtering)
  void _onSearchChanged(String value) {
    final query = value.toLowerCase();

    setState(() {
      filteredMeals = allMeals.where((meal) {
        return meal.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Toggle meal selection
  void _toggleMeal(String id) {
    setState(() {
      if (selectedMeals.contains(id)) {
        selectedMeals.remove(id);
      } else {
        selectedMeals.add(id);
      }
    });
  }

  @override
  void dispose() {
    searchBarController.dispose();
    listNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("BUILD → filteredMeals: ${filteredMeals.length}");
    // print("isLoading: $isLoading");
    return Scaffold(
      
      appBar: AppBar(automaticallyImplyLeading: false,centerTitle: true, title: Text("Add a new List")),
      body: SafeArea(
        child: Column(
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
            // grey Square Image Selector to upload image
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    //Image Picker
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xffDAD8D8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add_a_photo),
                      ),
                    ),
                    SizedBox(height: 16),
                    // ListName Field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffDAD8D8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.list_outlined),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Name of List",
                        ),
                        controller: listNameController,
                      ),
                    ),
                    SizedBox(height: 30),
                    /*Search Field*/
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffDAD8D8),
                      ),
                      // height: 10,
                      child: TextField(
                        controller: searchBarController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  searchBarController.clear();
                                  setState(() {});
                                },
                                icon: Icon(Icons.clear),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.mic),
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search for any product",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    /* Grid of Meals */
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredMeals.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.75,
                                ),
                            itemBuilder: (context, index) {
                              final meal = filteredMeals[index];
                              // print("Building item: ${meal.title}");
                              return MealCard(
                                meal: meal,
                                isSelected: selectedMeals.contains(meal.id),
                                onTap: () => _toggleMeal(meal.id),
                              );
                            },
                          ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          10,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CustomButton(
          color: selectedMeals.isEmpty ? Colors.grey : Color(0xff014162),
          onPressed: selectedMeals.isEmpty ? null : _createList,
          text: selectedMeals.isEmpty
              ? "Select items to add"
              : "Add ${selectedMeals.length} items to list",
        ),
      ),
    );
  }
}
