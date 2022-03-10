import 'dart:convert';

RegResponse regResponseFromJson(String str) =>
    RegResponse.fromJson(json.decode(str));

String regResponseToJson(RegResponse data) => json.encode(data.toJson());

class RegResponse {
  RegResponse({
    this.isOtpSent,
    this.msg,
    this.userId,
  });

  bool? isOtpSent;
  String? msg;
  String? userId;

  factory RegResponse.fromJson(Map<String, dynamic> json) => RegResponse(
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
