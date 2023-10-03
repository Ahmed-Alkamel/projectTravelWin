// import 'package:permission_handler/permission_handler.dart';
//
// import 'shard_prefernces.dart';
//
// class PermissionHelper {
//   Future<void> initi() async {
//     // Map<Permission, PermissionStatus> state = await [
//     //   Permission.accessNotificationPolicy,
//     //   Permission.systemAlertWindow,
//     //   Permission.criticalAlerts
//     // ].request();
//     if (ShardHelpar.shard.getBool('isAccessNotificationPolicy') != true) {
//       var accessNotificationPolicy =
//           await Permission.accessNotificationPolicy.request();
//       if (accessNotificationPolicy.isGranted) {
//         ShardHelpar.shard.setBool('isAccessNotificationPolicy', true);
//       }
//     }
//     if (ShardHelpar.shard.getBool('isScheduleExactAlarm') != true) {
//       var scheduleExactAlarm = await Permission.scheduleExactAlarm.request();
//       if (scheduleExactAlarm.isGranted) {
//         ShardHelpar.shard.setBool('isScheduleExactAlarm', true);
//       }
//     }
//     if (ShardHelpar.shard.getBool('isNotificaiton') != true) {
//       var notification = await Permission.notification.request();
//       if (notification.isGranted) {
//         ShardHelpar.shard.setBool('isNotificaiton', true);
//       }
//     }
//     if (ShardHelpar.shard.getBool('isSystemAlert') != true) {
//       var systemAlertWindow = await Permission.systemAlertWindow.request();
//       if (systemAlertWindow.isGranted) {
//         ShardHelpar.shard.setBool('isSystemAlert', true);
//       }
//     }
//
//     if (ShardHelpar.shard.getBool('isCriticalAlerts') != true) {
//       var criticalAlerts = await Permission.criticalAlerts.request();
//       if (criticalAlerts.isGranted) {
//         ShardHelpar.shard.setBool('isCriticalAlerts', true);
//       }
//     }
//   }
// }
