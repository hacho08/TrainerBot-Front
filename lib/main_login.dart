import 'package:dx_project_app/phone_number.dart';
import 'package:flutter/material.dart';
import 'login_check.dart';
import 'login_phone_number.dart';
import 'year.dart';
import 'next_reservation_info.dart';

class MainLoginPage extends StatelessWidget {
  const MainLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF265A5A), // 메인 로그인 페이지 배경색
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/main_manse_image.png"), // 이미지
            const SizedBox(height: 20), // 간격
            const Text(
              'LG 트레이너 봇',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "PaperlogySemiBold",
                fontSize: 110,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 90), // 간격
            const Text(
              '항목을 선택해주세요.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontFamily: "PaperlogyRegular",
              ),
            ),
            const SizedBox(height: 40), // 간격
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPhoneNumberPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFCF9F5),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // 둥근 모서리 정도 설정
                    ),
                    fixedSize: Size(480, 650), // 버튼의 너비와 높이 설정
                  ),
                  child:
                  const Text(
                    '로그인',
                    style: TextStyle(
                      fontFamily: "PaperlogySemiBold",
                      fontSize: 100
                    ),

                  ),
                ),
                const SizedBox(width: 20), // 버튼 간격
                ElevatedButton(
                  onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => InputBirthYearScreen()),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD5C6B9),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // 둥근 모서리 정도 설정
                    ),
                    fixedSize: Size(480, 650), // 버튼의 너비와 높이 설정
                  ),
                  child:
                  const Text(
                    '회원가입',
                    style: TextStyle(
                        fontFamily: "PaperlogySemiBold",
                        fontSize: 100
                    ),

                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
