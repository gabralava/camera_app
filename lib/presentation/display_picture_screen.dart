import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String inputText;
  final double latitude;
  final double longitude;

  const DisplayPictureScreen({super.key, required this.imagePath, required this.inputText, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Отображение запроса'),),
      body: Column(
        children: [
          SizedBox(height: 500, width: 500, child: Image.file(File(imagePath))),
          Text('Ваша геопозиция: ${latitude.toString()}, ${longitude.toString()}'),
          Text('Ваш текст: $inputText'),
        ],
      ),
    );
  }
}