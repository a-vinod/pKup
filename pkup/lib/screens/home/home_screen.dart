import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    );
  }
}
