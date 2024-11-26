import 'dart:async';
import 'package:dx_project_app/countdown.dart';
import 'package:flutter/material.dart';

class BeforeCountdownPage extends StatefulWidget {
  @override
  _BeforeCountdownPageState createState() => _BeforeCountdownPageState();
}

class _BeforeCountdownPageState extends State<BeforeCountdownPage> {

  @override
  void initState() {
    super.initState();
    // 페이지가 띄워진 후 1초 뒤에 다른 페이지로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CountdownPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // "3초 후 시작합니다" 텍스트
            Text(
              '3초 후\n시작합니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.15, // 화면 크기에 맞춰 숫자 크기 설정
                  fontFamily: 'PaperlogySemiBold',
                  color: Color(0xFF265A5A)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('다음 페이지')),
      body: Center(
        child: Text('다음 페이지로 이동했습니다!'),
      ),
    );
  }
}
