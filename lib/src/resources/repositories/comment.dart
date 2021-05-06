// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import '../../configs/configs.dart';
import '../resources.dart';

class CommentResponse {
  Future<Response> getComments(int productID) async {
    try {
      final products = await DioService()
          .get(AppEndpoint.getCommentsByProduct + productID.toString());
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> addComment(int productID, String comment) async {
    final params = FormData.fromMap({
      'product_id': productID,
      'comment': comment,
    });
    try {
      final products = await DioService(withToken: true)
          .post(AppEndpoint.comment, data: params);
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> deleteComment(int id) async {
    try {
      final products = await DioService(withToken: true)
          .delete('${AppEndpoint.comment}/$id');
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> editComment(int id, String comment) async {
    final param = FormData.fromMap({'_method': 'PATCH', 'com': comment});
    try {
      final products = await DioService(withToken: true).post(
        '${AppEndpoint.comment}/$id',
        data: param,
      );
      return products;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
