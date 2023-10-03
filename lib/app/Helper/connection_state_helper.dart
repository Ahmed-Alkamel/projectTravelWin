// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:projectgetx/app/data/local/local_data.dart';

// import '../services/notification_services.dart';
// import '../services/websockt_services.dart';

// class ConnctionStateHelper {
//   // WebsocketBaseClassServices websocket = WebsocketBaseClassServices();

//   Future<void> run() async {
//     Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult connectivityResult) async {
//       if (connectivityResult == ConnectivityResult.mobile) {
//         await websocket.connect();
//         websocket
//             .listenToEventSpecific(
//                 'App\\Events\\updataStateRequestcustomerEvent', 1)!
//             .listen((event) async {
//           await NotificationsService().showNotificationForgroand(
//               title: 'title',
//               body: 'moble',
//               id: -1,
//               channalKey: DataConst.channelUpdataState);
//         });
//       } else if (connectivityResult == ConnectivityResult.wifi) {
//         await websocket.connect();
//         websocket
//             .listenToEventSpecific(
//                 'App\\Events\\updataStateRequestcustomerEvent', 1)!
//             .listen((event) async {
//           await NotificationsService().showNotificationForgroand(
//               title: 'title',
//               body: 'wifi',
//               id: -2,
//               channalKey: DataConst.channelUpdataState);
//         });

//         // I am connected to a wifi network.
//       } else if (connectivityResult == ConnectivityResult.ethernet) {
//         await websocket.connect();
//         websocket
//             .listenToEventSpecific(
//                 'App\\Events\\updataStateRequestcustomerEvent', 1)!
//             .listen((event) async {
//           await NotificationsService().showNotificationForgroand(
//               title: 'title',
//               body: 'ethernet',
//               id: -3,
//               channalKey: DataConst.channelUpdataState);
//         });

//         // I am connected to a ethernet network.
//       } else if (connectivityResult == ConnectivityResult.other) {
//         await websocket.connect();
//         websocket
//             .listenToEventSpecific(
//                 'App\\Events\\updataStateRequestcustomerEvent', 1)!
//             .listen((event) async {
//           await NotificationsService().showNotificationForgroand(
//               title: 'title',
//               body: 'other',
//               id: -1,
//               channalKey: DataConst.channelUpdataState);
//         });
//       } else if (connectivityResult == ConnectivityResult.none) {
//         websocket.closeChannal();
//         await NotificationsService().showNotificationForgroand(
//             title: 'title',
//             body: 'close',
//             id: -1,
//             channalKey: DataConst.channelUpdataState);
//       }
//     });
//   }
// }
