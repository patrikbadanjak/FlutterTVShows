import 'dart:io';

import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/ui/shows/provider/user_provider.dart';

import '../../../common/models/user.dart';

class UserProfileScreenProvider extends RequestProvider<void> {
  UserProfileScreenProvider(this._authRepository, this.userProvider);

  final AuthRepository _authRepository;
  final UserProvider userProvider;

  String _updatedEmail = '';

  String get updatedEmail {
    if (_updatedEmail.isEmpty) {
      return userProvider.user!.email;
    }

    return _updatedEmail;
  }

  User? get user => userProvider.user;

  set updatedEmail(String value) => _updatedEmail = value;

  File? _temporaryImageFile;

  File? get temporaryImageFile => _temporaryImageFile;

  set temporaryImageFile(File? value) {
    _temporaryImageFile = value;
    notifyListeners();
  }

  Future<void> onUpdatePressed() async {
    await executeRequest(
      requestBuilder: () async {
        await _authRepository
            .updateUser(
              updatedEmail,
              imageFile: _temporaryImageFile,
            )
            .then((updatedUser) => userProvider.user = updatedUser);
      },
    );
  }

  Future<void> onLogoutPressed() async {
    executeRequest(
      requestBuilder: () async {
        await _authRepository.logoutUser();
      },
    );
  }
}
