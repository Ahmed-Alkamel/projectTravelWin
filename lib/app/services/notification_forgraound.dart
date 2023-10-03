
import '../data/local/local_data.dart';
import 'notification_services.dart';

class NotificationFourground {
  // var listen = Get.find<NotificationsService>();

  // void install() {
  //   Get.find<WebsocketBaseClassServices>().listenToEventSpecific(
  //       'App\\Events\\updataStateRequestcustomerEvent', 1);
  //   Get.find<WebsocketBaseClassServices>().data.listen((event) async {
  //     await listen.showNotificationForgroand(
  //         title: 'title',
  //         body: 'body',
  //         id: 565,
  //         channalKey: DataConst.channelUpdataState);
  //   });
  // }

  Future<void> test() async {
    // WebsocketChannalHelper.channal!.stream.listen((event) {
    NotificationsService().showNotificationForgroand(
        title: 'title',
        body: 'body',
        id: 1,
        channalKey: DataConst.channelUpdataState);
    // });
  }
}
