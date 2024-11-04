import 'package:flutter/material.dart';
import 'package:nbaBuzz/services/apiservice.dart';

class GamesPage extends StatefulWidget {
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  late Future<List<dynamic>> games;

  @override
  void initState() {
    super.initState();

    games = games = ApiService().fetchGames(date: "2024-11-03");
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Games")),
      body: FutureBuilder<List<dynamic>>(
        future: games,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No games available"));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final game = snapshot.data![index];
                return _buildGameCard(game);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildGameCard(dynamic game) {
    final String date =
        game['date']?['start']?.split('T').first ?? "Date not available";
    final String team1Name = game['teams']?['home']?['name'] ?? "Home Team";
    final int team1Score = game['scores']?['home']?['points'] ?? 0;

    final String team2Name =
        game['teams']?['visitors']?['name'] ?? "Visitors Team";
    final int team2Score = game['scores']?['visitors']?['points'] ?? 0;

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Game Date
            Text(
              date,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            // Team Names and Scores Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Team 1 - Home
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        team1Name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "$team1Score",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Separator for Scores
                Expanded(
                  child: Text(
                    ":",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Team 2 - Visitors
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        team2Name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "$team2Score",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
