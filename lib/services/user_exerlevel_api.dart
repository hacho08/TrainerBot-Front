import 'dart:convert';
import 'package:dx_project_app/services/user_api.dart';
import 'package:http/http.dart' as http;

class UserExerLevelApi {
  // 서버의 URL
  static const String baseUrl = "${UserApi.baseUrl}/exerlevel"; // 실제 서버 주소로 변경

  // 근력운동 수준을 서버에 저장하는 메서드
  Future<bool> saveWorkoutExperience(String userId, String workoutLevel) async {
    final url = Uri.parse('$baseUrl/$userId'); // API 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};

    // 데이터 준비
    final body = json.encode({
      'WORKOUT_EXPERIENCE': workoutLevel, // 'WORKOUT_EXPERIENCE' 필드에 선택된 운동 수준 저장
    });

    try {
      // 서버에 POST 요청 보내기
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
