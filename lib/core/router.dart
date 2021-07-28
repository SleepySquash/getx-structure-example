import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/services/auth_service.dart';

import '../modules/home/module.dart';
import '../modules/auth/module.dart';
import '../modules/profile/module.dart';

class AuthMiddleware extends GetMiddleware {
  AuthService? authService;

  @override
  RouteSettings? redirect(String? route) {
    authService ??= Get.find<AuthService>();

    return authService!.status.isSuccess || route == '/login'
        ? null
        : const RouteSettings(name: '/login');
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    authService ??= Get.find<AuthService>();

    if (authService!.username.value != null) {
      page?.parameters?['username'] = authService!.username.value!;
    }
    return page;
  }
}

final routes = [
  GetPage(
    name: '/home',
    page: () => const HomeView(),
    binding: HomeBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/login',
    page: () => const AuthView(),
    binding: AuthBinding(),
    middlewares: [AuthMiddleware()],
  ),
];
