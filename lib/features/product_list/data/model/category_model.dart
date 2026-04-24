class Category {
  Category({required this.id, required this.name, required this.slug});

  final String id;
  final String name;
  final String slug;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug};
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      slug: map['slug']?.toString() ?? '',
    );
  }
}
