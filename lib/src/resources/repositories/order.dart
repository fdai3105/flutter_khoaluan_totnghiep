import 'package:dio/dio.dart';
import '../../configs/configs.dart';
import '../resources.dart';

class OrderRepository {
  Future<Response> checkout(Map<String,String> params) async {
    try {
      final data = await DioService().get(AppEndpoint.getParentCategories);
      return data;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getOrders() async{
    try {
      final data = await DioService().get(AppEndpoint.getParentCategories);
      return data;
    } on DioError catch (e) {
      return e.response;
    }
  }
}