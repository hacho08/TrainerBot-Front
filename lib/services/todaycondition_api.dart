import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/routine.dart';

class TodayConditionApi {
  static const String baseUrl = "http://192.168.35.2:8090/api";  // Node.js 서버 주소

  // 데이터 삽입
  Future<Routine> addTodayCondition(String userId, String condition) async {
    final url = Uri.parse('$baseUrl/today_condition'); // API 엔드포인트
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'condition': condition, // condition 데이터를 전송
      }),
    );

    if (response.statusCode == 200) {
      // API 응답을 JSON 형식으로 파싱
      final responseData = json.decode(response.body);
      print('%%%%%%%%%%%%%%%% $responseData');
      // 'routine' 값을 추출하여 Routines 객체로 리턴
      Routine routine = Routine.fromJson(responseData);

      print('Routine added successfully: ${routine.routineId} target: ${routine.target}');
      print('add condition Successfully');
      return routine; // target 값을 리턴
    } else {
      throw Exception(
          'Failed to add today\'s condition: ${response.body}');
    }
  }
}