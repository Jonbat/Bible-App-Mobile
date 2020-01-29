import 'package:http/htpp.dart' as http;

class Verse {
  final String book;
  final int chapter;
  final int verse;
  final String text;

  Verse({this.book, this.chapter, this.verse, this.text});

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      book: json['book'],
      chapter: json['chapter'],
      verse: json['verse'],
      text: json['text'],
    );
  }
}