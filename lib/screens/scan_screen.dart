// lib/screens/scan_screen.dart

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart'; // 1. Dio 패키지 추가
import 'package:gnu_real_pbl/api/api_config.dart'; // 2. API 설정 파일 추가

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  final ImagePicker _picker = ImagePicker();

  // 3. Dio 객체 생성 (이미지 업로드는 시간이 걸릴 수 있어 타임아웃을 넉넉히 줍니다)
  final Dio dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('카메라 초기화 오류: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      if (!mounted) return;
      _processImage(image.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('촬영 오류: $e')),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (!mounted) return;
        _processImage(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('갤러리 오류: $e')),
      );
    }
  }

  // --- [수정됨] 이미지를 백엔드로 전송하는 함수 ---
  Future<void> _processImage(String imagePath) async {
    // 1. 로딩 표시
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('이미지를 분석 중입니다...')),
    );

    try {
      // 2. 전송할 데이터 준비 (FormData)
      // 파일 이름 추출 (예: image_picker_123.jpg)
      String fileName = imagePath.split('/').last;

      FormData formData = FormData.fromMap({
        // [수정됨] 백엔드 요청에 맞춰 키 이름을 'image'로 설정
        'image': await MultipartFile.fromFile(imagePath, filename: fileName),
      });

      // 3. 서버로 전송 (POST)
      // [수정됨] 백엔드 요청에 맞춰 엔드포인트를 '/api/ai/classify-image'로 설정
      final response = await dio.post(
        '/api/ai/classify-image', 
        data: formData,
      );

      if (!mounted) return;

      // 4. 결과 처리
      if (response.statusCode == 200) {
        // 성공 시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ 분석 완료! 결과 화면으로 이동합니다.'),
            backgroundColor: Colors.green,
          ),
        );
        
        // TODO: 분석 결과(response.data)를 가지고 결과 화면으로 이동
        // Navigator.push(context, MaterialPageRoute(builder: (_) => ResultScreen(data: response.data)));
        
        // (임시) 응답 데이터 확인용 출력
        print('서버 응답: ${response.data}');

      } else {
        // 실패 시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('분석 실패: 서버 오류')),
        );
      }

    } catch (e) {
      // 에러 발생 시
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('전송 오류: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
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
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _pickImageFromGallery,
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      tooltip: '갤러리에서 선택',
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: _takePicture,
                      child: const Icon(Icons.camera_alt, color: Colors.black),
                    ),
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