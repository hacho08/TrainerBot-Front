import 'package:flutter/material.dart';
import 'name_check.dart';
import 'services/user_api.dart'; // UserApi 임포트
import 'package:flutter_tts/flutter_tts.dart';

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
  final UserApi userApi = UserApi(); // UserApi 인스턴스 생성
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // FocusNode 초기화
    _controller = TextEditingController(); // TextEditingController 초기화
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("이름을 입력해주시고, 완료 버튼을 눌러주세요");
  }

  @override
  void dispose() {
    _focusNode.dispose(); // FocusNode 해제
    _controller.dispose(); // TextEditingController 해제
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  // 사용자 이름을 서버로 전송하는 메서드
  void _addUserName() async {
    String userName = _controller.text; // 입력된 이름 가져오기

    // 서버로 사용자 이름 전송
    await userApi.addUserName(userName); // userApi의 addUserName 메서드 호출

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
