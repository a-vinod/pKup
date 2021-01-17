import 'package:flutter/material.dart';

class ProfileCardAlignment extends StatelessWidget {
  final int cardNum;
  ProfileCardAlignment(this.cardNum);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('WASHINGTON PARK',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Text('A short description.',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, //Center Row contents vertically,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Color(0xFFD8D8D6),
                          onPressed: () {},
                          child: Text(
                            "5 mi away",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Color(0xFFD8D8D6),
                          onPressed: () {},
                          child: Text(
                            "9:00 am",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Color(0xFFD8D8D6),
                          onPressed: () {},
                          child: Text(
                            "3/10 Players",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xFFD55E2D),
                      onPressed: () {},
                      child: Text(
                        "Join",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
