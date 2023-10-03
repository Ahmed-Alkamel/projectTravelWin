import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/local/local_data.dart';
import '../theme/color.dart';

class NotificationsService extends GetxService {
  Future<NotificationsService> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            groupKey: 'localNotifictionApp',
            channelKey: DataConst.channelUpdataState,
            channelName: 'update state Requst',
            channelDescription: 'the channel to test notification ',
            defaultColor: DefaultColor.primaryColor,
            ledColor: Get.theme.colorScheme.secondary,
            importance: NotificationImportance.High,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
          ),
          NotificationChannel(
            groupKey: 'localNotifictionApp',
            channelKey: DataConst.channelCustomeServices,
            channelName: 'Custom Notificaiton Services',
            channelDescription: 'the channel to test notification ',
            defaultColor: DefaultColor.primaryColor,
            ledColor: Get.theme.colorScheme.secondary,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
          ),
          NotificationChannel(
            groupKey: 'localNotifictionApp',
            channelKey: DataConst.channelDataInput,
            channelName: 'noticfication data input',
            channelDescription: 'the channel to test notification ',
            defaultColor: DefaultColor.primaryColor,
            ledColor: Get.theme.colorScheme.secondary,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
          ),
          NotificationChannel(
            groupKey: 'localNotifictionApp',
            channelKey: DataConst.channelCustomeUser,
            channelName: 'Specific User',
            channelDescription: 'the channel to test notification ',
            defaultColor: DefaultColor.primaryColor,
            ledColor: Get.theme.colorScheme.secondary,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'localNotifictionApp',
              channelGroupName: 'groub1 ')
        ],
        debug: false);

    await AwesomeNotifications().isNotificationAllowed().then((value) async {
      if (!value) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod);

    return this;
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload['navigate'] == 'true') {}
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  Future<void> showNotification(
      {required final String title,
      required final String body,
      final String? summary,
      final Map<String, String>? payload,
      final NotificationCategory? category,
      final ActionType actionType = ActionType.Default,
      final NotificationLayout notificationLayout = NotificationLayout.Default,
      final String? bigPicture,
      final List<NotificationActionButton>? actionButton,
      final bool scheduled = false,
      required final String channalKey,
      final int? interval,
      required int id,
      final bool fullScreenIntent = false}) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channalKey,
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
          fullScreenIntent: fullScreenIntent,
          payload: payload,
          bigPicture: bigPicture,
        ),
        actionButtons: actionButton,
        schedule: scheduled
            ? NotificationInterval(
                allowWhileIdle: true,
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true)
            : null);
  }

  Future<void> showNotificationForgroand(
      {required final String title,
      required final String body,
      final String? summary,
      final Map<String, String>? payload,
      final NotificationCategory? category,
      final ActionType actionType = ActionType.Default,
      final NotificationLayout notificationLayout = NotificationLayout.Default,
      final String? bigPicture,
      final List<NotificationActionButton>? actionButton,
      final bool scheduled = false,
      final int? interval,
      required final int id,
      required final String channalKey,
      final bool fullScreenIntent = false}) async {
    assert(!scheduled || (scheduled && interval != null));

    await AndroidForegroundService.startAndroidForegroundService(
      foregroundStartMode: ForegroundStartMode.stick,
      foregroundServiceType: ForegroundServiceType.phoneCall,
      content: NotificationContent(
        wakeUpScreen: true,
        id: id,
        channelKey: channalKey,
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        fullScreenIntent: fullScreenIntent,
        payload: payload,
        bigPicture: bigPicture,

        //  backgroundColor: (platformVersion == 'Android-31')
        //         ? const Color(0xFF00796a)
        //         : Colors.white,
      ),
      actionButtons: actionButton,
    );
    // scheduled: NotificationInterval(interval: 5,,labale:);
  }
}
