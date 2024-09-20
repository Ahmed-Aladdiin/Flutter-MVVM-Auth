// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:client/core/providers/token_provider.dart';
import 'package:client/core/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:client/core/models/user_model.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository(
      userBox: Hive.box<UserModel>('auth_user'),
      tokenBox: Hive.box<String>('auth_token'),
      ref: ref);
}

class AuthLocalRepository {
  final Box<UserModel> _userBox;
  final Box<String> _tokenBox;
  final ProviderRef<AuthLocalRepository> _ref;

  AuthLocalRepository({
    required Box<UserModel> userBox,
    required Box<String> tokenBox,
    required ProviderRef<AuthLocalRepository> ref,
  })  : _userBox = userBox,
        _tokenBox = tokenBox,
        _ref = ref;

  String? getToken() {
    try {
      String? token = _tokenBox.get('token');
      _ref.read(tokenProvider.notifier).update((_) => token);
      return token;
    } catch (e) {
      debugPrint('error getting the token');
    }
    return null;
  }

  Future<void> setToken(String token) async {
    await _tokenBox.put('token', token);
    _ref.read(tokenProvider.notifier).update((_) => token);
  }

  Future<void> deleteToken() async {
    await _tokenBox.delete('token');
    _ref.read(tokenProvider.notifier).update((_) => null);
  }

  UserModel? getUser() {
    UserModel? user = _userBox.get('user');
    _ref.read(userProvider.notifier).update((_) => user);
    return user;
  }

  Future<void> setUser(UserModel user) async {
    await _userBox.put('user', user);
    _ref.read(userProvider.notifier).update((_) => user);
  }

  Future<void> deleteUser() async {
    await _userBox.delete('user');
    _ref.read(userProvider.notifier).update((_) => null);
  }
}
