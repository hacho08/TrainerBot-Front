 import 'package:flutter/material.dart';
import 'hobby_exercise_choice.dart';

class ExerciseGoalCheckPage extends StatelessWidget {
  final List<String> selectedConditions;

  // 생성자에서 selectedCondition을 받습니다.
  ExerciseGoalCheckPage({required this.selectedConditions});

  @override
  Widget build(BuildContext context) {
    // 2초 후 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HobbyExerciseChoicePage()),
      );
    });

    // '선택되지 않음' 처리
    String displayConditions = selectedConditions.join(', '); // 조건이 있으면 선택된 텍스트를 나열

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '운동 목표로\n아래 항목이\n선택되었습니다\n', // 전달된 운동 강도 텍스트를 사용
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              displayConditions, // 선택된 조건 또는 '없음'을 표시
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
