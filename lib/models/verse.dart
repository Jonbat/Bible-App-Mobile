class VerseResponse {
  final Verse prev, curr, next;

  VerseResponse({this.prev, this.curr, this.next});

  VerseResponse.fromJson(Map<String, dynamic> json)
    : prev = Verse.fromJson(json['prev']),
      curr = Verse.fromJson(json['curr']),
      next = Verse.fromJson(json['next']);
}

class Verse {
  final String book;
  final int chapter;
  final int verse;
  final String text;

  Verse({this.book, this.chapter, this.verse, this.text});

  Verse.fromJson(Map<String, dynamic> json)
    : book = json['book'],
      chapter = json['chapter'],
      verse = json['verse'],
      text = json['text'];
}