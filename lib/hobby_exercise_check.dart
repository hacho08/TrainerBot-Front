import 'package:flutter/material.dart';
import 'info_insert_finish.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'models/user.dart';

class HobbyExerciseCheckPage extends StatefulWidget {
  final User user;

  // Constructor to receive the selected conditions
  HobbyExerciseCheckPage({required this.user});

  @override
  _HobbyExerciseCheckPageState createState() => _HobbyExerciseCheckPageState();
}

class _HobbyExerciseCheckPageState extends State<HobbyExerciseCheckPage>{
  late FlutterTts _flutterTts;

  final List<String> hobbyTexts = [
    "걷기",
    "등산",
    "골프",
    "탁구",
    "배드민턴",
    "수영",
  ];

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
    await _flutterTts.speak("취미가 선택되었습니다");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('hobby: ${widget.user.hobby}');

    // 변환: Index 리스트를 텍스트 리스트로
    List<String> selectedTexts = widget.user.hobby
        .map((index) => hobbyTexts[index])
        .toList();

    // 2초 후 InfoInsertFinishPage로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InfoInsertFinishPage(user: widget.user)),
      );
    });

    // '선택되지 않음' 처리
    String displayHobbies = widget.user.hobby.isEmpty
        ? '없음' // 조건이 없으면 '없음'을 표시
        : selectedTexts.join(', '); // 조건이 있으면 선택된 텍스트를 나열

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '아래 취미가\n선택되었습니다\n',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              displayHobbies, // 선택된 조건 또는 '없음'을 표시
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
