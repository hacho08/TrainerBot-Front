import 'package:flutter/material.dart';
import 'package:dx_project_app/real_exercise.dart';
import 'package:flutter/services.dart';

import 'next_reservation_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: TodayExerciseFinishPage(), // 시작 화면
    );
  }
}

class TodayExerciseFinishPage extends StatefulWidget {
  @override
  _TodayExerciseFinishPageState createState() => _TodayExerciseFinishPageState();
}

class _TodayExerciseFinishPageState extends State<TodayExerciseFinishPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.13),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 버튼을 우측 끝으로 배치
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.03), // 오른쪽에 여백을 추가
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Color(0xFFB4C1C1),
                            size: screenWidth * 0.1,
                          ),
                          onPressed: () {
                            SystemNavigator.pop();  // 앱을 종료
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.03), // 오른쪽에 여백을 추가
                        child: Text(
                          '종료',
                          style: TextStyle(
                            fontSize: screenWidth * 0.055,
                            fontFamily: "PaperlogyBold",
                            color: Color(0xFFB4C1C1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              '오늘의 운동이\n완료되었습니다',
              style: TextStyle(
                fontSize: screenWidth * 0.13, // 화면 크기에 맞춰 숫자 크기 설정
                fontFamily: 'PaperlogyBold',
                color: Color(0xFF265A5A),
              ),
            ),
            const SizedBox(height: 100),
            Image.asset("images/medal.png", width: 200), // 운동 완료 이미지
            const SizedBox(height: 100),
            // "다음 운동 예약" 버튼
            ElevatedButton(
              onPressed: () {
                // 다음 운동 예약 페이지로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NextExerciseReservationPage(), // 여기에 실제 운동 예약 페이지로 이동하는 코드 넣기
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF265A5A), // 버튼 색상
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                '다음 운동 예약',
                style: TextStyle(
                  fontSize: screenWidth * 0.08, // 버튼 텍스트 크기
                  fontFamily: "PaperlogyBold",
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
