import 'package:flutter/material.dart';
import 'exercise_level_choice.dart';


class MedicalConditionCheckPage extends StatelessWidget {
  final List<String> selectedConditions;

  // Constructor to receive the selected conditions
  MedicalConditionCheckPage({required this.selectedConditions});

  @override
  Widget build(BuildContext context) {
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExerciseLevelChoicePage()),
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
              '유의해야 할 부위로\n아래 항목이 선택되었습니다\n',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              selectedConditions.join(', '), // Display the selected conditions
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
