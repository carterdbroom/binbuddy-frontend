import 'package:flutter/material.dart';

class LoginTextBox extends StatelessWidget {
  const LoginTextBox({
    this.hintText, 
    this.fontFamily,
    required this.obscureText,
    super.key,
    });

    final String? hintText;
    final String? fontFamily;
    final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: fontFamily,
            color: const Color.fromARGB(255, 81, 41, 30), 
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
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