import 'package:dio/dio.dart';
import 'package:tv_shows/domain/data_holder/auth_info_holder.dart';

class AuthInfoInterceptor extends Interceptor {
  AuthInfoInterceptor(AuthInfoHolder authInfoHolder) : _authInfoHolder = authInfoHolder;

  final AuthInfoHolder _authInfoHolder;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = _authInfoHolder.authInfo?.toHeaders();
    super.onRequest(options, handler);
  }
}
