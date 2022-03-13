import 'dart:convert';

ReSendOtpResponseModel reSendOtpResponseModelFromJson(String str) =>
    ReSendOtpResponseModel.fromJson(json.decode(str));

String reSendOtpResponseModelToJson(ReSendOtpResponseModel data) =>
    json.encode(data.toJson());

class ReSendOtpResponseModel {
  ReSendOtpResponseModel({
    this.isOtpSent,
    this.msg,
  });

  bool? isOtpSent;
  String? msg;

  factory ReSendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      ReSendOtpResponseModel(
        isOtpSent: json["isOTPSent"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "isOTPSent": isOtpSent,
        "msg": msg,
      };
}

ReSendOtpRequestModel reSendOtpRequestModelFromJson(String str) =>
    ReSendOtpRequestModel.fromJson(json.decode(str));

String reSendOtpRequestModelToJson(ReSendOtpRequestModel data) =>
    json.encode(data.toJson());

class ReSendOtpRequestModel {
  ReSendOtpRequestModel({
    this.contactNumber,
  });

  String? contactNumber;

  factory ReSendOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      ReSendOtpRequestModel(
        contactNumber: json["contact_number"],
      );

  Map<String, dynamic> toJson() => {
        "contact_number": contactNumber,
      };
}
