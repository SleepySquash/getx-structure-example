import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats".tr)),
      body: controller.obx(
        (users) => ListView(
          children: users!
              .map((e) => ListTile(
                    title: Text(e.username),
                    subtitle: const Text(
                        'Placeholder message message message message message message message message message...',
                        overflow: TextOverflow.ellipsis),
                    leading: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
                    ),
                    onTap: () => Get.offNamedUntil(
                      '/chat/${e.id}',
                      ModalRoute.withName('/'),
                      id: 1,
                    ),
                  ))
              .toList(),
        ),
        onEmpty: const Center(child: Text('No users')),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: controller.updateUsers,
      ),
    );
  }
}
