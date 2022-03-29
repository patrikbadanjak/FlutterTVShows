import 'package:tv_shows/common/models/user.dart';

abstract class LoginRegisterInteractor {
  Future<User> loginUser(String email, String password);
  Future<User> registerUser(String email, String password);
}
