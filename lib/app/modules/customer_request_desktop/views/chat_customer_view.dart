import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:projecttravelwin/app/models/basic/chat.dart';
import 'package:projecttravelwin/app/modules/widgets/default_widget.dart';
import 'package:projecttravelwin/app/modules/widgets/main_widget.dart';
import 'dart:math' as math;
import '../../widgets/main_widget_desktop.dart';
import '../controllers/cutomer_chat_controller.dart';

class ChatCustomerView extends GetView<CustomerChatController> {
  const ChatCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitleAppBarDesktop(
            title: "محادثة العملاء",
          ),
          iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
          centerTitle: true,
        ),
        body: Obx(() => controller.isLoading.value
            ? DefaultCircalProgress()
            : GetBuilder<CustomerChatController>(
                // init: MyController(),
                id: 'messageData',
                initState: (_) {},
                builder: (_) {
                  return Row(
                    children: [
                      DefaultCountainer(
                        width: Get.width * 0.3,
                        child: ListView.separated(
                          itemCount: controller.chats.length,
                          itemBuilder: (context, index) {
                            ChatData data = controller.chats[index];
                            return GestureDetector(
                              onTap: () async {
                                controller.selectChat = data;
                                controller.inputChat =
                                    Chat(idChat: data.idChat!);
                                controller.textController.clear();
                                // controller.inputChat = null;
                                controller.isenableMessage.value = false;
                                controller.updatacontaintMessage();

                                await controller.scrollToIndex();
                              },
                              child: GetBuilder<CustomerChatController>(
                                // init: MyController(),
                                id: 'conterMessage',
                                initState: (_) {},
                                builder: (_) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.chat,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    title: Text(
                                      data.nikName!,
                                      style: Get.textTheme.headlineMedium,
                                    ),
                                    trailing: Text(
                                      data.chats!.length.toString(),
                                      style: Get.textTheme.headlineMedium,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Get.theme.colorScheme.primary,
                            );
                          },
                        ),
                      ),
                      DefaultCountainer(
                          color: Colors.grey,
                          width: Get.width * 0.7,
                          child: GetBuilder<CustomerChatController>(
                            // init: MyController(),
                            id: 'containtMessage',
                            initState: (_) {},
                            builder: (_) {
                              return controller.selectChat == null
                                  ? Center(
                                      child: Text('اختيار بيانات'),
                                    )
                                  : Column(
                                      children: [
                                        DefaultCountainer(
                                          color: Get.theme.colorScheme.primary,
                                          width: Get.width * 0.7,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 45,
                                                color: Get.theme.colorScheme
                                                    .secondary,
                                              ),
                                              Text(
                                                controller.selectChat!.nikName!,
                                                style: Get
                                                    .textTheme.headlineMedium!
                                                    .merge(TextStyle(
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .secondary)),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            controller:
                                                controller.scrollController,
                                            itemCount: controller
                                                .selectChat!.chats!.length,
                                            itemBuilder: (context, indexd) {
                                              Chat chat = controller
                                                  .selectChat!.chats![indexd];
                                              final isMe = chat.idEmp != null;
                                              return Container(
                                                width: Get.width,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    isMe
                                                        ? CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            child:
                                                                DefaultIcon.svg(
                                                              path:
                                                                  'icons/customer_support.svg',
                                                              color: Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          )
                                                        : Container(),
                                                    const SizedBox(width: 8.0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: isMe
                                                            ? CrossAxisAlignment
                                                                .start
                                                            : CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          DefaultCountainer(
                                                            //  width:double.,
                                                            //     isMe ? Get.width - 50 : Get.width - 50,
                                                            color: isMe
                                                                ? Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary
                                                                : Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .primary,
                                                            borderRadius: (8.0),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              // crossAxisAlignment:
                                                              //     CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  chat.containt!,
                                                                  style:
                                                                      TextStyle(
                                                                    color: isMe
                                                                        ? Get
                                                                            .theme
                                                                            .colorScheme
                                                                            .primary
                                                                        : Get
                                                                            .theme
                                                                            .colorScheme
                                                                            .secondary,
                                                                    fontSize:
                                                                        16.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          chat.id == -99
                                                              ? const SizedBox(
                                                                  width: 10,
                                                                  height: 10,
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    isMe
                                                        ? Container()
                                                        : const CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.grey,
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 45,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        DefaultCountainer(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: Get.width,
                                          height: 60,
                                          child: Row(children: [
                                            Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(math.pi),
                                                child: Obx(() => IconButton(
                                                      icon: const Icon(
                                                          Icons.send),
                                                      onPressed: !controller
                                                              .isenableMessage
                                                              .value
                                                          ? null
                                                          : () async {
                                                              if (controller
                                                                      .inputChat!
                                                                      .containt !=
                                                                  null) {
                                                                controller
                                                                    .selectChat!
                                                                    .chats!
                                                                    .add(controller
                                                                        .inputChat!
                                                                        .copyWith(
                                                                            idEmp:
                                                                                controller.current!.idEmp));
                                                                controller
                                                                    .streamChat
                                                                    .add(controller
                                                                        .inputChat!);
                                                                controller
                                                                    .updataconterMessage();
                                                                controller
                                                                    .updatacontaintMessage();
                                                                await controller
                                                                    .scrollToIndex();

                                                                controller
                                                                    .textController
                                                                    .clear();
                                                                controller
                                                                    .isenableMessage
                                                                    .value = false;
                                                              }
                                                            },
                                                    ))),
                                            Expanded(
                                                child:
                                                    Obx(
                                                        () =>
                                                            RawKeyboardListener(
                                                              onKey: !controller
                                                                      .isenableMessage
                                                                      .value
                                                                  ? null
                                                                  : (RawKeyEvent
                                                                      value) async {
                                                                      if (value
                                                                              .physicalKey ==
                                                                          PhysicalKeyboardKey
                                                                              .enter) {
                                                                        if (controller.inputChat!.containt !=
                                                                            null) {
                                                                          controller
                                                                              .selectChat!
                                                                              .chats!
                                                                              .add(controller.inputChat!.copyWith(idEmp: controller.current!.idEmp));
                                                                          controller
                                                                              .streamChat
                                                                              .add(controller.inputChat!);
                                                                          controller
                                                                              .updataconterMessage();

                                                                          controller
                                                                              .updatacontaintMessage();
                                                                          await controller
                                                                              .scrollToIndex();

                                                                          controller
                                                                              .textController
                                                                              .clear();
                                                                          controller
                                                                              .isenableMessage
                                                                              .value = false;
                                                                        }
                                                                      } else {
                                                                        print(
                                                                            value);
                                                                      }
                                                                    },
                                                              focusNode:
                                                                  FocusNode(),
                                                              child:
                                                                  DefaultTextFormField(
                                                                controller:
                                                                    controller
                                                                        .textController,
                                                                isborderall:
                                                                    false,
                                                                onchange:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    controller
                                                                        .inputChat!
                                                                        .containt = value;
                                                                    controller
                                                                        .isenableMessage
                                                                        .value = false;
                                                                    // controller.lisentKey(true);
                                                                  } else {
                                                                    controller
                                                                        .inputChat!
                                                                        .containt = value;

                                                                    controller
                                                                        .isenableMessage
                                                                        .value = true;
                                                                  }
                                                                },
                                                              ),
                                                            ))),
                                          ]),
                                        )
                                      ],
                                    );
                            },
                          ))
                    ],
                  );
                })));
  }
}
