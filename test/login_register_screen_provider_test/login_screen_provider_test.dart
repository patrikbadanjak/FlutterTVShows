import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/common/utility/state/request_state.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/ui/login_register/provider/login_screen_provider.dart';

import 'login_screen_provider_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  final authRepoMock = MockAuthRepository();
  final loginProvider = LoginScreenProvider(authRepoMock);

  when(authRepoMock.loginUser(argThat(isNotEmpty), argThat(isNotEmpty))).thenAnswer(
    (_) async {
      return Future.delayed(
        const Duration(milliseconds: 500),
        () => User('1', 'user@example.com', null),
      );
    },
  );

  when(authRepoMock.loginUser(argThat(isNotEmpty), argThat(isEmpty))).thenThrow(Exception('Invalid login info'));

  group('Update email and password values', () {
    test('Set email to some value', () {
      loginProvider.updateEmail('someone@example.com');
      expect(loginProvider.email, 'someone@example.com');
    });

    test('Set password to some value', () {
      loginProvider.updatePassword('some_password');
      expect(loginProvider.password, 'some_password');
    });
  });

  group('Form submission', () {
    test('Set email and password values and submit the form', () async {
      loginProvider.updateEmail('user@example.com');
      loginProvider.updatePassword('some_password');

      await loginProvider.onLoginPressed();
      expect(loginProvider.state is RequestStateSuccess, true);
    });

    test('Set email, but leave password empty and submit', () async {
      loginProvider.updateEmail('user@example.com');
      loginProvider.updatePassword('');

      await loginProvider.onLoginPressed();

      expect(loginProvider.state is RequestStateFailure, true);
    });

    test('Loading state while waiting for response', () async {
      loginProvider.updateEmail('user@example.com');
      loginProvider.updatePassword('some_password');

      loginProvider.onLoginPressed();
      expect(loginProvider.state is RequestStateLoading, true);
    });
  });
}
