import 'package:get/get.dart';

import '../../../../domain/model/user.dart';
import '../../../../store/user.dart';
export 'view.dart';

class ProfileController extends GetxController {
  ProfileController(this.usersRepository, this.id);
  final UserRepository usersRepository;

  Rx<User?> user = Rx<User?>(null);
  final String id;

  @override
  void onReady() {
    super.onReady();
    fetchUser();
  }

  void fetchUser() async => user.value = await usersRepository.getUser(id);
}
