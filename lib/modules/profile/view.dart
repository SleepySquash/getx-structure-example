import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Obx(() {
      return controller.user.value == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(title: Text(controller.user.value!.username)),
              body: Center(child: Text('uuid: ${controller.user.value!.id}')));
    });
  }
}
