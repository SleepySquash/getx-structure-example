import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/services/auth.dart';

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

    if (authService!.user.value != null) {
      page?.parameters?['user.id'] = authService!.user.value!.id;
    }
    return page;
  }
}
