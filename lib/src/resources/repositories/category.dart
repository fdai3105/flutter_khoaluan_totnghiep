import 'package:dio/dio.dart';
import '../../configs/configs.dart';
import '../resources.dart';

class CategoryResponse {
  Future<Response> getParentCategories() async {
    try {
      final data = await DioService().get(AppEndpoint.getParentCategories);
      return data;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getSubCategories(int id) async {
    try {
      final data =
          await DioService().get('${AppEndpoint.getSubCategories}/$id');
      return data;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
