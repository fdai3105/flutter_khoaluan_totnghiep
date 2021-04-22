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

  Future<Response> getPopular(int page) async {
    try {
      final params = {
        'page': page ?? 1,
      };
      final products = DioService()
          .get(AppEndpoint.getPopularProducts, queryParameters: params);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getNew(int page) async {
    try {
      final params = {
        'page': page ?? 1,
      };
      final products =
          DioService().get(AppEndpoint.getNewProducts, queryParameters: params);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getSale(int page) async {
    final params = {
      'page': page ?? 1,
    };
    try {
      final products = DioService()
          .get(AppEndpoint.getSaleProducts, queryParameters: params);
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

  Future<Response> getCommentsByProduct(int productID) async {
    try {
      final products = await DioService()
          .get(AppEndpoint.getCommentsByProduct + productID.toString());
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getRatingsByProduct(int productID) async {
    try {
      final products = await DioService()
          .get(AppEndpoint.getRatingByProduct + productID.toString());
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

  Future<Response> getSimilarProducts(int productID) async {
    try {
      final products = await DioService()
          .get(AppEndpoint.getSimilarProducts + productID.toString());
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
