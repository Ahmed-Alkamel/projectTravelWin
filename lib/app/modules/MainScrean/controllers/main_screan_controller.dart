// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../models/basic/chat.dart';
import '../../../models/basic/customer.dart';
import '../../../models/basic/state_request.dart';
import '../../../models/basic/user_request.dart';
import '../../../repository/user_request_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../../theme/color.dart';
import '../../customer_request_desktop/views/intro_customer_request_view.dart';
import '../../home/views/home_view.dart';
import '../../management_user_desktop/views/intro_management_user_view.dart';
import '../../report_desktop/views/intro_report_view.dart';
import '../../service_desktop/views/intro_service_view.dart';
import '../../service_provider_desktop/views/intro_service_provider_view.dart';
import '../../trips_desktop/views/intro_trips_view.dart';
import '../../widgets/default_widget.dart';
import '../views/beneficicares_view.dart';
import '../views/customer_request_view.dart';
import '../views/intro_main_screan_view.dart';

class MainScreanController extends GetxController {
  final currentIndexNavigatorBar = 0.obs;
  final selecteMenu = 0.obs;
  StreamSubscription<Chat>? subscription;

  List<Widget> pages = [
    HomeView(),
    const CustomerRequestView(),
    const BeneficicaresView(),
    // const ChatView()
  ];
  List<String> titlePage = const [
    'القائمة الرئسية',
    "طلباتي",
    "المستفيدين",
    // 'مراسلة الدعم الفني'
  ];

  var itemMenuDrower = [
    TitleAndPathMenu(path: 'icons/home.svg', name: 'القائمة الرئسية'),
    TitleAndPathMenu(path: 'icons/services.svg', name: 'الخدمات'),
    TitleAndPathMenu(path: 'icons/provider_services.svg', name: 'موفر الخدمات'),
    TitleAndPathMenu(path: 'icons/trips.svg', name: 'الرحلات'),
    TitleAndPathMenu(path: 'icons/customer_request.svg', name: 'طلبات العملاء'),
    TitleAndPathMenu(
        path: 'icons/account_manager.svg', name: 'ادارة المستخدمين'),
    TitleAndPathMenu(path: 'icons/report_1.svg', name: 'التقارير')
  ];

  UserRequestRepository? _userRequestRepository;

  User? currentUser;
  List<UserRequest>? requsstData;
  List<UserRequest>? userRequest;
  List<UserRequest>? upDataStat;
  var screenAppRoutes = [
    const IntroMainScreanView(),
    const IntroServiceView(),
    const IntroServiceProviderView(),
    const IntroTripsView(),
    const IntroCustomerRequestView(),
    const IntroManagementUserView(),
    const IntroReportView()
  ];
  // WebsocketBaseClassServices websocket = Get.find<WebsocketBaseClassServices>();

