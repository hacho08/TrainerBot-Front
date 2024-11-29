import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserApi {
  static const String baseUrl = "http://192.168.0.14:8090/api"; // 서버 주소

  // 사용자 추가
  Future<void> addUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()), // 서버에 사용자 이름 전송
    );

    if (response.statusCode == 200) {
      print('User added successfully');
    } else {
      print('Failed to add user: ${response.body}');
    }
  }

  // 특정 사용자 조회
  Future<User> getUserById(String userId) async {
    print('사용자 조회: $userId');
    final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {"Content-Type": "text/plain"},
        body: userId,
    ); // userId를 서버로 전송);
    print('Response status: ${response.statusCode}');

    final String responseBody = utf8.decode(response.bodyBytes);
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      // User 객체로 변환
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user with ID $userId');
    }
  }
}

