// lib/screens/scan_screen.dart

import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // 1. camera 패키지 import

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // 2. 카메라 컨트롤러와 초기화 Future 선언
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // 카메라 초기화를 시작합니다.
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // 3. 사용 가능한 카메라 목록을 가져옵니다.
    final cameras = await availableCameras();
    // 4. 첫 번째 카메라(보통 후면 카메라)를 선택합니다.
    final firstCamera = cameras.first;

    // 5. 컨트롤러를 생성합니다.
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium, // 해상도 설정
    );

    // 6. 컨트롤러 초기화 Future를 저장합니다.
    // 이 Future가 FutureBuilder의 'future'가 됩니다.
    _initializeControllerFuture = _controller!.initialize();

    // initState는 async가 될 수 없으므로,
    // 초기화 완료 후 UI를 갱신하기 위해 setState를 호출합니다.
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    // 7. 위젯이 종료될 때 컨트롤러를 반드시 폐기합니다.
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      // 8. 카메라가 초기화될 때까지 기다립니다.
      await _initializeControllerFuture;

      // 9. 사진을 촬영합니다.
      final image = await _controller!.takePicture();

      // 위젯이 아직 화면에 있는지 확인
      if (!mounted) return;

      // --- [협업 포인트] ---
      // TODO: 1. AI/백엔드 팀과 상의하여 이 'image' (XFile)를 전송합니다.
      // 예: await uploadImageToAIServer(image.path);

      // TODO: 2. 분석 결과를 보여줄 result_screen.dart로 이동합니다.
      // 예: Navigator.push(context, MaterialPageRoute(builder: (_) => ResultScreen(imagePath: image.path)));

      // 우선은 촬영 성공을 알리는 스낵바를 띄웁니다.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('사진이 촬영되었습니다! 경로: ${image.path}')));
    } catch (e) {
      // 오류 발생 시
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('오류 발생: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // --- 카메라 미리보기 ---
            // 10. FutureBuilder를 사용해 카메라 초기화를 기다립니다.
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _controller != null) {
                  // 초기화 완료: 카메라 미리보기를 전체 화면으로 보여줍니다.
                  return Center(child: CameraPreview(_controller!));
                } else {
                  // 초기화 중: 로딩 스피너를 보여줍니다.
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
              },
            ),

            // --- UI 오버레이 ---
            // 뒤로가기 버튼 (상단 좌측)
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // 촬영 버튼 (하단 중앙)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: _takePicture, // 11. 촬영 함수 호출
                  child: const Icon(Icons.camera_alt, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
