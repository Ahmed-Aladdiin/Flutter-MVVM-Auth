import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  @override
  AsyncValue<String?>? build() {
    return null;
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    // search for a stored token
    final token = ref.read(authLocalRepositoryProvider).getToken();
    // if not found, go to log in screen
    if (token == null) {
      state = const AsyncValue.data(null);
      debugPrint('Go to login screen');
      return;
    }
    // else, get the user data online
    final res = await ref.read(authRemoteRepositoryProvider).getUser();
    // if getting the data online didn't work
    // get the locally stored data
    res.match((l) async {
      state = AsyncValue.error(l.error, StackTrace.current);
      debugPrint('Entered Here');
      final user = ref.read(authLocalRepositoryProvider).getUser();
      if (user != null) {
        state = const AsyncValue.data('success');
      } else {
        state = const AsyncValue.data(null);
      }
    }, (_) => state = const AsyncValue.data('success'));
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await ref.read(authRemoteRepositoryProvider).signUp(
          name: name,
          email: email,
          password: password,
        );
    // check if the operation is successful or not
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.error, StackTrace.current),
      Right(value: final msg) => state = AsyncValue.data(msg),
    };

    debugPrint(val.toString());
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    // log in
    final res = await ref
        .read(authRemoteRepositoryProvider)
        .logIn(email: email, password: password);
    // deal with the returned value
    res.match(
      (l) => state = AsyncValue.error(l.error, StackTrace.current),
      (r) => state = const AsyncValue.data(''),
    );

    debugPrint(res.toString());
  }

  Future<void> logOut() async {
    state = const AsyncValue.loading();
    // delete the stored user data
    await ref.read(authLocalRepositoryProvider).deleteToken();
    await ref.read(authLocalRepositoryProvider).deleteUser();
    // set the state data to null to stay in the log in screen
    state = const AsyncValue.data(null);
  }
}
