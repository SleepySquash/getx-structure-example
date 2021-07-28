import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/modules/home/navigation.dart';

import 'profile/module.dart';

import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      controller.isMobile.value = (constraints.maxWidth < 500);

      final navigationBar = Obx(
        () => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          ],
          currentIndex: controller.page.value,
          onTap: (i) => controller.pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ),
        ),
      );

      const contactsPage = Text('Contacts');
      final chatsPage = controller.obx(
        (users) => ListView(
          children: users!
              .map((e) => ListTile(
                    title: Text(e.username),
                    onTap: () => Get.offNamedUntil(
                        '/profile/${e.id}', ModalRoute.withName('/'),
                        id: 1),
                  ))
              .toList(),
        ),
        onEmpty: const Center(child: Text('No users')),
      );
      const menuPage = Text('Menu');

      final sideBar = ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: controller.isMobile.value
                ? constraints.maxWidth
                : constraints.maxWidth * 0.4),
        child: Scaffold(
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
              contactsPage,
              chatsPage,
              menuPage,
            ],
          ),
          bottomNavigationBar: navigationBar,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: controller.updateUsers,
          ),
        ),
      );

      return Stack(
        children: [
          Container(
              child: controller.isMobile.value
                  ? null
                  : Navigation(controller: controller)),
          sideBar,
          Container(
              child: controller.isMobile.value
                  ? Navigation(controller: controller)
                  : null),
        ],
      );
    });
  }
}
