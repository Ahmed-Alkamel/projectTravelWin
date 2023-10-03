import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../../../Helper/function_useable.dart';
import '../../../translations/locale.dart';
import '../../widgets/default_widget.dart';
import '../../widgets/main_widget.dart';
import '../controllers/services_screen_controller.dart';
import '../widget_local.dart';

class ServicesScreenView extends GetView<ServicesScreenController> {
  const ServicesScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Positioned(
                top: 180,
                child: Container(
                  padding: const EdgeInsets.only(top: 8),
                  // height: Get.height -  ,
                  height: Get.height - 200,
                  width: Get.width,
                  child: Obx(() => Column(
                        children: [
                          !controller.isShowBeforeTrip.value
                              ? Container()
                              : Expanded(
                                  child: Column(
                                    children: [
                                      const Text('الرحلات السابقة'),
                                      Expanded(
                                        child: ListView.builder(
                                          // shrinkWrap: true,
                                          itemCount: controller
                                              .triPSecondryBefore.length,
                                          itemBuilder: (context, index) =>
                                              TripCardUpdat(
                                            trip: controller
                                                .triPSecondryBefore[index],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          controller.isShowBeforeTrip.value
                              ? const Divider()
                              : Container(),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                const Text('الرحلات الحالية'),
                                controller.resultTripCategory.isEmpty
                                    ? const Expanded(
                                        child: Center(
                                          child:
                                              Text('لا توجد رحلات لهذا اليوم'),
                                        ),
                                      )
                                    : Expanded(
                                        child: ListView.builder(
                                          // shrinkWrap: true,
                                          itemCount: controller
                                              .resultTripCategory.length,
                                          itemBuilder: (context, index) =>
                                              TripCardUpdat(
                                            trip: controller
                                                .resultTripCategory[index],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      )),
                )),
            Positioned(
              top: 100,
              child: SizedBox(
                  width: Get.width,
                  height: 80,
                  child: GetBuilder<ServicesScreenController>(
                    id: 'SelectDataCategory',
                    init: ServicesScreenController(),
                    initState: (_) {},
                    builder: (_) {
                      return ScrollablePositionedList.separated(
                        // initialAlignment: controller.indexScroll.value * 50,
                        initialScrollIndex: controller.indexScroll.value,
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.groupDateTrip.length,
                        itemBuilder: (context, index) {
                          DateTime date = controller.groupDateTrip[index]!;
                          return GestureDetector(
                            onTap: () {
                              controller.selectByDataSpecific(date);
                            },
                            child: DefaultCountainer(
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 8.0, vertical: 5),
                              width: 60,
                              height: 30,
                              borderRadius: 10,
                              color: controller.currentDate == date
                                  ? Get.theme.colorScheme.primary
                                  : Get.theme.colorScheme.secondary,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      getDayArabic(date),
                                      style: Get.textTheme.headlineSmall!.merge(
                                          TextStyle(
                                              color:
                                                  controller.currentDate == date
                                                      ? Get.theme.colorScheme
                                                          .secondary
                                                      : Get.theme.colorScheme
                                                          .primary)),
                                    ),
                                    Text(
                                      getMonthString(date)!,
                                      style: Get.textTheme.headlineSmall!.merge(
                                          TextStyle(
                                              color:
                                                  controller.currentDate == date
                                                      ? Get.theme.colorScheme
                                                          .secondary
                                                      : Get.theme.colorScheme
                                                          .primary)),
                                    ),
                                    Text(
                                      getDayString(date)!,
                                      style: Get.textTheme.headlineSmall!.merge(
                                          TextStyle(
                                              color:
                                                  controller.currentDate == date
                                                      ? Get.theme.colorScheme
                                                          .secondary
                                                      : Get.theme.colorScheme
                                                          .primary)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 25,
                        ),
                      );
                    },
                  )),
            )
            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Expanded(
            //       child: PopupMenuButton<Company>(
            //         onSelected: (value) {
            //           controller.selectCompany.value = value;
            //         },
            //         child: Row(
            //           children: const [
            //             Icon(Icons.home_work, color: Colors.black),
            //             Text('حسب الشركة'),
            //           ],
            //         ),
            //         itemBuilder: (context) {
            //           return controller.company
            //               .asMap()
            //               .entries
            //               .map((e) => PopupMenuItem<Company>(
            //                   onTap: () {
            //                     controller.selectDropDown(3, e.value);
            //                   },
            //                   child: Text(
            //                     e.value.name!,
            //                     style: Get.textTheme.titleSmall!.merge(
            //                         TextStyle(color: Colors.black)),
            //                   )))
            //               .toList();
            //         },
            //       ),
            //     ),

            //     // PopupMenuButton<Category>(
            //     //   onSelected: (value) {
            //     //     controller.selectCategory.value = value;
            //     //     controller.selectDropDown(1, value);
            //     //   },
            //     //   child: Row(
            //     //     children: [
            //     //       Icon(Icons.category, color: Colors.black),
            //     //       Text('التصنيفات'),
            //     //     ],
            //     //   ),
            //     //   itemBuilder: (context) {
            //     //     return controller.category.value!.subCategory!
            //     //         .asMap()
            //     //         .entries
            //     //         .map((e) => PopupMenuItem<Category>(
            //     //             onTap: () {
            //     //               controller.selectDropDown(1, e.value);
            //     //             },
            //     //             child: Text(
            //     //               e.value.nameCategoryMain!,
            //     //               style: Get.textTheme.titleSmall!
            //     //                   .merge(TextStyle(color: Colors.black)),
            //     //             )))
            //     //         .toList();
            //     //   },
            //     // ),
            //     Obx(() => Expanded(
            //           flex: 2,
            //           child: Row(
            //             children: [
            //               Checkbox(
            //                   //  title: Text('عرض رحلات قبل التاريخ المحدد'),
            //                   value: controller.isShowBeforeTrip.value,
            //                   onChanged: (value) {
            //                     controller.isShowBeforeTrip.value =
            //                         value!;
            //                   }),
            //               Expanded(
            //                   child: Text('عرض رحلات قبل التاريخ المحدد'))
            //             ],
            //           ),
            //         )),
            //     // PopupMenuButton<Company>(
            //     //   onSelected: (value) {
            //     //     controller.selectCompany.value = value;
            //     //   },
            //     //   child: Row(
            //     //     children: [
            //     //       Icon(Icons.home_work, color: Colors.black),
            //     //       Text('حسب الشركة'),
            //     //     ],
            //     //   ),
            //     //   itemBuilder: (context) {
            //     //     return controller.company
            //     //         .asMap()
            //     //         .entries
            //     //         .map((e) => PopupMenuItem<Company>(
            //     //             onTap: () {
            //     //               controller.selectDropDown(3, e.value);
            //     //             },
            //     //             child: Text(
            //     //               e.value.name!,
            //     //               style: Get.textTheme.titleSmall!
            //     //                   .merge(TextStyle(color: Colors.black)),
            //     //             )))
            //     //         .toList();
            //     //   },
            //     // ),
            //     Spacer()
            //   ],
            // ),
            ,

            Positioned(
              top: 0,
              child: DefaultCountainer(
                color: Get.theme.colorScheme.primary,
                width: Get.width,
                height: 90,
                borderRadiusSpecific: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
            ),
            Positioned(
                top: 5,
                right: 3,
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Get.theme.colorScheme.secondary,
                    ))),
            // Positioned(
            //   top: 110,
            //   right: 10,
            //   child: PopupMenuButton<Category>(
            //     onSelected: (value) {
            //       controller.selectCategory.value = value;
            //       controller.selectDropDown(1, value);
            //     },
            //     child: Row(
            //       children: [
            //         Icon(Icons.category, color: Colors.black),
            //         Text('التصنيفات'),
            //       ],
            //     ),
            //     itemBuilder: (context) {
            //       return controller.category.value!.subCategory!
            //           .asMap()
            //           .entries
            //           .map((e) => PopupMenuItem<Category>(
            //                   child: Text(
            //                 e.value.nameCategoryMain!,
            //                 style: Get.textTheme.titleSmall!
            //                     .merge(TextStyle(color: Colors.black)),
            //               )))
            //           .toList();
            //     },
            //   ),
            // ),

            Positioned(
                top: 10,
                left: (Get.width / 2) - 20,
                child: GestureDetector(
                  onTap: () {
                    controller.test();
                  },
                  child: Text('الرحلات', style: Get.textTheme.titleLarge),
                )),
            Positioned(
                top: 0,
                left: 2,
                child: IconButton(
                  icon: DefaultIcon.svg(
                    path: 'icons/profile.svg',
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {
                    Get.back;
                  },
                )),
          ],
        ),
      ),
    ));
  }

  CustomScrollView tripVeiwScreen(BuildContext context) {
    return CustomScrollView(
      primary: true,
      slivers: [sliverBarCusttom(context), silverbodyView(context)],
    );
  }

  SliverToBoxAdapter silverbodyView(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(
        () => controller.isload.value
            ? Container(
                color: Get.theme.colorScheme.secondary,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                color: Get.theme.colorScheme.secondary,
                height: ((MediaQuery.of(context).size.height) / 3) * 2 + 20,
                child: ListView.builder(
                  itemCount: controller.resultTripCategory.length,
                  itemBuilder: (context, index) => TripCardUpdat(
                    trip: controller.resultTripCategory[index],
                  ),
                ),
              ),
      ),
    );
  }

  SliverAppBar sliverBarCusttom(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      // forceElevated: innerBoxIsScrolled,
      //backgroundColor: Get.theme.colorScheme.secondary,

      expandedHeight: ((MediaQuery.of(context).size.height) / 5),
      iconTheme: IconThemeData(color: Get.theme.primaryColor),
      centerTitle: true,
      floating: true,
      automaticallyImplyLeading: false,
      leading: Container(
        color: Get.theme.colorScheme.primary,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.menu,
                ),
                onPressed: () {
                  Get.back();
                }),
          ],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: ClipPath(
          clipper: WaveClipperOne(flip: true),
          child: Container(
              color: Get.theme.colorScheme.primary,
              width: MediaQuery.of(context).size.width,
              height: ((MediaQuery.of(context).size.height) / 3) * 1,
              child: Obx(
                () => controller.isload.value
                    ? Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              dropdownItemCategray(),
                              dropdwonItemWayCategory(),
                              dropdwonItemCompany()
                            ],
                          ),
                        ],
                      ),
              )),
        ),
      ),
    );
  }

  DefaultDropDown dropdownItemCategray() {
    return DefaultDropDown(
      hint: Text(
        LocaleKeys.TripScreen_selectCategeory.tr,
        style: Get.textTheme.titleSmall,
      ),
      items: controller.category.value!.subCategory!
          .map((element) => DropdownMenuItem(
              value: element,
              child: Text(
                element.nameCategoryMain!,
                style: Get.textTheme.titleSmall,
              )))
          .toList(),
      value: controller.selectCategory.value,
      onChanged: (p0) {
        controller.selectDropDown(1, p0);
      },
    );
  }

  Widget dropdwonItemWayCategory() {
    return controller.way.value == null
        ? Container()
        : DefaultDropDown(
            hint: Text(
              LocaleKeys.TripScreen_selectWay.tr,
              style: Get.textTheme.titleSmall,
            ),
            items: controller.way.value!.subCategory!
                .map((element) => DropdownMenuItem(
                    value: element,
                    child: Text(
                      element.nameCategoryMain!,
                      style: Get.textTheme.titleSmall,
                    )))
                .toList(),
            value: controller.selectWay.value,
            onChanged: (p0) {
              controller.selectDropDown(2, p0);
            },
          );
  }

  Widget dropdwonItemCompany() {
    return DefaultDropDown(
      hint: Text(
        'حسب الشركة',
        style: Get.textTheme.titleSmall,
      ),
      items: controller.company
          .map((element) => DropdownMenuItem(
              value: element,
              child: Text(
                element.name!,
                style: Get.textTheme.titleSmall,
              )))
          .toList(),
      value: controller.selectCompany.value,
      onChanged: (p0) {
        controller.selectDropDown(3, p0);
      },
    );
  }
}
