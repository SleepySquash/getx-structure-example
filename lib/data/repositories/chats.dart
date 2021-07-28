import 'dart:convert';

import '../models/message.dart';
import '../models/chat.dart';
import '../providers/graphql.dart';

class ChatsRepository {
  const ChatsRepository({required this.graphqlProvider});

  final GraphQlProvider graphqlProvider;

  getChats(String id) async {
    Map<String, dynamic> chats =
        json.decode(await graphqlProvider.queryChats(id));

    return (chats['data'] as List)
        .map((e) => Chat(
              title: e['title'],
              lastMessage: Message(body: e['lastMessage'], from: '123'),
            ))
        .toList();
  }
}
