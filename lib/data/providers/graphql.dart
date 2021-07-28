import 'dart:io';

import 'package:uuid/uuid.dart';

class GraphQlProvider {
  final HttpClient httpClient = HttpClient();
  final Uuid uuid = const Uuid();

  queryUsers() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return '''
    {
      "data": [
        {"id": "${uuid.v4()}", "username": "vasya"},
        {"id": "${uuid.v4()}", "username": "dima"},
        {"id": "${uuid.v4()}", "username": "kirill"},
        {"id": "${uuid.v4()}", "username": "tyoma"},
        {"id": "${uuid.v4()}", "username": "Arnold Alois Schwarzenegger"}
      ]
    }
    ''';
  }

  queryUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return '''
    {
        "user": {"id": "$id", "username": "${uuid.v1()}"}
    }
    ''';
  }

  auth(String username) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final token = username;
    return token;
  }
}
