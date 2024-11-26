import 'package:flutter/material.dart';
import 'next_reservation_choice.dart';

class NextExerciseReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 3초 후 자동 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NextReservationChoicePage(), // 다음 페이지로 이동
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 수평 중앙 정렬
            children: [
              Text(
                '다음 운동을\n예약하시는군요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PaperlogyBold',
                  fontSize: screenWidth * 0.09,
                  color: Color(0xFF265A5A),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Image.asset(
                'images/satisfaction.png', // 이미지 파일 경로
                width: screenWidth * 0.4, // 이미지 너비 조정
                height: screenHeight * 0.3, // 이미지 높이 조정
                fit: BoxFit.contain, // 이미지 비율 유지
              ),
            ],
          ),
        ),
      ),
    );
  }
}