  RxList<StateRequest> stateRequest = RxList();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final contrllerButtomNavbar = PersistentTabController(initialIndex: 0);
  @override
  void onInit() async {
    _userRequestRepository = UserRequestRepository();

    await loadData();
    // await WebsocketChannalApp.init();
    // final subscriptionMessage = {
    //   'event': 'pusher:subscribe',
    //   'data': {'channel': 'public-CustomerRequst'}
    // };
    // WebsocketChannalApp.channal.sink.add(json.encode(subscriptionMessage));
    // dataRequestStream();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   // websocket.closeChannal();
  //   super.onClose();
  // }

  loadData() async {
    // await refreshUser();
    if (currentUser != null) {
      userRequest =
          await _userRequestRepository!.getRequestById(currentUser!.idCus!);

      requsstData = userRequest;
      stateRequest.value = await _userRequestRepository!.getAllStatRequest();
      // configeWebsocket();

      // linstTochat();
    }
  }

  // refreshUser() async {
  //   await Get.find<AuthUserService>().refresh();
  //   currentUser = Get.find<AuthUserService>().user;
  // }

  // configeWebsocket() {
  //   // websocket.connect();
  //   websocket.subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
  //       data: {'channel': 'public-updataRequestCustomer'},
  //       event: 'pusher:subscribe'));
  //   websocket.listenToEventSpecific(
  //       'App\\Events\\updataStateRequestcustomerEvent', currentUser!.idCus!);
  //   websocket.streamController.stream.listen((event) async {
  //     upDataStat = event['info'] == null
  //         ? null
  //         : List<UserRequest>.from(
  //             (event['info'] as List<dynamic>).map<UserRequest?>(
  //               (x) => UserRequest.fromMap(x as Map<String, dynamic>),
  //             ),
  //           );

  //     if (upDataStat != null) {
  //       userRequest = upDataStat;
  //       requsstData = upDataStat;

  //       update(['bodyCustomerRequest']);
  //       await NotificationsService.showNotification(
  //           title: 'تم تلقي استجابة على الطلب',
  //           body: 'تم تلقي استجابة لطلبك من قبل ادراة التطبيق',
  //           actionButton: [
  //             NotificationActionButton(
  //                 key: 'id', label: 'عرض', actionType: ActionType.KeepOnTop)
  //           ]);
  //     }
  //   });
  // }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      cutomeItemButtomNavbar(
        index: 0,
        path: 'icons/homeone.svg',
        title: "الصفحة الرئيسية",
      ),
      cutomeItemButtomNavbar(
        index: 1,
        path: 'icons/evidence.svg',
        title: "طلباتي",
      ),
      cutomeItemButtomNavbar(
        index: 2,
        path: 'icons/people.svg',
        title: "المستفيدين",
      ),
      // cutomeItemButtomNavbar(
      //   index: 3,
      //   path: 'icons/chat.svg',
      //   title: "الدعم الفني",
      // ),
    ];
  }

  PersistentBottomNavBarItem cutomeItemButtomNavbar(
      {required String path, String? title, required int index}) {
    return PersistentBottomNavBarItem(
        icon: DefaultIcon.svg(
          path: path,
          width: 40,
          height: 40,
          color: index == currentIndexNavigatorBar.value
              ? Get.theme.colorScheme.secondary
              : Colors.black,
        ),
        title: title,
        activeColorPrimary: Get.theme.colorScheme.secondary,
        inactiveColorPrimary: Colors.black,
        textStyle: Get.textTheme.headlineMedium!.merge(TextStyle(
            fontSize: index == currentIndexNavigatorBar.value ? 15 : 14,
            color: index == currentIndexNavigatorBar.value
                ? DefaultColor.textPrimary
                : DefaultColor.textSecandry)));
  }

  void login() {}
  logout() async {
    Get.find<AuthUserService>().logout();
    await Get.offAllNamed(Routes.MAIN_SCREAN);
  }

  void changeNavigatorBar(int i) {
    currentIndexNavigatorBar.value = i;
    update(['bottomNavigationBar', 'bodyOfMainScreen']);
  }

  void shStatRequset(StateRequest e) {
    requsstData = userRequest!.where((element) => element.state! == e).toList();
    update(['bodyCustomerRequest']);
  }

  void test() {
    print('hello');
  }

  void updaatemainScreenViewBody() {
    update(['mainScreenViewBody']);
  }

  // void linstTochat() {
  //   if (!islisent) {
  //     // websocket
  //     //     .listenToEventSpecific('App\\Events\\updataStateRequestcustomerEvent',
  //     //         currentUser!.idCus!)!
  //     //     .listen((event) async {
  //     //   upDataStat = event['info'] == null
  //     //       ? null
  //     //       : List<UserRequest>.from(
  //     //           (event['info'] as List<dynamic>).map<UserRequest?>(
  //     //             (x) => UserRequest.fromMap(x as Map<String, dynamic>),
  //     //           ),
  //     //         );
  //     //
  //     //   if (upDataStat != null) {
  //     //     userRequest = upDataStat;
  //     //     requsstData = upDataStat;
  //     //
  //     //     update(['bodyCustomerRequest']);
  //     //     //     await NotificationsService().showNotification(
  //     //     //         title: 'تم تلقي استجابة على الطلب',
  //     //     //         body: 'تم تلقي استجابة لطلبك من قبل ادراة التطبيق',
  //     //     //         actionButton: [
  //     //     //           NotificationActionButton(
  //     //     //               key: 'id', label: 'عرض', actionType: ActionType.KeepOnTop)
  //     //     //         ],
  //     //     //         channalKey: DataConst.channelUpdataState,
  //     //     //         id: -1);
  //     //   }
  //     // });
  //     websocketChat.connect(SubsicrubeChannel.channelChat);
  //     websocketChat
  //         .listenToEventSpecific('App\\Events\\ChatEvent', currentUser!.idCus!)!
  //         .listen((event) {
  //       Chat chat = Chat.fromMap(event);
  //       chats.add(chat);
  //       isNewMassage.value = true;
  //     });
  //     islisent = true;
  //   }
  // }
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title!,
                style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TitleAndPathMenu {
  final String path;
  final String name;
  TitleAndPathMenu({
    required this.path,
    required this.name,
  });
}
