import 'dart:io';

import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';

class UserProfileScreenProvider extends RequestProvider<void> {
  UserProfileScreenProvider(this._authRepository) {
    user = _authRepository.user;
  }

  final AuthRepository _authRepository;

  String _updatedEmail = '';

  String get updatedEmail {
    if (_updatedEmail.isEmpty) {
      return user!.email;
    }

    return _updatedEmail;
  }

  set updatedEmail(String value) => _updatedEmail = value;

  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  File? _temporaryImageFile;

  File? get temporaryImageFile => _temporaryImageFile;

  set temporaryImageFile(File? value) {
    _temporaryImageFile = value;
    notifyListeners();
  }

  Future<void> onUpdatePressed() async {
    executeRequest(
      requestBuilder: () async {
        await _authRepository
            .updateUser(
              updatedEmail,
              imageFile: _temporaryImageFile,
            )
            .then((updatedUser) => user = updatedUser);
      },
    );
  }

  Future<void> onLogoutPressed() async {
    executeRequest(
      requestBuilder: () async {
        user = null;
        await _authRepository.logoutUser();
      },
    );
  }
}
