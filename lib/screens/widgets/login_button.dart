import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.onTap,
    required this.child,
    super.key});

  final VoidCallback onTap;
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 81, 41, 30), 
            width: 2.0
          ),
        ),
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: ElevatedButton(
          onPressed: onTap, 
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 237, 203, 177),
            foregroundColor: const Color.fromARGB(255, 81, 41, 30),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}