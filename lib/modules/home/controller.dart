import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/models/user.dart';
import 'package:getx_example/data/repositories/users.dart';
import 'package:getx_example/data/services/auth_service.dart';

class HomeController extends GetxController with StateMixin<List<User>> {
  HomeController({required this.usersRepository});
  final UsersRepository usersRepository;

  var page = 1.obs;
  late PageController pageController;

  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateUsers();

    pageController = PageController(initialPage: 1);
  }

  void updateUsers() async {
    change([], status: RxStatus.loading());
    change(await usersRepository.getUsers(), status: RxStatus.success());
  }

  void logout() {
    Get.find<AuthService>().logout();
    Get.offAndToNamed('/login');
  }
}
