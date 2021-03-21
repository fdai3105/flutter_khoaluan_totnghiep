import 'package:dio/dio.dart';
import '../resources.dart';
import '../../configs/configs.dart';

class ProductResponse {
  Future<Response> getProducts() async {
    try {
      final products = DioService().get(AppEndpoint.getProducts);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getPopular() async {
    try {
      final products = DioService().get(AppEndpoint.getPopularProducts);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getNew() async {
    try {
      final products = DioService().get(AppEndpoint.getNewProducts);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
