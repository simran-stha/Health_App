import 'package:flutter/material.dart';
import 'package:health_management_app/models/register_model.dart';
import 'package:health_management_app/widgets/password_otp.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../network/apiClient.dart';

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

  // Initial Selected Value
  String dropdownvalue = 'Consultant';
  int labled = 0;
  late String deviceId;
  late String userId;
  late String accessToken;
  DioClient _dioClient = DioClient();
  RegisterRequestModel registerRequestModel = RegisterRequestModel();
  RegisterResponseModel registerResponseModel = RegisterResponseModel();

  DateTime selectedDate = DateTime.now();
  String value = "";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 25),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                            // controller: _nameController,
                            onSaved: (newValue) =>
                                registerRequestModel.name = newValue,
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
                                          registerRequestModel.qualification =
                                              newValue;
                                        });
                                      },
                                      items: dropdownItems),
                                ),
                              ]),
                          TextFormField(
                            // controller: _specialityController,
                            onSaved: (newValue) {
                              registerRequestModel.speciality = newValue;
                              registerRequestModel.userType = newValue;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Speciality',
                              fillColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          TextFormField(
                              readOnly: true,
                              onChanged: (newValue) =>
                                  registerRequestModel.dob = value,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                // label: Text(value),
                                hintText: value,
                              ),
                              onTap: () async {
                                final DateTime? selected = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2025),
                                );
                                if (selected != null &&
                                    selected != selectedDate) {
                                  setState(() {
                                    selectedDate = selected;
                                    value =
                                        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                  });
                                }
                              }),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (newValue) =>
                                        registerRequestModel.email = newValue,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onSaved: (newValue) => registerRequestModel
                                        .contact_number = newValue,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Mobile Number',
                                    ),
                                  ),
                                ),
                              ]),
                          TextFormField(
                            onSaved: (newValue) =>
                                registerRequestModel.password = newValue,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            // controller: _passwordController,
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
                            onSaved: (newValue) =>
                                registerRequestModel.password = newValue,
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
                            obscureText: _isObscure,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Password is too short!';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: SizedBox(
                              width: double.infinity, // match_parent
                              child: ElevatedButton(
                                onPressed: () {
                                  if (validateAndSave()) {
                                    // loginFunc();
                                    print('simran');
                                    print(registerRequestModel.toJson());
                                    _dioClient
                                        .register(registerRequestModel)
                                        .then((value) {
                                      if (value != null) {
                                        print(value.msg);
                                        if (value.isOtpSent == true) {
                                          userId = value.userId.toString();
                                          print(userId);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('${value.msg}'),
                                            backgroundColor:
                                                Colors.green.shade300,
                                          ));
                                          deviceId = registerRequestModel
                                              .device_id
                                              .toString();
                                          userId = value.userId.toString();
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return OtpPage(
                                              verify: CardMode.otpVerification,
                                              userId: userId,
                                            );
                                          }));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Error: ${value.msg}'),
                                            backgroundColor:
                                                Colors.red.shade300,
                                          ));
                                        }
                                      }
                                    });
                                  }
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

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
