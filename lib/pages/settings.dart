import 'package:flutter/material.dart';

import '../components/button.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var constr = false;

          if (constraints.maxWidth > 600) constr = true;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                  child: circleButton(
                      constr, size.width / 100, size.width / 50,
                      "assets/idea.png"),
                )
              ],
            ),
          );
        }
    );
  }

}
