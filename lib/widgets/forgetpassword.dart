import 'package:flutter/material.dart';
import 'package:health_management_app/ui/top_bar.dart';

enum Cardmode {
  otpVerify,
  forgetPassword,
}

// ignore: must_be_immutable
class ForgetPw extends StatefulWidget {
  ForgetPw({Key? key, this.cardmode}) : super(key: key);
  Cardmode? cardmode;

  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(alignment: Alignment.center, children: [
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.only(top: 12.5),
                padding: const EdgeInsets.all(0.0),
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  margin: EdgeInsets.all(25),
                  child: (Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                              widget.cardmode == Cardmode.forgetPassword
                                  ? "Forget Password"
                                  : "OTP Verification",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  widget.cardmode == Cardmode.forgetPassword
                                      ? "Enter your mobile number "
                                      : "Enter 6 digits OTP code here",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return widget.cardmode ==
                                        Cardmode.forgetPassword
                                    ? "Please enter your mobile number"
                                    : "Please enter 6 digits OTP code";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.8, 50),
                              primary: const Color.fromRGBO(105, 49, 142, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPw(cardmode: Cardmode.otpVerify),
                                  ));
                            },
                            child: Text(
                                widget.cardmode == Cardmode.forgetPassword
                                    ? "Confirm Number"
                                    : "Verify OTP",
                                style: const TextStyle(
                                    fontSize: 20.0,
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
        ]),
      ),
    );
  }
}
