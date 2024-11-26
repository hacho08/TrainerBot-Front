import 'package:dx_project_app/phone_number.dart';
import 'package:dx_project_app/year.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'gender_check.dart';

class GenderChoicePage extends StatefulWidget {
  @override
  _GenderChoicePageState createState() => _GenderChoicePageState();
}

class _GenderChoicePageState extends State<GenderChoicePage> {
  // 버튼의 상태를 관리하는 리스트
  List<bool> isSelected = [false, false]; // 남자, 여자 버튼에 대해 각각 선택 여부를 저장
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.awaitSpeakCompletion(true); // TTS 작업 완료 대기

    // 1초 딜레이 후 TTS 실행
    Future.delayed(Duration(seconds: 1), () async {
      await _readText();
    });
  }

  Future<void> _readText() async {
    await _flutterTts.speak("성별을 선택하세요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  final List<Map<String, dynamic>> buttonData = [
    {
      "text": "남자",
      "defaultImage": "images/gender_choice_man.png",
      "selectedImage": "images/gender_choice_man_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Colors.teal[800],
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "여자",
      "defaultImage": "images/gender_choice_woman.png",
      "selectedImage": "images/gender_choice_woman_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Colors.teal[800],
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
                              builder: (context) => PhoneNumberPage(),
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
                              color: Colors.teal[800],
                              size: screenWidth * 0.1,
                            ),
                            onPressed: () {
                              String selectedCondition = "선택되지 않음"; // 기본값 설정

                              // 선택된 버튼에 맞춰 텍스트를 업데이트
                              if (_selectedIndex == 0) {
                                selectedCondition = "성별이\n남자로\n입력되었습니다.";
                              } else if (_selectedIndex == 1) {
                                selectedCondition = "성별이\n여자로\n입력되었습니다.";
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GenderCheckPage(selectedCondition: selectedCondition),
                                ),
                              );
                            },
                          ),
                          Text(
                            '다음',
                            style: TextStyle(
                              fontSize: screenWidth * 0.055,
                              fontFamily: "PaperlogyBold",
                              color: Colors.teal[800],
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  '옥수수님의\n성별을 입력하세요',
                  style: TextStyle(
                    fontSize: 100,
                    fontFamily: "PaperlogyBold",
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 150),
                Expanded(
                  child: Column(
                    children: [
                      _buildConditionButton(context, 0), // 남자 버튼
                      const SizedBox(height: 30),
                      _buildConditionButton(context, 1), // 여자 버튼
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _selectedIndex = -1; // -1은 아무것도 선택되지 않음을 나타냄

  Widget _buildConditionButton(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isSelected[index] = !isSelected[index];
            if (index == 0) {
              isSelected[1] = false;
            } else {
              isSelected[0] = false;
            }
          });
          _selectedIndex = index;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected[index]
              ? buttonData[index]["selectedColor"]
              : buttonData[index]["defaultColor"],
          minimumSize: Size(
            double.infinity,
            MediaQuery.of(context).size.height * 0.25,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 100),
            Text(
              buttonData[index]["text"]!,
              style: TextStyle(
                fontSize: 100,
                fontFamily: "PaperlogySemiBold",
                color: isSelected[index]
                    ? buttonData[index]["selectedTextColor"]
                    : buttonData[index]["defaultTextColor"],
              ),
            ),
            const SizedBox(width: 80),
            Image.asset(
              isSelected[index]
                  ? buttonData[index]["selectedImage"]
                  : buttonData[index]["defaultImage"],
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
