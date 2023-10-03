import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/color.dart';
import '../../../theme/theme.dart';
import '../../UserGuide/bindings/user_guide_binding.dart';
import '../../UserGuide/views/user_guide_view.dart';
import '../../widgets/default_widget.dart';
import '../../widgets/main_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final controller = Get.put<HomeController>(HomeController());
  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.arrow_back_ios_new;
    String lableSubTitle = 'اهم الخدمات';
    // String titleButton = 'طلب';
    // String titleService = 'تاشيرة عمل';

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   child: Container(
            //     child: Text('اعلانات'),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    // print(GetStorage().read('user'));
                    await GetStorage().erase();
                  },
                  child: DefaultCountainer(
                    borderRadius: 20,
                    width: 90,
                    height: 90,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SvgPicture.asset(
                            'icons/services.svg',
                            width: 60,
                            height: 60,
                            color: DefaultColor.primaryColor,
                            theme: SvgTheme(fontSize: 30),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: DefaultText(
                            'الخدمات',
                            style: Get.textTheme.headlineLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //  print(controller.servicsImportaint);
                    Get.to(() => UserGuideView(), binding: UserGuideBinding());
                  },
                  child: DefaultCountainer(
                    borderRadius: 20,
                    width: 90,
                    height: 90,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SvgPicture.asset(
                            'icons/evidence.svg',
                            width: 60,
                            height: 60,
                            color: DefaultColor.primaryColor,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: DefaultText(
                            'الدليل',
                            style: Get.textTheme.headlineLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                flex: 3,
                child: Column(
                  //column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleLabel(

                        ///text
                        lableSubTitle: lableSubTitle,
                        iconData: iconData),
                    Expanded(
                      child: GetBuilder<HomeController>(
                        id: 'CardServicesList',
                        initState: (_) {},
                        builder: (_) {
                          return GridView.builder(
                            //Gridveiw
                            itemCount: controller.category!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 7),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (controller
                                            .category![index].idCategoryMain ==
                                        1) {
                                      Get.toNamed(Routes.SERVICES_SCREEN);
                                    } else if (controller
                                            .category![index].idCategoryMain ==
                                        2) {
                                      Get.toNamed(Routes.SERVICES_PUBLIC,
                                          parameters: {'id': 2.toString()});
                                    } else {
                                      // await NotificationsService
                                      //     .showNotification(
                                      //         title: 'title',
                                      //         body: 'body',
                                      //         actionType: ActionType.KeepOnTop,
                                      //         notificationLayout:
                                      //             NotificationLayout.BigText,
                                      //         summary: 'summary',
                                      //         actionButton: [
                                      //       NotificationActionButton(
                                      //           key: 'data', label: 'mor')
                                      //     ]);
                                    }
                                  },
                                  child: DefaultCountainer(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: DefaultIcon.svg(
                                            path: controller.category![index]
                                                        .idCategoryMain ==
                                                    1
                                                ? 'icons/trip_e9bqzj6nxhw1.svg'
                                                : controller.category![index]
                                                            .idCategoryMain ==
                                                        2
                                                    ? 'icons/passport.svg'
                                                    : 'icons/servicesPublic.svg',
                                            color:
                                                Get.theme.colorScheme.primary,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        Center(
                                          child: DefaultText(
                                            controller.category![index]
                                                .nameCategoryMain!,
                                            style: Get.textTheme.headlineLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// class CardServices extends StatelessWidget {
//   CardServices({Key? key, required this.service}) : super(key: key);

//   Service service;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultCountainer(
//         margin: const EdgeInsets.only(top: 3, left: 20, right: 5, bottom: 3),
//         borderRadius: 12,
//         padding: const EdgeInsets.all(22),
//         width: 150,
//         height: 150,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               flex: 2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: DefaultText(
//                       service.name!,
//                       fontSize: OptionThemeWidget.cardTextSize,
//                       fontWeight: OptionThemeWidget.cardFontWeight,
//                     ),
//                   ),
//                   Center(
//                       child: service.category != null
//                           ? DefaultText(
//                               service.category!.nameCategoryMain!,
//                               fontSize: OptionThemeWidget.labalMainTextSize,
//                               fontWeight: OptionThemeWidget.lableMainFontWeight,
//                             )
//                           : null),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: defaultButton(
//                   isResponseve: true,
//                   isIcon: false,
//                   lable: titleButton,
//                   onPressed: () {}),
//             )
//           ],
//         ));
//   }
// }
