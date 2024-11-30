class Routine {
  String routineId;
  String userId;
  String condition;
  String target;
  DateTime createdAt;

  // 생성자
  Routine({
    required this.routineId,
    required this.userId,
    required this.condition,
    required this.target,
    required this.createdAt,
  });

   // JSON으로부터 객체 생성
  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      routineId: json['routineId'],
      userId: json['userId'],
      condition: json['condition'],
      target: json['target'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'routineId': routineId,
      'userId': userId,
      'condition': condition,
      'target': target,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
