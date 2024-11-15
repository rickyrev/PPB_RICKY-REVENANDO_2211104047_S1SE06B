import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  
  @override
_CameraScreenState createState() => _CameraScreenState();
    }
  class _CameraScreenState extends State<CameraScreen> {
      late CameraController _controller;
      late Future<void> _initializeControllerFuture;
  @override
  void initState() {
  super.initState();// Initialize camera on startup
  _initializeCamera();
  }
    Future<void> _initializeCamera() async {
// Ambil daftar kamera yang tersedia di perangkat
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
// Buat kontroler kamera dan mulai kamera
  _controller = CameraController(
  firstCamera,
  ResolutionPreset.high,
);
  _initializeControllerFuture = _controller.initialize();
}
  @override
  void dispose() {
// Bersihkan kontroler ketika widget dihapus
  _controller.dispose();
  super.dispose();
}
  @override
    Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: Text('Camera Example')),
  body: FutureBuilder<void>(
  future: _initializeControllerFuture,
  builder: (context, snapshot) {
  if (snapshot.connectionState ==
  ConnectionState.done) {
  return CameraPreview(_controller);
  } else {
  return Center(child:
  CircularProgressIndicator());}
  },
),
  floatingActionButton: FloatingActionButton(
    onPressed: () async {
      try {
// Pastikan kamera sudah diinisialisasi
      await _initializeControllerFuture;
// Ambil gambar
      final image = await _controller.takePicture();
// Tampilkan atau gunakan gambar
    Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) =>
      DisplayPictureScreen(imagePath: image.path),
    ),
  );
    } catch (e) {
    print(e);
    }
  },
    child: Icon(Icons.camera_alt),
  ),
  );
    }
      }
  class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
    const DisplayPictureScreen({Key? key, required
      this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: Text('Display Picture')),body: Image.file(File(imagePath)),
  );
  }
}