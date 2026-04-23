import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/smart_lists_cubit.dart';
import '../cubit/smart_lists_state.dart';
import '../widgets/smart_list_card.dart';

class SmartListsTab extends StatefulWidget {
  const SmartListsTab({super.key});

  @override
  State<SmartListsTab> createState() => _SmartListsTabState();
}

class _SmartListsTabState extends State<SmartListsTab> {
  @override
  void initState() {
    super.initState();
    context.read<SmartListsCubit>().fetchSmartLists();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmartListsCubit, SmartListsState>(
      listener: (context, state) {
        if (state is SmartListActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.primaryColor,
            ),
          );
          context.read<SmartListsCubit>().fetchSmartLists();
        }
      },
      builder: (context, state) {
        if (state is SmartListsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SmartListsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message, style: AppTextStyles.bodyMedium),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () =>
                      context.read<SmartListsCubit>().fetchSmartLists(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        List smartLists = [];
        if (state is SmartListsLoaded) {
          smartLists = state.smartLists;
        }

        if (smartLists.isEmpty && state is! SmartListsLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt, size: 80.sp, color: AppColors.grey),
                SizedBox(height: 16.h),
                Text('No smart lists found', style: AppTextStyles.titleMedium),
                SizedBox(height: 8.h),
                Text(
                  'Create your first list to get started!',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: smartLists.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final list = smartLists[index];
            return SmartListCard(smartList: list);
          },
        );
      },
    );
  }
}
