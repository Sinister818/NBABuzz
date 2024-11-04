import 'package:flutter/material.dart';
import 'pages/games.dart';
import 'pages/standings.dart';

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
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: 'NBA',
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text: 'Buzz',
                          style: TextStyle(color: Colors.blue),
                        )
                      ])))),
          SizedBox(height: 20),
          Image.asset(
            'assets/images/lightning.jpg',
            height: 100,
            width: 100,
          ),

          Padding(padding: EdgeInsets.only(top: 60)),

          //standings button
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StandingsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              child: Text('Standings', style: TextStyle(fontSize: 20))),

          Padding(padding: EdgeInsets.only(top: 80)),

          //games button
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GamesPage()));
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              child: Text("Games", style: TextStyle(fontSize: 20))),

          Padding(padding: EdgeInsets.only(top: 50)),
        ])));
  }
}
