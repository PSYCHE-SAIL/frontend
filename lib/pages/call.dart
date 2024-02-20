import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Container(
        decoration : BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/incoming_call.jpeg"),
            fit: BoxFit.cover,
          )
        ),
      )
    );
  }
}
