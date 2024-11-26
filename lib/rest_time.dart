     import 'dart:async';
import 'real_exercise.dart';
import 'package:flutter/material.dart';
import 'demonstration_exercise.dart';
import 'package:flutter_tts/flutter_tts.dart';// 해당 페이지로 이동

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: RestTimePage(), // 시작 화면
    );
  }
}

class RestTimePage extends StatefulWidget {
  @override
  _RestTimePageState createState() => _RestTimePageState();
}

class _RestTimePageState extends State<RestTimePage> {
  int _countdown = 60; // 카운트다운 초기값
  late Timer _timer;
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
    // 카운트다운 시작
    _startCountdown();
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("대단해요!! 1분간 휴식을 취해주세요");
  }

  @override
  void dispose() {
    _timer.cancel();
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }


  // 카운트다운을 1초마다 진행
  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--; // 카운트다운 감소
        } else {
          _timer.cancel(); // 카운트다운이 끝나면 타이머 종료
          // 0이 되면 다음 페이지로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DemonstrationExercisePage()),
          );
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.13),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 버튼을 우측 끝으로 배치
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.03), // 오른쪽에 여백을 추가
                        child: IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            color: Color(0xFFB4C1C1),
                            size: screenWidth * 0.1,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RealExercisePage(),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.03), // 오른쪽에 여백을 추가
                        child: Text(
                          '건너뛰기',
                          style: TextStyle(
                            fontSize: screenWidth * 0.055,
                            fontFamily: "PaperlogyBold",
                            color: Color(0xFFB4C1C1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '잘하셨습니다!',
              style: TextStyle(
                fontSize: screenWidth * 0.13, // 화면 크기에 맞춰 숫자 크기 설정
                fontFamily: 'PaperlogySemiBold',
                color: Color(0xFF265A5A),
              ),
            ),
            const SizedBox(height: 100),
            Text(
              '1분간\n휴식을 취해주세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.1, // 화면 크기에 맞춰 숫자 크기 설정
                fontFamily: 'PaperlogySemiBold',
                color: Color(0xFF265A5A),
              ),
            ),
            Image.asset("images/loading.png", width: 200),
            const SizedBox(height: 100),
            // 카운트다운 숫자를 크게 중앙에 표시
            Text(
              '남은 시간: $_countdown초',
              style: TextStyle(
                fontSize: screenWidth * 0.08, // 화면 크기에 맞춰 숫자 크기 설정
                fontFamily: 'PaperlogySemiBold',
                color: Color(0xFF265A5A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
