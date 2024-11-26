import 'package:dx_project_app/condition_choice.dart';
import 'package:flutter/material.dart';
import 'condition_choice.dart';
import 'exercise_start_info2.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ExcerciseStartInfoPage extends StatefulWidget {
  const ExcerciseStartInfoPage({super.key});

  _ExcerciseStartInfoPageState createState() => _ExcerciseStartInfoPageState();
}

class _ExcerciseStartInfoPageState extends State<ExcerciseStartInfoPage>{
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
    await _flutterTts.speak("운동을 시작합니다");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3초 후 condition_choice.dart로 이동
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExerciseStartInfo2Page()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF265A5A), // 상단 색상
              Color(0xFF517A79), // 중간1 색상
              Color(0xFF6C8E8A), // 중간2 색상
              Color(0xFFB8CBC8), // 하단 색상
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '운동을 \n시작합니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "PaperlogySemiBold",
                  fontSize: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 200),
              Image.asset('images/clap.png', width: 280),


            ],
          ),
        ),
      ),
    );
  }
}
