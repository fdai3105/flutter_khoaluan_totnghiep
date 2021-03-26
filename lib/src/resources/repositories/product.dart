import 'package:dio/dio.dart';
import '../resources.dart';
import '../../configs/configs.dart';

class ProductResponse {
  Future<Response> getProducts(int page) async {
    try {
      final params = {
        'page': page ?? 1,
      };
      final products =
          DioService().get(AppEndpoint.getProducts, queryParameters: params);
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

  Future<Response> getProductsByParentCategory(int parentId) async {
    try {
      final products = await DioService()
          .get('${AppEndpoint.getProductsInParentCategory}$parentId');
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getProductsByCategory(int categoryId) async {
    try {
      final products = await DioService()
          .get('${AppEndpoint.getProductsByCategory}/$categoryId');
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
