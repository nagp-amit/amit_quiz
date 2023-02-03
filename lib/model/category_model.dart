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
      : id = data['id'] as String,
        name = data['name'] as String,
        image = data['image'] as String;

  // Helper function to convert this MyUser to a Map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
