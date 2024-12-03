import 'package:dx_project_app/screens/pose_detector_view.dart';
import 'package:flutter/material.dart';
import 'login_phone_number.dart';
import 'name.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'real_exercise.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({super.key});

  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage>{
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

  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("항목을 선택해주세요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 얻기
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF265A5A), // 메인 로그인 페이지 배경색
      body: Center(
        child: SingleChildScrollView( // 스크롤 가능하게 해서 오버플로우 방지
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RealExercisePage(exercises: exercises, sets: 1, currentIndex: 0, )),
                );
              },
                child: Text(
                'Pose Detection',
                style: TextStyle(
                  fontFamily: "PaperlogySemiBold",
                  fontSize: width * 0.01, // 글자 크기 비율로 조정
                  ),
                ),
              ),
              Image.asset(
                "images/main_manse_image.png",
                width: width * 0.3, // 이미지 크기 화면 비율에 맞게 조정
              ),
              const SizedBox(height: 20), // 간격
              Text(
                'LG 트레이너 봇',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "PaperlogySemiBold",
                  fontSize: width * 0.12, // 글자 크기 비율로 조정
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.05), // 간격
              Text(
                '항목을 선택해주세요.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.08, // 글자 크기 비율로 조정
                  fontFamily: "PaperlogyRegular",
                ),
              ),
              SizedBox(height: height * 0.05), // 간격
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로그인 버튼
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPhoneNumberPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFCF9F5),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // 둥근 모서리 정도 설정
                      ),
                      fixedSize: Size(width * 0.4, height * 0.4), // 화면 크기에 맞게 크기 설정
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontFamily: "PaperlogySemiBold",
                        fontSize: width * 0.08, // 글자 크기 비율로 조정
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.05), // 버튼 간격
                  // 회원가입 버튼
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Name()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD5C6B9),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // 둥근 모서리 정도 설정
                      ),
                      fixedSize: Size(width * 0.4, height * 0.4), // 화면 크기에 맞게 크기 설정
                    ),
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        fontFamily: "PaperlogySemiBold",
                        fontSize: width * 0.08, // 글자 크기 비율로 조정
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
