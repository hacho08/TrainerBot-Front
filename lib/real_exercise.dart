import 'dart:async';

import 'package:dx_project_app/screens/pose_detector_view.dart';
import 'package:dx_project_app/test_rest_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


class RealExercisePage extends StatefulWidget {
  final int sets;

  final List<Map<String, dynamic>> exercises;
  final int currentIndex; // 현재 운동 인덱스

  const RealExercisePage(
      {Key? key,
        required this.exercises,
        required this.sets,
        required this.currentIndex})
      : super(key: key);

  @override
  _RealExercisePageState createState() => _RealExercisePageState();
}

class _RealExercisePageState extends State<RealExercisePage> {
  // late VideoPlayerController _controller;

  // 운동 데이터를 예시로 설정합니다.
  // AI로부터 받은 운동 데이터에 맞게 이 값을 변경할 수 있습니다.
  String exerciseType = '하체운동'; // 운동 종류
  String exerciseName = '스쿼트'; // 운동 이름
  int targetSets = 20; // 목표 갯수
  int remainingSets = 3; // 남은 갯수
  int _countdown = 20; // 카운트다운 초기값
  List<String> koreanNumbers = [
    '하나', '둘', '셋', '넷', '다섯', '여섯', '일곱', '여덟', '아홉', '열',
    '열하나', '열둘', '열셋', '열넷', '열다섯', '열여섯', '열일곱', '열여덟', '열아홉', '스물'
  ];
  late Timer _timer;
  late FlutterTts _flutterTts;
  late int _currentIndex; // 현재 인덱스 상태 변수

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
// await _flutterTts.speak("첫 번째 운동을 시작합니다");
  }
  // 운동 완료 여부를 받아서 처리하는 함수
  // 운동 완료 여부에 따라 카운트 감소 처리
  void onExerciseCompleted(bool completed) {
    setState(() {
      if (completed) {
        _countdown--;
        // if (targetSets <= 0) {
        //    // = "운동이 완료되었습니다!";
        //   _goToRestTime();
        // }
      } else {
        // _feedbackMessage = "운동이 잘못되었습니다. 다시 시도해주세요.";
      }
    });
  }

  void _startCountdown() {
    int time = 3;
    if (widget.exercises[_currentIndex]['name'] == "덤벨컬") {
      time = 2;
    }

    _timer = Timer.periodic(Duration(seconds: time), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown--; // 카운트다운 감소
          _flutterTts.speak(koreanNumbers[20-_countdown]);
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
          builder: (context) => TestRestTimePage(
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
    _startCountdown();
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
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
        padding: EdgeInsets.symmetric(horizontal: 0), //screenWidth * 0.05
        child: Stack(
          children: [
            Container(
              child: PoseDetectorView(),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          Text(
                            currentExercise['type'],  // 운동 종류가 동적으로 변경
                            style: TextStyle(
                              fontSize: screenWidth * 0.10,
                              fontFamily: "PaperlogyBold",
                              color: Color(0xFF265A5A),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          Text(
                            currentExercise['name'],  // 운동 이름이 동적으로 변경
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontFamily: "PaperlogySemiBold",
                              color: Color(0xFF265A5A),
                            ),
                          ),
                          SizedBox(height: screenHeight*0.005),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 90),
                          Text(
                            '남은 반복 횟수: $targetSets',  // 세트 수가 동적으로 변경
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: "PaperlogySemiBold",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          Text(
                            '남은 갯수: $_countdown',  // 남은 갯수가 동적으로 변경
                            style: TextStyle(
                              fontSize: 50,
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
            ),
          ],
        ),
      ),
    );
  }
}