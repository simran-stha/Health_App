import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key, required this.accessToken}) : super(key: key);
  final String accessToken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Dashboard Page!'),
      ),
      body: Center(
        child: Text(accessToken),
      ),
    );
  }
}
