import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth.dart';

class AuthController extends GetxController {
  final TextEditingController controller = TextEditingController();

  void submit() {
    if (controller.text.isNotEmpty) {
      Get.find<AuthService>().login(controller.text);
    }
  }
}
