import 'package:uuid/uuid.dart';

class GraphQlProvider {
  final Uuid uuid = const Uuid();

  Future<String> queryUsers(String id) async {
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

  Future<String> queryUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return '''
    {
        "user": {"id": "$id", "username": "${uuid.v1()}"}
    }
    ''';
  }

  Future<String> auth(String username) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return '''
    {
        "user": {"id": "${uuid.v1()}", "username": "$username"},
        "token": "123"
    }
    ''';
  }

  Future<String> verifyToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return '''
    {
        "user": {"id": "${uuid.v1()}", "username": "123"},
        "token": "123"
    }
    ''';
  }

  Future<String> queryMessages(String chatId) async {
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
        {"from": "${uuid.v4()}", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
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

  Future<String> sendMessage(
      {required String from, required String body}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return '''
    {
      "status": "ok"
    }
    ''';
  }

  Future<String> queryChats(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return '''
    {
      "data": [
        {"id": "${uuid.v4()}", "title": "Chat", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"id": "${uuid.v4()}", "title": "kirill", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."},
        {"id": "${uuid.v4()}", "title": "vasya", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"id": "${uuid.v4()}", "title": "Arnold Alois Schwarzenegger", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"id": "${uuid.v4()}", "title": "tyoma", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"},
        {"id": "${uuid.v4()}", "title": "Some chat", "body": "Lorem Ipsum is simply dummy text of the printing and typesetting industry"}
      ]
    }
    ''';
  }
}
