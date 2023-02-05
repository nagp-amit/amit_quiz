class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id, 
    required this.name,
    required this.image
  });

   CategoryModel.fromFirebaseMap(this.id, Map<String, Object?> data)
      : name = (data['name'] ?? '').toString(),
        image = (data['image'] ?? '').toString();
}
