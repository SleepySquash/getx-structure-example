import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../provider/graphql.dart';
import '../../../domain/model/user.dart';
import '../../../domain/service/auth.dart';
import '../../../store/user.dart';
import '../../../store/message.dart';
import '../../../store/chat.dart';
import 'chats/controller.dart';
import 'contacts/controller.dart';

import '../../../helper/html_io.dart'
    if (dart.library.js) '../../../helper/html_web.dart';

export 'view.dart';

class HomeBinding implements Bindings {
  HomeBinding([this.listenToRoute = false]);
  late bool listenToRoute;

  @override
  void dependencies() {
    Get.put(UserRepository(Get.find<GraphQlProvider>()));
    Get.put(MessageRepository(Get.find<GraphQlProvider>()));
    Get.put(ChatRepository(Get.find<GraphQlProvider>()));

    ChatsBinding().dependencies();
    ContactsBinding().dependencies();

    Get.put(HomeController(Get.find(), listenToRoute));
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  MyNavigatorObserver({required this.routeStack});
  List<Route<dynamic>> routeStack;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Future.delayed(Duration.zero, () {
      routeStack.add(route);
      HtmlHelper.pushState(null, '/#/', '#${route.settings.name}');
    });
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Future.delayed(Duration.zero, () {
      routeStack.removeLast();
      HtmlHelper.pushState(null, '/#/', '#${previousRoute!.settings.name}');
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
      HtmlHelper.pushState(null, '/#/', '#${oldRoute!.settings.name}');
      if (newRoute != null) {
        routeStack.add(newRoute);
        HtmlHelper.pushState(null, '/#/', '#${newRoute.settings.name}');
      }
    });
  }
}

class HomeController extends GetxController with StateMixin<List<User>> {
  HomeController(this.userRepository, [this.listenToRoute = false]);
  final UserRepository userRepository;

  final bool listenToRoute;
  late final String initialRoute;

  var routeStack = <Route<dynamic>>[].obs;
  late MyNavigatorObserver observer;

  var page = 1.obs;
  var showNavigator = false.obs;
  var isMobile = false.obs;
  var navigatorStack = 0.obs;

  late PageController pageController;
  late TrackingScrollController scrollController;

  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();

    initialRoute = listenToRoute ? Get.currentRoute : '/';

    observer = MyNavigatorObserver(routeStack: routeStack);
    pageController = PageController(initialPage: 1, keepPage: true);
    scrollController = TrackingScrollController();
  }

  void logout() {
    Get.find<AuthService>().logout();
  }
}
