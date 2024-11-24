import 'package:flutter/material.dart';
import 'upper_body_info.dart'; // 다음 페이지 임포트
import 'lower_body_info.dart';

class ConditionCheckPage extends StatelessWidget {
  final String condition;

  ConditionCheckPage({required this.condition});

  @override
  Widget build(BuildContext context) {
    // 2초 후에 다음 페이지로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpperBodyInfoPage(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '\'${condition}\' 운동강도\n 설정되었습니다.', // condition 변수를 작은 따옴표로 묶음
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
