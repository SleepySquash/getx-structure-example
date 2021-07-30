import '../model/chat.dart';
import '../../provider/graphql.dart';

abstract class AbstractChatRepository {
  const AbstractChatRepository(this.graphqlProvider);
  final GraphQlProvider graphqlProvider;

  Future<List<Chat>?> getChats(String id) async {}
}
