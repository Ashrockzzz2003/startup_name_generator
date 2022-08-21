import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  final bool useMaterial31;
  runApp(const MyApp());
}

//Build Method For Random Words Generator
class RandomWords extends StatefulWidget{
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

//Function to generate Random Words in TextView
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              final pair_new = pair.asPascalCase;
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromRGBO(0,0,0,0.6),
                ),
                child : ListTile(
                  //textColor: Colors.black,
                  iconColor: Colors.yellowAccent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),

                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon( Icons.airplane_ticket_rounded, size: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(0, 0, 0, 0.4),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: Text(
                          pair.asPascalCase,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            height: 2,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(0, 0, 0, 1),
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child:  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(0, 0, 0, 0.4),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              height: 1,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Congratulations! \n$pair_new is gonna Rock!'),
                              content: Text('The Name for your Startup is $pair_new!\nYou have successfully found your Mojo!'),
                              actions: <Widget>[
                                ElevatedButton(                     // FlatButton widget is used to make a text to work like a button
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25))),
                                  onPressed: () => Navigator.pop(context, 'Ok'),           // function used to perform after pressing the button
                                  child: const Text('Thank you!', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500, fontSize: 25,),
              title: const Text('Saved Suggestions'),
            ),
            body:
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.redAccent, Colors.deepPurpleAccent]),
              ),
              child: ListView(children: divided,),
            ),
          );
        },
      ), // ...to here.
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('StartUp Name Generator'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500, fontSize: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt_rounded, color: Colors.white,),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body:
      Container(
        decoration: const BoxDecoration(
          /*image: DecorationImage(
                        image: AssetImage("assets/bg.jpg"),
                        fit: BoxFit.cover,
                      ),*/
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.redAccent, Colors.deepPurpleAccent]),
        ),
        child: ListView.builder(
            padding: const EdgeInsets.all(13.0),
            itemBuilder: (context, i){
              if(i.isOdd) return const Divider(height: 15,);

              final index = i ~/ 2;
              if(index >= _suggestions.length){
                _suggestions.addAll(generateWordPairs().take(10));
              }

              final word = _suggestions[index].asPascalCase;
              final alreadySaved = _saved.contains(_suggestions[index]);

              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromRGBO(0,0,0,0.6),
                ),
                child: ListTile(
                  //textColor: Colors.black,
                  iconColor: Colors.yellowAccent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),

                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon( Icons.airplane_ticket_rounded, size: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(0, 0, 0, 0.4),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: Text(
                          _suggestions[index].asPascalCase,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            height: 2,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (alreadySaved) {
                              _saved.remove(_suggestions[index]);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 750),
                                content: Text('$word Removed from Favourites'),
                                backgroundColor: Colors.black,
                              ));
                            } else {
                              _saved.add(_suggestions[index]);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 750),
                                content: Text('$word Added to Favourites'),
                                backgroundColor: Colors.black,
                              ));
                            }
                          });                // to here.
                        },
                        /*onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Congratulations! \n$word is gonna Rock!'),
                              content: Text('The Name for your Startup is $word!'),
                              actions: <Widget>[
                                ElevatedButton(                     // FlatButton widget is used to make a text to work like a button
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25))),
                                  onPressed: () => Navigator.pop(context, 'Cancel'),           // function used to perform after pressing the button
                                  child: const Text('Find New', style: TextStyle(color: Colors.white)),
                                ),
                                ElevatedButton(                     // FlatButton widget is used to make a text to work like a button
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25))),
                                  onPressed: () => Navigator.pop(context, 'Ok'),           // function used to perform after pressing the button
                                  child: const Text('Accept', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),*/
                      ),
                      Icon(
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: alreadySaved ? Colors.red : Colors.red,
                        semanticLabel: alreadySaved ? 'Remove from Favourites' : 'Favourites',
                      ),
                    ],
                  ),
                ),

              );
            }
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      title: 'StartUp Name Generator',
      home: const RandomWords(),
      /*appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: const Text('StartUp Name Generator'),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500, fontSize: 25,
          ),
        ),*/
      /* Container(
                  decoration: const BoxDecoration(
                      /*image: DecorationImage(
                        image: AssetImage("assets/bg.jpg"),
                        fit: BoxFit.cover,
                      ),*/
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.redAccent, Colors.deepPurpleAccent]),

                  ),
                  child: const RandomWords(),
                ),*/
    );
  }
}