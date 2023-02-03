class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({
    required this.id, 
    required this.name,
    required this.image
  });

   CategoryModel.fromFirebaseMap(Map<String, Object?> data)
      : id = (data['id'] ?? '').toString(),
        name = (data['name'] ?? '').toString(),
        image = (data['image'] ?? '').toString();

  // Helper function to convert this MyUser to a Map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
