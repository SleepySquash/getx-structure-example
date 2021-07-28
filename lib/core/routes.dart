import 'package:get/get.dart';

import '../modules/auth/module.dart';
import '../modules/home/module.dart';
import 'middlewares.dart';

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
