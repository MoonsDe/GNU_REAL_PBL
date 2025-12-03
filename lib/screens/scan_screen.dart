// lib/screens/scan_screen.dart

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart'; // 1. image_picker import

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  // 2. ImagePicker 객체 생성
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사용 가능한 카메라가 없습니다. (시뮬레이터 확인)')),
        );
        setState(() {
          _initializeControllerFuture = Future.error('No cameras available');
        });
        return;
      }

      final firstCamera = cameras.first;

      _controller = CameraController(firstCamera, ResolutionPreset.medium);

      _initializeControllerFuture = _controller!.initialize();

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('카메라 초기화 오류: $e')));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // --- (기존) 카메라 촬영 함수 ---
  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      if (!mounted) return;
      _processImage(image.path); // 촬영된 이미지 처리
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('촬영 오류: $e')));
    }
  }

  // --- (추가됨) 갤러리에서 사진 가져오는 함수 ---
  Future<void> _pickImageFromGallery() async {
    try {
      // 갤러리 열기
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        if (!mounted) return;
        _processImage(image.path); // 선택된 이미지 처리
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('갤러리 오류: $e')));
    }
  }

  // --- (공통) 이미지 처리 로직 (촬영 or 갤러리 선택 후) ---
  void _processImage(String imagePath) {
    // TODO: 여기서 AI 서버로 이미지를 전송하거나 결과 화면으로 이동합니다.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('이미지 선택 완료! 경로: $imagePath')));

    // 예: Navigator.push(...)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. 카메라 미리보기
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _controller != null) {
                  return Center(child: CameraPreview(_controller!));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
              },
            ),

            // 2. 상단 뒤로가기 버튼
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // 3. 하단 컨트롤 영역 (촬영 버튼 + 갤러리 버튼)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                  children: [
                    // (추가됨) 갤러리 버튼 (왼쪽)
                    IconButton(
                      onPressed: _pickImageFromGallery,
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      tooltip: '갤러리에서 선택',
                    ),

                    // (기존) 촬영 버튼 (가운데)
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: _takePicture,
                      child: const Icon(Icons.camera_alt, color: Colors.black),
                    ),

                    // (공백) 레이아웃 균형을 맞추기 위한 투명 아이콘 (오른쪽)
                    const SizedBox(width: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
