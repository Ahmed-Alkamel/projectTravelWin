import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/basic/category.dart';
import '../../../models/basic/country.dart';
import '../../../theme/color.dart';
import '../../../translations/locale.dart';
import '../../widgets/default_widget.dart';
import '../controllers/services_screen_controller.dart';

class SearchQueryView extends GetView<ServicesScreenController> {
  const SearchQueryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => controller.isload.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      width: Get.width,
                      child: Image.asset(
                        'images/appbar-min.jpg',
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 233,
                      child: DefaultCountainer(
                          width: Get.width,
                          height: Get.height - 250,

                          // color: Get.theme.colorScheme.secondary,
                          borderRadiusSpecific: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: LayoutPage(
                            controler: controller,
                          )))
                ],
              ),
      ),
    ));
  }
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.controler});
  final ServicesScreenController controler;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ContainedTabBarView(
        initialIndex: controler.currentTabWay.value,
        tabs: controler.category.value!.subCategory!
            .asMap()
            .entries
            .map((e) => DefaultCountainer(
                  color: controler.currentTabWay.value == e.key
                      ? Get.theme.colorScheme.primary
                      : Colors.grey.shade200,
                  borderRadiusSpecific: BorderRadius.only(
                    topRight: e.key == 0
                        ? const Radius.circular(25)
                        : const Radius.circular(5),
                    topLeft: e.key == 0
                        ? const Radius.circular(5)
                        : const Radius.circular(25),
                  ),
                  child: Center(
                      child: Text(e.value.nameCategoryMain!,
                          style: Get.theme.textTheme.headlineMedium!.merge(
                              TextStyle(
                                  color: controler.currentTabWay.value == e.key
                                      ? DefaultColor.textPrimary
                                      : DefaultColor.textSecandry))

                          // Get.textTheme.bodyLarge!.merge(
                          //     TextStyle(color: Get.theme.colorScheme.secondary))
                          // : Get.textTheme.bodyLarge!
                          //     .merge(const TextStyle(color: Colors.black)),
                          )),
                ))
            .toList(),
        views: controler.category.value!.subCategory!
            .asMap()
            .entries
            .map((e) => BodySearch(
                  categry: e.value,
                  controler: controler,
                ))
            .toList(),
        onChange: (p0) {
          controler.currentTabWayChange(p0);
        },
      ),
    );
  }
}

class BodySearch extends StatelessWidget {
  const BodySearch({super.key, required this.categry, required this.controler});
  final Category categry;
  final ServicesScreenController controler;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          child: ContainedTabBarView(
            initialIndex: controler.currentTabBody.value,
            tabs: categry.subCategory!
                .asMap()
                .entries
                .map((e) => DefaultCountainer(
                      padding: const EdgeInsets.all(2),
                      color: controler.currentTabBody.value == e.key
                          ? Get.theme.colorScheme.primary
                          : Colors.grey.shade200,
                      // borderRadiusSpecific: BorderRadius.only(
                      //   topRight:
                      //       e.key == 0 ? Radius.circular(25) : Radius.circular(5),
                      //   topLeft:
                      //       e.key == 0 ? Radius.circular(5) : Radius.circular(25),
                      // ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          e.value.idCategoryMain == 9 ||
                                  e.value.idCategoryMain == 12
                              ? DefaultIcon.svg(
                                  path: 'icons/plane1.svg',
                                  width: 22,
                                  height: 22,
                                  color: controler.currentTabBody.value == e.key
                                      ? Get.theme.colorScheme.secondary
                                      : Get.theme.colorScheme.primary)
                              : e.value.idCategoryMain == 10 ||
                                      e.value.idCategoryMain == 7
                                  ? DefaultIcon.svg(
                                      path: 'icons/bus.svg',
                                      width: 22,
                                      height: 22,
                                      color: controler.currentTabBody.value ==
                                              e.key
                                          ? Get.theme.colorScheme.secondary
                                          : Get.theme.colorScheme.primary)
                                  : DefaultIcon.svg(
                                      path: 'icons/boat.svg',
                                      width: 22,
                                      height: 22,
                                      color: controler.currentTabBody.value ==
                                              e.key
                                          ? Get.theme.colorScheme.secondary
                                          : Get.theme.colorScheme.primary),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(e.value.nameCategoryMain!,
                              style: Get.theme.textTheme.headlineMedium!.merge(
                                  TextStyle(
                                      color: controler.currentTabBody.value ==
                                              e.key
                                          ? DefaultColor.textPrimary
                                          : DefaultColor.textSecandry))),
                        ],
                      )),
                    ))
                .toList(),
            views: categry.subCategory!
                .asMap()
                .entries
                .map((e) => DataBody(
                      categry: categry,
                    ))
                .toList(),
            onChange: (p0) {
              controler.currentTabBodychange(p0);
            },
          ),
        ),
      ),
    );
  }
}

