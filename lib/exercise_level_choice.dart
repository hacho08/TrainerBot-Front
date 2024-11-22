import 'package:flutter/material.dart';
import 'exercise_level_check.dart';
import 'gender_check.dart'; // GenderCheckPage를 임포트

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
      "selectedColor": Colors.teal[800],
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "중급자",
      "text2": "근력운동 경력 6개월 초과 2년 미만",
      "defaultColor": Color(0xFFF4E8DE),
      "selectedColor": Colors.teal[800],
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "고급자",
      "text2": "근력운동 경력 2년 이상",
      "defaultColor": Color(0xFFF2DDCD),
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
                          color: Colors.teal[800],
                          size: screenWidth * 0.07,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        '뒤로 가기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontFamily: "PaperlogyBold",
                          color: Colors.teal[800],
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
                              color: Color(0xFFFFCC00),
                              size: screenWidth * 0.1,
                            ),
                            onPressed: () {
                              // 선택된 운동 강도 텍스트를 GenderCheckPage로 전달
                              String selectedCondition = "선택되지 않음";  // 기본값 설정

                              // 선택된 버튼에 맞춰 텍스트를 업데이트
                              if (_selectedIndex == 0) {
                                selectedCondition = "근력운동 경험 수준이\n초보자로\n입력되었습니다.";
                              } else if (_selectedIndex == 1) {
                                selectedCondition = "근력운동 경험 수준이\n중급자로\n입력되었습니다.";
                              } else if (_selectedIndex == 2) {
                                selectedCondition = "근력운동 경험 수준이\n고급자로\n입력되었습니다.";
                              }

                              // ExerciseLevelCheckPage로 selectedCondition을 전달
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExerciseLevelCheckPage(selectedCondition: selectedCondition),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ExerciseLevelCheckPage(selectedCondition:selectedCondition)),
                              );
                            },
                          ),
                          Text(
                            '다음',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontFamily: "PaperlogyBold",
                              color: Color(0xFFFFCC00),
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
                  '옥수수님의\n근력운동 수준을\n선택하세요',
                  style: TextStyle(
                    fontSize: 100,
                    fontFamily: "PaperlogyBold",
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 50),
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
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // 버튼 클릭 시 선택 상태 변경
            isSelected[index] = !isSelected[index]; // 클릭된 버튼을 토글
            // 한 버튼이 선택되면 다른 버튼은 선택 해제
            for (int i = 0; i < isSelected.length; i++) {
              if (i != index) isSelected[i] = false;
            }
            _selectedIndex = index; // 클릭된 버튼의 인덱스를 설정
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected[index]
              ? buttonData[index]["selectedColor"]
              : buttonData[index]["defaultColor"],
          minimumSize: Size(
            screenWidth * 0.9, // 크기를 화면에 맞게 조절 (0.8은 너비의 80%)
            270, // 버튼의 높이
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
                fontSize: 100,
                fontFamily: "PaperlogySemiBold",
                color: isSelected[index]
                    ? buttonData[index]["selectedTextColor"]
                    : buttonData[index]["defaultTextColor"],
              ),
            ),
            Text(
              buttonData[index]["text2"]!,
              style: TextStyle(
                fontSize: 50,
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
