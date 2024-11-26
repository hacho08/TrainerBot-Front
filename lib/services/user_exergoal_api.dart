import 'dart:convert';
import 'package:dx_project_app/services/user_api.dart';
import 'package:http/http.dart' as http;

class UserExerGoalApi {
  // 서버의 URL
  static const String baseUrl = "${UserApi.baseUrl}/exergoal"; // 실제 서버 주소로 변경

  // 운동 목표를 서버에 저장하는 메서드
  Future<bool> saveExerciseGoal(String userId, List<String> goals) async {
    final url = Uri.parse('$baseUrl/$userId'); // API 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};

    // 선택된 운동 목표 리스트를 JSON으로 변환
    final body = json.encode({
      'GOAL': goals, // 'GOAL' 필드에 선택된 목표를 저장
    });

    try {
      // 서버에 PUT 요청 보내기
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      // 응답 확인
      if (response.statusCode == 200) {
        return true; // 성공적으로 저장됨
      } else {
        return false; // 실패
      }
    } catch (e) {
      print('Error: $e');
      return false; // 오류 발생 시 false 반환
    }
  }
}
