import 'package:get/get.dart';

import '../../../../domain/model/message.dart';

import '../../../../store/message.dart';

export 'view.dart';

class ChatController extends GetxController {
  ChatController(this.messagesRepository, this.id);
  final MessageRepository messagesRepository;

  Rx<List<Message>?> messages = Rx<List<Message>?>(null);
  final String id;

  @override
  void onReady() {
    super.onReady();
    fetchMessages();
  }

  void fetchMessages() async =>
      messages.value = await messagesRepository.getMessages(id);
}
