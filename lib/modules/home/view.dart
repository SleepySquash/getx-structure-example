import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/modules/profile/module.dart';

import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      controller.isMobile.value = (constraints.maxWidth < 500);

      final navigation = Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/',
        observers: [controller.observer],
        onGenerateRoute: (RouteSettings settings) {
          HomeController controller = Get.find();

          if (settings.name == '/') {
            return GetPageRoute(
              routeName: '/',
              page: () => Obx(
                () => controller.isMobile.value
                    ? const Scaffold(
                        backgroundColor: Colors.transparent,
                      )
                    : const Scaffold(
                        body: Center(
                          child: Text('123'),
                        ),
                      ),
              ),
            );
          }

          if (settings.name!.startsWith('/profile/')) {
            final id = settings.name!.replaceAll('/profile/', '');

            return GetPageRoute(
              routeName: '/profile/$id',
              page: () => ProfileView(id, key: ValueKey(id)),
            );
          }
        },
      );

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
                    onTap: () => Get.toNamed('/profile/${e.id}', id: 1),
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

      final navigatorObx = Obx(
        () => IgnorePointer(
          ignoring: controller.routeStack.length == 1,
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: controller.isMobile.value
                        ? 0
                        : constraints.maxWidth * 0.4),
                child: Container(),
              ),
              Expanded(child: navigation),
            ],
          ),
        ),
      );

      return Stack(
        children: [
          Container(child: controller.isMobile.value ? null : navigatorObx),
          sideBar,
          Container(child: controller.isMobile.value ? navigatorObx : null),
        ],
      );
    });
  }
}
