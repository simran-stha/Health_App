import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
     this.email,
     this.deviceId,
     this.password,
  });

  String? email;
  String? deviceId;
  String? password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        deviceId: json["device_id"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "device_id": deviceId,
        "password": password,
      };
}

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
     this.token,
     this.user,
     this.email,
     this.contactNumber,
     this.isNumberVerified,
  });

  String? token;
  String? user;
  String? email;
  String? contactNumber;
  bool? isNumberVerified;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
        user: json["user"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        isNumberVerified: json["isNumberVerified"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user,
        "email": email,
        "contactNumber": contactNumber,
        "isNumberVerified": isNumberVerified,
      };
}
