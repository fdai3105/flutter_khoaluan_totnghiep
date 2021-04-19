import 'package:dio/dio.dart';
import '../resources.dart';
import '../../configs/configs.dart';

class ProductResponse {
  Future<Response> getProduct(int id) async {
    try {
      final products = DioService().get(AppEndpoint.getProduct + id.toString());
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

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

  Future<Response> getSale() async {
    try {
      final products = DioService().get(AppEndpoint.getSaleProducts);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getProductsByParentCategory(int parentId) async {
    try {
      final products = await DioService()
          .get(AppEndpoint.getProductsByParentCategory + parentId.toString());
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

  Future<Response> getCommentsByProduct(int productId) async {
    try {
      final products = await DioService()
          .get(AppEndpoint.getCommentsByProduct + productId.toString());
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getRatingsByProduct(int productId) async {
    try {
      final products = await DioService()
          .get(AppEndpoint.getRatingByProduct + productId.toString());
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> searchProduct(
    String keyWord, {
    String sortPrice,
    String sortName,
  }) async {
    final params = {
      'name': keyWord,
      'sort-price': sortPrice,
      'sort-name': sortName,
    };
    try {
      final products = await DioService()
          .get(AppEndpoint.searchProduct, queryParameters: params);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
