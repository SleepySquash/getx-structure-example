import 'dart:convert';

import '../models/message.dart';
import '../providers/graphql.dart';

class MessagesRepository {
  const MessagesRepository({required this.graphqlProvider});

  final GraphQlProvider graphqlProvider;

  getMessages(String chatId) async {
    Map<String, dynamic> messages =
        json.decode(await graphqlProvider.queryMessages(chatId));

    return (messages['data'] as List)
        .map((e) => Message(from: e['from'], body: e['body']))
        .toList();
  }

  sendMessage(Message message) async {
    var response = json.decode(await graphqlProvider.sendMessage(
        body: message.body, from: message.from));
    return response != null;
  }
}
