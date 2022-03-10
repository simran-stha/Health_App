import 'package:dio/dio.dart';
import 'package:health_management_app/models/login_model.dart';

import 'end_point.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
  Future<LoginResponseModel> login(LoginModel userInfo) async {
    Response response = await _dio.post(LOGIN_URL,
        data: userInfo.toJson(),
        options: Options(responseType: ResponseType.plain));
    return LoginResponseModel.fromJson(response.data);
  }
}
