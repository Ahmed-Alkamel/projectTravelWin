import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/chat.dart';

class ChatRepository {
  LaravelApi? _laravelApi;
  ChatRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<ChatData>> all() async {
    return await _laravelApi!.getAllChat();
  }

  Future<Chat?> sendMessage(int idChat, String containt, int idEmp) async {
    return await _laravelApi!.sendChatCustomer(idChat, containt, idEmp);
  }

  // Future<bool> veifyClint(int id) async {
  //   return await _laravelApi!.verifyMessageServer(id);
  // }
}
