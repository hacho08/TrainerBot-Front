// lib/services/user_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApi {
  static const String baseUrl = "http://localhost:8090/api/users"; // 서버 주소


  // 사용자 이름 추가
  Future<void> addUserName(String userName) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"USER_NAME": userName}), // 서버에 사용자 이름 전송
    );

    if (response.statusCode == 200) {
      print('User name added successfully');
    } else {
      print('Failed to add user name');
    }
  }

  // 사용자 이름 조회
  Future<String> getUserName(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$userId'), // userId를 통해 사용자 이름 조회
    );

    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      return user['USER_NAME'];
    } else {
      return 'User not found';
    }
  }
}
