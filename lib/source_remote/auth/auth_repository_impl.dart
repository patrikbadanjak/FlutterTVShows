import 'package:tv_shows/source_remote/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> loginUser(String email, String password) async {
    Future.delayed(
      const Duration(seconds: 2),
      () => true,
    );
    throw Exception('Failed to login user');
  }

  @override
  Future<bool> registerUser(String email, String password) async {
    Future.delayed(
      const Duration(seconds: 2),
      () => true,
    );
    throw Exception('Failed to register user.');
  }
}
