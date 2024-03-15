import 'package:dino_vpn/vpn_status_provider.dart';
import 'package:dino_vpn/pages/Splash.dart';
import 'package:dino_vpn/pages/login.dart';
import 'package:dino_vpn/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultFontFamily = TextStyle(
      fontFamily: 'vazir',
    );
    return GetMaterialApp(
      title: 'ChiselBox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: defaultFontFamily,
          bodyMedium: defaultFontFamily,
          bodyLarge: defaultFontFamily,
          bodySmall: defaultFontFamily,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 28, 100, 184),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
