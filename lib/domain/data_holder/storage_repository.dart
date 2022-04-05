import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tv_shows/common/utility/auth_info.dart';

class StorageRepository {
  StorageRepository() : _secureStorage = const FlutterSecureStorage();

  static const _accessToken = 'accessToken';
  static const _client = 'client';
  static const _tokenType = 'tokenType';
  static const _uid = 'uid';

  AuthInfo? _authInfo;
  late final FlutterSecureStorage _secureStorage;

  set authInfo(value) {
    _authInfo = value;

    if (value != null) {
      _secureStorage.write(key: _accessToken, value: _authInfo?.accessToken);
      _secureStorage.write(key: _client, value: _authInfo?.client);
      _secureStorage.write(key: _tokenType, value: _authInfo?.tokenType);
      _secureStorage.write(key: _uid, value: _authInfo?.uid);
    }
  }

  Future<AuthInfo?> get authInfo async {
    if (_authInfo != null) {
      return _authInfo;
    } else {
      final accessToken = await _secureStorage.read(key: _accessToken);
      final client = await _secureStorage.read(key: _client);
      final tokenType = await _secureStorage.read(key: _tokenType);
      final uid = await _secureStorage.read(key: _uid);

      if (accessToken != null &&
          accessToken.isNotEmpty &&
          client != null &&
          client.isNotEmpty &&
          tokenType != null &&
          tokenType.isNotEmpty &&
          uid != null &&
          uid.isNotEmpty) {
        _authInfo = AuthInfo(accessToken: accessToken, client: client, tokenType: tokenType, uid: uid);
        return _authInfo;
      }
    }

    return null;
  }

  Future<void> deleteUserData() async {
    await _secureStorage.deleteAll();
    _authInfo = null;
  }
}
