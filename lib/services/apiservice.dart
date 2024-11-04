import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/apikey/key.dart';

class ApiService {
  final String baseUrl = "https://api-nba-v1.p.rapidapi.com";

  //fetch standings
  Future<List<dynamic>> fetchStandings(
      {required String conference, required String season}) async {
    final url = Uri.parse(
        '$baseUrl/standings?league=standard&season=$season&conference=$conference');
    final response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Key": NbaApi.key,
        "X-RapidAPI-Host": "api-nba-v1.p.rapidapi.com"
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'];
    } else {
      throw Exception("Failed to load standings");
    }
  }

  //fetch games
  Future<List<dynamic>> fetchGames({String? h2h, String? date}) async {
    final url = Uri.parse(
        date != null ? '$baseUrl/games?date=$date' : '$baseUrl/games?h2h=$h2h');
    final response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Key": NbaApi.key,
        "X-RapidAPI-Host": "api-nba-v1.p.rapidapi.com"
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> games = data['response'] ?? [];

      final finishedGames = games.where((game) {
        return game['status']['short'] == 3;
      }).toList();

      print("Fetched finished games: $finishedGames");
      return finishedGames;
    } else {
      throw Exception("Failed to load games");
    }
  }
}
