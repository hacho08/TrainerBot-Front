import 'package:flutter/material.dart';
import 'gender_choice.dart';
import 'info_insert_finish.dart';

class checkPage extends StatelessWidget {
  const checkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 메인 로그인 페이지 배경색
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar 배경색
        elevation: 0, // 그림자 제거
        actions: [
          IconButton(
            icon: Image.asset('images/next.png'), // 버튼 이미지 경로 설정
            iconSize: 40, // 이미지 크기 설정
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoInsertFinishPage(), // 이동할 페이지로 설정
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/check.png",
              width: 300,
            ),
            const SizedBox(height: 50),
            const Text(
              '이름이 옥수수(으)로\n입력되었습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
