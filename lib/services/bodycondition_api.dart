import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_body_condition.dart';

class UserBodyConditionService {
  final apiUrl = 'http://localhost:8090/api';  // Node.js 서버 주소

  // 데이터 삽입
  Future<void> addCondition(String userId, String conditionId) async {
    final response = await http.post(
      Uri.parse('$apiUrl/body_condition'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'conditionId': conditionId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add condition');
    }
  }

  // 데이터 조회
  Future<List<UserBodyCondition>> getCondition() async {
    final response = await http.get(Uri.parse('$apiUrl/body_condition'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserBodyCondition.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load conditions');
    }
  }


}