import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/Auth/bindings/auth_binding.dart';
import '../modules/Auth/views/login_view.dart';
import '../modules/MainScrean/bindings/main_screan_binding.dart';
import '../modules/MainScrean/views/main_screan_view.dart';

import '../modules/ServicesScreen/bindings/services_screen_binding.dart';
import '../modules/ServicesScreen/views/beneficiares_screen_view.dart';
import '../modules/ServicesScreen/views/search_query_view.dart';
import '../modules/UserGuide/bindings/user_guide_binding.dart';
import '../modules/UserGuide/views/user_guide_view.dart';
import '../modules/addService/bindings/add_service_binding.dart';
import '../modules/addService/views/add_service_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/customer_request_desktop/bindings/customer_request_desktop_binding.dart';
import '../modules/customer_request_desktop/bindings/customet_chat_request_binding.dart';
import '../modules/customer_request_desktop/views/chat_customer_view.dart';
import '../modules/customer_request_desktop/views/customer_request_desktop_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/management_user_desktop/bindings/management_user_desktop_binding.dart';
import '../modules/management_user_desktop/views/add_user_view.dart';
import '../modules/management_user_desktop/views/management_user_desktop_view.dart';
import '../modules/report_desktop/bindings/report_desktop_binding.dart';
import '../modules/report_desktop/views/report_desktop_view.dart';
import '../modules/service_desktop/bindings/service_desktop_binding.dart';
import '../modules/service_desktop/views/service_desktop_view.dart';
import '../modules/service_provider_desktop/bindings/service_provider_desktop_binding.dart';
import '../modules/service_provider_desktop/views/add_service_provider_view.dart';
import '../modules/service_provider_desktop/views/service_provider_desktop_view.dart';
import '../modules/servicesPublic/bindings/services_public_binding.dart';
import '../modules/servicesPublic/views/beneficiares_services_booking_view.dart';
import '../modules/servicesPublic/views/services_public_view.dart';
import '../modules/trips_desktop/bindings/trips_desktop_binding.dart';
import '../modules/trips_desktop/views/add_trip_view.dart';
import '../modules/trips_desktop/views/trips_desktop_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.SEARCH_TRIP,
    //   page: () => SearchTripView(),
    //   binding: SearchTripBinding(),
    // ),
    // GetPage(
    //   name: _Paths.BOOKING_TRIP,
    //   page: () => BookingTripView(),
    //   binding: BookingTripBinding(),
    // ),

    GetPage(
      name: _Paths.MAIN_SCREAN,
      page: () => const MainScreanView(),
      binding: MainScreanBinding(),
    ),
    // GetPage(
    //   name: _Paths.REQUERMENT_ME,
    //   page: () => const RequermentMeView(),
    //   binding: RequermentMeBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ACCOUT_USER,
    //   page: () => const AccoutUserView(),
    //   binding: AccoutUserBinding(),
    // ),
    GetPage(
      name: _Paths.USER_GUIDE,
      page: () => UserGuideView(),
      binding: UserGuideBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES_SCREEN,
      page: () => const SearchQueryView(),
      binding: ServicesScreenBinding(),
    ),
    GetPage(
        name: _Paths.AUTH,
        page: () => const LoginView(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.SERVICES_PUBLIC,
      page: () => const ServicesPublicView(),
      binding: ServicesPublicBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_CHAT_REQUSET,
      page: () => const ChatCustomerView(),
      binding: CustomerChatBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES_SCREEN_BENEFITES,
      page: () => BeneficiaresScreenView(),
    ),
    GetPage(
      name: _Paths.SERVICES_Public_BENEFITES,
      page: () => BeneficiaresServicesBookingView(),
    ),
    GetPage(
      name: _Paths.Chat_Screen,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: _Paths.ADD_SERVICE,
      page: () => const AddServiceView(),
      binding: AddServiceBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_DESKTOP,
      page: () => const ServiceDesktopView(),
      binding: ServiceDesktopBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_PROVIDER_DESKTOP,
      page: () => const ServiceProviderDesktopView(),
      binding: ServiceProviderDesktopBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_PROVIDER_DESKTOP_Add,
      page: () => const AddServiceProviderView(),
      binding: ServiceProviderDesktopBinding(),
    ),
    GetPage(
      name: _Paths.TRIPS_DESKTOP,
      page: () => const TripsDesktopView(),
      binding: TripsDesktopBinding(),
    ),
    GetPage(
      name: _Paths.TRIPS_Add_DESKTOP,
      page: () => const AddTripView(),
      binding: TripsDesktopBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_REQUEST_DESKTOP,
      page: () => const CustomerRequestDesktopView(),
      binding: CustomerRequestDesktopBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEMENT_USER_DESKTOP,
      page: () => const ManagementUserDesktopView(),
      binding: ManagementUserDesktopBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEMENT_USER_Add_DESKTOP,
      page: () => const AddUserView(),
      binding: ManagementUserDesktopBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_DESKTOP,
      page: () => const ReportDesktopView(),
      binding: ReportDesktopBinding(),
    ),
  ];
}
