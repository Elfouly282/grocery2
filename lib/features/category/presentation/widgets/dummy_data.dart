import '../../data/models/CategoryModel.dart';

class DummyData {
  static List<CategoryModel> categories = List.generate(
    6,
    (index) => CategoryModel(
      id: index,
      name: 'Loading...',
      imageUrl: '',
      slug: '',
      description: '',
      mealsCount: 1,
      sortOrder: 2,
      createdAt: DateTime.now(),
    ),
  );
}
