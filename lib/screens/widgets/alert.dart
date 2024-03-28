import 'package:binbuddy_frontend/screens/widgets/login_button.dart';
import 'package:flutter/material.dart';

class InformationDialog extends StatelessWidget {
  final String title;
  final String message;

  const InformationDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        LoginButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Ok",
            style: TextStyle(
              fontFamily: "Monospace",
            ),  
          )
        ),
      ],
    );
  }

}