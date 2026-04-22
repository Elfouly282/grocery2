import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/history_cubit.dart';
import '../cubit/smart_lists_cubit.dart';
import '../tabs/favorites_tab.dart';
import '../tabs/history_tab.dart';
import '../tabs/smart_lists_tab.dart';

class SmartListsScreen extends StatefulWidget {
  const SmartListsScreen({super.key});

  @override
  State<SmartListsScreen> createState() => _SmartListsScreenState();
}

class _SmartListsScreenState extends State<SmartListsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<SmartListsCubit>().load();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          context.read<SmartListsCubit>().load();
          break;
        case 1:
          context.read<FavoritesCubit>().load();
          break;
        case 2:
          context.read<HistoryCubit>().load();
          break;
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('My List', style: AppTextStyles.titleMedium),
        centerTitle: true,
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.black,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),

        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.grey,
          indicatorColor: AppColors.primaryColor,
          labelStyle: AppTextStyles.titleMedium,
          tabs: [
            const Tab(text: 'Smart Lists'),
            const Tab(text: 'Favorites'),
            const Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [SmartListsTab(), FavoritesTab(), HistoryTab()],
      ),
    );
  }
}
