import 'package:ejemplo/service/voter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: SizedBox(
              height: 50,
              child: SignInButton(
                Buttons.Google,
                elevation: 5,
                text: "Login Utem",
                onPressed: () => VoterService.login(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
