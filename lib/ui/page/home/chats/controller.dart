import 'package:get/get.dart';
import 'package:getx_example/domain/service/auth.dart';

import '../../../../domain/model/chat.dart';
import '../../../../store/chat.dart';

export 'view.dart';

class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatsController(Get.find()));
  }
}

class ChatsController extends GetxController with StateMixin<List<Chat>> {
  ChatsController(this.chatRepository);
  final ChatRepository chatRepository;

  @override
  void onReady() {
    super.onReady();
    fetchChats();
  }

  void fetchChats() async {
    change(null, status: RxStatus.loading());
    change(
      await chatRepository.getChats(Get.find<AuthService>().value!.id.value),
      status: RxStatus.success(),
    );
  }
}
