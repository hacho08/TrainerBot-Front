import 'package:dx_project_app/models/user.dart';
import 'package:dx_project_app/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class YearCheckPage extends StatefulWidget {
  final User user;

  YearCheckPage({required this.user});

  @override
  _YearCheckPageState createState() => _YearCheckPageState();
}

class _YearCheckPageState extends State<YearCheckPage> {
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTtsAndNavigate();
  }

  Future<void> _initializeTtsAndNavigate() async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.awaitSpeakCompletion(true); // TTS 완료 대기
    await _flutterTts.speak("출생년도가 입력되었습니다");

    @override
    void dispose() {
      _flutterTts.stop(); // 페이지 종료 시 TTS 중지
      super.dispose();
    }

    // TTS가 완료된 후 페이지 전환
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PhoneNumberPage(user: widget.user)),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    print("birthYear: ${widget.user.birthYear}");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text.rich(
              TextSpan(
                text: '출생연도가\n',
                style: const TextStyle(
                  fontSize: 80,
                  fontFamily: "PaperlogySemiBold",
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${widget.user.birthYear}년', // $name 부분에 색상 적용
                    style: TextStyle(
                      fontSize: 80,
                      fontFamily: "PaperlogySemiBold",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF265A5A), // 원하는 색상
                    ),
                  ),
                  const TextSpan(
                    text: '으로\n설정되었습니다',
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
