import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../providers/graphql.dart';

class AuthService extends GetxController with StateMixin<String> {
  AuthService({required this.graphQlProvider});

  final GraphQlProvider graphQlProvider;

  var user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();

    _initService();
  }

  void _initService() async {
    while (!Get.isRegistered<SharedPreferences>()) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    final token = Get.find<SharedPreferences>().getString('token');
    if (token != null) {
      var response = json.decode(await graphQlProvider.verifyToken(token));
      if (response['token'] == null) {
        change('', status: RxStatus.empty());
      } else {
        user.value = User(
          username: response['user']['username'],
          id: response['user']['id'],
        );
        change('', status: RxStatus.success());
        Get.offAndToNamed('/home');
      }

      Get.offAndToNamed('/home');
    } else {
      change('', status: RxStatus.empty());
    }

    ever(
      user,
      (value) => value != null
          ? Get.offAndToNamed('/home')
          : Get.offAndToNamed('/login'),
    );
  }

  void login(String username) async {
    change('', status: RxStatus.loading());

    final response = json.decode(await graphQlProvider.auth(username));

    if (response['token'] == null) {
      return change('', status: RxStatus.error('Auth failed'));
    }

    Get.find<SharedPreferences>().setString('token', response['token']);
    change('', status: RxStatus.success());
    user.value = User(
      username: response['user']['username'],
      id: response['user']['id'],
    );
  }

  void logout() async {
    change('', status: RxStatus.empty());
    Get.find<SharedPreferences>().remove('token');
    user.value = null;
  }
}
