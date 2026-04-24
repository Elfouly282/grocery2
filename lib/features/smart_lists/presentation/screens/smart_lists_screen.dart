import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../features/add_new_list/add_new_list.dart';
import '../tabs/favorites_tab.dart';
import '../tabs/history_tab.dart';
import '../tabs/smart_lists_tab.dart';

class SmartListsScreen extends StatelessWidget {
  const SmartListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text('Smart Lists', style: AppTextStyle.headlineSmall),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primaryColor,
            labelStyle: AppTextStyle.titleSmall,
            tabs: const [
              Tab(text: 'Lists'),
              Tab(text: 'Favorites'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [SmartListsTab(), FavoritesTab(), HistoryTab()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewList(),
              ),
            );
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
