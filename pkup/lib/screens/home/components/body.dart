import 'package:flutter/material.dart';
import 'cards_section_alignment.dart';

import 'header.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          TitleWithMoreBtn(title: "Games", press: () {}),
          Container(
            height: 500,
            width: 500,
            child: Column(children: <Widget>[
              CardsSectionAlignment(context),
            ]),
          ),
        ],
      ),
    );
  }
}
