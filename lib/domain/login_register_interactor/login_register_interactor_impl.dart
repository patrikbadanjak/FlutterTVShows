import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/source_remote/auth/auth_repository_impl.dart';

import 'login_register_interactor.dart';

class LoginRegisterInteractorImpl implements LoginRegisterInteractor {
  LoginRegisterInteractorImpl() : _authRepository = AuthRepositoryImpl();

  final AuthRepository _authRepository;

  @override
  Future<bool> loginUser(String email, String password) {
    return _authRepository.loginUser(email, password);
  }

  @override
  Future<bool> registerUser(String email, String password) {
    return _authRepository.registerUser(email, password);
  }
}
