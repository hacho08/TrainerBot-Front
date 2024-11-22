import 'package:dx_project_app/condition_choice.dart';
import 'package:dx_project_app/medical_condition_check.dart';
import 'package:flutter/material.dart';
import 'gender_choice.dart';
import 'info_insert_finish.dart';
import 'medical_condition_choice.dart';

class GenderCheckPage extends StatelessWidget {
  final String selectedCondition;

  // 생성자에서 selectedCondition을 받습니다.
  GenderCheckPage({required this.selectedCondition});

  @override
  Widget build(BuildContext context) {
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MedicalConditionChoicePage()),
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
              '$selectedCondition',
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
