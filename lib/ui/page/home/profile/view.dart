import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../store/user.dart';
import 'controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView(this.id, {Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(Get.find<UserRepository>(), id),
      tag: id,
      builder: (_) {
        return Obx(
          () => _.user.value == null
              ? const Scaffold(body: Center(child: CircularProgressIndicator()))
              : Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        leading: IconButton(
                          onPressed: () => Get.back(id: 1),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.6,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.passthrough,
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                'https://picsum.photos/900/500/?blur',
                                fit: BoxFit.cover,
                              ),
                              Image.network(
                                'https://picsum.photos/900/500',
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            Align(
                              alignment: Alignment.center,
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    ListTile(
                                      title: Text(
                                        _.user.value!.username.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      trailing: const Icon(Icons.edit),
                                    ),
                                    const ListTile(title: Text('dev')),
                                    const Divider(thickness: 2),
                                    ListTile(
                                      title: SelectableText(
                                          _.user.value!.id.value),
                                      subtitle: const Text('Gapopa ID'),
                                    ),
                                    const Divider(thickness: 2),
                                    ListTile(
                                      title: Text('Write a message'.tr),
                                      leading: const Icon(Icons.message),
                                    ),
                                    ListTile(
                                      title: Text('Audio call'.tr),
                                      leading: const Icon(Icons.call),
                                    ),
                                    ListTile(
                                      title: Text('Video call'.tr),
                                      leading: const Icon(Icons.video_call),
                                    ),
                                    const Divider(thickness: 2),
                                    ListTile(
                                      title: Text('Remove from contacts'.tr),
                                      leading: const Icon(Icons.contact_page),
                                    ),
                                    ListTile(
                                      title: Text('Remove from favorites'.tr),
                                      leading: const Icon(Icons.star_outline),
                                    ),
                                    const Divider(thickness: 2),
                                    ListTile(
                                      title: Text('Create group'.tr),
                                      leading: const Icon(Icons.group),
                                    ),
                                    const Divider(thickness: 2),
                                    ListTile(
                                      title: Text('Mute user'.tr),
                                      leading:
                                          const Icon(Icons.disabled_by_default),
                                    ),
                                    ListTile(
                                      title: Text('Block user'.tr),
                                      leading: const Icon(Icons.block),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
