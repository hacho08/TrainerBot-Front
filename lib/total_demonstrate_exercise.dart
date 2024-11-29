import 'test_before_countdown.dart';
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
      home: TotalDemonstrateExercisePage(currentIndex: 0), // 운동 페이지로 시작
    );
  }
}

class TotalDemonstrateExercisePage extends StatefulWidget {
  final int currentIndex;

  // 생성자에서 currentIndex 받기
  TotalDemonstrateExercisePage({required this.currentIndex});

  @override
  _TotalDemonstrateExercisePageState createState() =>
      _TotalDemonstrateExercisePageState();
}

class _TotalDemonstrateExercisePageState
    extends State<TotalDemonstrateExercisePage> {
  late VideoPlayerController _controller;
  late FlutterTts _flutterTts;

  int _currentIndex = 0; // 현재 운동 인덱스

// 운동 데이터를 리스트로 관리
  List<Map<String, dynamic>> exercises = [
    {
      //index 0
      'index': 0,
      'type': '상체운동',
      'name': '스탠딩 니업',
      'videoPath': 'video/standing_knee_up.mp4',
      'tts': '첫 번째 운동을 시작합니다',
    },
    {
      //index 1
      'index': 1,
      'type': '상체운동',
      'name': '덤벨 컬',
      'videoPath': 'video/dumbbell_curl.mp4',
      'tts': '두 번째 운동을 시작합니다',
    },
// { //index 2
//   'index': 2,
//   'type': '하체운동',
//   'name': '사이드 런지',
//   'videoPath': 'video/dumbbell_curl.mp4',
//   'tts': '첫 번째 운동을 시작합니다',
// },
// { //index 3
//   'index': 3,
//   'type': '하체운동',
//   'name': '바벨 데드리프트',
//   'videoPath': 'video/dumbbell_curl.mp4',
//   'tts': '두 번째 운동을 시작합니다',
// }
  ];

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _currentIndex = widget.currentIndex;
    _loadExercise();
    print("1번 페이지 currentIndex: ${widget.currentIndex}");
  }

// 운동을 로드하고 TTS 설정
  Future<void> _loadExercise() async {
    var currentExercise = exercises[_currentIndex];
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(currentExercise['tts']);
    print("video Path!!!!: ${currentExercise['videoPath']} workout: ${currentExercise['name']}");
    _controller = VideoPlayerController.asset(currentExercise['videoPath'])
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    var currentExercise = exercises[_currentIndex];

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
                      currentExercise['type'], // 운동 종류
                      style: TextStyle(
                        fontSize: 120,
                        fontFamily: "PaperlogyBold",
                        color: Color(0xFF265A5A),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    Text(
                      currentExercise['name'], // 운동 이름
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontFamily: "PaperlogySemiBold",
                        color: Color(0xFF265A5A),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_circle_right,
                              color: Color(0xFF265A5A),
                              size: screenWidth * 0.1,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestBeforeCountdownPage(
                                      exercises: exercises,
                                      currentIndex: _currentIndex),
                                ),
                              );
                            }
                        ),
                        Text(
                          '운동시작',
                          style: TextStyle(
                            fontFamily: 'PaperlogySemiBold',
                            fontSize: screenWidth * 0.06,
                            color: Color(0xFF265A5A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.005),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity, // 화면 전체 너비로 선을 만듦
              height: 2, // 선의 두께
              color: Color(0xFFB4C1C1), // 선의 색상
            ),
            SizedBox(height: screenHeight * 0.02),

            // 비디오 추가
            _controller.value.isInitialized
                ? Container(
                    width: screenWidth * 0.9, // 화면 너비의 90%
                    height: screenHeight * 0.7, // 화면 높이의 50%로 크기 설정
                    child: VideoPlayer(_controller),
                  )
                : Container(), // 비디오가 초기화될 때까지 빈 컨테이너 반환
          ],
        ),
      ),
    );
  }
}
