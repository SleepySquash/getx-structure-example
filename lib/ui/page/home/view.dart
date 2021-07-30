import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contacts/view.dart';
import 'controller.dart';
import 'chats/controller.dart';
import 'menu/menu.dart';
import 'navigation.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      controller.isMobile.value = (constraints.maxWidth < 500);

      final navigationBar = Obx(
        () => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.contacts), label: 'Contacts'.tr),
            BottomNavigationBarItem(
                icon: const Icon(Icons.message), label: 'Messages'.tr),
            BottomNavigationBarItem(
                icon: const Icon(Icons.menu), label: 'Menu'.tr),
          ],
          currentIndex: controller.page.value,
          onTap: (i) => controller.pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ),
        ),
      );

      final sideBar = ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: controller.isMobile.value
                ? constraints.maxWidth
                : constraints.maxWidth > 860
                    ? 345
                    : constraints.maxWidth * 0.4),
        child: Scaffold(
          body: PageView(
            controller: controller.pageController,
            onPageChanged: (i) => controller.page.value = i,
            children: [
              const ContactsView(),
              const ChatsView(),
              const MenuScreen(),
            ],
          ),
          bottomNavigationBar: navigationBar,
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
