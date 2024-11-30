import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;  // http 패키지 임포트
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDataSender {
  final List<Pose> poses;  // 추출된 포즈 데이터를 받을 변수
  final String apiUrl;  // API URL

  // 부위별 순서를 정의
  final List<String> bodyPartNames = [
    'Nose', 'Left Eye', 'Right Eye', 'Left Ear', 'Right Ear',
    'Left Shoulder', 'Right Shoulder', 'Left Elbow', 'Right Elbow',
    'Left Wrist', 'Right Wrist', 'Left Hip', 'Right Hip', 'Left Knee',
    'Right Knee', 'Left Ankle', 'Right Ankle', 'Left Foot', 'Right Foot'
  ];

  final List<PoseLandmarkType> bodyParts = [
    PoseLandmarkType.nose,
    PoseLandmarkType.leftEye, PoseLandmarkType.rightEye,
    PoseLandmarkType.leftEar, PoseLandmarkType.rightEar,
    PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder,
    PoseLandmarkType.leftElbow, PoseLandmarkType.rightElbow,
    PoseLandmarkType.leftWrist, PoseLandmarkType.rightWrist,
    PoseLandmarkType.leftHip, PoseLandmarkType.rightHip,
    PoseLandmarkType.leftKnee, PoseLandmarkType.rightKnee,
    PoseLandmarkType.leftAnkle, PoseLandmarkType.rightAnkle,
    PoseLandmarkType.leftFootIndex, PoseLandmarkType.rightFootIndex,
  ];
  PoseDataSender(this.poses, this.apiUrl);

  // 주기적으로 포즈 데이터를 저장하는 메소드
  void startSendingData() {
      sendPoseDataToApi();  // 주기적으로 데이터 보내기
  }

  // 포즈 데이터를 API로 보내는 메소드
  void sendPoseDataToApi() async {
    List<Map<String, Map<String, int>>> poseDataList = [];

    // 각 포즈에 대해 부위별로 순서대로 데이터를 추출
    for (final pose in poses) {
      Map<String, Map<String, int>> poseData = {};

      // 부위 순서대로 데이터를 추출하고 저장
      for (var i = 0; i < bodyParts.length; i++) {
          final landmark = pose.landmarks[bodyParts[i]]!;
          poseData[bodyPartNames[i]] = {
            'x': landmark.x.round(),
            'y': landmark.y.round(),
          };
        // }
      }

      poseDataList.add(poseData);
    }

    // workoutName과 poseDataList를 포함하는 새로운 맵 생성
    Map<String, dynamic> workoutData = {
      'workoutName': 'standing knee up',  // 운동 이름
      'points': poseDataList,  // poseDataList를 'points'로 포함
    };

    // JSON으로 변환
    final jsonString = jsonEncode(workoutData);

    // API로 POST 요청 보내기
    try {
      final response = await http.post(
        Uri.parse('https://a137-35-245-182-170.ngrok-free.app/getPoseResult'),  // 요청할 API URL
        headers: {
          'Content-Type': 'application/json',  // JSON 형식으로 보내기 위한 헤더
        },
        body: jsonString,  // 요청 본문에 JSON 데이터 추가
      );

      if (response.statusCode == 200) {
        print('Pose data sent successfully!');
        print(response.body);  // 서버의 응답 내용 출력
      } else {
        print('Failed to send pose data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending pose data: $e');
    }
  }
}
