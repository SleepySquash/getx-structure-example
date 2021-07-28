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
    return '''
    {
        "user": {"id": "${uuid.v1()}", "username": "$username"},
        "token": "123"
    }
    ''';
  }

  verifyToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return '''
    {
        "user": {"id": "${uuid.v1()}", "username": "123"},
        "token": "123"
    }
    ''';
  }

  queryMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return '''
    {
      "data": [
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"}
      ]
    }
    ''';
  }

  sendMessage({required String from, required String body}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  queryChats(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return '''
    {
      "data": [
        {"title": "Chat", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"title": "kirill", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."},
        {"title": "vasya", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"title": "Arnold Alois Schwarzenegger", "lastMessage": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"title": "tyoma", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"title": "Some chat", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"}
      ]
    }
    ''';
  }
}
