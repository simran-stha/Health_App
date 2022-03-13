// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:health_management_app/models/otp_verification_model.dart';
import 'package:health_management_app/ui/dashboard.dart';
import '../network/apiClient.dart';
import '../ui/custom_clipper.dart';
import '../ui/dashboard.dart';

enum CardMode { forgetPassword, otpVerification }

// ignore: must_be_immutable
class OtpPage extends StatefulWidget {
  OtpPage({Key? key, this.verify, this.deviceId, this.userId})
      : super(key: key);
  CardMode? verify;
  String? deviceId;
  String? userId;

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final DioClient _dioClient = DioClient();
  OtpRequestModel otpRequestModel = OtpRequestModel();
  OtpResponseModel otpResponseModel = OtpResponseModel();

  @override
  Widget build(BuildContext context) {
    print('user:${widget.userId}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Stack(alignment: Alignment.center, children: [
          Positioned.fill(
            child: Image(
              image: AssetImage('images/bg.png'),
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.cover,
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
                    width: 180,
                    height: 200,
                  ),
                ),
              ],
            ),
            clipper: MyCustomClipper(),
          ),
          Container(
            // margin: EdgeInsets.only(top: 10.5),
            padding: const EdgeInsets.all(0.0),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Container(
              margin: EdgeInsets.all(20),
              child: (Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                          widget.verify == CardMode.forgetPassword
                              ? "Forget Password"
                              : "OTP Verification",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      SizedBox(height: 20),
                      TextFormField(
                        // controller: _controller,
                        onSaved: (newValue) => otpRequestModel.otp = newValue,
                        decoration: InputDecoration(
                          hintText: widget.verify == CardMode.otpVerification
                              ? "Enter 4 digits OTP code here"
                              : "Enter your mobile number ",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return widget.verify == CardMode.forgetPassword
                                ? "Please enter your mobile number"
                                : "Please enter 4 digits OTP code";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.6, 40),
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            _dioClient
                                .verifyOtp(
                                    otpRequestModel, widget.userId.toString())
                                .then((value) {
                              if (value != null) {
                                print(value.msg);
                                if (value.msg != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const DashBoard(
                                                accessToken: '',
                                              )));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('Error: ${otpResponseModel.msg}'),
                                    backgroundColor: Colors.red.shade300,
                                  ));
                                }
                              }
                            });
                          }
                        },
                        child: Text(
                            widget.verify == CardMode.forgetPassword
                                ? "Confirm Number"
                                : "Verify OTP",
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ])),
            ),
          ),
        ]),
      ),
    );
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
