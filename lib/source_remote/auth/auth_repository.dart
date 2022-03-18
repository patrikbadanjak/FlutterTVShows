abstract class AuthRepository {
  Future<bool> loginUser(String email, String password);
  Future<bool> registerUser(String email, String password);
}
