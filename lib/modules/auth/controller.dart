import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/services/auth_service.dart';

class AuthController extends GetxController {
  final TextEditingController controller = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    ever(Get.find<AuthService>().username, (_) {
      if (Get.find<AuthService>().username.value != null) {
        Get.offAndToNamed('home');
      }
    });
  }

  void submit() {
    if (controller.text.isNotEmpty) {
      Get.find<AuthService>().login(controller.text);
    }
  }
}
