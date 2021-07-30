import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../../provider/graphql.dart';

class AuthService extends GetxController with StateMixin<User?> {
  AuthService(this.graphQlProvider, this.sharedPreferences);
  final GraphQlProvider graphQlProvider;
  final SharedPreferences sharedPreferences;

  Future<void> init() async {
    final token = Get.find<SharedPreferences>().getString('token');
    if (token == null) {
      change(null, status: RxStatus.empty());
    } else {
      var response = json.decode(await graphQlProvider.verifyToken(token));
      if (response['token'] == null) {
        change(null, status: RxStatus.empty());
      } else {
        change(
          User(
            UserId(response['user']['id']),
            UserName(response['user']['username']),
          ),
          status: RxStatus.success(),
        );
      }
    }
  }

  void login(String username) async {
    change(null, status: RxStatus.loading());

    final response = json.decode(await graphQlProvider.auth(username));

    if (response['token'] == null) {
      return change(null, status: RxStatus.error('Auth failed'));
    }

    Get.find<SharedPreferences>().setString('token', response['token']);
    change(
      User(
        UserId(response['user']['id']),
        UserName(response['user']['username']),
      ),
      status: RxStatus.success(),
    );
    Get.offAndToNamed('/');
  }

  void logout() async {
    change(null, status: RxStatus.empty());
    Get.find<SharedPreferences>().remove('token');
    Get.offAndToNamed('/login');
  }
}
