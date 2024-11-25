import 'package:flutter/material.dart';
import 'exercise_level_choice.dart';
import 'exercise_goal_choice.dart';

class ExerciseLevelCheckPage extends StatelessWidget {
  final String selectedCondition;

  // 생성자에서 selectedCondition을 받습니다.
  ExerciseLevelCheckPage({required this.selectedCondition});

  @override
  Widget build(BuildContext context) {

    // 2초 후 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExerciseGoalChoicePage()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '$selectedCondition', // 전달된 운동 강도 텍스트를 사용
              textAlign: TextAlign.center,
              style: const TextStyle(
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
