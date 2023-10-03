import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/websocket_helper.dart';
import '../../../commen/ui.dart';
import '../../../models/basic/chat.dart';
import '../../../models/basic/customer.dart';
import '../../../providers/database.dart';
import '../../../repository/chat_repository.dart';
import '../../../services/auth_services.dart';
import '../../../services/websockt_services.dart';

class ChatController extends GetxController {
  Chat? inputChat;
  RxBool isLoad = RxBool(false);
  RxBool isenableMessage = RxBool(false);
  ChatRepository? _chatRepository;
  StreamController<Chat> streamChat = StreamController();
  RxBool isNewMassage = RxBool(false);
  final ScrollController scrollController = ScrollController();
  // User? currentUser = Get.find<AuthUserService>().user;
  WebsocketBaseClassServices websocketChat = WebsocketBaseClassServices();
  bool islisent = false;

  TextEditingController textController = TextEditingController();
  RxList<Chat> chats = RxList();
  // DatabaseServices database = DatabaseServices();

  @override
  void onInit() async {
    // inputChat = Chat(idChat: currentUser!.idChat!, isRecive: false, id: -99);
    _chatRepository = ChatRepository();
    await load();
    super.onInit();
  }

  @override
  void onReady() {
    lisentScroll();
    super.onReady();
  }

  @override
  void onClose() async {
    scrollController.removeListener(() {});
    await websocketChat.closeChannal();
    super.onClose();
  }

  load() async {
    // await getChatFromDatabase();

    // await getChatFromapi();
    await lisentChat();
    // linstTochat();
  }

  // void linstTochat() {
  //   // websocket
  //   //     .listenToEventSpecific('App\\Events\\updataStateRequestcustomerEvent',
  //   //         currentUser!.idCus!)!
  //   //     .listen((event) async {
  //   //   upDataStat = event['info'] == null
  //   //       ? null
  //   //       : List<UserRequest>.from(
  //   //           (event['info'] as List<dynamic>).map<UserRequest?>(
  //   //             (x) => UserRequest.fromMap(x as Map<String, dynamic>),
  //   //           ),
  //   //         );
  //   //
  //   //   if (upDataStat != null) {
  //   //     userRequest = upDataStat;
  //   //     requsstData = upDataStat;
  //   //
  //   //     update(['bodyCustomerRequest']);
  //   //     //     await NotificationsService().showNotification(
  //   //     //         title: 'تم تلقي استجابة على الطلب',
  //   //     //         body: 'تم تلقي استجابة لطلبك من قبل ادراة التطبيق',
  //   //     //         actionButton: [
  //   //     //           NotificationActionButton(
  //   //     //               key: 'id', label: 'عرض', actionType: ActionType.KeepOnTop)
  //   //     //         ],
  //   //     //         channalKey: DataConst.channelUpdataState,
  //   //     //         id: -1);
  //   //   }
  //   // });
  //   websocketChat.connect(SubsicrubeChannel.channelChat);
  //   websocketChat
  //       .listenToEventSpecific('App\\Events\\ChatEvent', currentUser!.idCus!)!
  //       .listen((event) async {
  //     Chat chat = Chat.fromMap(event);
  //     // UiApp.snakfaild("فشل", 'الرجاء التاكد من اليبانات المدخلة');

  //     await addNewChat(chat);
  //   });
  //   // islisent = true;
  // }

  addNewChat(Chat chat) async {
    if (chat.idEmp != null) {
      chats.add(chat.copyWith(isRecive: true));
      // await addNewChatDatabas(chat.copyWith(isRecive: true));
      // await senReciveMessage(chat);
    } else {
      chats.add(chat);
      // await addNewChatDatabas(chat);
    }
    isNewMassage.value = true;
  }

  // senReciveMessage(Chat chat) async {
  //   bool doneVerify = await _chatRepository!.veifyClint(chat.id!);
  //   if (doneVerify) {
  //     print(doneVerify);
  //   } else {
  //     print(doneVerify);
  //   }
  // }

  // addNewChatDatabas(Chat chat) async {
  //   // await database.insertData(ChatTable.nameTable, chat.toMapDataBase());
  // }
  //
  // getChatFromDatabase() async {
  //   // // List<Chat> temp = await database.getAllDataChat();
  //   // if (temp.isNotEmpty) {
  //   //   chats.addAll(temp);
  //   // }
  //   //  chats.addAll()
  // }

  // getChatFromapi() async {
  //   List<Chat> temp = await _chatRepository!.all(currentUser!.idChat!);
  //   if (temp.isNotEmpty) {
  //     chats.addAll(temp);
  //     isNewMassage.value = true;
  //   }
  // }

  Future<void> lisentChat() async {
    // streamChat.stream.listen((event) async {
    //   // Chat? newChat =
    //       // await _chatRepository!.sendMessage(event.idChat, event.containt!);
    //   // Future.delayed(Duration(seconds: 1));
    //   // if (newChat != null) {
    //   //   chats[chats.indexWhere((element) => element.id == -99)] = newChat;
    //   //   // await addNewChatDatabas(newChat);
    //   // } else {
    //   //   chats[chats.indexWhere((element) => element.id == -99)] =
    //   //       event.copyWith(id: -88);
    //   });
    // }, onDone: () {
    //   // subscription!.cancel();
    // });
  }

  void lisentScroll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isNewMassage.value = false;
      }
    });
  }

  void scrollToIndex(int index) {
    if (index > 0 && index < chats.length) {
      // scrollController.jumpTo(index*1);
      if (scrollController.position.hasViewportDimension) {
        scrollController.animateTo(
          scrollController.position
              .maxScrollExtent, // Assuming each ListTile is 56 pixels in height
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void updateSendIcon() {
    update(['sendIcon']);
  }
}
