import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ContactsView extends GetView<ContactsController> {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts".tr)),
      body: controller.obx(
        (users) => users!.isEmpty
            ? const Center(child: Text('No contacts yet'))
            : ListView(
                children: users
                    .map((e) => Slidable(
                          actionPane: const SlidableScrollActionPane(),
                          actions: [
                            IconSlideAction(
                              caption: 'Favorite'.tr,
                              foregroundColor: Colors.orange[900],
                              color: Colors.yellow,
                              icon: Icons.favorite,
                            ),
                            IconSlideAction(
                              caption: 'Mute'.tr,
                              foregroundColor: Colors.white,
                              color: Colors.blue,
                              icon: Icons.notifications_off,
                            )
                          ],
                          child: ListTile(
                            title: Text(e.username.value),
                            subtitle: const Text('status...',
                                overflow: TextOverflow.ellipsis),
                            leading: const CircleAvatar(
                              backgroundImage:
                                  NetworkImage('https://picsum.photos/200'),
                            ),
                            onTap: () => Get.offNamedUntil(
                              '/profile/${e.id.value}',
                              ModalRoute.withName('/'),
                              id: 1,
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
