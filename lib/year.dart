import 'package:flutter/material.dart';
import 'year_check.dart';

class InputBirthYearScreen extends StatefulWidget {
  final String name; // name을 받기 위한 변수

  // 생성자에서 name 값을 받아오기
  InputBirthYearScreen({required this.name});

  @override
  _InputBirthYearScreenState createState() => _InputBirthYearScreenState();
}

class _InputBirthYearScreenState extends State<InputBirthYearScreen> {
  String input = ''; // 입력된 값 저장

  void onKeyPress(String value) {
    setState(() {
      if (value == '지움') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1); // 마지막 문자 삭제
        }
      } else if (value == '확인') {
        // 확인 버튼 눌렀을 때의 동작
        if (input.isNotEmpty && input.length == 4) {
          // 출생연도가 4자리인 경우
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YearCheckPage(birthYear: input), // NextPage로 이동
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('4자리 출생연도를 입력하세요', style: TextStyle(fontSize: 40, fontFamily:"PaperlogyBold"),)),
          );
        }
      } else {
        if (input.length < 4) {
          input += value; // 숫자 추가
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.04),
          // 상단 텍스트
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.name}님의\n출생연도를 입력하세요',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 70,
                  fontFamily: "PaperlogySemiBold",
                  color: Color(0xFF265A5A),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          // 입력된 값 표시
          Center(
            child: Text(
              input.isEmpty ? '출생연도 입력' : input,
              style: TextStyle(
                fontSize: 100,
                color: input.isEmpty ? Colors.grey : Colors.black,
                fontFamily: "PaperlogySemiBold",
              ),
            ),
          ),
          Spacer(),
          // 커스텀 키패드
          Container(
            height: height * 0.6, // 키패드 영역 크기
            color: Color(0xFF265A5A),
            padding: EdgeInsets.all(5),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3열
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1.5, // 정사각형 버튼
              ),
              itemCount: 12, // 0~9 + 지움 + 확인
              itemBuilder: (context, index) {
                final List<String> keys = [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '지움',
                  '0',
                  '확인'
                ];
                return buildKey(keys[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildKey(String key) {
    return GestureDetector(
      onTap: () => onKeyPress(key),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF265A5A), // 버튼 색상
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          key,
          style: TextStyle(
            fontSize: 100,
            fontFamily: "PaperlogySemiBold",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String birthYear; // 전달된 출생연도

  NextPage({required this.birthYear}); // 생성자에서 출생연도 받기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page"),
        backgroundColor: Color(0xFF265A5A),
      ),
      body: Center(
        child: Text(
          '입력된 출생연도: $birthYear', // 전달된 출생연도 표시
          style: TextStyle(
            fontSize: 30,
            fontFamily: "PaperlogySemiBold",
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
