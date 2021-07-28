import 'package:get/get.dart';
import 'package:getx_example/data/providers/graphql.dart';
import 'package:getx_example/data/repositories/users.dart';

import 'controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        usersRepository: UsersRepository(graphqlProvider: GraphQlProvider())));
  }
}
