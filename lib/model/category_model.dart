class CategoryModel {
  late String id;
  late String name;
  late String image;

  CategoryModel({
    required this.id, 
    required this.name,
    required this.image
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'image': image
    };
  }
}
