import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../../configs/configs.dart';
import '../../utils/utils.dart';

class DioService extends DioForNative {
  final bool withToken;

  DioService({BaseOptions options, this.withToken = false}) : super(options) {
    interceptors.add(
      InterceptorsWrapper(
        onRequest: _request,
        onResponse: _response,
        onError: _error,
      ),
    );
  }

  void _request(RequestOptions options, RequestInterceptorHandler handler) {
    options
      ..connectTimeout = 120 * 1000 // 2 minute
      ..receiveTimeout = 120 * 1000 // 2 minute
      ..baseUrl = AppEndpoint.base
      ..headers = {
        'accept': 'application/json',
        'authorization': !withToken ? '' : 'Bearer ${SharedPref.getToken()}',
      };
    handler.next(options);
  }

  void _response(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  void _error(DioError error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }
}
