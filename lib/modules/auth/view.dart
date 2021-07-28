import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth.dart';
import 'controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Get.find<AuthService>().obx(
        (username) => Container(),
        onEmpty: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Auth'),
            TextFormField(
              controller: controller.controller,
              decoration: const InputDecoration(
                hintText: 'Username',
                icon: Icon(Icons.person),
              ),
            ),
            TextButton(
              onPressed: () => controller.submit(),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
