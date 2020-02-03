import 'package:bible_app_mobile/pages/verseDisplay.dart';
import 'package:flutter/material.dart';
import 'services/verseAPI.dart';
import 'models/verse.dart';

Future<String> _calculation = Future<String>.delayed(
  Duration(seconds: 2),
  () => 'Data Loaded',
);

Future<void> main() async {
  // final VerseAPI verseAPI = VerseAPI();
  runApp(MyApp());

  //comment out to test api calls Seperated

  //List<String> versions = await verseAPI.getVersions();
  //print(versions[2]);

  //List<String> books = await verseAPI.getBooks('ASV');
  //print(books[3]);

  // List<int> chapters = await verseAPI.getChapters('ASV', 'Romans');
  // print(chapters);

  //int verses = await verseAPI.getVerses('ASV', 'Romans', 3);
  //print(verses);

  // VerseResponse verseResponse = await verseAPI.getVerseNum('ASV', 'Genesis', 3, 2);
  // print(verseResponse.curr);

  //Intregration of API calls together

  //List<String> versions = await verseAPI.getVersions();
  //print(versions[0]);
  //String versionselect = versions[0];

  //List<String> books = await verseAPI.getBooks(versionselect);
  //print(books[2]);
  //String bookselect = books[2];

  // int chapters = await verseAPI.getChapters(versionselect, bookselect);
  //print(chapters);

  //int verses = await verseAPI.getVerses(versionselect, bookselect, 3);
  //print(verses);

  //VerseResponse verseResponse = await verseAPI.getVerseNum(versionselect, bookselect, 3, 5);
  //print(verseResponse);

} 

class MyApp extends StatelessWidget {

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final VerseAPI verseAPI = VerseAPI();

  Future<List<String>> versions;
  Future<List<String>> books;
  Future<List<int>> chapters;
  Future<List<int>> verses;
  Future<VerseResponse> verseResponse;
  // List<String> versions; 
  // List<String> books; // = await verseAPI.getBooks('ASV');
  // List<int> chapters;// = await verseAPI.getChapters('ASV', 'Romans');
  // List<int> verses;// = await verseAPI.getVerses('ASV', 'Romans', 3);
  String versionselect;// = versions[0];
  String bookselect;// = books[2];
  int chapterselect;
  int verseselect;

  // int chapters = await verseAPI.getChapters(versionselect, bookselect);
  //print(chapters);

  //int verses = await verseAPI.getVerses(versionselect, bookselect, 3);
  //print(verses);

  //VerseResponse verseResponse = await verseAPI.getVerseNum(versionselect, bookselect, 3, 5);
  //print(verseResponse);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override void initState() {
    // TODO: implement initState

    // Future test() async{
    //   widget.versions = await widget.verseAPI.getVersions();

    //   widget.versionselect = widget.versions[0];

    //   widget.books = await widget.verseAPI.getBooks(widget.versionselect);

    //   widget.bookselect = widget.books[0];

    //   widget.chapters = await widget.verseAPI.getChapters(widget.versionselect, widget.bookselect);

    //   widget.chapterselect = widget.chapters[0];

    //   widget.verses = await widget.verseAPI.getVerses(widget.versionselect, widget.bookselect, widget.chapterselect);

    //   widget.verseselect = widget.verses[0];

    //   versionChanged(widget.versionselect);

    //   print("Ver: ${widget.versionselect}, Book: ${widget.bookselect}, Ch: ${widget.chapterselect}, V: ${widget.verseselect}");
    // };

    // test();

    widget.versions = widget.verseAPI.getVersions();
    widget.versions.then( (versions){
      widget.versionselect = versions[0];

      widget.books = widget.verseAPI.getBooks(widget.versionselect);
      widget.books.then( (books){
        widget.bookselect = books[0];

        widget.chapters = widget.verseAPI.getChapters(widget.versionselect, widget.bookselect);
        widget.chapters.then( (chapters) {
          widget.chapterselect = chapters[0];

          widget.verses = widget.verseAPI.getVerses(widget.versionselect, widget.bookselect, widget.chapterselect);
          widget.verses.then( (verses) {
            widget.verseselect = verses[0];
            
            widget.verseResponse = widget.verseAPI.getVerseNum(widget.versionselect, widget.bookselect, widget.chapterselect, widget.verseselect);

          });
        });

      });
    });

