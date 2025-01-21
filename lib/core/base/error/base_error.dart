import 'package:flutter/material.dart';

@immutable
abstract class BaseError extends Error {
  final String message;
  final String? code;
  @override
  final StackTrace? stackTrace;

  BaseError(this.message, {this.code, this.stackTrace});

  @override
  String toString() => 'Error: $message${code != null ? ' (Code: $code)' : ''}';
}

class NetworkError extends BaseError {
  NetworkError(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}

class CacheError extends BaseError {
  CacheError(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}

class AuthError extends BaseError {
  AuthError(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}

class ValidationError extends BaseError {
  ValidationError(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}
