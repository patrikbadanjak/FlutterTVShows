import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/common/utility/state/request_state.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/ui/login_register/provider/register_screen_provider.dart';

import 'register_screen_provider_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  final authRepoMock = MockAuthRepository();
  final provider = RegisterScreenProvider(authRepoMock);

  when(
    authRepoMock.registerUser(
      argThat(isNotEmpty),
      argThat(isNotEmpty),
    ),
  ).thenAnswer(
    (_) async {
      return Future.delayed(
        const Duration(milliseconds: 10),
        () => User('1', 'user@example.com', null),
      );
    },
  );

  when(
    authRepoMock.registerUser(
      argThat(isNotEmpty),
      argThat(isEmpty),
    ),
  ).thenThrow(
    Exception('Invalid register info'),
  );

  group('Update email and password values', () {
    test('Set email to some value', () {
      provider.updateEmail('someone@example.com');
      expect(provider.email, 'someone@example.com');
    });

    test('Set password to some value', () {
      provider.updatePassword('some_password');
      expect(provider.password, 'some_password');
    });
  });

  group('Form submission', () {
    test('Set email and password values and submit the form', () async {
      provider.updateEmail('user@example.com');
      provider.updatePassword('some_password');

      await provider.onRegisterPressed();
      expect(provider.state is RequestStateSuccess, true);
    });

    test('Set email, but leave password empty and submit', () async {
      provider.updateEmail('user@example.com');
      provider.updatePassword('');

      await provider.onRegisterPressed();

      expect(provider.state is RequestStateFailure, true);
    });
  });
}
