import 'package:flutter/material.dart';
import 'widgets/splash_screen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '~bibin~',
      theme: ThemeData(primarySwatch: Colors.blue),
        home: const SplashScreenWidget()
    );
  }
}
