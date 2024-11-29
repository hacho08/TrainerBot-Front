import 'package:flutter/material.dart';
import 'exercise_level_choice.dart';
import 'models/user.dart';
import 'exercise_goal_choice.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ExerciseLevelCheckPage extends StatefulWidget {
  final User user;

  // 생성자에서 selectedCondition을 받습니다.
  ExerciseLevelCheckPage({required this.user});

  @override
  _ExerciseLevelCheckPageState createState() => _ExerciseLevelCheckPageState();
}

  class _ExerciseLevelCheckPageState extends State<ExerciseLevelCheckPage>{
    late FlutterTts _flutterTts;

    @override
    void initState() {
      super.initState();
      _flutterTts = FlutterTts();
      _initializeTts(); // TTS 초기화 및 실행
      // User 객체 상태 출력
      _printUserDetails();
    }

    Future<void> _initializeTts() async {
      await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
      await _flutterTts.setLanguage("ko-KR");
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.speak("근력운동 수준이 선택되었습니다");
    }

    @override
    void dispose() {
      _flutterTts.stop(); // 페이지 종료 시 TTS 중지
      super.dispose();
    }

    void _printUserDetails() {
      print("Workout Experience: ${widget.user.workoutExperience}");
    }

  @override
  Widget build(BuildContext context) {

      // 2초 후 이동
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExerciseGoalChoicePage(user: widget.user,)),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text.rich(
              TextSpan(
                text: '근력운동 경험 수준이\n',
                style: const TextStyle(
                  fontSize: 80,
                  fontFamily: "PaperlogySemiBold",
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${widget.user.workoutExperience}', // $name 부분에 색상 적용
                    style: TextStyle(
                      fontSize: 80,
                      fontFamily: "PaperlogySemiBold",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF265A5A), // 원하는 색상
                    ),
                  ),
                  const TextSpan(
                    text: '로\n선택되었습니다',
                    style: TextStyle(
                      fontSize: 80,
                      fontFamily: "PaperlogySemiBold",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
