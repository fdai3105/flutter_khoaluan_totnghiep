import 'package:dio/dio.dart';
import '../../configs/configs.dart';
import '../resources.dart';

class CategoryResponse {
  Future<Response> getCategories() async {
    try {
      final data = await DioService().get(AppEndpoint.getCategories);
      return data;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
