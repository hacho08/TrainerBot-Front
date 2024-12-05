import 'dart:async';
import 'package:dx_project_app/real_exercise.dart';
import 'package:dx_project_app/today_exercise_finish.dart';

import 'total_demonstrate_exercise.dart';
import 'upper_and_lower_body_final.dart';
import 'test_real_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_tts/flutter_tts.dart'; // TTS 패키지

class TestRestTimePage extends StatefulWidget {
  final int currentSet;
  final List<Map<String, dynamic>> exercises;
  final int currentIndex;

  // 생성자에서 selectedCondition을 받습니다.
  TestRestTimePage({required this.currentSet, required this.exercises, required this.currentIndex});

  @override
  _TestRestTimePageState createState() => _TestRestTimePageState();
}

class _TestRestTimePageState extends State<TestRestTimePage> {
  int _countdown = 5; // 카운트다운 초기값
  late Timer _timer;
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    print("rest_time 페이지 currentIndex: ${widget.currentIndex}");
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
    // 카운트다운 시작
    _startCountdown();
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("대단해요!! 5초간 휴식을 취해주세요");
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
      // setState(() {
        if (_countdown > 1) {
          setState(() {
            _countdown--; // 카운트다운 감소
          });

        } else {
          _timer.cancel(); // 카운트다운이 끝나면 타이머 종료

          _goToExercisePage(); // 0이 되면 운동 페이지로 이동
        }
      // });
    });
  }

  // 카운트다운이 끝나면 운동 페이지로 돌아가기
  void _goToExercisePage() {
    // currentSet이 0이면 TotalDemonstrateExercisePage로 넘어가고 currentIndex를 1 증가시킴
    if(widget.currentSet-1!=0){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RealExercisePage(sets: widget.currentSet-1, exercises: widget.exercises, currentIndex:widget.currentIndex),
        ),
      );
    } else if (widget.currentIndex==0 && widget.currentSet-1==0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpperAndLowerBodyFinalPage(),
        ),
      );
    }
    else if (widget.currentSet-1==0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TotalDemonstrateExercisePage(
            currentIndex: widget.currentIndex + 1, // currentIndex 1 증가
          ),
        ),
      );
    }
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
                            // widget.onRestTimeFinished(); // 타이머 종료 후 콜백 함수 호출
                            _goToExercisePage(); // 0이 되면 운동 페이지로 이동
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