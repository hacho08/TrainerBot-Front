import 'package:flutter/material.dart';
import 'excercise_start_info.dart'; // exercise_start_info 페이지를 import하세요.

class LowerBodyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 2초 후에 exercise_start_info 페이지로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ExcerciseStartInfoPage(), // 이동할 페이지
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '오늘은\n하체 운동을 진행하세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.085,
                fontWeight: FontWeight.bold,
                fontFamily: "PaperlogyMedium",
                color: Color(0xFF265A5A), // 텍스트 색상
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Image.asset(
              'images/lower_body.png', // 이미지 파일 경로
              width: screenWidth * 0.8, // 이미지 너비 조정
              height: screenHeight * 0.5, // 이미지 높이 조정
              fit: BoxFit.contain, // 이미지 비율 유지
            ),
          ],
        ),
      ),
    );
  }
}
