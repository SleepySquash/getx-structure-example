import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/bindings.dart';
import 'core/router.dart';

void main() {
  runApp(const SocialApp());
}

class SocialApp extends StatelessWidget {
  const SocialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      initialBinding: GlobalBinding(),
      defaultTransition: Transition.cupertino,
      getPages: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
