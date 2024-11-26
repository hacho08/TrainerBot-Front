import 'dart:convert';
import 'package:dx_project_app/services/user_api.dart';
import 'package:http/http.dart' as http;

class UserIdApi {
  final String apiUrl = '${UserApi.baseUrl}/id'; // 실제 API URL로 변경

  // 사용자 전화번호 저장 (USER_ID)
  Future<bool> addUserPhoneNumber(String userId) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return true; // 저장 성공
    } else {
      return false; // 저장 실패
    }
  }

  // 사용자 전화번호 조회 (USER_ID)
  Future<String?> getUserPhoneNumber(String userId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$userId'), // userId로 데이터를 조회
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['userId']; // 서버에서 받은 USER_ID
    } else {
      return null; // 데이터가 없을 경우 null 반환
    }
  }
}
