import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class Auth extends StatefulWidget {
  Auth({
    Key? key,
  }) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLoginScreen = true;
  bool forgetPassword = false;

  void toggleView() {
    setState(() => isLoginScreen = !isLoginScreen);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginScreen) {
      return LoginPage(
        toggleView: toggleView,
      );
    } else {
      return SignUp(toggleView: toggleView);
    }
  }
}
