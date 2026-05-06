import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZAPATERÍA PRO',
      home: Scaffold(
        appBar: AppBar(title: const Text("ZAPATERÍA PRO")),
        body: const Center(
          child: Text("APK DESDE LA NUBE 🚀", style: TextStyle(fontSize: 22)),
        ),
      ),
    );
  }
}
