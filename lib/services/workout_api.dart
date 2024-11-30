import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import '../models/routine.dart';
import '../models/workout.dart';

class WorkoutApi {
  static const String baseUrl = "http://192.168.0.13:8090/api";  // Node.js 서버 주소

  // 데이터 삽입
  Future<List<Workout>> getWorkouts(String userId, String routineId) async {
    final url = Uri.parse('$baseUrl/getWorkouts'); // API 엔드포인트
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'routineId': routineId, // condition 데이터를 전송
      }),
    );

    if (response.statusCode == 200) {
      // API 응답을 JSON 형식으로 파싱
      final responseData = json.decode(response.body);
      // 'routine' 값을 추출하여 Routines 객체로 리턴
      Workout workout = Workout.fromJson(responseData);
      List<Workout> workoutList = (responseData['workouts'] as List).map((item) => Workout.fromJson(item)).toList();

      print('add condition Successfully');
      return workoutList; // target 값을 리턴
    } else {
      throw Exception(
          'Failed to add today\'s condition: ${response.body}');
    }
  }
}