import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final int response;
  final String imagePath;
  final String inputText;
  final double latitude;
  final double longitude;

  const ErrorScreen({super.key, required this.response, required this.imagePath, required this.inputText, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera app'),),
      body: Text('Error! $response\nФотография: $imagePath\nТекст: $inputText\nШирота: $latitude\nДолгота: $longitude'),
    );
  }
}