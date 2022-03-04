import 'package:flutter/material.dart';
import '../ui/custom_clipper.dart';

enum Verification { forgetPassword, otpVerification }

// ignore: must_be_immutable
class ForgetPw extends StatefulWidget {
  ForgetPw({Key? key, this.verify}) : super(key: key);
  Verification? verify;

  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                          widget.verify == Verification.forgetPassword
                              ? "Forget Password"
                              : "OTP Verification",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText:
                              widget.verify == Verification.otpVerification
                                  ? "Enter 6 digits OTP code here"
                                  : "Enter your mobile number ",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return widget.verify == Verification.forgetPassword
                                ? "Please enter your mobile number"
                                : "Please enter 6 digits OTP code";
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
                        child: Text(
                            widget.verify == Verification.forgetPassword
                                ? "Confirm Number"
                                : "Verify OTP",
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPw(
                                    verify: Verification.otpVerification),
                              ));
                        },
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
}
