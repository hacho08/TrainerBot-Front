import 'package:flutter/material.dart';
import 'excercise_start_info.dart'; // exercise_start_info 페이지를 import하세요.
import 'package:flutter_tts/flutter_tts.dart';

class UpperBodyInfoPage extends StatefulWidget {

  _UpperBodyInfoPageState createState() => _UpperBodyInfoPageState();
}

class _UpperBodyInfoPageState extends State<UpperBodyInfoPage>{
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
    await _flutterTts.speak("오늘은 상체 운동을 진행하세요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 2초 후에 exercise_start_info 페이지로 이동
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ExcerciseStartInfoPage(), // 이동할 페이지
        ),
      );
    });

    return Scaffold(
      //backgroundColor: Colors.white, // 배경색 흰색 설정
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '오늘은\n상체 운동을 진행하세요',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                fontFamily: "PaperlogyMedium",
                color: Color(0xFF265A5A), // 텍스트 색상
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Image.asset(
              'images/upper_body.png', // 이미지 파일 경로
              width: screenWidth * 0.8, // 이미지 너비 조정
              height: screenHeight * 0.5, // 이미지 높이 조정
              fit: BoxFit.contain, // 이미지 비율 유지
            ),
          ],
        ),
      ),
    );
  }
}
