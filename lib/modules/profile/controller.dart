import 'package:get/get.dart';
import 'package:getx_example/data/models/user.dart';
import 'package:getx_example/data/repositories/users.dart';

class ProfileController extends GetxController {
  ProfileController({required this.usersRepository});
  final UsersRepository usersRepository;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async =>
      user.value = await usersRepository.getUser(Get.parameters['id']!);
}
