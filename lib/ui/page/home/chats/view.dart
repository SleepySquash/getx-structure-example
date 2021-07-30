import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats".tr)),
      body: controller.obx(
        (chats) => chats!.isEmpty
            ? Center(child: Text('No chats yet'.tr))
            : ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(chats[index].title.value),
                  subtitle: Text(
                    chats[index].lastMessage.body.value,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  onTap: () => Get.offNamedUntil(
                    '/chat/${chats[index].id.value}',
                    ModalRoute.withName('/'),
                    id: 1,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: controller.fetchChats,
      ),
    );
  }
}
