import 'package:flutter/material.dart';
import 'next_reservation_complete.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../services/reservation_api.dart';
import 'global/global.dart';

class NextReservationChoicePage extends StatefulWidget {
  @override
  _NextReservationChoicePageState createState() =>
      _NextReservationChoicePageState();
}

class _NextReservationChoicePageState
    extends State<NextReservationChoicePage> {
  final List<Map<String, String>> dates = [
    {'date': '12월 4일', 'day': '수요일'},
    {'date': '12월 5일', 'day': '목요일'},
    {'date': '12월 6일', 'day': '금요일'},
    {'date': '12월 7일', 'day': '토요일'},
    {'date': '12월 8일', 'day': '일요일'},
    {'date': '12월 9일', 'day': '월요일'},
    {'date': '12월 10일', 'day': '화요일'},
  ];
  final List<String> times = [
    '오전 8시',
    '오전 9시',
    '오전 10시',
    '오전 11시',
    '오후 12시',
    '오후 1시',
    '오후 2시',
    '오후 3시',
    '오후 4시',
    '오후 5시',
    '오후 6시',
  ];

  int currentDateIndex = 0; // 날짜 첫 번째 인덱스
  int currentTimeIndex = 0; // 시간 첫 번째 인덱스
  int? selectedDateIndex; // 선택된 날짜 인덱스
  int? selectedTimeIndex; // 선택된 시간 인덱스

  void goToNextDates() {
    setState(() {
      if (currentDateIndex < dates.length - 2) {
        currentDateIndex += 2;
      }
    });
  }

  void goToPreviousDates() {
    setState(() {
      if (currentDateIndex > 0) {
        currentDateIndex -= 2;
      }
    });
  }

  void goToNextTimes() {
    setState(() {
      if (currentTimeIndex < times.length - 2) {
        currentTimeIndex += 2;
      }
    });
  }

  void goToPreviousTimes() {
    setState(() {
      if (currentTimeIndex > 0) {
        currentTimeIndex -= 2;
      }
    });
  }

  void selectDate(int index) {
    setState(() {
      selectedDateIndex = index;
    });
  }

  void selectTime(int index) {
    setState(() {
      selectedTimeIndex = index;
    });
  }
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
    await _flutterTts.speak("예약을 원하는 날짜와 시간을 선택해주세요");
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

      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '예약을 원하는\n날짜와 시간을\n선택하세요',
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PaperlogyBold',
                    color: Color(0xFF265A5A),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_circle_right,
                        color: Color(0xFF265A5A),
                        size: screenWidth * 0.1,
                      ),
                      onPressed: () {
                        if (selectedDateIndex != null &&
                            selectedTimeIndex != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NextReservationCompletePage(
                                date: dates[selectedDateIndex!]['date']!,
                                time: times[selectedTimeIndex!],
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '날짜와 시간을 선택해주세요!',
                                style: TextStyle(
                                  fontSize: 50.0, // 텍스트 크기 설정
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      '다음',
                      style: TextStyle(
                        fontFamily: 'PaperlogySemiBold',
                        fontSize: screenWidth * 0.06,
                        color: Color(0xFF265A5A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            _buildDateSelector(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.05),
            _buildTimeSelector(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '날짜',
          style: TextStyle(
            fontFamily: 'PaperlogySemiBold',
            fontSize: screenWidth * 0.075,
            fontWeight: FontWeight.bold,
            color: Color(0xFF265A5A),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_left,
                color: currentDateIndex > 0 ? Colors.teal[800] : Colors.grey,
                size: screenWidth * 0.12,
              ),
              onPressed: goToPreviousDates,
            ),
            Row(
              children: [
                if (currentDateIndex < dates.length)
                  _buildDateCard(dates[currentDateIndex], currentDateIndex,
                      screenWidth, screenHeight),
                if (currentDateIndex + 1 < dates.length)
                  SizedBox(width: screenWidth * 0.03),
                if (currentDateIndex + 1 < dates.length)
                  _buildDateCard(dates[currentDateIndex + 1],
                      currentDateIndex + 1, screenWidth, screenHeight),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: currentDateIndex < dates.length - 2
                    ? Color(0xFF265A5A)
                    : Colors.grey,
                size: screenWidth * 0.12,
              ),
              onPressed: goToNextDates,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSelector(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '시간',
          style: TextStyle(
            fontFamily: 'PaperlogySemiBold',
            fontSize: screenWidth * 0.075,
            fontWeight: FontWeight.bold,
            color: Color(0xFF265A5A),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_left,
                color: currentTimeIndex > 0 ? Color(0xFF265A5A) : Colors.grey,
                size: screenWidth * 0.12,
              ),
              onPressed: goToPreviousTimes,
            ),
            Row(
              children: [
                if (currentTimeIndex < times.length)
                  _buildTimeCard(
                      times[currentTimeIndex], currentTimeIndex, screenWidth),
                if (currentTimeIndex + 1 < times.length)
                  SizedBox(width: screenWidth * 0.03),
                if (currentTimeIndex + 1 < times.length)
                  _buildTimeCard(times[currentTimeIndex + 1],
                      currentTimeIndex + 1, screenWidth),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: currentTimeIndex < times.length - 2
                    ? Color(0xFF265A5A)
                    : Colors.grey,
                size: screenWidth * 0.12,
              ),
              onPressed: goToNextTimes,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateCard(Map<String, String> dateInfo, int index,
      double screenWidth, double screenHeight) {
    final isSelected = selectedDateIndex == index;

    return GestureDetector(
      onTap: () => selectDate(index),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF265A5A) : Colors.white,
          border: Border.all(color: Color(0xFF265A5A)!, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${dateInfo['date']}\n${dateInfo['day']}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
            color: isSelected ? Colors.white : Color(0xFF265A5A),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeCard(String time, int index, double screenWidth) {
    final isSelected = selectedTimeIndex == index;

    return GestureDetector(
      onTap: () => selectTime(index),
      child: Container(
        width: screenWidth * 0.27,
        padding: EdgeInsets.symmetric(
            vertical: 10, horizontal: screenWidth * 0.04),
        height: 130,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF265A5A) : Colors.white,
          border: Border.all(color: Color(0xFF265A5A)!, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
              color: isSelected ? Colors.white : Color(0xFF265A5A),
            ),
          ),
        ),
      ),
    );
  }
}
