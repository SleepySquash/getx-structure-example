import 'dart:convert';

import '../domain/repository/message.dart';
import '../domain/model/message.dart';
import '../../provider/graphql.dart';

class MessageRepository implements AbstractMessageRepository {
  const MessageRepository(this.graphqlProvider);

  @override
  final GraphQlProvider graphqlProvider;

  @override
  Future<List<Message>?> getMessages(String chatId) async {
    Map<String, dynamic> messages =
        json.decode(await graphqlProvider.queryMessages(chatId));

    return (messages['data'] as List)
        .map((e) => Message(MessageFrom(e['from']), MessageBody(e['body'])))
        .toList();
  }

  @override
  Future<bool> sendMessage(Message message) async {
    var response = json.decode(await graphqlProvider.sendMessage(
        body: message.body.value, from: message.from.value));
    return response != null;
  }
}
