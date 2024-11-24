import 'package:flutter/material.dart';
import 'next_reservation_check.dart';

class NextReservationCompletePage extends StatelessWidget {
  final String date;
  final String time;

  NextReservationCompletePage({required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.11),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: const Color(0xFF989898),
                          size: screenWidth * 0.07,
                        ),
                        onPressed: () {
                          Navigator.pop(context); // 뒤로 가기 동작 추가
                        },
                      ),
                      Text(
                        '뒤로 가기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontFamily: "PaperlogyBold",
                          color: const Color(0xFF989898),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_circle_right,
                          color: const Color(0xFF265A5A),
                          size: screenWidth * 0.1,
                        ),
                        onPressed: () {
                          // '다음' 버튼 동작 추가
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NextReservationCheckPage(),
                            ),
                          );
                        },
                      ),
                      Text(
                        '다음',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontFamily: "PaperlogyBold",
                          color: const Color(0xFF265A5A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('예약 정보를\n확인하세요',
            style: TextStyle(
            fontSize: 100,
            fontFamily: "PaperlogyBold",
            color: Colors.teal[800],
                ),
              ),

            SizedBox(height: screenHeight * 0.06),
            _buildInfoRow('예약 날짜', date, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.04),
            _buildInfoRow('예약 시간', time, screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      String title, String value, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'PaperlogyBold',
            fontSize: screenWidth * 0.08,
            color: Colors.teal[800],
          ),
        ),
        SizedBox(height: screenHeight * 0.009),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'PaperlogyBold',
            fontSize: screenWidth * 0.09,
            color: Colors.black87,
            decoration: TextDecoration.underline, // 밑줄 추가
            decorationColor: Colors.black, // 밑줄 색상
            decorationThickness: 2.0, // 밑줄 두께
          ),
        ),
      ],
    );
  }
}
