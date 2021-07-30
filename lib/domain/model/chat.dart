import 'message.dart';

class Chat {
  const Chat(this.id, this.title, this.lastMessage);

  final ChatId id;
  final ChatTitle title;
  final Message lastMessage;
}

class ChatId {
  const ChatId(this.value);
  final String value;
}

class ChatTitle {
  const ChatTitle(this.value);
  final String value;
}
