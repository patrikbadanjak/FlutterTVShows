import 'package:tv_shows/source_remote/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> loginUser(String email, String password) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => true,
    );
  }

  @override
  Future<bool> registerUser(String email, String password) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => true,
    );
  }
}
