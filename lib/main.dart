import 'package:flutter/material.dart';
import 'package:submission_pixel_art/main_screen.dart';
import 'package:submission_pixel_art/about_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
      routes: {
        '/about': (context) => const AboutScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}