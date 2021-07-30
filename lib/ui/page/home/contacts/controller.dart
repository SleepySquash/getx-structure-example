import 'package:get/get.dart';
import 'package:getx_example/domain/service/auth.dart';

import '../../../../domain/model/user.dart';
import '../../../../store/user.dart';

export 'view.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ContactsController(Get.find()));
  }
}

class ContactsController extends GetxController with StateMixin<List<User>> {
  ContactsController(this.userRepository);
  final UserRepository userRepository;

  @override
  void onReady() {
    super.onReady();
    fetchUsers();
  }

  void fetchUsers() async {
    change(null, status: RxStatus.loading());
    change(
      await userRepository.getUsers(Get.find<AuthService>().value!.id.value),
      status: RxStatus.success(),
    );
  }
}
