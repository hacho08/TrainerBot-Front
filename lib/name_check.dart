import 'package:dx_project_app/year.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NameCheckPage extends StatefulWidget {
  final User user; // User 객체를 받기 위한 변수

  // 생성자에서 selectedCondition을 받습니다.
  NameCheckPage({required this.user});

  @override
  _NameCheckPageState createState() => _NameCheckPageState();
  }

 class _NameCheckPageState extends State<NameCheckPage>{
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
     await _flutterTts.speak("이름이 입력되었습니다");
   }

   @override
   void dispose() {
     _flutterTts.stop(); // 페이지 종료 시 TTS 중지
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    print("name: ${widget.user.userName}");
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InputBirthYearScreen(user: widget.user)),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text.rich(
              TextSpan(
                text: '이름이 ',
                style: const TextStyle(
                  fontSize: 80,
                  fontFamily: "PaperlogySemiBold",
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${widget.user.userName}', // $name 부분에 색상 적용
                    style: TextStyle(
                      fontSize: 80,
                      fontFamily: "PaperlogySemiBold",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF265A5A), // 원하는 색상
                    ),
                  ),
                  const TextSpan(
                    text: ' (으)로\n입력되었습니다',
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
