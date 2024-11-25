// lib/services/user_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApi {
  static const String baseUrl = "http://localhost:8080/api/users"; // 서버 주소

  // 사용자 추가
  Future<void> addUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user),
    );
    if (response.statusCode == 200) {
      print('User added successfully');
    } else {
      print('Failed to add user');
    }
  }

  // 사용자 조회
  Future<void> getUserById(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$userId'),
    );
    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      print('User data: $user');
    } else {
      print('User not found');
    }
  }

  // 사용자 수정
  Future<void> updateUser(String userId, Map<String, dynamic> user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$userId'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user),
    );
    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Failed to update user');
    }
  }

  // 사용자 삭제
  Future<void> deleteUser(String userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$userId'),
    );
    if (response.statusCode == 204) {
      print('User deleted successfully');
    } else {
      print('Failed to delete user');
    }
  }
}
