
class UserBodyCondition {
  final String userId;
  final String conditionId;

  UserBodyCondition({required this.userId, required this.conditionId});

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'conditionId': conditionId,
    };
  }

  // JSON에서 변환
  factory UserBodyCondition.fromJson(Map<String, dynamic> json) {
    return UserBodyCondition(
      userId: json['USER_ID'],
      conditionId: json['B_COND_ID'],
    );
  }
}
