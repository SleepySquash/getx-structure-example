import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/service/auth.dart';

export 'view.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

class AuthController extends GetxController {
  final TextEditingController usernameEditingController =
      TextEditingController();

  @override
  void onReady() {
    super.onReady();

    if (Get.find<AuthService>().state != null) {
      Get.offAndToNamed('/');
    }
  }

  void submit() {
    if (usernameEditingController.text.isNotEmpty) {
      Get.find<AuthService>().login(usernameEditingController.text);
    }
  }
}
