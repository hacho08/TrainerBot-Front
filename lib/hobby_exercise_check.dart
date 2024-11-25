import 'package:flutter/material.dart';
import 'exercise_level_choice.dart';
import 'info_insert_finish.dart';

class HobbyExerciseCheckPage extends StatelessWidget {
  final List<String> selectedConditions;

  // Constructor to receive the selected conditions
  HobbyExerciseCheckPage({required this.selectedConditions});

  @override
  Widget build(BuildContext context) {
    // 2초 후 InfoInsertFinishPage로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InfoInsertFinishPage()),
      );
    });

    // '선택되지 않음' 처리
    String displayConditions = selectedConditions.isEmpty
        ? '없음' // 조건이 없으면 '없음'을 표시
        : selectedConditions.join(', '); // 조건이 있으면 선택된 텍스트를 나열

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 300),
            const SizedBox(height: 50),
            Text(
              '취미 활동으로\n아래 항목이 입력되었습니다\n',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              displayConditions, // 선택된 조건 또는 '없음'을 표시
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 80,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
