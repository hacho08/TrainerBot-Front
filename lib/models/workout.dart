class Workout {
  String workoutId; // WORKOUT_ID
  String routineId; // ROUTINE_ID
  String workoutName; // WORKOUT_NAME
  int setCount; // SET_COUNT
  int restTime; // REST_TIME
  int isCount; // IS_COUNT
  int workoutCount; // WORKOUT_COUNT
  int workoutOrder; // WORKOUT_ORDER

  // 생성자
  Workout({
    required this.workoutId,
    required this.routineId,
    required this.workoutName,
    required this.setCount,
    required this.restTime,
    required this.isCount,
    required this.workoutCount,
    required this.workoutOrder,
  });

  // JSON -> 객체 변환
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      workoutId: json['workoutId'] as String,
      routineId: json['routineId'] as String,
      workoutName: json['workoutName'] as String,
      setCount: json['setCount'] as int,
      restTime: json['restTime'] as int,
      isCount: json['isCount'] as int,
      workoutCount: json['workoutCount'] as int,
      workoutOrder: json['workoutOrder'] as int,
    );
  }

  // 객체 -> JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'workoutId': workoutId,
      'routineId': routineId,
      'workoutName': workoutName,
      'setCount': setCount,
      'restTime': restTime,
      'isCount': isCount,
      'workoutCount': workoutCount,
      'workoutOrder': workoutOrder,
    };
  }
}
