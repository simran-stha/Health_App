import 'package:flutter/material.dart';
import 'package:health_management_app/widgets/password_otp.dart';
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
    DropdownMenuItem(child: Text("Consultant"), value: "Consultant"),
    DropdownMenuItem(child: Text("Resident"), value: "Resident"),
    DropdownMenuItem(child: Text("Medical Officer"), value: "Medical Officer "),
    DropdownMenuItem(child: Text("Nurse"), value: "Nurse"),
  ];
  return menuItems;
}

class _SignUpState extends State<SignUp> {
  String? selectedValue = null;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    Form(
                      child: Column(children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                'I am a',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )),
                              Expanded(
                                child: DropdownButtonFormField(
                                    validator: (value) =>
                                        value == null ? "Select an item" : null,
                                    value: selectedValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue!;
                                      });
                                    },
                                    items: dropdownItems),
                              ),
                            ]),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Speciality',
                            fillColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                  ),
                                ),
                              ),
                            ]),
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgetPw(
                                          verify: Verification.otpVerification),
                                    ));
                              },
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
                      ]),
                    )
                  ])),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
