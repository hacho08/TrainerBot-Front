import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'models/user.dart';
import 'gender_check.dart';
import 'phone_number.dart';

class GenderChoicePage extends StatefulWidget {
  final User user;

  GenderChoicePage({required this.user});

  @override
  _GenderChoicePageState createState() => _GenderChoicePageState();
}

class _GenderChoicePageState extends State<GenderChoicePage> {
  // 버튼의 상태를 관리하는 리스트
  List<bool> isSelected = [false, false]; // 남자, 여자 버튼에 대해 각각 선택 여부를 저장
  late FlutterTts _flutterTts;
  int _selectedIndex = -1; // -1은 아무것도 선택되지 않음을 나타냄

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
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("성별을 선택하세요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  void _saveGender(String input) {
    setState(() {
      widget.user.gender = input; // 입력된 성별을 user 객체에 저장
    });
  }


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
                              builder: (context) => PhoneNumberPage(user: widget.user),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '성별을 선택해주세요',
                                      style: TextStyle(fontSize: 40, fontFamily: "PaperlogyBold"),
                                    ),
                                  ),
                                );
                              } else {
                                String selectedGender = _selectedIndex == 0 ? "M" : "F";
                                _saveGender(selectedGender);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GenderCheckPage(user: widget.user),
                                  ),
                                );
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05),
                Text(
                  '${widget.user.userName}님의\n성별을 선택하세요',
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontFamily: "PaperlogyBold",
                    color: Color(0xFF265A5A),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Expanded(
                  child: Column(
                    children: [
                      _buildConditionButton(context, 0),
                      const SizedBox(height: 30),
                      _buildConditionButton(context, 1),
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

  Widget _buildConditionButton(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // 버튼을 한 번 클릭하면 다른 버튼은 선택 해제되고, 클릭된 버튼만 선택됨
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index; // 클릭된 버튼만 true로 설정
            }
            _selectedIndex = index; // 클릭된 버튼의 인덱스를 저장
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected[index]
              ? buttonData[index]["selectedColor"]
              : buttonData[index]["defaultColor"], // 선택된 색상
          minimumSize: Size(screenWidth * 0.9, 200), // 버튼 크기
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글게
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonData[index]["text"], // 버튼 텍스트
              style: TextStyle(
                fontSize: screenWidth * 0.1,
                fontFamily: "PaperlogySemiBold",
                color: isSelected[index]
                    ? buttonData[index]["selectedTextColor"]
                    : buttonData[index]["defaultTextColor"], // 텍스트 색상
              ),
            ),
            SizedBox(width: screenWidth * 0.1), // 간격 추가
            Image.asset(
              isSelected[index]
                  ? buttonData[index]["selectedImage"]
                  : buttonData[index]["defaultImage"], // 이미지 선택
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
