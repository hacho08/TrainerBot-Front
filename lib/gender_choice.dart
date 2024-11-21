import 'package:flutter/material.dart';

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
                  '오늘의 컨디션은\n어떠신가요?',
                  style: TextStyle(
                    fontSize: 100,
                    fontFamily: "PaperlogyBold",
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  '컨디션에 맞는 운동 강도를\n선택해주세요',
                  style: TextStyle(
                    fontSize: 60,
                    fontFamily: "PaperlogySemiBold",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildConditionButton(
                          context, '가볍게', Color(0xFFB5C6C6)),
                      SizedBox(height: 30),
                      _buildConditionButton(
                          context, '적당히', Color(0xFF7D9C9C)),
                      SizedBox(height: 30),
                      _buildConditionButton(
                          context, '힘껏', Color(0xFF457171)),
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
                  onPressed: () {
                    // '다음' 버튼 동작 추가
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

  Widget _buildConditionButton(BuildContext context, String text, Color? color) {
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
            MediaQuery.of(context).size.height * 0.18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}