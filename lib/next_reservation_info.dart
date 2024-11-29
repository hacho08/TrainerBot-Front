import 'package:flutter/material.dart';
import 'next_reservation_choice.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: NextExerciseReservationPage(), // NextExerciseReservationPage를 초기 화면으로 설정
    );
  }
}


class NextExerciseReservationPage extends StatefulWidget {

  _NextExerciseReservationPageState createState() =>
      _NextExerciseReservationPageState();
}

class _NextExerciseReservationPageState extends State<NextExerciseReservationPage>{
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
    await _flutterTts.speak("다음 운동을 예약하시는군요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 3초 후 자동 이동
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NextReservationChoicePage(), // 다음 페이지로 이동
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 수평 중앙 정렬
            children: [
              Text(
                '다음 운동을\n예약하시는군요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PaperlogyBold',
                  fontSize: screenWidth * 0.09,
                  color: Color(0xFF265A5A),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Image.asset(
                'images/satisfaction.png', // 이미지 파일 경로
                width: screenWidth * 0.4, // 이미지 너비 조정
                height: screenHeight * 0.3, // 이미지 높이 조정
                fit: BoxFit.contain, // 이미지 비율 유지
              ),
            ],
          ),
        ),
      ),
    );
  }
}
