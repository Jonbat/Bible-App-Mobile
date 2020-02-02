import 'package:flutter/material.dart';
import '../services/verseAPI.dart';
import '../models/verse.dart';

class VerseDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerseDisplayState();
  }
}

class VerseDisplayState extends State<VerseDisplay> {

  // [0] : previous verse
  // [1] : current verse
  // [2] : next verse
  List<Verse> verses = [
    Verse(book: "Ge", chapter: 1, verse: 1, text: "In the beginning God created the heavens and the earth."),
    Verse(book: "Ge", chapter: 1, verse: 2, text: "And the earth was waste and void; and darkness was upon the face of the deep: and the Spirit of God moved upon the face of the waters."),
    Verse(book: "Ge", chapter: 1, verse: 3, text: "And God said, Let there be light: and there was light.")
  ];

  // change verses to display when the next or previous button is pressed
  void initializeVerses (VerseResponse response) {
    verses = [
      response.prev,
      response.curr,
      response.next
    ];
  }

  void displayPreviousVerse() {
    // if there is no previous verse, go to last verse of previous chapter
    if (verses[0] == null) {
      throw("ToDo: go to last verse of previous chapter");
    } else {
      final previousVerse = VerseAPI().getVerseNum('ASV', verses[0].book, verses[0].chapter, verses[0].verse);
      previousVerse.then((response) {
        setState(() {
          initializeVerses(response);
        }); 
      });
    }
  }

  void displayNextVerse() {
    // if there is no next verse, go to first verse of next chapter
    if (verses[2] == null) {
      throw("ToDo: go to first verse of next chapter");
    } else {
      final nextVerse = VerseAPI().getVerseNum('ASV', verses[2].book, verses[2].chapter, verses[2].verse);
      nextVerse.then((response) {
        setState(() {
          initializeVerses(response);
        }); 
      });
    }
  }


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
        // title: new Text("Genesis 1:2"),
        title: new Text(
          verses[1].book + ' ' + verses[1].chapter.toString() + ':' + verses[1].verse.toString()
        ),
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
                    displayPreviousVerse();     
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
                    displayNextVerse();
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