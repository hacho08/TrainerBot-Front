import 'package:dx_project_app/condition_choice.dart';
import 'package:dx_project_app/gender_choice.dart';
import 'package:dx_project_app/phone_number.dart';
import 'package:flutter/material.dart';

class YearCheckPage extends StatelessWidget {
  final String birthYear;

  // 생성자에서 selectedCondition을 받습니다.
  YearCheckPage({required this.birthYear});

  @override
  Widget build(BuildContext context) {
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PhoneNumberPage()),
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
              '출생연도가\n$birthYear년으로\n설정되었습니다', // 전달된 운동 강도 텍스트를 사용
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
