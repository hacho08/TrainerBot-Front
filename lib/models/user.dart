
class User {
  final String userId;
  final String userName;
  final int birthYear;
  final String gender;
  final String workoutExperience;
  final String goal;
  final DateTime createdAt;

  // 생성자
  User({
    required this.userId,
    required this.userName,
    required this.birthYear,
    required this.gender,
    required this.workoutExperience,
    required this.goal,
    required this.createdAt,
  });

  // JSON을 Dart 객체로 변환하는 팩토리 메서드
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['USER_ID'],
      userName: json['USER_NAME'],
      birthYear: json['BIRTH_YEAR'],
      gender: json['GENDER'],
      workoutExperience: json['WORKOUT_EXPERIENCE'],
      goal: json['GOAL'],
      createdAt: DateTime.parse(json['CREATED_AT']),
    );
  }

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'USER_ID': userId,
      'USER_NAME': userName,
      'BIRTH_YEAR': birthYear,
      'GENDER': gender,
      'WORKOUT_EXPERIENCE': workoutExperience,
      'GOAL': goal,
      'CREATED_AT': createdAt.toIso8601String(),
    };
  }
}
