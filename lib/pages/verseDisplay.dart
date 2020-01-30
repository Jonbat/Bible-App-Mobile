import 'package:flutter/material.dart';
import '../services/verseAPI.dart';
import '../models/verse.dart';

class VerseDisplay extends StatelessWidget {

  List<Verse> verses = [
    Verse(book: "Ge", chapter: 1, verse: 1, text: "In the beginning God created the heavens and the earth."),
    Verse(book: "Ge", chapter: 1, verse: 2, text: "And the earth was waste and void; and darkness was upon the face of the deep: and the Spirit of God moved upon the face of the waters."),
    Verse(book: "Ge", chapter: 1, verse: 3, text: "And God said, Let there be light: and there was light.")
  ];

  Widget verseTemplate(verse) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '${verse.book} ${verse.chapter}:${verse.verse}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.purple[800]
              )
            ),
            SizedBox(height: 6.0),
            Text(
              verse.text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Genesis 1:2"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: verses.map((verse) => verseTemplate(verse)).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 160.0,
                colorScheme: ColorScheme.dark(),
                child: RaisedButton(
                  child: Text('Previous'),
                  onPressed: () {
                  // todo: call the previous verse and reload the page
                  },
                ),
              ),
              SizedBox(width: 12.0),
              ButtonTheme(
                minWidth: 160.0,
                colorScheme: ColorScheme.dark(),
                child: RaisedButton(
                  child: Text('Next'),
                  onPressed: () {
                  // todo: call the next verse and reload the page
                  },
                ),
              ),
            ],
          )
        ],
      ),
      
    );
  }
}

//Text('${verse.book} ${verse.chapter} ${verse.verse} - ${verse.text}')