import 'package:get/get.dart';
import 'package:getx_example/data/providers/graphql.dart';
import 'package:getx_example/data/repositories/users.dart';

import 'controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(
        usersRepository: UsersRepository(
          graphqlProvider: GraphQlProvider(),
        ),
      ),
    );
  }
}
