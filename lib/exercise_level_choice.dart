import 'package:flutter/material.dart';
import 'exercise_level_check.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'medical_condition_choice.dart';
import 'services/user_exerlevel_api.dart'; // UserExerLevelApi 임포트


class ExerciseLevelChoicePage extends StatefulWidget {
  @override
  _ExerciseLevelChoicePageState createState() =>
      _ExerciseLevelChoicePageState();
}

class _ExerciseLevelChoicePageState extends State<ExerciseLevelChoicePage> {
  // 각 버튼의 선택 상태를 관리
  List<bool> isSelected = [false, false, false]; // 초보자, 중급자, 고급자 버튼에 대해 각각 선택 여부를 저장
  int _selectedIndex = -1; // 선택된 버튼의 인덱스를 저장

  // 버튼 데이터
  final List<Map<String, dynamic>> buttonData = [
    {
      "text": "초보자",
      "text2": "근력운동 경력 6개월 이하",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "중급자",
      "text2": "근력운동 경력 6개월 초과 2년 미만",
      "defaultColor": Color(0xFFF4E8DE),
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "고급자",
      "text2": "근력운동 경력 2년 이상",
      "defaultColor": Color(0xFFF2DDCD),
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
  ];
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
    await _flutterTts.speak("근력운동 수준을 선택하세요");
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
                          size: screenWidth * 0.07,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicalConditionChoicePage(),
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
                                // 선택된 운동 강도가 없으면 페이지 이동을 막고 알림 표시
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('운동 강도를 선택하세요', style: TextStyle(fontSize: 40, fontFamily:"PaperlogyBold"),)),
                                );
                              } else {
                                // 선택된 운동 강도에 따라 페이지 이동
                                String selectedCondition = "선택되지 않음";  // 기본값 설정

                                if (_selectedIndex == 0) {
                                  selectedCondition = "초보자";
                                } else if (_selectedIndex == 1) {
                                  selectedCondition = "중급자";
                                } else if (_selectedIndex == 2) {
                                  selectedCondition = "고급자";
                                }

                                // 여기에 API 호출 추가
                                UserExerLevelApi().saveWorkoutExperience('user_id', selectedCondition).then((success) {
                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ExerciseLevelCheckPage(selectedCondition: selectedCondition),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('성공적으로 저장되지 않았습니다. 다시 시도해주세요', style: TextStyle(fontSize: 40, fontFamily:"PaperlogyBold"),)),
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
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  '옥수수님의\n근력운동 수준을\n선택하세요',
                  style: TextStyle(
                    fontSize: 70,
                    fontFamily: "PaperlogyBold",
                    color: Color(0xFF265A5A),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      _buildConditionButton(context, 0, screenWidth), // 초보자 버튼
                      const SizedBox(height: 30),
                      _buildConditionButton(context, 1, screenWidth), // 중급자 버튼
                      const SizedBox(height: 30),
                      _buildConditionButton(context, 2, screenWidth), // 고급자 버튼
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

  // 버튼 클릭 시 상태 변경
  Widget _buildConditionButton(BuildContext context, int index, double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // 한 번 클릭되면 해제되지 않도록 설정
            isSelected[index] = true;
            // 다른 버튼은 선택 해제
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonData[index]["text"]!,
              style: TextStyle(
                fontSize: 70,
                fontFamily: "PaperlogySemiBold",
                color: isSelected[index]
                    ? buttonData[index]["selectedTextColor"]
                    : buttonData[index]["defaultTextColor"],
              ),
            ),
            Text(
              buttonData[index]["text2"]!,
              style: TextStyle(
                fontSize: 30,
                fontFamily: "PaperlogySemiBold",
                color: isSelected[index]
                    ? buttonData[index]["selectedTextColor"]
                    : buttonData[index]["defaultTextColor"],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
