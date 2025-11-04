import 'package:flutter/material.dart';
// 1. (수정) main_screen.dart 대신 login_screen.dart를 import

import 'package:gnu_real_pbl/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re:Cycle',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // (추가) 텍스트 필드 테마도 앱 전체 테마와 맞춥니다.
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,

      // 2. (수정) 앱의 첫 화면을 LoginScreen으로 변경합니다.
      home: const LoginScreen(),
    );
  }
}
