import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import '../../configs/configs.dart';

class DioService extends DioForNative {
  DioService({BaseOptions options}) : super(options) {
    interceptors.add(
      InterceptorsWrapper(
        onRequest: _request,
        onResponse: _response,
        onError: _error,
      ),
    );
  }

  RequestOptions _request(RequestOptions options) {
    options
      ..connectTimeout = 120 * 1000 // 2 minute
      ..receiveTimeout = 120 * 1000 // 2 minute
      ..baseUrl = AppEndpoint.base;
    return options;
  }

  Response _response(Response response) {
    return response;
  }

  DioError _error(DioError error) {
    return error;
  }
}
