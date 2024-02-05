import 'package:flutter/cupertino.dart';


class ServerException implements Exception {
  final int? code;
  final String? message;

  ServerException(data, {
    this.code = 404,
    this.message = 'Could not process your request at the moment.',
  });

  @override
  String toString() {
    debugPrint(message);
    return super.toString();
  }
}