import 'package:flutter/material.dart';
import 'phone_number_check.dart';

void main() {
  runApp(MyApp()); // main 함수에서 앱을 실행
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneNumberPage(),
    );
  }
}

class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  String input = ''; // 입력된 값 저장

  void onKeyPress(String value) {
    setState(() {
      if (value == '지움') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1); // 마지막 문자 삭제
        }
      } else if (value == '확인') {
        // 확인 버튼 눌렀을 때의 동작
        if (input.isNotEmpty && input.length == 11) {
          // 전화번호가 11자리인 경우
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhoneNumberCheckPage(phoneNumber: input),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('잘못 입력되었습니다', style: TextStyle(fontSize: 30))),
          );
        }
      } else {
        if (input.length < 11) {
          input += value; // 숫자 추가
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.04),
          // 상단 텍스트
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '전화번호를 입력하세요',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: width * 0.08, // 화면 크기에 맞춰 텍스트 크기 설정
                  fontFamily: "PaperlogySemiBold",
                  color: Colors.teal[800],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          // 입력된 값 표시
          Center(
            child: Text(
              input.isEmpty ? '전화번호 입력' : input,
              style: TextStyle(
                fontSize: width * 0.1, // 화면 크기에 맞춰 텍스트 크기 설정
                color: input.isEmpty ? Colors.grey : Colors.black,
                fontFamily: "PaperlogySemiBold",
              ),
            ),
          ),
          Spacer(),
          // 커스텀 키패드
          Container(
            height: height * 0.6, // 키패드 영역 크기
            color: Colors.teal[700],
            padding: EdgeInsets.all(5),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3열
                crossAxisSpacing: width * 0.02, // 화면 비율에 맞춰 간격 조정
                mainAxisSpacing: height * 0.02, // 화면 비율에 맞춰 간격 조정
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
          color: Colors.teal[800], // 버튼 색상
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          key,
          style: TextStyle(
            fontSize: 90, // 화면 크기에 맞춰 키 크기 조정
            fontFamily: "PaperlogySemiBold",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PhoneNumberCheckPage extends StatelessWidget {
  final String phoneNumber; // 전달된 전화번호

  PhoneNumberCheckPage({required this.phoneNumber}); // 생성자에서 전화번호 받기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("전화번호 확인"),
        backgroundColor: Colors.teal[800],
      ),
      body: Center(
        child: Text(
          '입력된 전화번호: $phoneNumber', // 전달된 전화번호 표시
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
