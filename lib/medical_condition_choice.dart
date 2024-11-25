import 'package:flutter/material.dart';
import 'exercise_level_choice.dart';
import 'gender_choice.dart';
import 'medical_condition_check.dart'; // CheckPage로 이동하는 임포트

class MedicalConditionChoicePage extends StatefulWidget {
  @override
  _MedicalConditionChoicePageState createState() =>
      _MedicalConditionChoicePageState();
}

class _MedicalConditionChoicePageState
    extends State<MedicalConditionChoicePage> {
  // 각 버튼의 선택 상태를 관리
  List<bool> isSelected = [false, false, false, false, false, false];

  // 선택된 버튼들의 텍스트 리스트
  List<String> selectedConditions = [];

  // 버튼 데이터
  final List<Map<String, dynamic>> buttonData = [
    {
      "text": "무릎",
      "defaultImage": "images/knee.png",
      "selectedImage": "images/knee_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF00695C),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "허리",
      "defaultImage": "images/back.png",
      "selectedImage": "images/back_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF00695C),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "어깨",
      "defaultImage": "images/shoulder.png",
      "selectedImage": "images/shoulder_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF00695C),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "목",
      "defaultImage": "images/neck.png",
      "selectedImage": "images/neck_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF00695C),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "손목",
      "defaultImage": "images/wrist.png",
      "selectedImage": "images/wrist_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF00695C),
      "defaultTextColor": Colors.black,
      "selectedTextColor": Colors.white,
    },
    {
      "text": "발목",
      "defaultImage": "images/ankle.png",
      "selectedImage": "images/ankle_selected.png",
      "defaultColor": Color(0xFFEFE7E1),
      "selectedColor": Color(0xFF00695C),
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
                          color: Color(0xFFA3A3A3),
                          size: screenWidth * 0.07,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenderChoicePage(),
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
                              // 선택된 버튼들이 없거나 있거나 상관 없이 페이지 이동
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MedicalConditionCheckPage(
                                          selectedConditions: selectedConditions),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              '옥수수님,\n아프신 곳이 있나요?',
              style: TextStyle(
                fontSize: 70,
                fontFamily: "PaperlogyBold",
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              '최대 2개 선택가능',
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
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                  childAspectRatio: 1.5,
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
            width: 90,
            height: 90,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            buttonData[index]["text"]!,
            style: TextStyle(
              fontFamily: "PaperlogyRegular",
              fontSize: 50,
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
