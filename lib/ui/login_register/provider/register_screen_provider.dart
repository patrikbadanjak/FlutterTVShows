import 'dart:async';

import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';

import '../../../common/models/user.dart';

class RegisterScreenProvider extends RequestProvider<User> {
  RegisterScreenProvider(this._authRepository);

  final AuthRepository _authRepository;

  String _email = '';

  String get email => _email;

  String _password = '';

  String get password => _password;

  void updateEmail(String email) {
    _email = email.trim();
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password.trim();
    notifyListeners();
  }

  Future<void> onRegisterPressed() async {
    await executeRequest(
      requestBuilder: () async => await _authRepository.registerUser(_email, _password),
    );
  }
}
