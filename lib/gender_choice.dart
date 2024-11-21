import 'package:flutter/material.dart';
import 'medical_condition_choice.dart';

class GenderChoicePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 250),
                Expanded(
                  child:
                  Column(
                    children: [
                      _buildConditionButton(
                        context,
                        '남자',
                        'images/gender_choice_man.png',
                        Color(0xFFEFE7E1),
                      ),
                      const SizedBox(height: 30),
                      _buildConditionButton(
                        context,
                        '여자',
                        'images/gender_choice_woman.png',
                        Color(0xFFEFE7E1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            right: 40,
            child: Column(
              children: [
                Icon(
                  Icons.arrow_circle_right_rounded,
                  size: 80,
                  color: Colors.teal[800],
                ),
                TextButton(
                  onPressed: () { // '다음' 버튼 동작 추가
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicalConditionChoicePage(), // 이동할 페이지로 설정
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  child: Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionButton(BuildContext context, String text, String imagePath, Color? color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          // 버튼 클릭 시 동작 추가
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
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
              text,
              style: const TextStyle(
                fontSize: 100,
                fontFamily: "PaperlogySemiBold",
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 80), // 이미지와 텍스트 간격
            Image.asset(
              imagePath, // 전달된 이미지 경로를 사용
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