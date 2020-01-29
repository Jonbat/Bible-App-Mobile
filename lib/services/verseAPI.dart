import 'package:http/htpp.dart' as http;
import 'dart:convert';

class verseAPI {

  String baseUrl = "http://rordonez.pythonanywhere.com/bible/api/v1.0/";

  Future<List<String>> getVersions() async {
    // make the request

    final response = await http.get(baseUrl + 'versions');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}