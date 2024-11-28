import 'dart:convert';
import 'package:http/http.dart' as http;

class TodayConditionApi {
  static const String baseUrl = "http://192.168.0.14:8090/api";  // Node.js 서버 주소

  // 데이터 삽입
  Future<void> addTodayCondition(String userId, String condition) async {
    final url = Uri.parse('$baseUrl/today_condition'); // API 엔드포인트
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'condition': condition, // condition 데이터를 전송
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add condition');
    } else {
      throw Exception(
          'Failed to add today\'s condition: ${response.body}');
    }
  }
}