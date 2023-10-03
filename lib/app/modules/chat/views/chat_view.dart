import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'dart:math' as math;
import '../../widgets/default_widget.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Positioned(
              top: 0,
              child: DefaultCountainer(
                width: Get.width,
                height: 60,
                color: Get.theme.colorScheme.primary,
                child: Center(
                    child: Text(
                  'محادثة',
                  style: Get.textTheme.titleLarge,
                )),
              )),
          Positioned(
              top: 0,
              right: 8,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Get.theme.colorScheme.secondary,
                ),
                onPressed: () async {
                  Get.back();
                },
              )),
          Positioned(
            top: 60,
            bottom: 60,
            child: DefaultCountainer(
              width: Get.width,
              // height: 200,
              height: Get.height - 100,
              child: Obx(() => controller.chats.isEmpty
                  ? Center(child: Text("لا توجد رسائل"))
                  : ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.chats.length,
                      itemBuilder: (context, index) {
                        final chat = controller.chats[index];
                        // Set your condition here
                        final isMe = chat.idEmp == null;
                        return Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              isMe
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.person),
                                    )
                                  : Container(),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    DefaultCountainer(
                                      //  width:double.,
                                      //     isMe ? Get.width - 50 : Get.width - 50,
                                      color: isMe
                                          ? Get.theme.colorScheme.secondary
                                          : Get.theme.colorScheme.primary,
                                      borderRadius: (8.0),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chat.containt!,
                                            style: TextStyle(
                                              color: isMe
                                                  ? Get
                                                      .theme.colorScheme.primary
                                                  : Get.theme.colorScheme
                                                      .secondary,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //  chat.isRecive!
                                    //           ? const Align(
                                    //               alignment: Alignment.bottomLeft,
                                    //               child:  Icon(
                                    //                 Icons.check,
                                    //                 color: Colors.black,
                                    //               ),
                                    //             )
                                    //           : chat.id == -99
                                    //               ? const LinearProgressIndicator()
                                    //               : Container(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    chat.id == -99
                                        ? const SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator())
                                        : Container()
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              isMe
                                  ? Container()
                                  : const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.admin_panel_settings,
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        );
                      },
                    )),
            ),
          ),
          Positioned(
              bottom: 70,
              right: 10,
              child: Obx(() => controller.isNewMassage.value
                  ? IconButton(
                      onPressed: () {
                        controller.isNewMassage.value = false;
                        controller.scrollController.animateTo(
                            controller
                                .scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        // weight: 30,
                        size: 40,
                        color: Get.theme.colorScheme.primary,
                      ),
                    )
                  : Container())),
          Positioned(
              bottom: 0,
              child: DefaultCountainer(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                height: 60,
                child: Row(children: [
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Obx(() => IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: !controller.isenableMessage.value
                                ? null
                                : () {
                                    if (controller.inputChat!.containt !=
                                        null) {
                                      controller.chats
                                          .add(controller.inputChat!);
                                      controller.streamChat
                                          .add(controller.inputChat!);
                                      controller.scrollToIndex(
                                          controller.chats.length - 1);

                                      controller.textController.clear();
                                      controller.isenableMessage.value = false;
                                    }
                                  },
                          ))),
                  Expanded(
                      child: DefaultTextFormField(
                    controller: controller.textController,
                    isborderall: false,
                    onchange: (value) {
                      if (value.isEmpty) {
                        controller.inputChat!.containt = value;
                        controller.isenableMessage.value = false;
                      } else {
                        controller.inputChat!.containt = value;

                        controller.isenableMessage.value = true;
                      }
                    },
                  )),
                ]),
              ))
        ],
      ),
    ));
  }
}
