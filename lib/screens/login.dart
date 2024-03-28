import 'package:binbuddy_frontend/models/user.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/net/errors.dart';
import 'package:binbuddy_frontend/screens/widgets/login_container.dart';
import 'package:binbuddy_frontend/screens/widgets/login_textbox.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'widgets/login_button.dart';
import 'widgets/alert.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.setUser});

  final Function setUser;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async  {
      User? user;
      
      try {
        if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => const InformationDialog(
              title: "An error has occured.",
              message: "Please fill in all fields.",
            ),
          );
          
          return;
        }
        
        user = await RequestSender.tryLogin(_emailController.text, _passwordController.text);
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) => InformationDialog(
            title: "Error",
            message: Errors.convertAuthError(e),
          ),
        );
        
        _passwordController.clear();
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => InformationDialog(
            title: "Error",
            message: e.toString(),
          ),
        );

        _passwordController.clear();
      } finally {
        if(user != null) {
          print(user.toMap());

          await widget.setUser(user);
        }
      }

      //User user = await RequestSender.tryLogin(_emailController.text, _passwordController.text);
      //widget.setUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BinBuddy",
          style: TextStyle(
            fontFamily: "Monospace",
          ),
        ),
        centerTitle: true,
      ),
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginContainer(
              children: [
                LoginTextBox(
                  hintText: "Email", 
                  fontFamily: "Monospace",
                  obscureText: false,
                  controller: _emailController,
                ),
                LoginTextBox(
                  hintText: "Password",
                  fontFamily: "Monospace",
                  obscureText: true,
                  controller: _passwordController,
                ),
                LoginButton(
                  onTap: login,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Monospace",
                    ),  
                  )
                ),
              ],
            ),
          ],
        ),
    );
  }
}