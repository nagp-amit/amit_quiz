class AnswerModel {
  final int id;
  final String value;

  AnswerModel({
    required this.id, 
    required this.value,
  });

   AnswerModel.fromFirebaseMap(Map<String, Object?> data)
      : id = int.parse((data['id'] ?? '0').toString()),
        value = (data['value'] ?? '').toString();

  // Helper function to convert this MyUser to a Map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'value': value
    };
  }
}