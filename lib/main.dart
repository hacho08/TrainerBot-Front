import 'package:dx_project_app/phone_number.dart';
import 'package:flutter/material.dart';
import 'main_login.dart'; // main_login.dart 파일을 import
import 'package:dx_project_app/next_reservation_info.dart';

void main() {
  runApp(const MyApp());
}

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

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
            Image.asset("images/main_manse_image.png"), // 이미지
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
          ],
        ),
      ),
    );
  }
}
