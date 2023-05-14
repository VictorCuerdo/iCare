import 'dart:convert';
import 'package:http/http.dart' as http;

class News {
  final String _apiKey = '0ff209df84msh40355c07fb81eddp161d0fjsndcd34cd08bc9';
  final String _apiHost = 'covid-193.p.rapidapi.com';

  Future<dynamic> fetchCountries() async {
    var response = await http.get(
      Uri.parse('https://$_apiHost/statistics?country=Colombia'),
      headers: {'X-RapidAPI-Key': _apiKey, 'X-RapidAPI-Host': _apiHost},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      print('Failed to load countries. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load countries');
    }
  }
}
