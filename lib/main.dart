import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SenApp(),));

class SenApp extends StatelessWidget {
  const SenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SenPass"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Text")
        ],
      ),
    );
  }
}





