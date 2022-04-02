import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/common/utility/interceptor/error_extractor_interceptor.dart';
import 'package:tv_shows/domain/data_holder/storage_repository.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';

import '../../common/utility/auth_info.dart';
import '../../common/utility/interceptor/auth_info_interceptor.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(StorageRepository authInfoHolder) : _authInfoHolder = authInfoHolder {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://tv-shows.infinum.academy',
      ),
    );

    final authInfoInterceptor = AuthInfoInterceptor(authInfoHolder);
    final errorExtractorInterceptor = ErrorExtractorInterceptor();

    _dio.interceptors.addAll([
      authInfoInterceptor,
      errorExtractorInterceptor,
    ]);
  }

  final StorageRepository _authInfoHolder;
  late final Dio _dio;

  Future<void> _storeUserToHive(User user) async {
    final box = await Hive.openBox('user');
    box.put('id', user.id);
    box.put('email', user.email);
    box.put('imageUrl', user.imageUrl);
  }

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

    final User user = User.fromJson(json);

    await _storeUserToHive(user);

    return user;
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

    final User user = User.fromJson(json);

    await _storeUserToHive(user);

    return user;
  }
}
