import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:path_provider/path_provider.dart';


class PoseDataSender {
  final List<Pose> poses;  // 추출된 포즈 데이터를 받을 변수
  final String fileName;

  // 부위별 순서를 정의
  final List<String> bodyPartsOrder = [
    'Nose', 'Left Eye', 'Right Eye', 'Left Ear', 'Right Ear',
    'Left Shoulder', 'Right Shoulder', 'Left Elbow', 'Right Elbow',
    'Left Wrist', 'Right Wrist', 'Left Hip', 'Right Hip', 'Left Knee',
    'Right Knee', 'Left Ankle', 'Right Ankle', 'Neck', 'Left Palm',
    'Right Palm', 'Back', 'Waist', 'Left Foot', 'Right Foot'
  ];

  PoseDataSender(this.poses, this.fileName);

  // 주기적으로 포즈 데이터를 저장하는 메소드
  void startSendingData() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      savePoseDataAsJson();
    });
  }

  // 포즈 데이터를 JSON 파일로 저장하는 메소드
  void savePoseDataAsJson() async {
    List<Map<String, Map<String, double>>> poseDataList = [];

    // 각 포즈에 대해 부위별로 순서대로 데이터를 추출
    for (final pose in poses) {
      Map<String, Map<String, double>> poseData = {};
      print(pose);
      // 부위 순서대로 데이터를 추출하고 저장
      for (var part in bodyPartsOrder) {
        if (pose.landmarks.containsKey(PoseLandmarkType.values.firstWhere((e) => e.toString() == 'PoseLandmarkType.$part', orElse: () => PoseLandmarkType.nose))) {
          final landmark = pose.landmarks[PoseLandmarkType.values.firstWhere((e) => e.toString() == 'PoseLandmarkType.$part')]!;
          poseData[part] = {
            'x': landmark.x,
            'y': landmark.y,
          };
        }
      }

      poseDataList.add(poseData);
    }

    // JSON으로 변환하여 저장
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/output/${fileName}';
    final jsonString = jsonEncode(poseDataList);

    final file = File(filePath);
    await file.writeAsString(jsonString);

    // 출력
    print('Pose data saved to $fileName: $jsonString');
  }
}
