// import 'dart:async';
// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// // import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:projecttravel/app/services/websockt_services.dart';
//
// import '../Helper/diohelper.dart';
// import '../Helper/shard_prefernces.dart';
// import '../Helper/websocket_helper.dart';
// import '../data/local/local_data.dart';
// import '../models/basic/notification_app.dart';
// import 'notification_services.dart';
//
// @pragma('vm:entry-point')
// onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   var dio = DioHelpper();
//
//   StreamSubscription<dynamic>? listen;
//   Connectivity()
//       .onConnectivityChanged
//       .listen((ConnectivityResult connectivityResult) async {
//     var websocket = WebsocketBaseClassServices();
//     if (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.ethernet) {
//       if (listen == null || listen!.isPaused) {
//         await websocket.connect(SubsicrubeChannel.notification);
//         listen = websocket
//             .listenToEventSpecific('App\\Events\\NotificationEvent', 1)!
//             .listen((event) async {
//           NotificationApp message = NotificationApp.fromMap(event);
//           NotificationsService().showNotification(
//               title: message.message!.titleNotification,
//               body: message.message!.body,
//               actionButton: [
//                 NotificationActionButton(
//                     key: 'id', label: 'عرض', actionType: ActionType.KeepOnTop)
//               ],
//               channalKey: DataConst.channelUpdataState,
//               id: -1);
//           await dio.initialbackgroud();
//           await dio.postDataBackgroud(
//               path: 'notification/recive', data: {'id': message.id});
//         }, onError: (value) {
//           // print(value);
//           websocket.closeChannal();
//           listen!.pause();
//         }, onDone: () {});
//       }
//     } else {
//       websocket.closeChannal();
//       listen!.pause();
//     }
//   });
// }
//
// class BackgroundServices {
//   BackgroundServices() {
//     // fristOpen = ShardHelpar.shard.getBool('fristOpen') ?? false;
//     // fristOpen = false;
//   }
//   // late bool fristOpen;
//
//   Future<void> initializeService() async {
//     // if (true) {
//     // if (!fristOpen) {
//     final service = FlutterBackgroundService();
//
//     await service.configure(
//         androidConfiguration: AndroidConfiguration(
//           onStart: onStart,
//           autoStartOnBoot: true,
//           // auto start service
//           autoStart: true,
//           isForegroundMode: false,
//
//           notificationChannelId: DataConst.channelUpdataState,
//         ),
//         iosConfiguration: IosConfiguration());
//   }
//   // await ShardHelpar.shard.setBool('fristOpen', true);
//   // }
// }
