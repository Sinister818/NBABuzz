import 'package:flutter/material.dart';
import 'package:nbaBuzz/services/apiservice.dart';
import '../services/apiservice.dart';

class StandingsPage extends StatefulWidget {
  @override
  _StandingsPageState createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  late Future<List<dynamic>> eastStandings;
  late Future<List<dynamic>> westStandings;

  @override
  void initState() {
    super.initState();
    eastStandings =
        ApiService().fetchStandings(conference: "east", season: "2024");
    westStandings =
        ApiService().fetchStandings(conference: "west", season: "2024");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Standings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildConferenceSection("Eastern Conference", eastStandings),
            _buildConferenceSection("Western Conference", westStandings),
          ],
        ),
      ),
    );
  }

  Widget _buildConferenceSection(
      String title, Future<List<dynamic>> standingsFuture) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<dynamic>>(
          future: standingsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data available"));
            } else {
              // Sort teams by number of wins in descending order
              final sortedTeams = snapshot.data!
                ..sort((a, b) => (b['win']['total'] as int)
                    .compareTo(a['win']['total'] as int));

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sortedTeams.length,
                itemBuilder: (context, index) {
                  final team = sortedTeams[index];
                  return ListTile(
                    title: Text("${index + 1}. ${team['team']['name']}"),
                    subtitle: Text(
                        'Wins: ${team['win']['total']}, Losses: ${team['loss']['total']}'),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
