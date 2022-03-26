import 'package:dio/dio.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/common/utility/interceptor/auth_info_interceptor.dart';
import 'package:tv_shows/common/utility/interceptor/error_extractor_interceptor.dart';
import 'package:tv_shows/domain/data_holder/auth_info_holder.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';

import '../../common/utility/auth_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(AuthInfoHolder authInfoHolder) : _authInfoHolder = authInfoHolder {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://tv-shows.infinum.academy',
      ),
    );

    final authInfoHolder = AuthInfoHolder();

    final authInfoInterceptor = AuthInfoInterceptor(authInfoHolder);
    final errorExtractorInterceptor = ErrorExtractorInterceptor();

    _dio.interceptors.addAll([
      authInfoInterceptor,
      errorExtractorInterceptor,
    ]);
  }

  final AuthInfoHolder _authInfoHolder;
  late final Dio _dio;

  @override
  Future<User> loginUser(String email, String password) async {
    final response = await _dio.post(
      '/users/sign_in',
      data: {
        'email': email,
        'password': password,
      },
    );

    _authInfoHolder.authInfo = AuthInfo.fromHeaderMap(response.headers.map);

    final json = response.data['user'];

    return User.fromJson(json);
  }

  @override
  Future<User> registerUser(String email, String password) async {
    final response = await _dio.post(
      '/users',
      data: {
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );

    _authInfoHolder.authInfo = AuthInfo.fromHeaderMap(response.headers.map);

    final json = response.data['user'];

    return User.fromJson(json);
  }
}
