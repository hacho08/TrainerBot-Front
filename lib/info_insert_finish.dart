import 'package:flutter/material.dart';
import 'gender_choice.dart';

class InfoInsertFinishPage extends StatelessWidget {
  const InfoInsertFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF265A5A), // AppBar 배경색
        elevation: 0, // 그림자 제거
        actions: [
          IconButton(
            icon: Image.asset('images/next.png'), // 버튼 이미지 경로 설정
            iconSize: 40, // 이미지 크기 설정
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenderChoicePage(), // 이동할 페이지로 설정
                ),
              );
            },
          ),
        ],
      ),
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
              Image.asset('images/clap.png', width: 350),
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
