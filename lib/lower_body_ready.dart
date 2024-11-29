import 'dart:async';
import 'lower_total_demonstrate_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: LowerBodyReadyPage(), // 시작 화면
    );
  }
}

class LowerBodyReadyPage extends StatefulWidget {
  _LowerBodyReadyPageState createState() => _LowerBodyReadyPageState();
}

class _LowerBodyReadyPageState extends State<LowerBodyReadyPage> {
  late FlutterTts _flutterTts;
  late VideoPlayerController _controller;
  int _countdown = 60; // 카운트다운 초기값
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts();

    // 비디오 파일 로드
    _controller = VideoPlayerController.asset('video/lower_body_start_stretching.mp4') // 경로 수정
      ..initialize().then((_) {
        setState(() {});  // 비디오 초기화가 완료된 후 setState 호출
      })
      ..setLooping(true)  // 반복 재생 설정
      ..play();  // 재생 시작

    // 카운트다운 시작
    _startCountdown();

    // 1분 후 다른 페이지로 이동
    Future.delayed(Duration(minutes: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LowerTotalDemonstrateExercisePage(currentIndex: 0)),  // NextPage로 이동
      );
    });
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("준비운동을 시작합니다");
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--; // 카운트다운 감소
        } else {
          _timer.cancel(); // 카운트다운이 끝나면 타이머 종료
        }
      });
    });
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    _controller.dispose(); // 비디오 리소스 해제
    _timer.cancel(); // 타이머 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '준비운동',
                      style: TextStyle(
                        fontSize: 120,
                        fontFamily: "PaperlogyBold",
                        color: Color(0xFF265A5A),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Row(
                      children: [
                        Text(
                          '스모자세 스트레칭',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontFamily: "PaperlogySemiBold",
                            color: Color(0xFF265A5A),
                          ),
                        ),
                        SizedBox(width: 60),
                        // 남은 시간 카운트 표시
                        Text(
                          '남은 시간: $_countdown초',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06, // 크기 설정
                            fontFamily: "PaperlogySemiBold",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            // 비디오 플레이어 추가
            _controller.value.isInitialized
                ? Container(
              width: screenWidth * 0.9, // 화면 너비의 90%
              height: screenHeight * 0.65, // 화면 높이의 50%로 크기 설정
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
                : Center(child: CircularProgressIndicator()), // 로딩 중일 때 표시할 위젯
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
