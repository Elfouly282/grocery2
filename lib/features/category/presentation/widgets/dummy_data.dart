
import '../../data/models/CategoryModel.dart';

class DummyData {
  static List<CategoryModel> categories =
  List.generate(
    6,
        (index) => CategoryModel(
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