import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pKup',
      home: Scaffold(
        appBar: AppBar(
          title: Text('pKup Games'),
        ),
        body: Center(
          child: RegisterGame(),
        ),
      ),
    );
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

/**/

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    final game_id = Text("Rutvik's Game");
    return game_id;
  }
}

class RegisterGame extends StatefulWidget {
  @override
  _RegisterGameState createState() => _RegisterGameState();
}

//
class _RegisterGameState extends State<RegisterGame> {
  final _formKey = GlobalKey<FormState>();
  final gameName = TextEditingController();
  final gameDate = TextEditingController();
  final gameTime = TextEditingController();
  final gameLoc = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("games");

  @override
  Widget build(BuildContext context) {
    // New game registration
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: gameName,
                decoration: InputDecoration(
                  labelText: "Game Type",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'What\'s the game?';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: gameDate,
                decoration: InputDecoration(
                  labelText: "Date",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'What day?';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: gameTime,
                decoration: InputDecoration(
                  labelText: "Time",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'When?';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: gameLoc,
                decoration: InputDecoration(
                  labelText: "Location",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Where?';
                  }
                  return null;
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          dbRef.push().set({
                            "game_type": gameName.text,
                            "date": gameDate.text,
                            "time": gameTime.text,
                            "location": gameLoc.text
                          }).then((_) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Game Posted!')));
                            gameName.clear();
                            gameDate.clear();
                            gameTime.clear();
                            gameLoc.clear();
                          }).catchError((onError) {
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text(onError)));
                          });
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                )),
          ],
        )));
  }
}
