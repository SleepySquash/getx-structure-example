import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView(this.id, {Key? key}) : super(key: key);

  final String id;

  @override
  String? get tag => id;

  @override
  Widget build(context) {
    Widget sendField = Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.transparent,
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.face,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {}),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type Something...",
                          hintStyle: TextStyle(color: Colors.blueAccent),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_camera,
                        color: Colors.blueAccent),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.attach_file, color: Colors.blueAccent),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
                color: Colors.blueAccent, shape: BoxShape.circle),
            child: InkWell(
              child: const Icon(
                Icons.keyboard_voice,
                color: Colors.white,
              ),
              onLongPress: () {},
            ),
          )
        ],
      ),
    );

    return GetBuilder<ChatController>(
      init: ChatController(Get.find(), id),
      tag: id,
      builder: (_) {
        return Stack(
          children: [
            // В Chrome в дебаге выдаёт "Expected a value of type 'SkDeletable', but got one of type 'Null'"
            // В любом другом браузере такой ошибке нет. Если запустить в release или profile, то ошибка и в хроме исчезает.
            // https://stackoverflow.com/questions/66531192/expected-a-value-of-type-skdeletable-but-got-one-of-type-null
            const Positioned.fill(
              child: Image(
                image: Svg('assets/images/bg-gapopa.svg'),
                repeat: ImageRepeat.repeat,
              ),
            ),
            Obx(
              () => controller.messages.value == null
                  ? const Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(child: CircularProgressIndicator()))
                  : Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        title: Text(id),
                        actions: [
                          TextButton(
                            child: const CircleAvatar(),
                            onPressed: () => Get.toNamed(
                              '/profile/$id',
                              id: 1,
                            ),
                          )
                        ],
                      ),
                      body: Stack(
                        children: [
                          Scrollbar(
                            child: ListView(
                              children: controller.messages.value!
                                  .map(
                                    (e) => Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Get.theme.colorScheme.surface,
                                        ),
                                        margin: const EdgeInsets.all(5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                e.from.value,
                                                style: Get.textTheme.caption,
                                              ),
                                              SelectableText(
                                                e.body.value,
                                                style: Get.textTheme.bodyText2,
                                              ),
                                              Text(
                                                '10:00',
                                                style: Get.textTheme.caption,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()
                                    ..add(const Align(
                                        child: SizedBox(height: 71))),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [sendField],
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
