import 'package:flutter/material.dart';
import 'next_reservation_complete.dart';
import 'main_login.dart';

class NextReservationCheckPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // 3초 후에 MainLoginPage로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainLoginPage()),
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
              '예약되었습니다',
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