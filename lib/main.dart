import 'phone_number.dart';
import 'package:flutter/material.dart';
import 'main_login.dart'; // main_login.dart 파일을 import
import 'next_reservation_info.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:camera/camera.dart';

// 카메라 목록 변수
List<CameraDescription> cameras = [];

Future<void> main() async {
  // 비동기 메서드를 사용함
  WidgetsFlutterBinding.ensureInitialized();
  // 사용 가능한 카메라 목록 받아옴
  cameras = await availableCameras();
  // 앱 실행
  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: const SplashScreen(), // 시작 화면
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen>{
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
    await _flutterTts.speak("안녕하세요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainLoginPage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF265A5A), // 배경색
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/main_manse_image.png", width: 200), // 이미지
            const SizedBox(height: 20), // 간격
            const Text(
              'LG 트레이너 봇',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "PaperlogySemiBold",
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: (){
              print('I clicked');
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => PoseDetectionPage(cameras: cameras)))
            },
            child: Text('포즈'))
          ],
        ),
      ),
    );
  }
}
