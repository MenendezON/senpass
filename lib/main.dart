import 'package:flutter/material.dart';
import 'package:senpass/pages/homePage.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: SenApp(),));

class SenApp extends StatelessWidget {
  const SenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}