import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../l10n/_l10n.dart';
import '../../../../domain/service/auth.dart';

import '../controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu'.tr)),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          ListTile(
            title: Text('Your profile'.tr),
            leading: const CircleAvatar(),
            onTap: () => Get.offNamedUntil(
              // ignore: invalid_use_of_protected_member
              '/profile/${Get.find<AuthService>().value!.id.value}',
              ModalRoute.withName('/'),
              id: 1,
            ),
          ),
          const Divider(thickness: 2),
          ListTile(
            title: Text('Settings'.tr),
            leading: const Icon(Icons.settings),
          ),
          ExpandablePanel(
            header: ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppTranslation.languages[AppTranslation.locale]!),
            ),
            collapsed: Container(),
            expanded: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: AppTranslation.languages.entries
                    .map((e) => ListTile(
                        leading: const Icon(Icons.flag),
                        title: Text(e.value),
                        onTap: () {
                          Get.updateLocale(AppTranslation.locales[e.key]!);
                          AppTranslation.locale = e.key;
                        }))
                    .toList(),
              ),
            ),
          ),
          const Divider(thickness: 2),
          ListTile(
            title: Text('Privacy'.tr),
            leading: const Icon(Icons.privacy_tip),
          ),
          ListTile(
            title: Text('Terms of use'.tr),
            leading: const Icon(Icons.data_usage),
          ),
          ListTile(
            title: Text('Report a problem'.tr),
            leading: const Icon(Icons.report),
          ),
          const Divider(thickness: 2),
          ListTile(
            title: Text('Logout'.tr),
            leading: const Icon(Icons.logout),
            onTap: () => Get.find<HomeController>().logout(),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.light_mode,
                color: Colors.orange,
              ),
              ObxValue(
                (data) => Switch(
                  value: (data as Rx<bool>).value,
                  onChanged: (flag) {
                    data.value = flag;
                    Get.changeThemeMode(
                        flag ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
                Get.isDarkMode.obs,
              ),
              const Icon(Icons.dark_mode),
            ],
          )
        ],
      ),
    );
  }
}
