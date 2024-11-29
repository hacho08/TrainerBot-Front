import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import '../main.dart';

// 카메라 화면
class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key,
        required this.customPaint,
        required this.onImage,
        this.initialDirection = CameraLensDirection.front})
      : super(key: key);
  // 스켈레톤을 그려주는 객체
  final CustomPaint? customPaint;
  // 이미지 받을 때마다 실행하는 함수
  final Function(InputImage inputImage) onImage;
  // 카메라 렌즈 방향 변수
  final CameraLensDirection initialDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  // 카메라를 다루기 위한 변수
  CameraController? _controller;
  // 카메라 인덱스
  int _cameraIndex = -1;
  // 확대 축소 레벨
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  // 카메라 렌즈 변경 변수
  bool _changingCameraLens = false;

  @override
  void initState() {
    super.initState();

    // 카메라 설정. 기기에서 실행 가능한 카메라, 카메라 방향 설정...
    if (cameras.any(
          (element) =>
      element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
        element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      for (var i = 0; i < cameras.length; i++) {
        if (cameras[i].lensDirection == widget.initialDirection) {
          _cameraIndex = i;
          break;
        }
      }
    }

    // 카메라 실행 가능하면 포즈 추출 시작
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 카메라 화면 보여주기 + 화면에서 실시간으로 포즈 추출
      body: _liveFeedBody(),
      // 전면<->후면 변경 버튼
      // floatingActionButton: _floatingActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // 전면<->후면 카메라 변경 버튼
  Widget? _floatingActionButton() {
    if (cameras.length == 1) return null;
    return SizedBox(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: _switchLiveCamera,
          child: Icon(
            Platform.isIOS
                ? Icons.flip_camera_ios_outlined
                : Icons.flip_camera_android_outlined,
            size: 40,
          ),
        ));
  }

  // 카메라 화면 보여주기 + 화면에서 실시간으로 포즈 추출
  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    // 화면 및 카메라 비율에 따른 스케일 계산
    // 원문: calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 전면 후면 변경 시 화면 변경 처리
          Transform.scale(
            scale: scale,
            child: Center(
              child: _changingCameraLens
                  ? const Center(
                child: Text('Changing camera lens'),
              )
                  : CameraPreview(_controller!),
            ),
          ),
          // 추출된 스켈레톤 그리기
          if (widget.customPaint != null) widget.customPaint!,
          // 화면 확대 축소 위젯
          // Positioned(
          //   bottom: 100,
          //   left: 50,
          //   right: 50,
          //   child: Slider(
          //     value: zoomLevel,
          //     min: minZoomLevel,
          //     max: maxZoomLevel,
          //     onChanged: (newSliderValue) {
          //       setState(() {
          //         zoomLevel = newSliderValue;
          //         _controller!.setZoomLevel(zoomLevel);
          //       });
          //     },
          //     divisions: (maxZoomLevel - 1).toInt() < 1
          //         ? null
          //         : (maxZoomLevel - 1).toInt(),
          //   ),
          // ),
        ],
      ),
    );
  }

  // 실시간으로 카메라에서 이미지 받기(비동기적)
  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      // 이미지 받은 것을 _processCameraImage 함수로 처리
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  // 전면<->후면 카메라 변경 함수
  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    print('카메라 인덱스 $_cameraIndex');
    _cameraIndex = (_cameraIndex + 1) % cameras.length;
    print(_cameraIndex);
    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  Uint8List convertYUV420ToNV21(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    // print("width: ${image.width}, height: ${image.height}");
    // YUV 크기 계산
    final int ySize = image.planes[0].bytes.length;
    final int uvSize = image.planes[1].bytes.length + image.planes[2].bytes.length;

    // NV21 포맷에 맞는 크기의 배열 생성
    final Uint8List nv21 = Uint8List(ySize + uvSize);

    // Y 채널 복사
    for (int i = 0; i < ySize; i++) {
      nv21[i] = image.planes[0].bytes[i];
    }

    // UV 채널 병합 (UV 순서로 interleave)
    int uvIndex = ySize;
    final int uvLength = image.planes[1].bytes.length;
    for (int i = 0; i < uvLength; i++) {
      nv21[uvIndex++] = image.planes[2].bytes[i]; // V 채널
      nv21[uvIndex++] = image.planes[1].bytes[i]; // U 채널
    }

    return nv21;
  }


  // 카메라에서 실시간으로 받아온 이미치 처리: PoseDetectorView에서 받아온 함수인 onImage(이미지에 포즈가 추출되었으면 스켈레톤 그려주는 함수) 실행
  Future<void> _processCameraImage(CameraImage image) async {
    try {
      // YUV 데이터를 NV21로 변환
      final Uint8List nv21Bytes = convertYUV420ToNV21(image);

      // 이미지 크기 설정
      final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

      // 카메라 정보에서 회전 값 가져오기
      final camera = cameras[_cameraIndex];
      final imageRotation =
      InputImageRotationValue.fromRawValue(camera.sensorOrientation);
      if (imageRotation == null) {
        print('Error: Invalid image rotation');
        return;
      }

      // InputImageMetadata 생성
      final inputImageMetadata = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: InputImageFormat.nv21, // 변환된 포맷 사용
        bytesPerRow: image.planes[0].bytesPerRow,
      );

      // InputImage 생성
      final inputImage = InputImage.fromBytes(
        bytes: nv21Bytes,
        metadata: inputImageMetadata,
      );

      // PoseDetectorView에서 전달받은 onImage 함수 호출
      widget.onImage(inputImage);

    } catch (e) {
      print('Error in _processCameraImage: $e');
    }
  }

}