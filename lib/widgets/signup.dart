import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({required this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Doctor"), value: "Doctor"),
    DropdownMenuItem(child: Text("Nurse"), value: "Nurse"),
    DropdownMenuItem(child: Text("Health Worker"), value: "Health Worker"),
    DropdownMenuItem(child: Text("Compounder"), value: "Compounder"),
    DropdownMenuItem(child: Text("Pharmacist"), value: "Pharmacist"),
  ];
  return menuItems;
}

class _SignUpState extends State<SignUp> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
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
                          minWidth: MediaQuery.of(context).size.width * 0.3,
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
                  Form(
                    key: _dropdownFormKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButtonFormField(
                              validator: (value) =>
                                  value == null ? "Select an item" : null,
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: dropdownItems),
                        ]),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Speciality',
                      fillColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Email',
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
              )),
            ),
          ),
        ]),
      ),
    ]);
  }
}
