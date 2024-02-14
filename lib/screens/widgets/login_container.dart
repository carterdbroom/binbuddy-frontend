import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    required this.children,
    super.key});
  
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 81, 41, 30), 
            width: 2.0
          ),
        ),
        color: const Color.fromARGB(255, 237, 203, 177),
        child: Column(children: children),
      ),
    );
  }
}