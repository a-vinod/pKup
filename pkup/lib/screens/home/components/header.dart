import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final KeyChainManager _keyChainManager = KeyChainManager.getInstance();
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // It will cover 20% of our total height
      child: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                top: kDefaultPadding + 36,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 0 + kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: FutureBuilder(
                  future: _keyChainManager.getAtSign(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/basketball.svg',
                                  height: 60,
                                  width: 60,
                                ),
                                Text(
                                  snapshot.data,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    }
                  })),
        ],
      ),
    );
  }
}
