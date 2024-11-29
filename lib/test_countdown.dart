import 'dart:async';
import 'test_real_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_tts/flutter_tts.dart'; // TTS 패키지

class TestCountdownPage extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  final int currentIndex; // 현재 운동 인덱스를 받아옴

// 생성자를 통해 exercises 리스트를 받음
  TestCountdownPage({required this.exercises, required this.currentIndex});

  @override
  _TestCountdownPageState createState() => _TestCountdownPageState();
}

class _TestCountdownPageState extends State<TestCountdownPage> {
  int _countdown = 3; // 카운트다운 초기값
  late Timer _timer;
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    print("3번 페이지 currentIndex: ${widget.currentIndex}");
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
// 카운트다운 시작
    _startCountdown();
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
  }

  @override
  void dispose() {
    _timer.cancel();
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

// 카운트다운을 1초마다 진행
  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--; // 카운트다운 감소
          _flutterTts.speak('$_countdown'); // 숫자 음성으로 읽어줌
        } else {
          _timer.cancel(); // 카운트다운이 끝나면 타이머 종료
          _goToExercisePage(); // 0이 되면 운동 페이지로 이동
        }
      });
    });
  }

// 카운트다운이 끝나면 운동 페이지로 돌아가기
  void _goToExercisePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TestRealExercisePage(
            sets: 2,
            exercises: widget.exercises,
            currentIndex: widget.currentIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
// 카운트다운 숫자를 크게 중앙에 표시
            Text(
              '$_countdown',
              style: TextStyle(
                fontSize: screenWidth * 0.2, // 화면 크기에 맞춰 숫자 크기 설정
                fontFamily: 'PaperlogySemiBold',
                color: Color(0xFF265A5A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