class DataBody extends GetView<ServicesScreenController> {
  const DataBody({super.key, required this.categry});
  final Category categry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
        left: 8.0,
        right: 8.0,
      ),
      child: SizedBox(
        height: double.infinity,
        // key: controller.keyForm,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<ServicesScreenController>(
              // init: ServicesScreenController(),
              id: 'PlanTrip',
              initState: (_) {},
              builder: (_) {
                return SizedBox(
                    width: Get.width,
                    height: 50,
                    child: Row(
                      children: controller.dataBasic.value!.planTrip!
                          .map((e) => Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Radio(
                                      value: e,
                                      groupValue: controller.currentPlan,
                                      onChanged: (value) {
                                        controller.choiceCurrentPlan(value!);
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        e.name!,
                                        style: Get.textTheme.headlineMedium,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ));
              },
            ),
            const Spacer(),
            GetBuilder<ServicesScreenController>(
              id: 'city',
              initState: (_) {},
              builder: (_) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: controller.currentPlan.id == 4
                      ? Colors.grey.withOpacity(0.2)
                      : Get.theme.colorScheme.secondary,
                  child: Column(
                    children: [
                      Column(
                        children: controller.selectTrip
                            .asMap()
                            .entries
                            .map((e) => Row(
                                  children: [
                                    controller.currentPlan.id == 4
                                        ? Text((e.key + 1).toString())
                                        : Container(),
                                    Expanded(
                                      child: CityItem(
                                        categry: categry,
                                        controller: controller,
                                        index: e.key,
                                      ),
                                    ),
                                    controller.selectTrip.length > 1
                                        ? IconButton(
                                            onPressed: () {
                                              controller.addOrDeleteSelectCity(
                                                  isAdd: false, index: e.key);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.grey.shade400,
                                            ))
                                        : Container()
                                  ],
                                ))
                            .toList(),
                      ),
                      controller.currentPlan.id == 4
                          ? GestureDetector(
                              onTap: () {
                                controller.addOrDeleteSelectCity(isAdd: true);
                              },
                              child: const DefaultIconTitle(
                                title: 'اضافة وجهة',
                                icon: Icon(Icons.add),
                                isVertical: false,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            )
                          : Container(),
                      Center(
                        child: Text(controller.errorCity,
                            style: Get.textTheme.bodyMedium!
                                .merge(const TextStyle(color: Colors.red))),
                      )
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            GetBuilder<ServicesScreenController>(
              id: 'DatTrip',
              initState: (_) {},
              builder: (_) {
                return Column(
                  children: [
                    Column(
                      children: controller.selectTrip
                          .asMap()
                          .entries
                          .map(
                            (e) => Column(
                              children: [
                                controller.currentPlan.id == 4
                                    ? Text('تاريخ الرحلة ${e.key + 1}')
                                    : Container(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: DefaultDataTimePickerWidget(
                                        calendarTitle: 'اختيار موعد المغادرة',
                                        confirmText: 'اختيار',
                                        cancelText: 'الغاء',
                                        firstDate: DateTime.now(),
                                        // initialDate: controller
                                        //             .selectTrip[e.key]
                                        //             .dateGo !=
                                        //         null
                                        //     ? controller
                                        //         .selectTrip[e.key].dateGo!
                                        //     : null,
                                        isborderall: true,
                                        label: Text(
                                          LocaleKeys.trip_dateAndTimeSeats.tr,
                                          style: Get.textTheme.headlineMedium,
                                        ),
                                        onChanged: (p0) {
                                          controller.selectTrip[e.key].dateGo =
                                              DateTime.tryParse(p0);
                                        },
                                      ),
                                    ),
                                    const Spacer(),
                                    controller.currentPlan.id == 4 ||
                                            controller.currentPlan.id == 2
                                        ? Expanded(
                                            flex: 3,
                                            child: DefaultDataTimePickerWidget(
                                              calendarTitle:
                                                  'اختيار موعد العودة',
                                              confirmText: 'اختيار',
                                              cancelText: 'الغاء',
                                              onChanged: (p0) {
                                                controller.selectTrip[e.key]
                                                        .dateBack =
                                                    DateTime.tryParse(p0);
                                              },
                                              isborderall: true,
                                              label: Text(
                                                'تاريخ العود',
                                                style: Get.textTheme.titleLarge,
                                              ),
                                            ),
                                          )
                                        : Expanded(flex: 3, child: Container()),
                                  ],
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    Center(
                      child: Text(controller.errorDate,
                          style: Get.textTheme.bodyMedium!
                              .merge(const TextStyle(color: Colors.red))),
                    )
                  ],
                );
              },
            ),
            const Spacer(),
            defaultButton(
                isResponseve: true,
                isIcon: false,
                lable: 'تم',
                onPressed: () async {
                  await controller.checkVaidatioin();
                })
          ],
        ),
      ),
    );
  }

  Future dialogCountPerson() async {
    return Get.defaultDialog(
        title: 'عدد المسافرين',
        confirm: defaultButton(
          isResponseve: false,
          isIcon: false,
          lable: 'عودة',
          onPressed: () {
            Get.back();
          },
        ),
        content: Column(children: [
          Row(
            children: [
              Expanded(child: DefaultText('البالغين')),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              controller.incrementCountTravels(id: 1);
                            },
                            icon: const Icon(Icons.add))),
                    Expanded(
                      child: Obx(() => Center(
                          child: DefaultText(
                              controller.countAdult.value.toString()))),
                    ),
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              controller.decrementCountTravels(id: 1);
                            },
                            icon: const Icon(Icons.remove))),
                  ],
                ),
              )
            ],
          ),
          controller.groubeVauleIsFamily.value
              ?
              //     ?
              Row(
                  children: [
                    Expanded(child: DefaultText('الأطفال اقل 12')),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    controller.incrementCountTravels(id: 2);
                                  },
                                  icon: const Icon(Icons.add))),
                          Expanded(
                            child: Obx(() => Center(
                                  child: DefaultText(controller
                                      .countChildern.value
                                      .toString()),
                                )),
                          ),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    controller.decrementCountTravels(id: 2);
                                  },
                                  icon: const Icon(Icons.remove))),
                        ],
                      ),
                    )
                  ],
                )
              : Container(),
          controller.groubeVauleIsFamily.value
              ? Row(
                  children: [
                    Expanded(child: DefaultText('الرضع اقل من سنتين')),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    controller.incrementCountTravels(id: 3);
                                  },
                                  icon: const Icon(Icons.add))),
                          Expanded(
                            child: Obx(() => Center(
                                  child: DefaultText(
                                      controller.countbaby.value.toString()),
                                )),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                controller.decrementCountTravels(id: 3);
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Container()
        ]));
  }
}