    super.initState();
  }

  // an example of a function
  void versionChanged(version) {
    setState(() {
      widget.versionselect = version;
      
      widget.books = widget.verseAPI.getBooks(widget.versionselect);
      widget.books.then( (books){
        bookChanged(books[0]);

      });

    });
  }

  void bookChanged(book) {
    setState(() {
      widget.bookselect = book;
      widget.chapters = widget.verseAPI.getChapters(widget.versionselect, widget.bookselect);
      widget.chapters.then( (chapters) {
        chapterChanged(chapters[0].toString());
      });
    });
  }

  void chapterChanged(chapter) {
    setState(() {
      widget.chapterselect = int.parse(chapter);
      widget.verses = widget.verseAPI.getVerses(widget.versionselect, widget.bookselect, widget.chapterselect);
      widget.verses.then( (verses) {
        verseChanged(verses[0].toString());
      });
    });
  }

  void verseChanged(verse) {
    setState(() {
      widget.verseselect = int.parse(verse);
      widget.verseResponse = widget.verseAPI.getVerseNum(widget.versionselect, widget.bookselect, widget.chapterselect, widget.verseselect);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Select a verse'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          // Version Row
          Text("Please Reselect Version On intital Load"),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Version: "),
            FutureBuilder<List<String>>(
              future: widget.versions, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                var versiondropdown;

                if (snapshot.hasData) {
                  versiondropdown = DropdownButton<String>(
                  value: widget.versionselect,
                  items: snapshot.data.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {

                      print("User selected ${value}");
                      versionChanged(value);

                    },
                  );
                  
                } else if (snapshot.hasError) {
                  versiondropdown = Text("Error");
                } else {
                  versiondropdown = Text("Populating");
                }
                
                return versiondropdown;
              },
            ), 
          ]),
          // Book Row
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Book: "),
            FutureBuilder<List<String>>(
              future: widget.books, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                var bookdropdown;

                if (snapshot.hasData) {
                  bookdropdown = DropdownButton<String>(
                  value: widget.bookselect,
                  items: snapshot.data.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value, textAlign: TextAlign.center),
                    );
                  }).toList(),
                  onChanged: (value) {

                      print("User selected ${value}");
                      bookChanged(value);

                    },
                  );
                  
                } else if (snapshot.hasError) {
                  bookdropdown = Text("Error");
                } else {
                  bookdropdown = Text("Populating");
                }
                
                return bookdropdown;
              },
            ), 
          ]),
          // Chapter Row
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Chapter: "),
            FutureBuilder<List<int>>(
              future: widget.chapters, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                var dropdown;

                if (snapshot.hasData) {
                  dropdown = DropdownButton<String>(
                  value: widget.chapterselect.toString(),
                  items: snapshot.data.map((int value) {
                    return new DropdownMenuItem<String>(
                      value: value.toString(),
                      child: new Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {

                      print("User selected ${value}");
                      // ADD : TODO
                      chapterChanged(value);

                    },
                  );
                  
                } else if (snapshot.hasError) {
                  dropdown = Text("Error");
                } else {
                  dropdown = Text("Populating");
                }
                
                return dropdown;
              },
            ), 
          ]),
          // Verse Row
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Verse: "),
            FutureBuilder<List<int>>(
              future: widget.verses, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                var tdropdown;

                if (snapshot.hasData) {
                  tdropdown = DropdownButton<String>(
                  value: widget.verseselect.toString(),
                  items: snapshot.data.map((int value) {
                    return new DropdownMenuItem<String>(
                      value: value.toString(),
                      child: new Text(value.toString(), textAlign: TextAlign.center), 
                    );
                  }).toList(),
                  onChanged: (value) {

                      print("User selected ${value}");
                      // ADD : TODO
                      verseChanged(value);

                    },
                  );
                  
                } else if (snapshot.hasError) {
                  tdropdown = Text("Error");
                } else {
                  tdropdown = Text("Populating");
                }
                
                return tdropdown;
              },
            ), 
          ]),
          // Show the actual verse Row
          // Row(children: <Widget>[
          //   Text("Text: "),
          //   FutureBuilder<VerseResponse>(
          //     future: widget.verseResponse, // a previously-obtained Future<String> or null
          //     builder: (BuildContext context, AsyncSnapshot<VerseResponse> snapshot) {
          //       var txtVerse;

          //       if (snapshot.hasData) {
          //         txtVerse = Text(snapshot.data.curr.text);
                  
          //       } else if (snapshot.hasError) {
          //         txtVerse = Text("Error");
          //       } else {
          //         txtVerse = Text("Populating");
          //       }
                
          //       return txtVerse;
          //     },
          //   ), 
          // ]),

          RaisedButton(
            child: Text('Open Verse'),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => VerseDisplay(widget.versionselect, widget.bookselect, widget.chapterselect, widget.verseselect))
              );
            },
          )
        ],)
      ), 
    );
  }
}

