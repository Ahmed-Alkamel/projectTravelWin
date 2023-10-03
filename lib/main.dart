import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/Helper/diohelper.dart';
import 'app/Helper/shard_prefernces.dart';
import 'app/Helper/websocket_helper.dart';
import 'app/data/api/laravel_api.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_services.dart';
import 'app/services/global_services.dart';
import 'app/services/notification_services.dart';
import 'app/services/websockt_services.dart';
import 'app/theme/color.dart';
import 'app/theme/setting.dart';
import 'app/translations/locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     systemNavigationBarColor: Colors.white,
  //     statusBarColor: DefaultColor.primaryColor));
  await GetStorage.init();
  await Get.putAsync(() => LaravelApi().init());
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => AuthUserService().init());
  await Get.putAsync(
      () => WebsocketBaseClassServices().connect(SubsicrubeChannel.no));
  await Get.putAsync(() => NotificationsService().initializeNotification());
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  DioHelpper.init();
  await ShardHelpar.init();
  // await PermissionHelper().initi();
  DefaultColor.init();
  // await DatabaseServices().initDatabase();

  // await BackgroundServices().initializeService();
  SettingsService setting = SettingsService();
  await setting.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: setting.getLightTheme(),
      locale: const Locale('ar'),
      translations: AppTranslation(),
    ),
  );
}
