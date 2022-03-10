import 'package:flutter/material.dart';
import 'package:health_management_app/widgets/password_otp.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:health_management_app/network/request.dart';
import 'package:health_management_app/network/response.dart';

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
  bool _isObscure = true;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _specialityController = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Consultant';
  int labled = 0;
  late String deviceId;
  late String userId;
  late String accessToken;

  UserInfo _apiClient = UserInfo();
  RegResponse _regResponse = RegResponse();

  Future<void> registerFunc() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Registering a user'),
        backgroundColor: Colors.blue,
      ));

      dynamic res = await _apiClient.registerUser(UserInfo(
          name: _nameController.text,
          email: _emailController.text,
          contact_number: _emailController.text,
          password: _passwordController.text,
          speciality: _specialityController.text,
          is_verify: 'false',
          device_id: '12345',
          qualification: 'resident',
          dob: '2 march 1989',
          role: '2',
          userType: 'resident'));
      deviceId = _apiClient.device_id.toString();
      userId = _apiClient.user_id.toString();
      print('djkha');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      print(_regResponse.isOtpSent);

      String? testMsg = _regResponse.msg;

      if (testMsg == null) {
        print("Empty or NULL Value received");
      } else {
        print(testMsg);
      }

      print(_regResponse.msg);

      if (_regResponse.isOtpSent == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ForgetPw(
            verify: Verification.otpVerification,
            deviceId: deviceId,
            userId: userId,
          );
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${_regResponse.msg}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

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
                width: deviceSize.width * 0.90,
                height: deviceSize.height * 0.63,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: (Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
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
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          TextFormField(
                            controller: _nameController,
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
                                      validator: (value) => value == null
                                          ? "Select an item"
                                          : null,
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
                            controller: _specialityController,
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
                                    controller: _emailController,
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
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                            obscureText: _isObscure,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Password is too short!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: SizedBox(
                              width: double.infinity, // match_parent
                              child: ElevatedButton(
                                onPressed: () {
                                  registerFunc();
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
                      ),
                    ),
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
