import 'package:get/get.dart';

import '../../../data/models/message.dart';
import '../../../data/repositories/messages.dart';

class ChatController extends GetxController {
  ChatController({required this.id, required this.messagesRepository});
  final MessagesRepository messagesRepository;

  Rx<List<Message>?> messages = Rx<List<Message>?>(null);
  final String id;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  void fetchMessages() async =>
      messages.value = await messagesRepository.getMessages(id);
}
