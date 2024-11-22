import 'package:dx_project_app/phone_number.dart';
import 'package:dx_project_app/year.dart';
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
                          color: Color(0xFF989898),
                          size: screenWidth * 0.07,
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
                          fontSize: screenWidth * 0.035,
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
                                // 선택된 운동 강도 텍스트를 CheckPage로 전달
                                String selectedCondition = "선택되지 않음";  // 기본값 설정

                                // 선택된 버튼에 맞춰 텍스트를 업데이트
                                if (_selectedIndex == 0) {
                                  selectedCondition = "성별이\n남자로\n입력되었습니다.";
                                } else if (_selectedIndex == 1) {
                                  selectedCondition = "성별이\n여자로\n입력되었습니다.";
                                }
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GenderCheckPage(selectedCondition: selectedCondition),
                                  ),
                                );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GenderCheckPage(selectedCondition:selectedCondition)),
                              );
                            },
                          ),
                          Text(
                            '다음',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
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
  // 선택된 성별을 설정할 변수
  int _selectedIndex = -1; // -1은 아무것도 선택되지 않음을 나타냄

  Widget _buildConditionButton(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // 버튼 클릭 시 선택 상태 변경
            isSelected[index] = !isSelected[index]; // 클릭된 버튼을 토글
            // 한 버튼이 선택되면 다른 버튼은 선택 해제
            if (index == 0) {
              isSelected[1] = false; // 남자 버튼 클릭 시 여자 버튼 선택 해제
            } else {
              isSelected[0] = false; // 여자 버튼 클릭 시 남자 버튼 선택 해제
            }
          });
          // 버튼 클릭 시 상태 업데이트
          _selectedIndex = index; // 클릭된 버튼의 인덱스를 설정
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected[index]
              ? buttonData[index]["selectedColor"] // 선택된 색상
              : buttonData[index]["defaultColor"], // 기본 색상
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
            const SizedBox(width: 100), // 이미지와 텍스트 간격
            Text(
              buttonData[index]["text"]!,
              style: TextStyle(
                fontSize: 100,
                fontFamily: "PaperlogySemiBold",
                color: isSelected[index]
                    ? buttonData[index]["selectedTextColor"] // 선택된 텍스트 색상
                    : buttonData[index]["defaultTextColor"], // 기본 텍스트 색상
              ),
            ),
            const SizedBox(width: 80), // 이미지와 텍스트 간격
            Image.asset(
              isSelected[index]
                  ? buttonData[index]["selectedImage"] // 선택된 이미지
                  : buttonData[index]["defaultImage"], // 기본 이미지
              width: 450,
              height: 350,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
