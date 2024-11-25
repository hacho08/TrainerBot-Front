import 'package:dx_project_app/phone_number.dart';
import 'package:flutter/material.dart';
import 'gender_check.dart';

class GenderChoicePage extends StatefulWidget {
  @override
  _GenderChoicePageState createState() => _GenderChoicePageState();
}

class _GenderChoicePageState extends State<GenderChoicePage> {
  // 버튼의 상태를 관리하는 리스트
  List<bool> isSelected = [false, false]; // 남자, 여자 버튼에 대해 각각 선택 여부를 저장

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
                              if (_selectedIndex == 0) {
                                selectedCondition = "성별이\n남자로\n입력되었습니다.";
                              } else if (_selectedIndex == 1) {
                                selectedCondition = "성별이\n여자로\n입력되었습니다.";
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GenderCheckPage(
                                    selectedCondition: selectedCondition,
                                  ),
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
                    color: Colors.teal[800],
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

  int _selectedIndex = -1; // -1은 아무것도 선택되지 않음을 나타냄

  Widget _buildConditionButton(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isSelected[index] = !isSelected[index]; // 선택 상태 토글
            if (index == 0) {
              isSelected[1] = false; // 남자 버튼 클릭 시 여자 버튼 선택 해제
            } else {
              isSelected[0] = false; // 여자 버튼 클릭 시 남자 버튼 선택 해제
            }
          });
          _selectedIndex = index; // 클릭된 버튼의 인덱스를 설정
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected[index]
              ? buttonData[index]["selectedColor"]
              : buttonData[index]["defaultColor"], // 선택된 색상
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
