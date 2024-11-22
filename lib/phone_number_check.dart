import 'package:dx_project_app/condition_choice.dart';
import 'package:dx_project_app/gender_choice.dart';
import 'package:dx_project_app/year.dart';
import 'package:flutter/material.dart';

class PhoneNumberCheckPage extends StatelessWidget {
  final String phoneNumber;

  // 생성자에서 selectedCondition을 받습니다.
  PhoneNumberCheckPage({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GenderChoicePage()),
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
              '전화번호가\n입력되었습니다\n\n$phoneNumber', // 전달된 운동 강도 텍스트를 사용
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
