import 'package:get/get.dart';
import 'package:getx_example/data/models/user.dart';
import 'package:getx_example/data/repositories/users.dart';

class ProfileController extends GetxController {
  ProfileController({required this.id, required this.usersRepository});
  final UsersRepository usersRepository;

  Rx<User?> user = Rx<User?>(null);
  final String id;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async => user.value = await usersRepository.getUser(id);
}
