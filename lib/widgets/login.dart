import 'package:flutter/material.dart';
import 'package:health_management_app/widgets/password_otp.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({required this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(alignment: Alignment.center, children: [
      Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(top: 10.5),
            padding: const EdgeInsets.all(0.0),
            width: deviceSize.width * 0.85,
            height: deviceSize.height * 0.60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Container(
              margin: EdgeInsets.all(20),
              child: (Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: ToggleSwitch(
                        totalSwitches: 2,
                        radiusStyle: true,
                        minHeight: 35,
                        minWidth: MediaQuery.of(context).size.width * 0.3,
                        cornerRadius: 80.0,
                        activeBgColor: [Color(0xff5A227E)],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.white,
                        inactiveFgColor: Colors.black,
                        initialLabelIndex: 0,
                        labels: ['Log In', 'Sign Up'],
                        onToggle: (value) {
                          widget.toggleView();
                        }),
                  ),
                ),
                new Container(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number or Email',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(
                            FontAwesomeIcons.eye,
                            size: 15,
                          ),
                        ),
                      ),
                      Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Forgot Password?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // padding: EdgeInsets.only(right: 20),
                            new TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgetPw(
                                          verify: Verification.forgetPassword),
                                    ));
                              },
                              style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                              ),
                              child: new Text(
                                "Click Here",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // Text Color
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                          width: double.infinity, // match_parent
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Log In',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
            ),
          ),
        ]),
      ),
    ]);
  }
}
