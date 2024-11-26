import 'package:flutter/material.dart';
import 'name_check.dart';

void main() {
  runApp(MyApp()); // main 함수에서 앱을 실행
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Name(),
    );
  }
}

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  late FocusNode _focusNode;
  late TextEditingController _controller; // TextEditingController를 선언

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController(); // 컨트롤러 초기화

    // 처음 앱 실행 시 바로 TextField에 포커스를 요청
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose(); // 컨트롤러 메모리 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    String input = _controller.text; // TextField에서 입력된 값을 실시간으로 가져오기

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: screenWidth * 0.05), // 우측에 패딩을 추가하여 왼쪽으로 이동
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // 버튼을 오른쪽 끝에 배치
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right,
                    color: Color(0xFF265A5A),
                    size: screenWidth * 0.1,
                  ),
                  onPressed: () {
                    if (input.isEmpty) {
                      // 텍스트가 비어 있을 경우 경고 메시지 출력
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '이름을 입력해주세요.',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    } else {
                      // 텍스트가 입력되면 다음 페이지로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NameCheckPage(name: input),
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
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          // 상단 텍스트
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이름을 입력해주세요',
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
              input.isEmpty ? '이름 입력' : input,
              style: TextStyle(
                fontSize: 80,
                color: input.isEmpty ? Colors.grey : Colors.black,
                fontFamily: "PaperlogySemiBold",
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Center(
            child: Container(
              width: 550, // 원하는 가로 길이 설정
              child: TextField(
                focusNode: _focusNode,  // FocusNode를 연결
                controller: _controller, // TextEditingController 연결
                decoration: InputDecoration(
                  hintText: '이곳에 입력하세요', // 힌트 텍스트
                  hintStyle: TextStyle(
                    color: Colors.grey[400], // 힌트 텍스트 색상
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white!), // 비활성화 상태일 때 경계선 색상
                    borderRadius: BorderRadius.circular(20), // 모서리 둥글게
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white!), // 활성화 상태일 때 경계선 색상
                    borderRadius: BorderRadius.circular(20), // 모서리 둥글게
                  ),
                  filled: true, // 배경색을 채운다
                  fillColor: Colors.teal[80], // 배경색
                  contentPadding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0), // 패딩 추가
                ),
                keyboardType: TextInputType.text,  // 한글 키보드를 사용
                style: TextStyle(
                  fontSize: 70,  // 입력하는 텍스트 크기 설정
                  fontFamily: "PaperlogyRegular",
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,  // 텍스트를 가운데 정렬
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
