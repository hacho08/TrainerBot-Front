import 'package:dx_project_app/models/routine.dart';
import 'package:dx_project_app/models/workout.dart';
import 'package:dx_project_app/services/workout_api.dart';
import 'package:flutter/material.dart';
import 'exercise_start_info2.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ExcerciseStartInfoPage extends StatefulWidget {

  final Routine routine; // 예시로 target이라는 파라미터를 받는다고 가정

  // 생성자에서 target을 받도록 설정
  ExcerciseStartInfoPage({required this.routine});


  _ExcerciseStartInfoPageState createState() => _ExcerciseStartInfoPageState();
}

class _ExcerciseStartInfoPageState extends State<ExcerciseStartInfoPage>{
  late FlutterTts _flutterTts;
  final WorkoutApi workoutApi = WorkoutApi();

  @override
  void initState()  {
    super.initState();
    // api 호출
    getWorkouts();
    _flutterTts = FlutterTts();
    _initializeTts(); // TTS 초기화 및 실행
  }

  Future<void> getWorkouts() async {
    List<Workout> workoutList = await workoutApi.getWorkouts(widget.routine.userId, widget.routine.routineId, widget.routine.target, widget.routine.condition);
    print("출력체크4 $workoutList");
  }

  Future<void> _initializeTts() async {
    await Future.delayed(Duration(seconds: 1)); // 1초 딜레이
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak("운동을 시작합니다");
    await _flutterTts.speak("정보를 불러오고 있습니다. 잠시만 기다려주세요");
  }

  @override
  void dispose() {
    _flutterTts.stop(); // 페이지 종료 시 TTS 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3초 후 condition_choice.dart로 이동
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExerciseStartInfo2Page()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF265A5A), // 상단 색상
              Color(0xFF517A79), // 중간1 색상
              Color(0xFF6C8E8A), // 중간2 색상
              Color(0xFFB8CBC8), // 하단 색상
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '운동을 \n시작합니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "PaperlogySemiBold",
                  fontSize: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 200),
              Image.asset('images/clap.png', width: 280),


            ],
          ),
        ),
      ),
    );
  }
}
