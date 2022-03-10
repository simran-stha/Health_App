// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'end_point.dart';
import 'package:dio/dio.dart';

class UserInfo {
  String? name;
  String? email;
  String? contact_number;
  String? password;
  String? speciality;
  String? is_verify;
  String? device_id;
  String? user_id;
  String? qualification;
  String? dob;
  String? role;
  String? userType;

  UserInfo({
    this.name,
    this.email,
    this.contact_number,
    this.password,
    this.speciality,
    this.dob,
    this.is_verify,
    this.qualification,
    this.role,
    this.userType,
    this.device_id,
    this.user_id,
  });

  UserInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        contact_number = json['contact_number'],
        password = json['password'],
        speciality = json['speciality'],
        is_verify = json['is_verify'],
        device_id = json['device_id'],
        qualification = json['qualification'],
        dob = json['dob'],
        role = json['role'],
        userType = json['userType'],
        user_id = json['user_id'];

  Map<String, dynamic> toJson() {
    var map = {
      'name': name,
      'email': email,
      'contactNumber': contact_number,
      'password': password,
      'speciality': speciality,
      'is_verify': is_verify,
      'device_id': device_id,
      'qualification': qualification,
      'dob': dob,
      'role': role,
      'userType': userType,
      'user_id': user_id,
    };
    return map;
  }

  Future<UserInfo?> registerUser(UserInfo userInfo) async {
    UserInfo? userInfo;
    // Future<User> getuser(User user) async {
    var dio = new Dio();
    dio.options.baseUrl = REGISTER_URL;
    dio.options.connectTimeout = 500000;
    dio.options.receiveTimeout = 500000;
    //dio.options.headers["x-access-token"] = "${loginUser.userToken}";
    // FormData formdata = new FormData.fromMap({
    //   'name': userInfo.name,
    //   'is_verify': 'false',
    //   'device_id': '12345',
    //   'qualification': 'resident',
    //   'email': userInfo.email,
    //   'contact_number': userInfo.email,
    //   'dob': '2 march 1989',
    //   'password': userInfo.password,
    //   'role': '2',
    //   'speciality': userInfo.speciality,
    //   'userType': 'resident'
    // });
    try {
      var response = await dio.post(REGISTER_URL,
          data: userInfo?.toJson(),
          options: Options(
              method: 'POST',
              responseType: ResponseType.plain // or ResponseType.JSON
              ));
      print(json.decode(response.data));
      userInfo = UserInfo.fromJson(response.data);
      print(userInfo);
    } on DioError catch (e) {
      print(e);

      // return e.response!.data;
    }
    return userInfo;
  }

// dynamic value = json.decode(response.data);
// String usertoken = value["token"];

  Future<UserInfo> verifyOtp(String otp, String deviceId, String userId) async {
    // Future<User> getuser(User user) async {
    var dio = new Dio();
    dio.options.baseUrl = VERIFY_OTP_URL;
    dio.options.connectTimeout = 500000;
    dio.options.receiveTimeout = 500000;

    //dio.options.headers["x-access-token"] = "${loginUser.userToken}";
    try {
      var response = await dio.post(VERIFY_OTP_URL + userId,
          data: {'otp': otp, 'deviceId': deviceId, 'userId': userId},
          options: Options(responseType: ResponseType.plain));
      return UserInfo.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response!.data);
      return e.response!.data;
    }
  }

  Future<UserInfo> loginUser(
      String email, String deviceId, String password) async {
    var dio = new Dio();
    dio.options.baseUrl = LOGIN_URL;
    dio.options.connectTimeout = 500000;
    dio.options.receiveTimeout = 500000;

    try {
      Response response = await dio.post(LOGIN_URL,
          data: {'email': email, 'deviceId': deviceId, 'password': password},
          options: Options(responseType: ResponseType.plain));
      var data1 = json.decode(response.data);
      return data1;
    } on DioError catch (e) {
      print(e.response!.data);
      return e.response!.data;
    }
  }
}






// class NetworkHandle {
//   late Dio _dio;
//   NetworkHandle() {
//     _dio = getNetwork();
//   }

//   Dio getNetwork() {
//     Dio _dio = Dio();
//     _dio.options = BaseOptions(connectTimeout: 50000, receiveTimeout: 50000);
//     _dio.interceptors.clear();
//     // _dio.options.headers["content-type"] = "application/json";
//     // _dio.options.headers["accept"] = "application/json";
//     _dio.options.baseUrl = BASE_URL;
//     return _dio;
//   }

//   Future<dynamic> registerUser(Map<String, dynamic>? data) async {
//     try {
//       Response response = await _dio.post(REGISTER_URL,
//           data: data, options: Options(responseType: ResponseType.plain));
//       var data1 = json.decode(response.data);
//       return data1;
//     } on DioError catch (e) {
//       print(e.response!.data);
//       return e.response!.data;
//     }
//   }

  // Future<dynamic> verifyOtp(String otp, String deviceId, String userId) async {
  //   print(VERIFY_OTP_URL + userId);
  //   try {
  //     Response response = await dio.post(VERIFY_OTP_URL + userId,
  //         data: {'otp': otp, 'deviceId': deviceId},
  //         options: Options(responseType: ResponseType.plain));
  //     var data1 = json.decode(response.data);
  //     print("data: $data1");
  //     return data1;
  //   } on DioError catch (e) {
  //     print(e.response!.data);
  //     return e.response!.data;
  //   }
  // }

  // Future<dynamic> anotherOtp(String otp, String deviceId, String userId) async {
  //   // print(VERIFY_OTP_URL + userId);
  //   try {
  //     Response response = await _dio.post(RESEND_OTP_URL + userId,
  //         data: {'otp': otp, 'deviceId': deviceId},
  //         options: Options(responseType: ResponseType.plain));
  //     var data1 = json.decode(response.data);
  //     print("data: $data1");
  //     return data1;
  //   } on DioError catch (e) {
  //     print(e.response!.data);
  //     return e.response!.data;
  //   }
  // }

//   Future<dynamic> loginUser(
//       String email, String deviceId, String password) async {
//     try {
//       Response response = await _dio.post(LOGIN_URL,
//           data: {'email': email, 'deviceId': deviceId, 'password': password},
//           options: Options(responseType: ResponseType.plain));
//       var data1 = json.decode(response.data);
//       return data1;
//     } on DioError catch (e) {
//       print(e.response!.data);
//       return e.response!.data;
//     }
//   }
// }
