import 'dart:convert';
import '../models/verse.dart';
import 'package:http/http.dart' as http;

class VerseAPI {

  String baseUrl = "http://rordonez.pythonanywhere.com/bible/api/v1.0/";

  Future<List<String>> getVersions() async {
    // make the request

    final response = await http.get(baseUrl + 'versions');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body).cast<String>();
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<VerseResponse> getVerses(String version, String book, int chapter, int verse) async {
    // make the request

    final response = await http.get(baseUrl + version + '/' + book + '/' + chapter.toString() + '/' + verse.toString());
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return VerseResponse.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
  
}