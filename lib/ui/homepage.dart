import 'package:flutter/material.dart';
import 'package:health_management_app/ui/custom_clipper.dart';

import 'package:health_management_app/widgets/login.dart';
import 'package:health_management_app/widgets/signup.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundPage(),
    );
  }
}

class BackgroundPage extends StatefulWidget {
  @override
  _BackgroundPageState createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  bool isLoginScreen = true;
  void toggleView() {
    setState(() => isLoginScreen = !isLoginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(alignment: Alignment.center, children: [
          Positioned.fill(
            child: Image(
              image: AssetImage('images/bg.png'),
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          ClipPath(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Positioned(
                  top: 2.0,
                  child: Image.asset(
                    "images/logo.png",
                    width: 170,
                    height: 175,
                  ),
                ),
              ],
            ),
            clipper: MyCustomClipper(),
          ),
          Container(
            child: isLoginScreen == false
                ? SignUp(
                    toggleView: toggleView,
                  )
                : new LoginPage(toggleView: toggleView),
          ),
        ]));
  }
}
