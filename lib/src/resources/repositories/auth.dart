import 'package:dio/dio.dart';
import '../../configs/constants/app_endpoint.dart';
import '../../configs/configs.dart';
import '../resources.dart';
import '../models/models.dart';

class AuthRepository {
  Future<Response> login(String email, String password) async {
    try {
      final params = FormData.fromMap({
        'email': email,
        'password': password,
      });
      final response = await DioService().post(AppEndpoint.login, data: params);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> forgotPassword(String email) async {
    try {
      final params = FormData.fromMap({
        'email': email,
      });
      final response =
          await DioService().post(AppEndpoint.forgotPassword, data: params);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<User> register(String name, String email, String phone,
      String password, int gender) async {
    try {
      final params = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'gender': gender,
      });
      final response =
          await DioService().post(AppEndpoint.register, data: params);
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else if (response.statusCode == 422) {
        print(response.data['message']);
        return null;
      }
    } on DioError catch (e) {
      print(e.response.data['message']);
      return null;
    }
  }
}
