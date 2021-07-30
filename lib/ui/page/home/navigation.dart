import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'chat/controller.dart';
import 'profile/controller.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final navigation = Navigator(
      key: Get.nestedKey(1),
      initialRoute: controller.initialRoute,
      observers: [controller.observer],
      onGenerateRoute: (RouteSettings settings) {
        HomeController controller = Get.find();

        if (settings.name == '/') {
          return GetPageRoute(
            settings: const RouteSettings(name: '/'),
            page: () => Obx(
              () => controller.isMobile.value
                  ? const Scaffold(
                      backgroundColor: Colors.transparent,
                    )
                  : Scaffold(
                      body: Center(
                        child: Text('Choose a chat or a user'.tr),
                      ),
                    ),
            ),
          );
        }

        if (settings.name!.startsWith('/profile/')) {
          final id = settings.name!.replaceAll('/profile/', '');

          return GetPageRoute(
            settings: RouteSettings(name: '/profile/$id'),
            page: () => ProfileView(id, key: ValueKey(id)),
          );
        }

        if (settings.name!.startsWith('/chat/')) {
          final id = settings.name!.replaceAll('/chat/', '');

          return GetPageRoute(
            settings: RouteSettings(name: '/chat/$id'),
            page: () => ChatView(id, key: ValueKey(id)),
          );
        }
      },
    );

    return Obx(
      () => IgnorePointer(
        ignoring: controller.routeStack.length == 1,
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: controller.isMobile.value
                        ? 0
                        : constraints.maxWidth > 860
                            ? 345
                            : constraints.maxWidth * 0.4),
                child: Container(),
              ),
              Expanded(child: navigation),
            ],
          );
        }),
      ),
    );
  }
}
