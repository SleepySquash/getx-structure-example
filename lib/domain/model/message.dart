class Message {
  const Message(this.from, this.body, [this.attachments]);

  final MessageFrom from;
  final MessageBody body;
  final MessageAttachments? attachments;
}

class MessageFrom {
  const MessageFrom(this.value);
  final String value;
}

class MessageBody {
  const MessageBody(this.value);
  final String value;
}

class MessageAttachments {
  const MessageAttachments(this.value);
  final List<String> value;
}
