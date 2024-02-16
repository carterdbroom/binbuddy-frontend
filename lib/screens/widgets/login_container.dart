import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    required this.children,
    super.key});
  
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 203, 177),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 81, 41, 30), 
            width: 2.0
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children),
      ),
    );
  }
}