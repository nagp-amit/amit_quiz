class ResultModel {
  final int total;
  final int correctCount;
  final int wrongCount;
  final int unAnsweredCount;
  final int score;
  final String categoryId;
  late String? userId;
  late DateTime? createdOn;

  ResultModel({
    required this.total,
    required this.correctCount,
    required this.wrongCount,
    required this.unAnsweredCount, 
    required this.score,
    required this.categoryId,
    this.userId,
    this.createdOn
  });

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'total': total,
      'correctCount': correctCount,
      'wrongCount': wrongCount,
      'unAnsweredCount': unAnsweredCount,
      'score': score,
      'categoryId': categoryId,
      'userId': userId,
      'createdOn': createdOn
    };
  }

  ResultModel.fromFirebaseMap(Map<String, Object?> data)
      : total = int.parse((data['total'] ?? 0).toString()),
      correctCount = int.parse((data['correctCount'] ?? 0).toString()),
      wrongCount = int.parse((data['wrongCount'] ?? 0).toString()),
      unAnsweredCount = int.parse((data['unAnsweredCount'] ?? 0).toString()),
      score = int.parse((data['score'] ?? 0).toString()),
      categoryId = (data['categoryId'] ?? '').toString(),
      userId = (data['userId'] ?? 0).toString();
}
