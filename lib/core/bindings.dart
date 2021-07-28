import 'package:get/get.dart';
import 'package:getx_example/data/providers/graphql.dart';
import 'package:getx_example/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance(),
      permanent: true,
    );
    Get.put(
      AuthService(graphQlProvider: GraphQlProvider()),
      permanent: true,
    );
  }
}
