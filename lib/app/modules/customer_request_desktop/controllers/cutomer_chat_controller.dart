import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecttravelwin/app/models/basic/user_request.dart';
import 'package:projecttravelwin/app/services/auth_services.dart';

import '../../../Helper/websocket_helper.dart';
import '../../../models/basic/chat.dart';
import '../../../repository/chat_repository.dart';
import '../../../services/websockt_services.dart';

class CustomerChatController extends GetxController {
  RxBool isLoading = RxBool(false);
  ChatRepository? _repository;
  List<ChatData> chats = [];
  ChatData? selectChat;
  Chat? inputChat;
  RxBool isenableMessage = RxBool(false);
  StreamController<Chat> streamChat = StreamController();

  final ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  Employees? current = Get.find<AuthUserService>().user;
  WebsocketBaseClassServices? web;
  StreamController<dynamic>? dataMessage;
  @override
  void onInit() async {
    _repository = ChatRepository();
    web = await Get.find<WebsocketBaseClassServices>()
        .connect(SubsicrubeChannel.channalChatServicer);
    await loadData();
    await connectWeb();
    // TODO: implement onInit
    super.onInit();
  }

  connectWeb() async {
    dataMessage = web!
        .listenToEventSpecificWithConstrant("App\\Events\\ReceiveMassageEvent");
    dataMessage!.stream.listen((event) async {
      Chat data = Chat.fromMap(event);
      print(data);
      chats
          .firstWhere((element) => element.idChat == data.idChat)
          .chats
          ?.add(data);
      update(['messageData']);
      updatacontaintMessage();
      await scrollToIndex();
    });
  }

  loadData() async {
    isLoading.value = true;
    chats = await _repository!.all();
    isLoading.value = false;
    await lisentChat();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    dataMessage!.close();
    web!.closeChannal();
    super.onClose();
  }

  Future<void> updatacontaintMessage() async {
    update(['containtMessage']);
  }

  Future<void> lisentChat() async {
    streamChat.stream.listen((event) async {
      Chat? newChat = await _repository!
          .sendMessage(event.idChat, event.containt!, current!.idEmp!);
      Future.delayed(Duration(seconds: 1));
    }, onDone: () {
      // subscription!.cancel();
    });
  }

  Future<void> scrollToIndex() async {
    // if (index > 0 && index < chats.length) {
    // scrollController.jumpTo(index*1);
    // if (scrollController.position.hasViewportDimension) {
    await Future.delayed(Duration(milliseconds: 20));
    scrollController.jumpTo(
      scrollController.position
          .maxScrollExtent, // Assuming each ListTile is 56 pixels in height
    );
    // scrollController.animateTo(
    //   scrollController.position
    //       .maxScrollExtent, // Assuming each ListTile is 56 pixels in height
    //   duration: const Duration(milliseconds: 500),
    //   curve: Curves.easeInOut,
    // );
    // }
    // }
  }

  void updataconterMessage() {
    update(['conterMessage']);
  }

  // void lisentKey(bool check) {
  //   RawKeyboardListener
  // }
}
