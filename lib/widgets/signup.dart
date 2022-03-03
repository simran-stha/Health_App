import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:health_management_app/ui/top_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({required this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage('images/bg.png'),
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.5),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            TopBar(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 12.5),
                    padding: const EdgeInsets.all(0.0),
                    height: 480,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(25),
                      child: (Column(
                        children: [
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
                                  minHeight: 35,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.3,
                                  cornerRadius: 80.0,
                                  activeBgColor: [Color(0xff5A227E)],
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: Colors.white,
                                  inactiveFgColor: Colors.black,
                                  initialLabelIndex: 1,
                                  totalSwitches: 2,
                                  radiusStyle: true,
                                  labels: const ['Log In', 'Sign Up'],
                                  onToggle: (index) {
                                    widget.toggleView();
                                  }),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                            ),
                          ),
                          // Form(
                          //   key: formKey,
                          //   autovalidateMode:
                          //       AutovalidateMode.disabled, // <- here

                          // child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: <Widget>[
                          //     Container(
                          //       padding: EdgeInsets.all(16),
                          //       child: DropDownFormField(
                          //         titleText: 'My workout',
                          //         hintText: 'Please choose one',
                          //         value: _myActivity,
                          //         onSaved: (value) {
                          //           setState(() {
                          //             _myActivity = value;
                          //           });
                          //         },
                          //         onChanged: (value) {
                          //           setState(() {
                          //             _myActivity = value;
                          //           });
                          //         },
                          //         dataSource: [
                          //           {
                          //             "display": "Running",
                          //             "value": "Running",
                          //           },
                          //           {
                          //             "display": "Climbing",
                          //             "value": "Climbing",
                          //           },
                          //           {
                          //             "display": "Walking",
                          //             "value": "Walking",
                          //           },
                          //           {
                          //             "display": "Swimming",
                          //             "value": "Swimming",
                          //           },
                          //           {
                          //             "display": "Soccer Practice",
                          //             "value": "Soccer Practice",
                          //           },
                          //           {
                          //             "display": "Baseball Practice",
                          //             "value": "Baseball Practice",
                          //           },
                          //           {
                          //             "display": "Football Practice",
                          //             "value": "Football Practice",
                          //           },
                          //         ],
                          //         textField: 'display',
                          //         valueField: 'value',
                          //       ),
                          //     ),
                          //   ],
                          //   ),
                          // ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                            ),
                          ),

                          // Row(
                          //   children: [
                          //     TextField(
                          //       keyboardType: TextInputType.text,
                          //       decoration: InputDecoration(
                          //         hintText: 'Email',
                          //       ),
                          //     ),
                          //     TextField(
                          //       keyboardType: TextInputType.text,
                          //       decoration: InputDecoration(
                          //         hintText: 'Mobile Number',
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: Icon(
                                FontAwesomeIcons.eye,
                                size: 15,
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              suffixIcon: Icon(
                                FontAwesomeIcons.eye,
                                size: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: SizedBox(
                              width: double.infinity, // match_parent
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
