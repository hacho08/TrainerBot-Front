import 'package:dx_project_app/services/user_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserYearApi {
  final String apiUrl = '${UserApi.baseUrl}/year'; // 실제 API URL로 변경

  // 사용자의 출생연도를 서버에 저장하는 함수
  Future<bool> addUserBirthYear(String userName, String birthYear) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userName': userName,
        'birthYear': birthYear,
      }),
    );

    if (response.statusCode == 200) {
      return true; // 저장 성공
    } else {
      return false; // 저장 실패
    }
  }

  // 서버에서 사용자의 출생연도를 조회하는 함수
  Future<String?> getUserBirthYear(String userName) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$userName'), // userName으로 데이터를 조회
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['birthYear']; // 서버에서 받은 출생연도
    } else {
      return null; // 데이터가 없을 경우 null 반환
    }
  }
}
