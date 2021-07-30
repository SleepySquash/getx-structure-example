import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/_l10n.dart';
import 'bindings.dart';
import 'routes.dart';
import 'domain/service/auth.dart';
import 'provider/graphql.dart';

Future<void> main() async {
  // Provider
  GraphQlProvider graphQlProvider = Get.put(GraphQlProvider());

  WidgetsFlutterBinding.ensureInitialized();

  // Service
  SharedPreferences sharedPreferences = await Get.putAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
    permanent: true,
  );

  await Get.put(
    AuthService(graphQlProvider, sharedPreferences),
    permanent: true,
  ).init();

  runApp(const SocialApp());
}

class SocialApp extends StatelessWidget {
  const SocialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      initialBinding: ApplicationBinding(),
      defaultTransition: Transition.cupertino,
      getPages: routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      locale: AppTranslation.locales[AppTranslation.locale],
      translationsKeys: AppTranslation.translations,
      debugShowCheckedModeBanner: false,
    );
  }
}
