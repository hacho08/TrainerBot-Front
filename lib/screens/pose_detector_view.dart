import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../utils/pose/pose_painter.dart';
import '../utils/pose/pose_data_sender.dart';
import 'camera_view.dart';

// 카메라에서 스켈레톤 추출하는 화면
class PoseDetectorView extends StatefulWidget {
  const PoseDetectorView({super.key});

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  // 스켈레톤 추출 변수 선언(google_mlkit_pose_detection 라이브러리)
  final PoseDetector _poseDetector =
  PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  // 스켈레톤 모양을 그려주는 변수
  CustomPaint? _customPaint;
  // input Map
  Map<String, double> inputMap = {};

  @override
  void dispose() {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 카메라뷰 보이기
    return CameraView(
      // 스켈레톤 그려주는 객체 전달
      customPaint: _customPaint,
      // 카메라에서 전해주는 이미지 받을 때마다 아래 함수 실행
      onImage: (inputImage) {
        processImage(inputImage); // processImage를 호출하여 이미지 처리
      },
    );
  }

  // 카메라에서 실시간으로 받아온 이미지 처리: 이미지에 포즈가 추출되었으면 스켈레톤 그려주기
  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) {
      return;
    }

    if (_isBusy) {
      return;
    }

    _isBusy = true;

    try {
      // poseDetector에서 추출된 포즈 가져오기
      List<Pose> poses = await _poseDetector.processImage(inputImage);
      // print('Detected poses: ${poses.length}');

      // 이미지가 정상적이면 포즈에 스켈레톤 그려주기
      if (inputImage.metadata?.size != null &&
          inputImage.metadata?.rotation != null) {
        final painter = PosePainter(
          poses,
          inputImage.metadata!.size,
          inputImage.metadata!.rotation,
        );
        _customPaint = CustomPaint(painter: painter);

        // PoseDataSender 호출하여 데이터를 저장
        PoseDataSender(poses, "pose_data.json").startSendingData();  // JSON 파일로 저장하고 서버로 보내기

      } else {
        // 추출된 포즈 없음
        print('No pose detected');
        _customPaint = null;
      }
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isBusy = false; // 항상 false로 설정하여 다음 프레임 처리 가능
      if (mounted) {
        setState(() {}); // UI 업데이트
      }
    }
  }
}
