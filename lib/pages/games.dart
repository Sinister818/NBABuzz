import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Games")),
      body: Center(child: Text("Games Page")),
    );
  }
}
