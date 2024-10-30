import 'package:flutter/material.dart';

void main() {
  runApp(NbaBuzzApp());
}

class NbaBuzzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NBABuzz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          decoration: BoxDecoration(
            // Light grey background
            borderRadius: BorderRadius.circular(8),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'NBA',
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: 'Buzz',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
