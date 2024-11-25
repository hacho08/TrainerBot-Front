import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AutoReadPage extends StatefulWidget {
  final String textToRead;

  AutoReadPage({required this.textToRead});

  @override
  _AutoReadPageState createState() => _AutoReadPageState();
}

class _AutoReadPageState extends State<AutoReadPage> {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _readText(); // 페이지가 로드될 때 자동으로 텍스트 읽기 시작
  }

  Future<void> _readText() async {
    await _flutterTts.setLanguage("ko-KR"); // 한국어 설정
    await _flutterTts.setSpeechRate(0.5); // 읽는 속도 설정
    await _flutterTts.speak(widget.textToRead); // 전달된 텍스트 읽기
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("자동 읽기 페이지")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            widget.textToRead,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}