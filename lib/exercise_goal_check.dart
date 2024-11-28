import 'package:dx_project_app/models/user.dart';
import 'package:flutter/material.dart';
import 'hobby_exercise_choice.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ExerciseGoalCheckPage extends StatefulWidget {
  final User user;

  // 생성자에서 selectedCondition을 받습니다.
  ExerciseGoalCheckPage({required this.user});

  @override
  _ExerciseGoalCheckPageState createState() => _ExerciseGoalCheckPageState();
}

  class _ExerciseGoalCheckPageState extends State<ExerciseGoalCheckPage>{
    late FlutterTts _flutterTts;

    @override
    void initState() {
      super.initState();
      _flutterTts = FlutterTts();
      _initializeTts(); // TTS 초기화 및 실행
    }

    Future<void> _initializeTts() async {
      await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
      await _flutterTts.setLanguage("ko-KR");
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.speak("운동목표가 선택되었습니다");
    }

    @override
    void dispose() {
      _flutterTts.stop(); // 페이지 종료 시 TTS 중지
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    print("goal: ${widget.user.goal}");
    // 2초 후 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HobbyExerciseChoicePage(user: widget.user,)),
      );
    });

    // '선택되지 않음' 처리
    String displayConditions = widget.user.goal; // 조건이 있으면 선택된 텍스트를 나열

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '운동 목표로\n아래 항목이\n선택되었습니다\n', // 전달된 운동 강도 텍스트를 사용
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              displayConditions, // 선택된 조건 또는 '없음'을 표시
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
