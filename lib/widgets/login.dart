import 'package:flutter/material.dart';
import 'package:health_management_app/models/login_model.dart';
import 'package:health_management_app/models/resend_otp_model.dart';
import 'package:health_management_app/network/apiClient.dart';
import 'package:health_management_app/widgets/password_otp.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../ui/dashboard.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({required this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late String accessToken;
  bool _isObscure = true;
  late String deviceID;
  late String userId;

  final DioClient _dioClient = DioClient();
  LoginRequestModel loginrequestModel = LoginRequestModel();
  LoginResponseModel loginResponseModel = LoginResponseModel();
  ReSendOtpRequestModel reSendOtpRequestModel = ReSendOtpRequestModel();
  ReSendOtpResponseModel reSendOtpResponseModel = ReSendOtpResponseModel();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(alignment: Alignment.center, children: [
      Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(0.0),
            width: 330,
            height: 480,
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: new Container(
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (newValue) =>
                                loginrequestModel.email = newValue,
                            // controller: _emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number or Email',
                            ),
                          ),
                          TextFormField(
                            onSaved: (newValue) =>
                                loginrequestModel.password = newValue,
                            // controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
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
                                          builder: (context) => OtpPage(
                                              verify: CardMode.forgetPassword),
                                        ));
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  child: new Text(
                                    "Click Here",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                onPressed: () {
                                  if (validateAndSave()) {
                                    // loginFunc();
                                    print('simran');
                                    print(loginrequestModel.toJson());

                                    _dioClient
                                        .login(loginrequestModel)
                                        .then((value) {
                                      // if (value != null) {
                                      //   if (value.token!.isNotEmpty) {
                                      if (value.isNumberVerified == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Logging you in.....'),
                                          backgroundColor: Colors.red.shade300,
                                        ));
                                        accessToken =
                                            loginResponseModel.token.toString();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DashBoard(
                                                      accessToken: '',
                                                    )));
                                      }
                                      if (value.isNumberVerified == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Error: ${value.msg}'),
                                          backgroundColor: Colors.red.shade300,
                                        ));

                                        _dioClient
                                            .reSendOtp(reSendOtpRequestModel)
                                            .then((value) {
                                          if (value.isOtpSent == true) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtpPage(
                                                          verify: CardMode
                                                              .otpVerification,
                                                          deviceId: deviceID,
                                                          userId: userId,
                                                        )));
                                          }
                                        });
                                      }
                                      //   }
                                      // }
                                    });
                                  }
                                },
                                child: const Text(
                                  'Log In',
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
                      ),
                    ),
                  ),
                ),
              ])),
            ),
          ),
        ]),
      ),
    ]);
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
