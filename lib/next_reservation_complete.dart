import 'package:dx_project_app/next_reservation_choice.dart';
import 'package:flutter/material.dart';
import 'models/reservation.dart';
import 'next_reservation_check.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'services/reservation_api.dart';
import 'global/global.dart';

class NextReservationCompletePage extends StatefulWidget {
  final String date;
  final String time;

  NextReservationCompletePage({required this.date, required String time})
      : this.time = time.replaceAll('\n', ' ');

  @override
  _NextReservationCompletePageState createState() =>
      _NextReservationCompletePageState();
}

class _NextReservationCompletePageState extends State<NextReservationCompletePage>{

  late FlutterTts _flutterTts;
  final ReservationApi reservationApi = ReservationApi();

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
    print(_parseDateTime(widget.date, widget.time)); // 예약 날짜와 시간 출력
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  Future<void> _saveReservation() async {
    try {
      // 예약 날짜와 시간을 결합하여 DateTime 객체 생성
      DateTime bookingDate = _parseDateTime(widget.date, widget.time);

      // 서버로 전송할 Reservation 객체 생성
      final reservation = Reservation(
        userId: globalUserId!, // 전역 변수에서 userId 가져오기
        bookingDate: bookingDate,
      );

      // API 호출로 예약 저장
      final statusCode = await reservationApi.addReservation(reservation);

      if (statusCode == 200) {
        // 예약 저장 성공 후 다음 페이지로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NextReservationCheckPage(),
          ),
        );
      } else {
        // 실패 상태 코드 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '예약 저장에 실패했습니다. 오류 코드: $statusCode',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }

    } catch (e) {
      // 네트워크 또는 기타 예외 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '오류가 발생했습니다. 다시 시도해주세요.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
  }

  DateTime _parseDateTime(String date, String time) {
    // 월과 일을 추출
    final dateParts = date.replaceAll('일', '').split('월');
    int month = int.parse(dateParts[0].trim());
    int day = int.parse(dateParts[1].trim());

    // 오전/오후 처리
    bool isMorning = time.contains('오전');
    final timeParts = time.replaceAll(RegExp(r'[오전|오후\s]'), '').split('시');
    int hour = int.parse(timeParts[0].trim());
    if (!isMorning && hour != 12) {
      hour += 12; // 오후이고 12시가 아닐 경우 12를 더함
    } else if (isMorning && hour == 12) {
      hour = 0; // 오전 12시는 0시로 변환
    }

    // 현재 연도를 사용하여 DateTime 생성
    int year = DateTime
        .now()
        .year;
    return DateTime(year, month, day, hour, 0, 0);
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
                              _saveReservation(); // 예약 저장 호출
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
