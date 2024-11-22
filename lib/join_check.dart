import 'package:flutter/material.dart';

class JoinCheckPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '회원가입이\n완료되었습니다', // 전달된 운동 강도 텍스트를 사용
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
