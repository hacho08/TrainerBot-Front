import 'package:flutter/material.dart';

class MedicalConditionChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // 상단 여백
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '옥수수님,\n아프신 곳이 있나요?',
                  style: TextStyle(
                    fontSize: 100,
                    fontFamily: "PaperlogyBold",
                    color: Colors.teal[800],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // 건너뛰기 동작 추가
                      },
                      icon: Icon(Icons.skip_next, color: Colors.teal[800]),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        // 다음 페이지 이동
                      },
                      icon: Icon(Icons.arrow_circle_right, color: Colors.teal[800]),
                      iconSize: 30,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10), // 텍스트 아래 여백
            Text(
              '중복 선택 가능',
              style: TextStyle(
                fontSize: 60,
                fontFamily: "PaperlogyBold",
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20), // 버튼 그룹 상단 여백
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 열의 개수
                crossAxisSpacing: 16, // 열 간 간격
                mainAxisSpacing: 16, // 행 간 간격
                children: [
                  _buildPainButton('무릎', 'images/knee.png'),
                  _buildPainButton('허리', 'images/back.png'),
                  _buildPainButton('어깨', 'images/shoulder.png'),
                  _buildPainButton('목', 'images/neck.png'),
                  _buildPainButton('손목', 'images/wrist.png'),
                  _buildPainButton('발목', 'images/ankle.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPainButton(String text, String imagePath) {
    return ElevatedButton(
      onPressed: () {
        print('$text 버튼 클릭됨');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFEFEFEF), // 버튼 배경색
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 모서리를 둥글게
        ),
        padding: const EdgeInsets.all(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20), // 이미지와 텍스트 간 간격
          Text(
            text,
            style: TextStyle(
              fontFamily: "PaperlogyRegular",
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
