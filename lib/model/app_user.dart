import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final String image;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.image
  });

  // When comparing two instances of MyUser class we want to check
  // that all the properties are the same, then we can say that
  // the two instances are equals
  @override
  List<Object?> get props => [id, name, email, image];

  // Helper function to convert this MyUser to a Map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'email': email,
      'image': image,
    };
  }

  // Helper function to convert a Map to an instance of MyUser
  AppUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        email = data['email'] as String,
        image = data['image'] as String;

  // Helper function that updates some properties of this instance,
  // and returns a new updated instance of MyUser
  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }
}
