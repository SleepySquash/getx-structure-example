import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/models/user.dart';
import 'package:getx_example/data/repositories/users.dart';
import 'package:getx_example/data/services/auth.dart';

class MyNavigatorObserver extends NavigatorObserver {
  MyNavigatorObserver({required this.routeStack});
  List<Route<dynamic>> routeStack;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Future.delayed(Duration.zero, () {
      routeStack.add(route);
    });
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Future.delayed(Duration.zero, () {
      routeStack.removeLast();
    });
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    Future.delayed(Duration.zero, () {
      routeStack.removeLast();
    });
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    Future.delayed(Duration.zero, () {
      routeStack.removeLast();
      if (newRoute != null) routeStack.add(newRoute);
    });
  }
}

class HomeController extends GetxController with StateMixin<List<User>> {
  HomeController({required this.usersRepository});
  final UsersRepository usersRepository;

  var routeStack = <Route<dynamic>>[].obs;
  late MyNavigatorObserver observer;

  var page = 1.obs;
  var showNavigator = false.obs;
  var isMobile = false.obs;
  var navigatorStack = 0.obs;

  late PageController pageController;

  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateUsers();

    observer = MyNavigatorObserver(routeStack: routeStack);
    pageController = PageController(initialPage: 1, keepPage: true);
  }

  void updateUsers() async {
    change([], status: RxStatus.loading());
    change(await usersRepository.getUsers(), status: RxStatus.success());
  }

  void logout() {
    Get.find<AuthService>().logout();
    Get.offAndToNamed('/login');
  }
}
