import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';

import 'login_register_interactor.dart';

class LoginRegisterInteractorImpl implements LoginRegisterInteractor {
  LoginRegisterInteractorImpl(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<User> loginUser(String email, String password) async {
    return await _authRepository.loginUser(email, password);
  }

  @override
  Future<User> registerUser(String email, String password) async {
    return await _authRepository.registerUser(email, password);
  }
}
