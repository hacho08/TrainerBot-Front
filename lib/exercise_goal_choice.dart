import 'package:dx_project_app/exercise_level_check.dart';
import 'package:dx_project_app/exercise_level_choice.dart';
import 'package:flutter/material.dart';
import 'exercise_goal_check.dart'; // CheckPage로 이동하는 임포트
import 'package:flutter_tts/flutter_tts.dart';

class ExerciseGoalChoicePage extends StatefulWidget {
  @override
  _ExerciseGoalChoicePageState createState() =>
      _ExerciseGoalChoicePageState();
}

class _ExerciseGoalChoicePageState
    extends State<ExerciseGoalChoicePage> {
  // 각 버튼의 선택 상태를 관리
  List<bool> isSelected = [false, false, false, false, false, false];

  // 선택된 버튼들의 텍스트 리스트
  List<String> selectedConditions = [];

  // 버튼 데이터
  final List<Map<String, dynamic>> buttonData = [
    {
      "text": "근력 강화",
      "defaultImage": "images/goal_muscles.png",
      "selectedImage": "images/goal_muscles_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "체중 감소",
      "defaultImage": "images/goal_diet.png",
      "selectedImage": "images/goal_diet_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "기초 체력",
      "defaultImage": "images/goal_stamina.png",
      "selectedImage": "images/goal_stamina_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "유연성 향상",
      "defaultImage": "images/goal_pliability.png",
      "selectedImage": "images/goal_pliability_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF265A5A),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    }
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
    await _flutterTts.speak("운동 목표를 선택해주세요");
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
                          color: Color(0xFFA3A3A3),
                          size: screenWidth * 0.07,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExerciseLevelChoicePage(),
                            ),
                          );
                        },
                      ),
                      Text(
                        '뒤로 가기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontFamily: "PaperlogyBold",
                          color: Color(0xFFA3A3A3),
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
                              // 선택된 버튼들이 1개 이상일 때만 다음 페이지로 이동
                              if (selectedConditions.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ExerciseGoalCheckPage(
                                            selectedConditions: selectedConditions),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text('최소 1개 이상의 목표를 선택하세요.',
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontFamily: "PaperlogySemiBold",
                                        )
                                    ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              '옥수수님의\n운동 목표를\n선택해주세요',
              style: TextStyle(
                fontSize: 70,
                fontFamily: "PaperlogyBold",
                color: Color(0xFF265A5A),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '최대 2개 선택 가능',
              style: TextStyle(
                fontSize: 40,
                fontFamily: "PaperlogySemiBold",
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1.1,
                ),
                itemCount: buttonData.length,
                itemBuilder: (context, index) {
                  return _buildPainButton(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPainButton(int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected[index]) {
            // 선택을 해제
            selectedConditions.remove(buttonData[index]["text"]);
          } else {
            // 최대 2개 선택 가능
            if (selectedConditions.length < 2) {
              selectedConditions.add(buttonData[index]["text"]);
            } else {
              return; // 이미 2개가 선택되었으면 아무것도 하지 않음
            }
          }
          isSelected[index] = !isSelected[index]; // 선택 상태 토글
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected[index]
            ? buttonData[index]["selectedColor"]
            : buttonData[index]["defaultColor"],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isSelected[index]
                ? buttonData[index]["selectedImage"]
                : buttonData[index]["defaultImage"],
            width: 130,
            height: 130,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            buttonData[index]["text"]!,
            style: TextStyle(
              fontFamily: "PaperlogyRegular",
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: isSelected[index]
                  ? buttonData[index]["selectedTextColor"]
                  : buttonData[index]["defaultTextColor"],
            ),
          ),
        ],
      ),
    );
  }
}
