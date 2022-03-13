// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) =>
    RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  RegisterRequestModel({
    this.name,
    this.is_verify = false,
    this.password,
    this.qualification,
    this.contact_number,
    this.dob = "2 march 1989",
    this.role = "2",
    this.speciality,
    this.userType,
    this.img = null,
    this.email,
    this.device_id = "12345",
  });

  String? name;
  bool? is_verify;
  String? password;
  String? qualification;
  String? contact_number;
  String? dob;
  String? role;
  String? speciality;
  String? userType;
  dynamic img;
  String? email;
  String? device_id;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json, [param1]) =>
      RegisterRequestModel(
        name: json["name"],
        is_verify: json["is_verify"],
        password: json["password"],
        qualification: json["qualification"],
        contact_number: json["contact_number"],
        dob: json["dob"],
        role: json["role"],
        speciality: json["speciality"],
        userType: json["userType"],
        img: json["img"],
        email: json["email"],
        device_id: json["device_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_verify": is_verify,
        "password": password,
        "qualification": qualification,
        "contact_number": contact_number,
        "dob": dob,
        "role": 2,
        "speciality": speciality,
        "userType": userType,
        "img": img,
        "device_id": device_id,
        "email": email,
      };
}

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.isOtpSent,
    this.msg,
    this.userId,
  });

  bool? isOtpSent;
  String? msg;
  String? userId;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        isOtpSent: json["isOTPSent"],
        msg: json["msg"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "isOTPSent": isOtpSent,
        "msg": msg,
        "user_id": userId,
      };
}
