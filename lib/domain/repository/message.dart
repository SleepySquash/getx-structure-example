import 'dart:convert';

import '../model/message.dart';
import '../../provider/graphql.dart';

class AbstractMessageRepository {
  const AbstractMessageRepository({required this.graphqlProvider});
  final GraphQlProvider graphqlProvider;

  Future<List<Message>?> getMessages(String chatId) async {}
  Future<bool> sendMessage(Message message) async => false;
}