class DefaultIconTitle extends StatelessWidget {
  const DefaultIconTitle(
      {super.key,
      required this.icon,
      this.mainAxisAlignment,
      required this.title,
      required this.isVertical});

  final Widget icon;
  final String title;
  final bool isVertical;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              icon,
              Text(title, style: Get.theme.textTheme.titleMedium)
            ],
          )
        : Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              icon,
              Text(title, style: Get.theme.textTheme.titleMedium)
            ],
          );
  }
}

class CityItem extends StatelessWidget {
  const CityItem(
      {super.key,
      required this.controller,
      required this.categry,
      required this.index});

  final ServicesScreenController controller;
  final Category categry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
                onPressed: () {
                  searchBottomSheet(
                      controller,
                      categry.idCategoryMain == 5
                          ? controller.dataBasic.value!.countries!
                              .where(
                                (element) =>
                                    element.isLocal == true &&
                                    element.cities!.isNotEmpty,
                              )
                              .toList()
                          : categry.idCategoryMain == 6
                              ? controller.dataBasic.value!.countries!
                                  .where(
                                    (element) => element.cities!.isNotEmpty,
                                  )
                                  .toList()
                              : controller.dataBasic.value!.countries!,
                      1,
                      indexParent: index);
                },
                child: GetBuilder<ServicesScreenController>(
                  // init: ServicesScreenController(),
                  id: 'city',
                  initState: (_) {},
                  builder: (_) {
                    return Text(
                      controller.selectTrip[index].fromCity == null
                          ? LocaleKeys.trip_fromCity.tr
                          : controller.selectTrip[index].fromCity!.name!,
                      style: Get.textTheme.headlineMedium,
                    );
                  },
                )),
          ),
          DefaultIcon(icon: Icons.arrow_circle_left_outlined, size: 40),
          Expanded(
            child: TextButton(
                onPressed: () {
                  searchBottomSheet(
                      controller,
                      categry.idCategoryMain == 5
                          ? controller.dataBasic.value!.countries!
                              .where(
                                (element) =>
                                    element.isLocal == true &&
                                    element.cities!.isNotEmpty,
                              )
                              .toList()
                          : categry.idCategoryMain == 6
                              ? controller.dataBasic.value!.countries!
                                  .where(
                                    (element) =>
                                        element.isLocal == false &&
                                        element.cities!.isNotEmpty,
                                  )
                                  .toList()
                              : controller.dataBasic.value!.countries!,
                      2,
                      indexParent: index);
                },
                child: GetBuilder<ServicesScreenController>(
                  // init: ServicesScreenController(),
                  id: 'city',
                  initState: (_) {},
                  builder: (_) {
                    return Text(
                      controller.selectTrip[index].toCity == null
                          ? LocaleKeys.trip_ToCity.tr
                          : controller.selectTrip[index].toCity!.name!,
                      style: Get.textTheme.headlineMedium,
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}

Future searchBottomSheet(
    ServicesScreenController controller, List<Countries> countries, int type,
    {required int indexParent}) {
  controller.searchCityList = countries;
  return Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: true,
      SafeArea(
          child: Container(
              color: Get.theme.colorScheme.secondary,
              height: Get.height - 100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: DefaultIcon(
                          icon: Icons.close,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: DefaultTextFormField(
                        suffixIcon: DefaultIcon(icon: Icons.search),
                        facaColor: Colors.black,
                        hintText: 'بحث',
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            controller.searchCityList = countries;
                            controller.searchCity(isChange: false);
                          } else {
                            controller.searchCity(
                                isChange: true, value: p0, dataOrig: countries);
                          }
                        },
                        isborderall: true),
                  ),
                  GetBuilder<ServicesScreenController>(
                    // init: MyController(),
                    id: 'resueltSearchCity',
                    initState: (_) {},
                    builder: (_) {
                      return Expanded(
                        child: controller.searchCityList!.isEmpty ||
                                controller.searchCityList == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: controller.searchCityList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        color: Get.theme.colorScheme.primary
                                            .withOpacity(0.7),
                                        child: ListTile(
                                          title: Text(
                                            controller.searchCityList![index]
                                                .countryName!,
                                            style: Get.textTheme.headlineMedium!
                                                .merge(TextStyle(
                                                    color: Get.theme.colorScheme
                                                        .secondary)),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .searchCityList![index]
                                            .cities!
                                            .length,
                                        itemBuilder: (BuildContext context,
                                            int childIndex) {
                                          return ListTile(
                                            title: GestureDetector(
                                              onTap: () {
                                                controller.selectedCity(
                                                    countries[index]
                                                        .cities![childIndex],
                                                    type,
                                                    indexParent);
                                                Get.back();
                                              },
                                              child: Text(
                                                controller
                                                    .searchCityList![index]
                                                    .cities![childIndex]
                                                    .name!,
                                                style: Get
                                                    .textTheme.headlineMedium,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                      );
                    },
                  ),
                ],
              )

              // child: Column(
              //   children: [
              //     Column(
              //       children: countries
              //           .map((e) => Column(children: [
              //                 Row(
              //                   children: [
              //                     Text(e.countryName!),
              //                   ],
              //                 ),
              //                 Container(
              //                   height: double.infinity,
              //                   child: Column(
              //                     children: e.cities!
              //                         .map((e) => Expanded(
              //                               child: ListTile(
              //                                 title: Text(e.name!),
              //                               ),
              //                             ))
              //                         .toList(),
              //                   ),
              //                 )
              //               ]))
              //           .toList(),
              //     ),
              //     Spacer()
              //   ],
              // )),
              )));
}
