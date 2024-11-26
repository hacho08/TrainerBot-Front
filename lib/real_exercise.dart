import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: RealExercisePage(), // 시작 화면
    );
  }
}

class RealExercisePage extends StatefulWidget {
  @override
  _RealExercisePageState createState() => _RealExercisePageState();
}

class _RealExercisePageState extends State<RealExercisePage> {
  late VideoPlayerController _controller;

  // 운동 데이터를 예시로 설정합니다.
  // AI로부터 받은 운동 데이터에 맞게 이 값을 변경할 수 있습니다.
  String exerciseType = '하체운동'; // 운동 종류
  String exerciseName = '스쿼트'; // 운동 이름
  int targetSets = 5; // 목표 갯수
  int remainingSets = 3; // 남은 갯수
  late FlutterTts _flutterTts;

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("하체운동을 시작합니다");
  }


  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
    // 비디오 파일 로드
    _controller = VideoPlayerController.asset('video/test_video.mp4') // 비디오 경로 지정
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)  // 반복 재생 설정
      ..play();  // 재생 시작
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
    _controller.dispose(); // 비디오 리소스 해제
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
                      exerciseType,  // 운동 종류가 동적으로 변경
                      style: TextStyle(
                        fontSize: 120,
                        fontFamily: "PaperlogyBold",
                        color: Color(0xFF265A5A),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    Text(
                      exerciseName,  // 운동 이름이 동적으로 변경
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
                      '목표 갯수: $targetSets',  // 목표 갯수가 동적으로 변경
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: "PaperlogySemiBold",
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    Text(
                      '남은 갯수: $remainingSets',  // 남은 갯수가 동적으로 변경
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: "PaperlogySemiBold",
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
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
