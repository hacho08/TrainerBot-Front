import 'dart:math';
import 'dart:async';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseMonitor {
  final PoseDetector _poseDetector;
  Timer? _motionTimer;
  Pose? _lastPose;
  bool _isFallen = false; // 넘어짐 상태를 추적하는 플래그
  bool _fallDetected = false; // 넘어짐 감지 여부
  Function(String) onReportTrigger;



  PoseMonitor(this._poseDetector, this.onReportTrigger);

  // 무릎이 올라갔는지 체크하는 함수
  bool isKneeUp(Pose pose) {
    final knee = pose.landmarks[PoseLandmarkType.leftKnee];
    final hip = pose.landmarks[PoseLandmarkType.leftHip];
    final ankle = pose.landmarks[PoseLandmarkType.leftAnkle];

    if (knee != null && hip != null && ankle != null) {
      double kneeAngle = calculateAngle(hip.x, hip.y, knee.x, knee.y);
      double ankleAngle = calculateAngle(knee.x, knee.y, ankle.x, ankle.y);

      // 무릎이 올라갔는지 체크 (예: 각도가 90도 이상일 때)
      if (kneeAngle < 90 ) { ///&& ankleAngle < 90
        return true;  // 무릎이 충분히 올라갔을 때
      }
    }
    return false;  // 무릎이 올라가지 않았을 때
  }
  // 운동이 제대로 이루어졌는지 체크 후 콜백 호출
  void checkExercise(Pose pose, String workoutName) {
    bool exerciseCompleted = false;
    if (workoutName == "standingKneeUp") {
      exerciseCompleted = isKneeUp(pose);
      if (exerciseCompleted) {
        onReportTrigger("굿");
      } else {
        onReportTrigger("자세를 바르게 하세요");
      }
    }
      // 운동 완료 여부 확인 (예시로 무릎을 체크)
    // onExerciseCompleted(exerciseCompleted);  // 완료 여부를 콜백으로 전달
  }

  // 사람이 넘어졌는지 감지하는 로직
  bool isPersonFallen(Pose pose) {
    final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
    final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
    final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
    final rightHip = pose.landmarks[PoseLandmarkType.rightHip];

    if (leftShoulder != null && rightShoulder != null && leftHip != null && rightHip != null) {
      // 어깨와 엉덩이의 수평 각도를 계산
      double shoulderAngle = calculateAngle(leftShoulder.x, leftShoulder.y, rightShoulder.x, rightShoulder.y);
      double hipAngle = calculateAngle(leftHip.x, leftHip.y, rightHip.x, rightHip.y);

      // 넘어짐을 판단하는 기준: 기울기 각도가 일정 값 이상일 때 넘어졌다고 판단
      if ((shoulderAngle > 90 && shoulderAngle < 135 && hipAngle < 135 && hipAngle > 90) || (shoulderAngle < -90 && shoulderAngle > -135  && hipAngle > -135 && hipAngle < -90)) {
        return true;  // 넘어짐
      }
    }
    return false;
  }

  // 두 점 사이의 각도를 계산하는 함수
  double calculateAngle(double x1, double y1, double x2, double y2) {
    double dx = x2 - x1;
    double dy = y2 - y1;
    return atan2(dy, dx) * (180 / pi);  // 라디안 -> 도로 변환
  }

  // 일정 시간 동안 움직이지 않으면 감지하는 로직
  void startMonitoring(Pose currentPose) {
    if (_lastPose != null) {
      if (_hasPoseChanged(_lastPose!, currentPose)) {
        // 움직임이 있을 때마다 타이머를 초기화
        _motionTimer?.cancel(); // 이전 타이머 취소

        // 5초 동안 움직이지 않으면 경고
        _motionTimer = Timer(Duration(seconds: 5), () {
          onReportTrigger("신고되었습니다."); // 화면 업데이트
        });
      }
    }

    _lastPose = currentPose;
  }

  // 두 포즈가 비슷한지 확인하는 함수
  bool _hasPoseChanged(Pose lastPose, Pose currentPose) {
    final lastX = lastPose.landmarks[PoseLandmarkType.nose]?.x ?? 0;
    final currentX = currentPose.landmarks[PoseLandmarkType.nose]?.x ?? 0;
    return (lastX - currentX).abs() > 20;  // 좌표 차이가 20픽셀 이상이면 변화가 있다고 판단
  }

  // 포즈 모니터링 함수
  void monitorPose(Pose pose) {
    if (_fallDetected) {
      // 이미 넘어짐이 감지되었으면, 일정 시간동안 반복되지 않도록 설정
      return;
    }

    if (isPersonFallen(pose)) {
      // 넘어짐 감지
      _fallDetected = true;  // 넘어짐 감지 플래그 설정

      if (_lastPose != null) {
        if (_hasPoseChanged(_lastPose!, pose)) {
          // 움직임이 있을 때마다 타이머를 초기화
          _fallDetected = false; // 이전 타이머 취소
        }
      }

      // 넘어짐 감지 후 10초 동안만 "넘어짐" 메시지를 표시
      onReportTrigger("넘어짐이 감지되었습니다.\n5초 이상 움직임이 없다면 자동 신고됩니다.");

      // 10초 후에 플래그 해제하여 다시 검사를 할 수 있게 설정
      Timer(Duration(seconds: 5), () {
        _fallDetected = false;
      });
    }

    // isKneeUp(pose);
  }

  // 신고 트리거
  void _triggerReport() {
    print("##########################################3Sending alert for help...");
  }
}
