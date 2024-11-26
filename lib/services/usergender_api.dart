import 'dart:convert';
import 'package:dx_project_app/services/user_api.dart';
import 'package:http/http.dart' as http;

class UserGenderApi {
  // 서버의 URL (여기서는 예시로 설정)
  final String apiUrl = "${UserApi.baseUrl}/gender";

  // 성별을 서버로 전송하여 저장하는 함수
  Future<bool> saveUserGender(String userId, String gender) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({
        'USER_ID': userId,
        'GENDER': gender,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // 서버에서 성공적으로 응답 받은 경우
      return true;
    } else {
      // 실패한 경우
      return false;
    }
  }
}
