import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/common/utility/interceptor/error_extractor_interceptor.dart';
import 'package:tv_shows/domain/data_holder/storage_repository.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';

import '../../common/utility/auth_info.dart';
import '../../common/utility/interceptor/auth_info_interceptor.dart';

class AuthRepositoryImpl with ChangeNotifier implements AuthRepository {
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

    fetchUserFromHive();
  }

  @override
  User? user;

  final StorageRepository _authInfoHolder;
  late final Dio _dio;

  Future<void> _storeUserToHive(User user) async {
    final box = await Hive.openBox('user');
    box.put('id', user.id);
    box.put('email', user.email);
    box.put('imageUrl', user.imageUrl);
  }

  @override
  Future<void> fetchUserFromHive() async {
    try {
      final box = await Hive.openBox('user');
      user = User(
        box.get('id'),
        box.get('email'),
        box.get('imageUrl') as String?,
      );
    } on Exception catch (e) {
      user = null;
    }
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

    user = User.fromJson(json);

    await _storeUserToHive(user!);

    return user!;
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

    user = User.fromJson(json);

    await _storeUserToHive(user!);

    return user!;
  }

  @override
  Future<User> updateUser(String email, {File? imageFile}) async {
    Response<dynamic> response;

    if (imageFile != null) {
      final String fileName = imageFile.path.split('/').last;
      final formData = FormData.fromMap({
        'email': email,
        'image': await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      response = await _dio.put(
        '/users',
        data: formData,
      );
    } else {
      response = await _dio.put(
        '/users',
        data: {
          'email': email,
        },
      );
    }

    _authInfoHolder.authInfo = AuthInfo.fromHeaderMap(response.headers.map);

    final json = response.data['user'];

    user = User.fromJson(json);

    await _storeUserToHive(user!);

    notifyListeners();

    return user!;
  }

  @override
  Future<void> logoutUser() async {
    _deleteUserDataFromDevice();
  }

  Future<void> _deleteUserDataFromDevice() async {
    await Hive.deleteBoxFromDisk('user');
    _authInfoHolder.deleteUserData();
    user = null;
  }
}
