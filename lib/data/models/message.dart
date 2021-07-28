class Message {
  const Message({required this.from, required this.body, this.attachments});

  final String from;
  final String body;
  final List<String>? attachments;
}
