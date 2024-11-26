import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'gender_check.dart';
import 'phone_number.dart';
import 'services/usergender_api.dart'; // UserGenderApi 임포트

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
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "여자",
      "defaultImage": "images/gender_choice_woman.png",
      "selectedImage": "images/gender_choice_woman_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF265A5A),
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
                              color: Color(0xFF265A5A),
                              size: screenWidth * 0.1,
                            ),
                            onPressed: () {
                              if (_selectedIndex == -1) {
                                // 선택되지 않은 경우에는 알림을 띄움
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('성별을 선택해주세요', style: TextStyle(fontSize: 40, fontFamily:"PaperlogyBold"),)),
                                );
                              } else {
                                String selectedCondition = "선택되지 않음"; // 기본값 설정
                                if (_selectedIndex == 0) {
                                  selectedCondition = "남자";
                                } else if (_selectedIndex == 1) {
                                  selectedCondition = "여자";
                                }

                                // **성별을 서버에 저장하는 API 호출** (라인 44-46)
                                UserGenderApi().saveUserGender("someUserId", selectedGender!).then((success) {
                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GenderCheckPage(
                                          selectedCondition: selectedGender!, // 성별을 GenderCheckPage로 전달
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('성별 저장에 실패했습니다.')),
                                    );
                                  }
                                });
                              }
                            },
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // 가로 여백을 화면 크기에 맞게 설정
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05), // 상단 간격
                Text(
                  '옥수수님의\n성별을 선택하세요',
                  style: TextStyle(
                    fontSize: screenWidth * 0.1, // 텍스트 크기를 화면에 비례하게 설정
                    fontFamily: "PaperlogyBold",
                    color: Color(0xFF265A5A),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // 버튼들 간 간격
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

  int _selectedIndex = -1;

  String? get selectedGender => null; // -1은 아무것도 선택되지 않음을 나타냄

  Widget _buildConditionButton(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // 버튼을 한 번 클릭하면 다른 버튼은 선택 해제되고, 클릭된 버튼만 선택됨
            isSelected[index] = true;
            for (int i = 0; i < isSelected.length; i++) {
              if (i != index) isSelected[i] = false;
            }
            _selectedIndex = index; // 클릭된 버튼의 인덱스를 설정
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected[index]
              ? buttonData[index]["selectedColor"]
              : buttonData[index]["defaultColor"], // 선택된 색상
          minimumSize: Size(
            screenWidth * 0.9, // 크기를 화면에 맞게 조절 (0.8은 너비의 80%)
            200, // 버튼의 높이
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: screenWidth * 0.1), // 이미지와 텍스트 간 간격
            Text(
              buttonData[index]["text"]!,
              style: TextStyle(
                fontSize: screenWidth * 0.1, // 텍스트 크기를 화면에 비례하게 설정
                fontFamily: "PaperlogySemiBold",
                color: isSelected[index]
                    ? buttonData[index]["selectedTextColor"]
                    : buttonData[index]["defaultTextColor"], // 선택된 텍스트 색상
              ),
            ),
            SizedBox(width: screenWidth * 0.1), // 이미지와 텍스트 간 간격
            Image.asset(
              isSelected[index]
                  ? buttonData[index]["selectedImage"]
                  : buttonData[index]["defaultImage"], // 이미지
              width: screenWidth * 0.3, // 이미지의 가로 크기 설정
              height: screenWidth * 0.3, // 이미지의 세로 크기 설정
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
