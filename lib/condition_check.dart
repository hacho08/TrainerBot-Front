import 'package:dx_project_app/models/routine.dart';
import 'package:flutter/material.dart';
import 'lower_body_info.dart';
import 'upper_body_info.dart'; // 다음 페이지 임포트
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Routine exampleRoutine = Routine(
      userId: '01011112222',
      target: 'upper', // 예시 데이터 (예: upper body)
      condition: '힘껏',
      createdAt: DateTime.now(), routineId: 'aaaa',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: ConditionCheckPage(condition: '힘껏', routine: exampleRoutine,)
    );
  }
}

class ConditionCheckPage extends StatefulWidget {
  final String condition;
  final Routine routine;

  ConditionCheckPage({required this.condition, required this.routine});

  @override
  _ConditionCheckPageState createState() => _ConditionCheckPageState();
}

class _ConditionCheckPageState extends State<ConditionCheckPage>{
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
    await _flutterTts.speak("운동강도가 설정되었습니다");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2초 후에 다음 페이지로 이동
    Future.delayed(Duration(seconds: 4), () {
      // if (widget.routine.target == 'upper') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UpperBodyInfoPage(routine: widget.routine,)
          ),
        );
      // } else { // lower
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => LowerBodyInfoPage(routine: widget.routine,)
      //     ),
      //   );
      // }

    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            Text.rich(
              TextSpan(
                text: "'${widget.condition}'",
                style: const TextStyle(
                  fontSize: 80,
                  fontFamily: "PaperlogySemiBold",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF265A5A), // 원하는 색상
                ),
                children: [
                  TextSpan(
                    text: ' 운동강도\n설정되었습니다', // $name 부분에 색상 적용
                    style: TextStyle(
                      fontSize: 80,
                      fontFamily: "PaperlogySemiBold",
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // 원하는 색상
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
