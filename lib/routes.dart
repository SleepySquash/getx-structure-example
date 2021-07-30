import 'package:get/get.dart';

import 'ui/page/auth/controller.dart';
import 'ui/page/home/controller.dart';

final routes = [
  GetPage(
    name: '/',
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/login',
    page: () => const AuthView(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: '/chat/:id',
    page: () => const HomeView(),
    binding: HomeBinding(true),
  ),
  GetPage(
    name: '/profile/:id',
    page: () => const HomeView(),
    binding: HomeBinding(true),
  ),
];
