import 'package:get/get.dart';

import '../controllers/cutomer_chat_controller.dart';

class CustomerChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerChatController>(() => CustomerChatController());
  }
}
