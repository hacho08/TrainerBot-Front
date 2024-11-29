import 'models/user.dart';
import 'gender_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PhoneNumberCheckPage extends StatefulWidget {
  final User user;

  // 생성자에서 phoneNumber를 받습니다.
  PhoneNumberCheckPage({required this.user});

  @override
  _PhoneNumberCheckPageState createState() => _PhoneNumberCheckPageState();
}

class _PhoneNumberCheckPageState extends State<PhoneNumberCheckPage> {
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _readText(); // 페이지가 열리면 읽기 시작
  }

  Future<void> _readText() async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("전화번호가 입력되었습니다");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("userid: ${widget.user.userId}");
    // 3초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GenderChoicePage(user: widget.user)),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Image.asset("images/check.png", width: 300),
                const SizedBox(height: 50),
              Center(
                child:
                Text.rich(
                  TextSpan(
                    text: '전화번호가\n입력되었습니다\n\n',
                    style: const TextStyle(
                      fontSize: 80,
                      fontFamily: "PaperlogySemiBold",
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '${widget.user.userId}', // $name 부분에 색상 적용
                        style: TextStyle(
                          fontSize: 80,
                          fontFamily: "PaperlogySemiBold",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF265A5A), // 원하는 색상
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
