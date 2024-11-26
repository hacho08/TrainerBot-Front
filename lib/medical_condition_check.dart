import 'package:flutter/material.dart';
import 'exercise_level_choice.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MedicalConditionCheckPage extends StatefulWidget {
  final List<String> selectedConditions;

  // Constructor to receive the selected conditions
  MedicalConditionCheckPage({required this.selectedConditions});

  @override
  _MedicalConditionCheckPageState createState() =>
      _MedicalConditionCheckPageState();
}

class _MedicalConditionCheckPageState extends State<MedicalConditionCheckPage>{
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
    await _flutterTts.speak("유의해야할 부위가 선택되었습니다");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2초 후 ExerciseLevelChoicePage로 이동
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExerciseLevelChoicePage()),
      );
    });

    // '선택되지 않음' 처리
    String displayConditions = widget.selectedConditions.isEmpty
        ? '없음' // 조건이 없으면 '없음'을 표시
        : widget.selectedConditions.join(', '); // 조건이 있으면 선택된 텍스트를 나열

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '유의해야 할 부위로\n아래 항목이 선택되었습니다\n',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 70,
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


