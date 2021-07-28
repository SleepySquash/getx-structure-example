import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/graphql.dart';

class AuthService extends GetxController with StateMixin<String> {
  AuthService({required this.graphQlProvider});

  final GraphQlProvider graphQlProvider;

  var username = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();

    _initService();
  }

  void _initService() async {
    while (!Get.isRegistered<SharedPreferences>()) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    username.value = Get.find<SharedPreferences>().getString('username');
    (username.value != null)
        ? {
            change(await graphQlProvider.auth(username.value!),
                status: RxStatus.success()),
            Get.offAndToNamed('/home')
          }
        : change('', status: RxStatus.empty());

    ever(
      username,
      (value) => value != null
          ? Get.offAndToNamed('/home')
          : Get.offAndToNamed('/login'),
    );
  }

  void login(String username) async {
    change('', status: RxStatus.loading());
    final result = await graphQlProvider.auth(username);
    if (result != null) {
      Get.find<SharedPreferences>().setString('username', username);
      change('', status: RxStatus.success());
      this.username.value = username;
    } else {
      change('', status: RxStatus.error('Auth failed'));
    }
  }

  void logout() async {
    change('', status: RxStatus.empty());
    Get.find<SharedPreferences>().remove('username');
    username.value = null;
  }
}
