import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authorized() = Authorized;
  const factory AuthState.unauthorized() = Unauthorized;
  factory AuthState.error([String? message]) = Error;
}