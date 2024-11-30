import 'dart:math';
import 'dart:async';
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
  final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  late Timer _timer; // Timer 변수 추가
  List<Pose> _currentPoses = []; // 현재 포즈 데이터를 저장할 변수
  InputImage? _currentImage; // 마지막에 처리한 이미지 저장
  String _feedbackMessage = ""; // 서버로부터 받은 메시지를 저장할 변수

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      print("called");
      addPoses(_currentImage!);
    });
  }

  @override
  void dispose() {
    _canProcess = false;
    _poseDetector.close();
    _timer.cancel(); // 타이머 종료
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi), // 좌우 반전 제거하는 설정
        child: CameraView(
          customPaint: _customPaint,
          onImage: (inputImage) {
            setState(() {
              _currentImage = inputImage; // onImage에서 받은 이미지 저장
            });
            processImage(inputImage); // 이미지 처리
          },
        ),
      ),
      // 서버로부터 받은 메시지를 표시하는 부분
      if (_feedbackMessage.isNotEmpty) ...[
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.2),
                Text(
                '$_feedbackMessage',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontFamily: "PaperlogySemiBold",
                  color: Color(0xFFCC4343),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // 카메라에서 실시간으로 받아온 이미지 처리
  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) {
      return;
    }

    if (_isBusy) {
      return;
    }

    _isBusy = true;

    try {
      // 포즈 추출
      List<Pose> poses = await _poseDetector.processImage(inputImage);

      // 이미지가 정상적이면 포즈에 스켈레톤 그려주기
      if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
        final painter = PosePainter(
          poses,
          inputImage.metadata!.size,
          inputImage.metadata!.rotation,
        );
        _customPaint = CustomPaint(painter: painter);

      } else {
        print('No pose detected');
        _customPaint = null;
      }
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isBusy = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  // 포즈 데이터를 서버로 보내는 메소드
  void sendPoseData() {
    if (_currentPoses.isNotEmpty) {
      // PoseDataSender(_currentPoses, "pose_data.json").sendPoseDataToApi();
      // print('Sending pose data to API');

      PoseDataSender(_currentPoses, "pose_data.json").sendPoseDataToApi().then((message) {
        setState(() {
          _feedbackMessage = message;  // 서버 응답을 상태로 업데이트
          _showFeedbackMessage(_feedbackMessage);
        });
        print('Server response: $message');
      });
      // // 전송 후 _currentPoses 초기화
      // setState(() {
      //   _currentPoses.clear();  // 데이터 전송 후 초기화
      // });;
    }
  }
  // void sendPoseData() {
  //   if (_currentPoses.isNotEmpty) {
  //     String feedbackMessage = PoseDataSender(_currentPoses, "pose_data.json").startSendingData() as String;
  //     print('Sending pose data to API');
  //
  //     // // 전송 후 _currentPoses 초기화
  //     // setState(() {
  //     //   _currentPoses.clear();  // 데이터 전송 후 초기화
  //     // });
  //     print("mesage!!!!!!: $feedbackMessage");
  //   }
  // }

  void addPoses(InputImage inputImage) async {
    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      // 포즈 추출
      List<Pose> poses = await _poseDetector.processImage(inputImage);
      if (poses.isNotEmpty) {
        setState(() {
          _currentPoses.add(poses.first); // 첫 번째 포즈만 추가 (필요에 따라 변경 가능)
        });
        print("length ${_currentPoses.length}");
        if (_currentPoses.length >= 17) {
          sendPoseData();  // 17개가 되면 서버로 전송
          setState(() {
            _currentPoses.clear();  // 데이터 전송 후 초기화
          });
        }
      }
    }
  }

  // 5초 후에 메시지를 사라지게 하는 함수
  void _showFeedbackMessage(String message) {
    setState(() {
      _feedbackMessage = message;
    });

    // 5초 후에 메시지 지우기
    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        _feedbackMessage = ''; // 메시지를 비움
      });
    });
  }
}
