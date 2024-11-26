import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dx_project_app/demonstration_exercise.dart'; // 해당 페이지로 이동


class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  int _countdown = 3; // 카운트다운 초기값
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // 카운트다운 시작
    _startCountdown();
  }

  // 카운트다운을 1초마다 진행
  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--; // 카운트다운 감소
        } else {
          _timer.cancel(); // 카운트다운이 끝나면 타이머 종료
          // 0이 되면 다음 페이지로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DemonstrationExercisePage()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 페이지가 닫힐 때 타이머 종료
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 카운트다운 숫자를 크게 중앙에 표시
            Text(
              '$_countdown',
              style: TextStyle(
                fontSize: screenWidth * 0.3, // 화면 크기에 맞춰 숫자 크기 설정
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
