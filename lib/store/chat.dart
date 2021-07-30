import 'dart:convert';

import '../domain/repository/chat.dart';
import '../domain/model/chat.dart';
import '../domain/model/message.dart';
import '../provider/graphql.dart';

class ChatRepository implements AbstractChatRepository {
  const ChatRepository(this.graphqlProvider);

  @override
  final GraphQlProvider graphqlProvider;

  @override
  Future<List<Chat>?> getChats(String id) async {
    Map<String, dynamic> chats =
        json.decode(await graphqlProvider.queryChats(id));

    return (chats['data'] as List)
        .map((e) => Chat(
              ChatId(e['id']),
              ChatTitle(e['title']),
              Message(
                const MessageFrom('123'),
                MessageBody(e['body']),
              ),
            ))
        .toList();
  }
}
