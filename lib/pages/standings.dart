import 'package:flutter/material.dart';
import 'package:nbaBuzz/services/apiservice.dart';

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eastern Conference Column
            Expanded(
              child: _buildConferenceSection("Eastern", eastStandings),
            ),
            // Western Conference Column
            Expanded(
              child: _buildConferenceSection("Western", westStandings),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConferenceSection(
      String title, Future<List<dynamic>> standingsFuture) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Conference Title
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Standings List
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
      ),
    );
  }
}
