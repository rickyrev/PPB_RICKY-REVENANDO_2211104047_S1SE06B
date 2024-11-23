import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praktikum_10/view/my_db_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Database Storage Bagian 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Mengatur textTheme menggunakan Google Fonts
        textTheme: GoogleFonts.robotoTextTheme(
          // Menggunakan font Poppins dari Google Fonts
          Theme.of(context).textTheme,
        ),
      ),
      home: MyDbView(),
    );
  }
}