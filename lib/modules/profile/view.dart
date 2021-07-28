import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/providers/graphql.dart';
import 'package:getx_example/data/repositories/users.dart';

import 'controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView(this.id, {Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(
        id: id,
        usersRepository: UsersRepository(graphqlProvider: GraphQlProvider()),
      ),
      tag: id,
      builder: (_) {
        return Obx(
          () => _.user.value == null
              ? const Scaffold(body: Center(child: CircularProgressIndicator()))
              : Scaffold(
                  appBar: AppBar(title: Text(_.user.value!.username)),
                  body: Center(child: Text('uuid: ${_.user.value!.id}'))),
        );
      },
    );
  }
}
