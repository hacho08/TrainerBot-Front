import 'dart:async';
import 'test_rest_time_lower.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TestRealExerciseLowerPage extends StatefulWidget {
  final int sets;

  final List<Map<String, dynamic>> exercises;
  final int currentIndex; // 현재 운동 인덱스

  const TestRealExerciseLowerPage(
      {Key? key,
      required this.exercises,
      required this.sets,
      required this.currentIndex})
      : super(key: key);

  @override
  _TestRealExerciseLowerPageState createState() => _TestRealExerciseLowerPageState();
}

class _TestRealExerciseLowerPageState extends State<TestRealExerciseLowerPage> {
  late VideoPlayerController _controller;

  int targetSets = 2; // 반복횟수
  int _countdown = 5; // 카운트다운 초기값
  late Timer _timer;
  late FlutterTts _flutterTts;
  late int _currentIndex; // 현재 인덱스 상태 변수

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
// await _flutterTts.speak("첫 번째 운동을 시작합니다");
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--; // 카운트다운 감소
        } else if (_countdown == 1) {
          _timer.cancel(); // 카운트다운이 1초일 때 타이머 종료
          _goToRestTime(); // 1초가 되면 RestTimePage로 이동
        }
      });
    });
  }

  // 카운트다운이 끝나면 RestTimePage로 이동
  void _goToRestTime() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TestRestTimeLowerPage(
          currentSet: widget.sets,
          exercises: widget.exercises,
          currentIndex: widget.currentIndex,
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _currentIndex = widget.currentIndex; // widget.currentIndex로 초기화
    _initializeTts(); // TTS 초기화 및 실행
    targetSets = widget.sets;
    if (widget.sets == 0) {
      _currentIndex++;
    }

    // 비디오 파일 로드
    _controller =
        VideoPlayerController.asset('video/test_video.mp4') // 비디오 경로 지정
          ..initialize().then((_) {
            setState(() {}); // 비디오 초기화가 완료된 후 setState 호출
          })
          ..setLooping(true) // 반복 재생 설정
          ..play(); // 재생 시작

// 카운트다운 시작
    _startCountdown();
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
    _controller.dispose(); // 비디오 리소스 해제
    _timer.cancel(); // 타이머 해제
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    var currentExercise = widget.exercises[_currentIndex]; // 리스트를 widget에서 가져옴

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
                      currentExercise['type'], // 운동 종류가 동적으로 변경
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
                          currentExercise['name'], // 운동 이름이 동적으로 변경
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontFamily: "PaperlogySemiBold",
                            color: Color(0xFF265A5A),
                          ),
                        ),
                        SizedBox(width: 60),
                        Column(
                          children: [
                            Text(
                              '반복 횟수: $targetSets회',
                              style: TextStyle(
                                fontSize: screenWidth * 0.06, // 크기 설정
                                fontFamily: "PaperlogySemiBold",
                                color: Colors.black,
                              ),
                            ),
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
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
// 가로선 추가
            Container(
              width: double.infinity, // 화면 전체 너비로 선을 만듦
              height: 2, // 선의 두께
              color: Color(0xFFB4C1C1), // 선의 색상
            ),
            SizedBox(height: screenHeight * 0.05),

// 비디오 추가
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(), // 비디오가 초기화될 때까지 빈 컨테이너 반환
          ],
        ),
      ),
    );
  }
}
