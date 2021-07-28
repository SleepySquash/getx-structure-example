import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/modules/profile/module.dart';

import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (i) => controller.page.value = i,
        children: [
          const Text('Contacts'),
          controller.obx(
            (users) => ListView(
              children: users!
                  .map((e) => ListTile(
                        title: Text(e.username),
                        onTap: () => Get.toNamed('/profile/${e.id}'),
                      ))
                  .toList(),
            ),
            onEmpty: const Center(child: Text('No users')),
          ),
          const Text('Menu'),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          ],
          currentIndex: controller.page.value,
          onTap: (i) => controller.pageController.jumpToPage(i),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: controller.updateUsers,
      ),
    );
  }
}
