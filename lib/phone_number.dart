import 'package:dx_project_app/phone_number_check.dart';
import 'package:flutter/material.dart';
import 'phone_number_check.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
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
  late FlutterTts _flutterTts;
  bool _isSpeaking = false; // 현재 TTS가 실행 중인지 확인

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 시작
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0); // 볼륨 최대 설정
    await _flutterTts.awaitSpeakCompletion(true); // TTS 작업 완료 대기

    // 딜레이 후 TTS 시작
    Future.delayed(Duration(seconds: 1), () async {
      await _readText();
    });
  }

  Future<void> _readText() async {
    if (!_isSpeaking) {
      setState(() {
        _isSpeaking = true;
      });
      try {
        await _flutterTts.speak("전화번호를 입력하세요");
      } catch (e) {
        print("TTS 오류: $e");
      } finally {
        setState(() {
          _isSpeaking = false;
        });
      }
    }
  }

  void onKeyPress(String value) {
    if (_isSpeaking) return; // TTS 실행 중일 때는 입력 방지
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
            SnackBar(
              content: Text(
                '잘못 입력되었습니다',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
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

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.04),
          // 상단 텍스트
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '전화번호를 입력하세요',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 90,
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
            color: Colors.teal[700],
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

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    _flutterTts.awaitSpeakCompletion(false); // 종료 시 대기 비활성화
    super.dispose();
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
  final String phoneNumber; // 전달된 전화번호

  NextPage({required this.phoneNumber}); // 생성자에서 전화번호 받기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page"),
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
