import 'dart:async';
import 'test_countdown.dart';
import 'package:flutter/material.dart';

class TestBeforeCountdownPage extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  final int currentIndex; // 현재 운동 인덱스

// 생성자를 통해 exercises 리스트를 받음
  TestBeforeCountdownPage(
      {required this.exercises, required this.currentIndex});

  @override
  _TestBeforeCountdownPageState createState() =>
      _TestBeforeCountdownPageState();
}

class _TestBeforeCountdownPageState extends State<TestBeforeCountdownPage> {
  @override
  void initState() {
    super.initState();
    print("2번 페이지 currentIndex: ${widget.currentIndex}");
// 페이지가 띄워진 후 1초 뒤에 다른 페이지로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TestCountdownPage(
                exercises: widget.exercises,
                currentIndex: widget.currentIndex)),
      );
    });
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
// "3초 후 시작합니다" 텍스트
            Text(
              '3초 후\n시작합니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: screenWidth * 0.15, // 화면 크기에 맞춰 숫자 크기 설정
                  fontFamily: 'PaperlogySemiBold',
                  color: Color(0xFF265A5A)),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('다음 페이지')),
      body: Center(
        child: Text('다음 페이지로 이동했습니다!'),
      ),
    );
  }
}
