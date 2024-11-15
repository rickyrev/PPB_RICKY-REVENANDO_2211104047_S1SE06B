import 'dart:io';
import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  
  final String imagePath;

  const DisplayScreen({
    super.key,
    required this.imagePath,
    });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Screen'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[500],
      ),
      body: Image.file(File(imagePath)),
    );
  }
}