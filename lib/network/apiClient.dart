// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import '../models/register_model.dart';
import '../models/login_model.dart';
import '../models/otp_verification_model.dart';
import 'package:dio/dio.dart';
import 'package:health_management_app/network/end_point.dart';

import '../models/resend_otp_model.dart';

class DioClient {
  late Dio _dio;
  ApiClient() {
    _dio = getApiClient();
  }

  Dio getApiClient() {
    Dio _dio = Dio();

    _dio.options = BaseOptions(connectTimeout: 50000, receiveTimeout: 50000);
    _dio.interceptors.clear();
    // _dio.options.headers["content-type"] = "application/json";
    // _dio.options.headers["accept"] = "application/json";
    _dio.options.baseUrl = BASE_URL;
    return _dio;
  }

  var user_id;
  var device_id;

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    Dio _dio = getApiClient();
    var response = await _dio.post(LOGIN_URL, data: loginRequestModel.toJson());
    return LoginResponseModel.fromJson(response.data);
  }

  Future<RegisterResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    Dio _dio = getApiClient();
    var response =
        await _dio.post(REGISTER_URL, data: registerRequestModel.toJson());
    return RegisterResponseModel.fromJson(response.data);
  }

  Future<OtpResponseModel> verifyOtp(
      OtpRequestModel otpRequestModel, String userId) async {
    Dio _dio = getApiClient();

    var response = await _dio.post(VERIFY_OTP_URL + userId,
        data: otpRequestModel.toJson(),
        options: Options(responseType: ResponseType.plain));
    return OtpResponseModel.fromJson(json.decode(response.data));
  }

  Future<ReSendOtpResponseModel> reSendOtp(
      ReSendOtpRequestModel resendOtpRequestModel) async {
    Dio _dio = getApiClient();
    var response =
        await _dio.post(RESEND_OTP_URL, data: resendOtpRequestModel.toJson());
    return ReSendOtpResponseModel.fromJson(response.data);
  }
}
