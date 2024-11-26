import 'package:dx_project_app/next_reservation_choice.dart';
import 'package:flutter/material.dart';
import 'next_reservation_check.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NextReservationCompletePage extends StatefulWidget {
  final String date;
  final String time;

  NextReservationCompletePage({required this.date, required this.time});

  @override
  _NextReservationCompletePageState createState() =>
      _NextReservationCompletePageState();
}

class _NextReservationCompletePageState extends State<NextReservationCompletePage>{

  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("예약 정보를 확인해주세요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.13),
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
                          color: Color(0xFF989898),
                          size: screenWidth * 0.1,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NextReservationChoicePage(),
                            ),
                          );
                        },
                      ),
                      Text(
                        '뒤로 가기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontFamily: "PaperlogyBold",
                          color: Color(0xFF989898),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_circle_right,
                              color: Color(0xFF265A5A),
                              size: screenWidth * 0.1,
                            ),
                            onPressed: () {

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NextReservationCheckPage(),
                                    ),
                                  );
                              }

                          ),
                          Text(
                            '다음',
                            style: TextStyle(
                              fontSize: screenWidth * 0.055,
                              fontFamily: "PaperlogyBold",
                              color: Color(0xFF265A5A),
                            ),
                          ),
                        ],
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
            color: Color(0xFF265A5A),
                ),
              ),

            SizedBox(height: screenHeight * 0.06),
            _buildInfoRow('예약 날짜', widget.date, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.04),
            _buildInfoRow('예약 시간', widget.time, screenWidth, screenHeight),
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
            fontSize: screenWidth * 0.09,
            color: Color(0xFF265A5A),
          ),
        ),
        SizedBox(height: screenHeight * 0.009),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'PaperlogyBold',
            fontSize: screenWidth * 0.13,
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
