// Mocks generated by Mockito 5.1.0 from annotations
// in tv_shows/test/login_screen_provider_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:io' as _i5;
import 'dart:ui' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_shows/common/models/user.dart' as _i2;
import 'package:tv_shows/source_remote/auth/auth_repository.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUser_0 extends _i1.Fake implements _i2.User {}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set user(_i2.User? _user) =>
      super.noSuchMethod(Invocation.setter(#user, _user),
          returnValueForMissingStub: null);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i4.Future<void> fetchUserFromHive() =>
      (super.noSuchMethod(Invocation.method(#fetchUserFromHive, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.User> loginUser(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#loginUser, [email, password]),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i4.Future<_i2.User>);
  @override
  _i4.Future<_i2.User> registerUser(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#registerUser, [email, password]),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i4.Future<_i2.User>);
  @override
  _i4.Future<_i2.User> updateUser(String? email, {_i5.File? imageFile}) =>
      (super.noSuchMethod(
              Invocation.method(#updateUser, [email], {#imageFile: imageFile}),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i4.Future<_i2.User>);
  @override
  _i4.Future<void> logoutUser() =>
      (super.noSuchMethod(Invocation.method(#logoutUser, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
