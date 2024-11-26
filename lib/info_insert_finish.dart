import 'package:dx_project_app/condition_choice.dart';
import 'package:flutter/material.dart';
import 'main_login.dart';

class InfoInsertFinishPage extends StatelessWidget {
  const InfoInsertFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 3초 후 condition_choice.dart로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainLoginPage()),
      );
    });

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF265A5A), // 상단 색상
                Color(0xFF517A79), // 중간1 색상
                Color(0xFF6C8E8A), // 중간2 색상
                Color(0xFFB8CBC8), // 하단 색상
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '모든 정보가\n입력되었습니다',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PaperlogySemiBold",
                    fontSize: 100,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 200),
                Image.asset('images/clap.png', width: 280),
                const SizedBox(height: 100),
                const Text(
                  '주신 정보에 따라\n맞춤형 운동을\n추천해드릴게요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PaperlogyMedium",
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
