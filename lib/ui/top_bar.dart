import 'package:health_management_app/ui/custom_clipper.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            top: 3.0,
            child: Image.asset(
              "images/logo.png",
              width: 180,
              height: 200,
            ),
          ),
        ],
      ),
      clipper: MyCustomClipper(),
    );
  }
}
