import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:projecttravelwin/app/services/auth_services.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/color.dart';
import '../../widgets/default_widget.dart';
import '../controllers/main_screan_controller.dart';
import '../widget_local.dart';

class MainScreanView extends GetView<MainScreanController> {
  const MainScreanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String titleApplication = 'travel pro';
    String mainDataLabal = 'البيانات الاساسية';
    String pathIconMainData = 'icons/data_main.svg';

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: DefaultCountainer(
              width: 250,
              color: Get.theme.colorScheme.primary,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: DefaultIcon.svg(
                            path: 'icons/logo.svg',
                            width: 100,
                            height: 100,
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                        Expanded(
                          child: DefaultText(
                            'TravelPro',
                            style: Get.textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Get.theme.colorScheme.primary,
                  ),
                  Expanded(
                      child: Column(
                          children: controller.itemMenuDrower
                              .asMap()
                              .entries
                              .map((e) => Obx(
                                    () => ItemDrowerMenu(
                                      selected:
                                          controller.selecteMenu.value == e.key,
                                      path: e.value.path,
                                      name: e.value.name,
                                      onTap: () {
                                        controller.selecteMenu.value = e.key;
                                        controller.updaatemainScreenViewBody();
                                        // Get.offNamed(
                                        //     controller.screenAppRoutes[e.key]);
                                      },
                                    ),
                                  ))
                              .toList()))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                DefaultCountainer(
                  // offset: Offset(2, 2),
                  colorShadow: Colors.black45,
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Get.find<AuthUserService>().logout();
                        },
                        child: DefaultText(
                          'تسجيل خروج',
                          style: Get.textTheme.titleMedium!.merge(
                              TextStyle(color: Get.theme.colorScheme.primary)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(
                        Get.find<AuthUserService>().user!.name!.getFullName,
                        style: Get.textTheme.headlineLarge,
                      ),
                      Icon(
                        Icons.person,
                        color: Get.theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
                GetBuilder<MainScreanController>(
                  // init: MainScreanController(),
                  id: 'mainScreenViewBody',
                  initState: (_) {},
                  builder: (_) {
                    return Expanded(
                      child: controller
                          .screenAppRoutes[controller.selecteMenu.value],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> defaultShowDialog(BuildContext context, String labal,
      {required List<Widget> listButton}) {
    return showDialog(
      context: context,
      builder: (contextBuilder) {
        double width = (MediaQuery.of(contextBuilder).size.width) / 2;
        double height = (MediaQuery.of(contextBuilder).size.height) / 2;
        print(width);
        print(height);
        return AlertDialog(
          actions: [
            Container(
              height: height,
              child: Column(
                children: [
                  Expanded(
                    child: DefaultText(
                      labal,
                    ),
                  ),
                  Row(
                    children: listButton,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}



  //  Column(children: [
  //               DefaultCountainer(
  //                 color: Get.theme.colorScheme.secondary,
  //                 padding: const EdgeInsets.symmetric(horizontal: 6),
  //                 height: 50,
  //                 child: Row(
  //                   children: [
  //                     DefaultText(
  //                       'الخدمات',
  //                       style: Get.textTheme.titleMedium!.merge(
  //                           TextStyle(color: Get.theme.colorScheme.primary)),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     DefaultText(
  //                       'الشركات',
  //                       style: Get.textTheme.titleMedium!.merge(
  //                           TextStyle(color: Get.theme.colorScheme.primary)),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     DefaultText('المستخدمين',
  //                         style: Get.textTheme.titleMedium!.merge(
  //                             TextStyle(color: Get.theme.colorScheme.primary))),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                   child: ItemCardOperationServices(
  //                 title: 'الخدمات',
  //                 childern: [
  //                   Expanded(
  //                     child: ItemCardMain(
  //                       title: 'اضافة خدمة',
  //                       color: DefaultColor.containTheme2,
  //                       onTap: () async {
  //                         await Get.toNamed(Routes.ADD_SERVICE);
  //                       },
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 30,
  //                   ),
  //                   Expanded(
  //                     child: ItemCardMain(
  //                       title: 'تعديل خدمة',
  //                       color: DefaultColor.containTheme1,
  //                       onTap: () {},
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 30,
  //                   ),
  //                   Expanded(
  //                     child: ItemCardMain(
  //                       title: 'حذف خدمة',
  //                       color: DefaultColor.containTheme3,
  //                       onTap: () {},
  //                     ),
  //                   )
  //                 ],
  //               ))
  //             ]))
       


          //  Expanded(
          //           child: ItemCardOperationServices(
          //         title: 'الخدمات',
          //         childern: [
          //           Expanded(
          //             child: ItemCardMain(
          //               title: 'اضافة خدمة',
          //               color: DefaultColor.containTheme2,
          //               onTap: () async {
          //                 await Get.toNamed(Routes.ADD_SERVICE);
          //               },
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 30,
          //           ),
          //           Expanded(
          //             child: ItemCardMain(
          //               title: 'تعديل خدمة',
          //               color: DefaultColor.containTheme1,
          //               onTap: () {},
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 30,
          //           ),
          //           Expanded(
          //             child: ItemCardMain(
          //               title: 'حذف خدمة',
          //               color: DefaultColor.containTheme3,
          //               onTap: () {},
          //             ),
          //           )
          //         ],
          //       ))
             