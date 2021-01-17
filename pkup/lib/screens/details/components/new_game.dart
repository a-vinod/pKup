import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class RegisterGame extends StatefulWidget {
  @override
  _RegisterGameState createState() => _RegisterGameState();
}

//
class _RegisterGameState extends State<RegisterGame> {
  final _formKey = GlobalKey<FormState>();
  final gameName = TextEditingController();
  final gameLoc = TextEditingController();
  var gameDateTime;
  final dbRef = FirebaseDatabase.instance.reference().child("games");

  @override
  Widget build(BuildContext context) {
    // New game registration
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
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
              padding: EdgeInsets.all(10.0),
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: 'Hour',
                selectableDayPredicate: (date) {
                  return true;
                },
                onChanged: (val) => gameDateTime = val,
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => gameDateTime = val,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                // here
                height: 200,
                alignment: Alignment.centerLeft,
                child: FlutterMap(
                  options: new MapOptions(
                    center: new LatLng(34.413955, -119.845884),
                    zoom: 14.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
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
                            "game_loc": gameLoc.text,
                            "date": gameDateTime,
                          }).then((_) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Game Posted!')));
                            gameName.clear();
                            gameDateTime.clear();
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
        ));
  }
}
