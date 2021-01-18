import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import '../../../constants.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterGame()));
            },
            child: Text(
              "Create",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.0),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterGame extends StatefulWidget {
  @override
  _RegisterGameState createState() => _RegisterGameState();
}

//
class _RegisterGameState extends State<RegisterGame> {
  final KeyChainManager _keyChainManager = KeyChainManager.getInstance();
  final _formKey = GlobalKey<FormState>();
  final gameName = TextEditingController();
  final gameLoc = TextEditingController();
  String gameDateTime = "";
  final dbRef = FirebaseDatabase.instance.reference().child("games");
  String host;

  @override
  Future<String> getAtsign() async {
    String host;
    FutureBuilder<String>(
      future: _keyChainManager.getAtSign(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            host = snapshot.data;
          }
        }
      },
    );
    return host;
  }

  @override
  @override
  Widget build(BuildContext context) {
    // New game registration
    return FutureBuilder(
        future: _keyChainManager.getAtSign(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('New @PiKUP'),
              ),
              body: Form(
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
                              return 'What kind of game?';
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
                                color: kPrimaryColor,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if (gameDateTime.isEmpty) {
                                      gameDateTime = DateTime.now().toString();
                                    }
                                    dbRef.push().set({
                                      "type": gameName.text,
                                      "loc": gameLoc.text,
                                      "date_time": gameDateTime,
                                      "host": snapshot.data
                                    }).then((_) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('Game Posted!')));
                                      gameName.clear();
                                    }).catchError((onError) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(content: Text(onError)));
                                    });

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Submit',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          )),
                    ],
                  )));
        });
  }
}
