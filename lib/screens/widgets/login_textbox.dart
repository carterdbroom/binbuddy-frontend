import 'package:flutter/material.dart';

class LoginTextBox extends StatelessWidget {
  const LoginTextBox({
    this.hintText, 
    this.fontFamily,
    this.controller,
    required this.obscureText,
    super.key,
    });

    final String? hintText;
    final String? fontFamily;
    final TextEditingController? controller;
    final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: fontFamily,
            color: const Color.fromARGB(255, 81, 41, 30), 
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 81, 41, 30),
              width: 4.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 81, 41, 30),
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
          color: Color.fromARGB(255, 81, 41, 30), 
          fontFamily: fontFamily,
        ),
        obscureText: obscureText,
        obscuringCharacter: '●',
        maxLines: 1,
      ),
    );
  }
}