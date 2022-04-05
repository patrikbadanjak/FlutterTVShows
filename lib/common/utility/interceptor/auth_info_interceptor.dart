import 'package:dio/dio.dart';
import 'package:tv_shows/domain/data_holder/storage_repository.dart';

class AuthInfoInterceptor extends Interceptor {
  AuthInfoInterceptor(StorageRepository authInfoHolder) : _authInfoHolder = authInfoHolder;

  final StorageRepository _authInfoHolder;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authInfo = await _authInfoHolder.authInfo;

    if (authInfo != null) {
      options.headers.addAll(authInfo.toHeaders().cast());
    }

    super.onRequest(options, handler);
  }
}
