import 'dart:io';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/models/app_error.dart';
import 'package:client/core/models/user_model.dart';
import 'package:client/core/providers/token_provider.dart';
import 'package:client/features/auth/models/log_in_response_model.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository(ref, Dio(BASE_OPTIONS));
}

class AuthRemoteRepository {
  final ProviderRef<AuthRemoteRepository> _ref;
  final Dio _dio;

  AuthRemoteRepository(this._ref, this._dio);

  Future<Either<AppError, String>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dio.post('/auth/sign-up', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      final details = res.data['details'];
      if (res.statusCode != 201) {
        return Left(AppError(details));
      }

      return Right(details);
    } on DioException catch (dioException) {
      String? details;
      if (dioException.response != null) {
        details = (dioException.response!.data)['details'];
        debugPrint(details);
      } else if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.connectionError ||
          dioException.type == DioExceptionType.unknown) {
        details = 'Couldn\'t connect to the server, check your internet connection.';
        debugPrint('Server is not reachable: ${dioException.message}');
        // Handle server not reachable error
      } else {
        details = 'Unhandled Dio Exception';
        debugPrint(details);
        debugPrint('here ${dioException.type}');
      }
      return Left(AppError(details ?? 'Unexpected server error.'));
    } catch (e) {
      debugPrint('Sign Up error:\n${e.toString()}');
      return Left(AppError('Couldn\'t sign up now. Please, try again later.'));
    }
  }

  Future<Either<AppError, void>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dio
          .post('/auth/log-in', data: {"email": email, "password": password});

      if (res.statusCode != 200) {
        final String details = res.data['details'] ?? 'Unexpected Error';
        return Left(AppError(details));
      }

      final resData =
          LogInResponseModel.fromJson(res.data as Map<String, dynamic>);

      await _ref.read(authLocalRepositoryProvider).setToken(resData.token);
      await _ref.read(authLocalRepositoryProvider).setUser(resData.user);
      debugPrint(res.data.toString());
      return const Right(null);
    } on DioException catch (dioException) {
      String? details;
      if (dioException.response != null) {
        details = (dioException.response!.data)['details'];
        debugPrint(details);
      } else if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.connectionError ||
          dioException.type == DioExceptionType.unknown) {
        details = 'Couldn\'t connect to the server, check your internet connection.';
        debugPrint('Server is not reachable: ${dioException.message}');
        // Handle server not reachable error
      } else {
        details = 'Unhandled Dio Exception';
        debugPrint(details);
        debugPrint('here ${dioException.type}');
      }
      return Left(AppError(details ?? 'Unexpected server error.'));
    } catch (e) {
      debugPrint('Log in error:\n${e.toString()}');
      return Left(AppError('Couldn\'t log in now. Please, try again later.'));
    }
  }

  Future<Either<AppError, UserModel>> getUser() async {
    final token = _ref.read(tokenProvider);
    debugPrint(token ?? '');
    try {
      final res = await _dio.get(
        '/auth/me',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );

      // todo: remove me
      debugPrint(res.data.toString());

      final user = UserModel.fromMap(res.data);
      _ref.read(authLocalRepositoryProvider).setUser(user);
      return Right(user);
    } on DioException catch (dioException) {
      String? details;
      if (dioException.response != null) {
        details = (dioException.response!.data)['details'];
        debugPrint(details);
      } else if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.connectionError ||
          dioException.type == DioExceptionType.unknown) {
        details = 'Couldn\'t connect to the server, check your internet connection.';
        debugPrint('Server is not reachable: ${dioException.message}');
        // Handle server not reachable error
      } else {
        details = 'Unhandled Dio Exception';
        debugPrint(details);
      }
      return Left(AppError(details ?? 'Unexpected server error.'));
    } catch (e) {
      debugPrint('Get user error:\n${e.toString()}');
      return Left(AppError('An error occurred while fetching user data'));
    }
  }
}
