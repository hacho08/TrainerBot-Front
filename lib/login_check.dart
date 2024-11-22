import 'package:dx_project_app/condition_choice.dart';
import 'package:flutter/material.dart';

class LoginCheckPage extends StatelessWidget {

  @override
  @override
  Widget build(BuildContext context) {
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ConditionChoicePage()),
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
              '로그인이\n완료되었습니다', // 전달된 운동 강도 텍스트를 사용
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
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
