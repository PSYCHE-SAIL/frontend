import 'package:flutter/material.dart';

class  MyTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hinttext;
  final bool obscureText;
  const MyTextField({
        super.key,
        required this.controller,
        required this.hinttext,
        required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
                  controller: controller,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(32,160,144,255)),
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: Color.fromRGBO(32, 160, 144, 255),
                    filled: true,
                    hintText: hinttext,
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
    ) ;
  }
}

