import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts".tr)),
      body: controller.obx(
        (users) => ListView(
          children: users!
              .map((e) => ListTile(
                    title: Text(e.username),
                    subtitle: const Text('status...',
                        overflow: TextOverflow.ellipsis),
                    leading: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
                    ),
                    onTap: () => Get.offNamedUntil(
                        '/profile/${e.id}', ModalRoute.withName('/'),
                        id: 1),
                  ))
              .toList(),
        ),
        onEmpty: const Center(child: Text('No users')),
      ),
    );
  }
}
