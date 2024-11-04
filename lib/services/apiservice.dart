import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/apikey/key.dart'; // Import your key file

class ApiService {
  final String baseUrl = "https://api-nba-v1.p.rapidapi.com";

  // Method to fetch standings by conference and season
  Future<List<dynamic>> fetchStandings(
      {required String conference, required String season}) async {
    final url = Uri.parse(
        '$baseUrl/standings?league=standard&season=$season&conference=$conference');
    final response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Key": NbaApi.key, // Use the key from NbaApi class
        "X-RapidAPI-Host": "api-nba-v1.p.rapidapi.com"
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[
          'response']; // Extract the "response" part of the data (adjust if necessary based on the actual JSON structure)
    } else {
      throw Exception("Failed to load standings");
    }
  }
}
