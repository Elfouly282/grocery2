
import '../../data/models/SubCategoryModel.dart';

class DummyData {
  static List<SubCategoryModel> categories =
  List.generate(
    6,
        (index) => SubCategoryModel(
         name: 'Loading...',
          imageUrl: '',
          id: 1,
          slug: '',
          description: '',
          mealsCount: 1,
          sortOrder: 2,
          createdAt: DateTime.now(),
    ),
  );
}