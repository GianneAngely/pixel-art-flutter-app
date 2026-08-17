import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        title: const Text('About Me'),
        backgroundColor: const Color(0xFF1A252F),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gianne Angely Puspa Pilatus',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Submission Flutter Pemula',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
             const SizedBox(height: 5),
            const Text(
              'Pixel Art Enthusiast 👾',
              style: TextStyle(fontSize: 14, color: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}