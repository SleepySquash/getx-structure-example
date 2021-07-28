import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/graphql.dart';
import '../../../data/repositories/messages.dart';

import 'controller.dart';

class ChatView extends StatelessWidget {
  const ChatView(this.id, {Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(context) {
    return GetBuilder<ChatController>(
      init: ChatController(
        id: id,
        messagesRepository:
            MessagesRepository(graphqlProvider: GraphQlProvider()),
      ),
      tag: id,
      builder: (_) {
        return Obx(
          () => _.messages.value == null
              ? const Scaffold(body: Center(child: CircularProgressIndicator()))
              : Scaffold(
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
                  body: ListView(
                    children: _.messages.value!
                        .map(
                          (e) => Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade200,
                              ),
                              margin: EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(
                                  e.from,
                                  style: Get.textTheme.caption,
                                ),
                                subtitle: Text(
                                  e.body,
                                  style: Get.textTheme.bodyText2,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Write your message'.tr),
                              onFieldSubmitted: (s) {},
                            ),
                          ),
                          const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
