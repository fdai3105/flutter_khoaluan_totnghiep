import 'package:dio/dio.dart';
import '../../configs/configs.dart';
import '../resources.dart';

class OrderRepository {
  Future<Response> checkout(
      List<Cart> carts, String note, int addressID) async {
    final params = FormData();
    params.fields.add(MapEntry('note', note ?? ""));
    params.fields.add(MapEntry('address_id', addressID.toString()));
    for (var i = 0; i < carts.length; i++) {
      final item = carts[i];
      params.fields
        ..add(
          MapEntry('products[$i]', item.product.id.toString()),
        )
        ..add(
          MapEntry('products_quantity[$i]', item.quantity.toString()),
        );
    }
    try {
      final data = await DioService(withToken: true).post(
        AppEndpoint.checkout,
        data: params,
      );
      return data;
    } on DioError catch (e) {
      print(e.message);
      return e.response;
    }
  }

  Future<Response> getOrders() async {
    try {
      final data = await DioService(withToken: true).get(AppEndpoint.getOrders);
      return data;
    } on DioError catch (e) {
      print(e.response);
      return e.response;
    }
  }

  Future<Response> getOrderDetail(int id) async {
    try {
      final data =
          await DioService(withToken: true).get(AppEndpoint.getOrderDetail);
      return data;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> cancelOrder(int id) async {
    final param = FormData.fromMap({'id': id});
    try {
      final data = await DioService(withToken: true)
          .post(AppEndpoint.cancelOrder, data: param);
      return data;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
