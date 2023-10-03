// import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projecttravelwin/app/models/basic/company.dart';
import 'package:projecttravelwin/app/models/basic/country.dart';
// import 'package:projecttravelwin/app/theme/color.dart';

import '../../../Helper/validation.dart';
import '../../../commen/ui.dart';
import '../../../models/basic/checkbox_scheduler.dart';
import '../../../models/basic/currencies.dart';
import '../../../models/basic/data_basic_add_trip.dart';
import '../../../models/basic/trips.dart';
// import '../../addService/views/add_service_view.dart';
import '../../widgets/default_widget.dart';
import '../../widgets/main_widget.dart';
import '../../widgets/main_widget_desktop.dart';
import '../controllers/trips_desktop_controller.dart';

class AddTripView extends GetView<TripsDesktopController> {
  const AddTripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBarDesktop(
          title: 'اضافة رحلة',
        ),
        iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.isLoadAddService.value
                ? const Center(
                    child: DefaultCircalProgress(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            child: DefaultDataTable(
                              columns: [
                                headerColumnDefault("رقم الرحلة"),
                                headerColumnDefault('اسم الشركة'),
                                headerColumnDefault('من مدينة'),
                                headerColumnDefault('الى مدينة'),
                                headerColumnDefault('موعد الرحلة'),
                                headerColumnDefault('السعر'),
                                headerColumnDefault('العملة'),
                                headerColumnDefault('تفاصيل')
                              ],
                              rows: controller.trips == null ||
                                      controller.trips!.isEmpty
                                  ? []
                                  : controller.trips!
                                      .map((e) => DataRow(cells: [
                                            DataCell(DefaultWidgetDataCell(
                                              data: e.idTrips!.toString(),
                                            )),
                                            DataCell(DefaultWidgetDataCell(
                                              data: e.company!.name.toString(),
                                            )),
                                            DataCell(DefaultWidgetDataCell(
                                              data: e.fromCity!.name.toString(),
                                            )),
                                            DataCell(DefaultWidgetDataCell(
                                              data: e.toCity!.name.toString(),
                                            )),
                                            DataCell(DefaultWidgetDataCell(
                                              data: e.timeLeave == null
                                                  ? 'غير متوفر'
                                                  : DateFormat.jm('ar').format(
                                                      DateTime(
                                                          2023,
                                                          1,
                                                          1,
                                                          e.timeLeave!.hour,
                                                          e.timeLeave!.minute)),
                                            )),
                                            DataCell(DefaultWidgetDataCell(
                                              data: e.price.toString(),
                                            )),
                                            DataCell(DefaultWidgetDataCell(
                                              data: e.currencie!.name!,
                                            )),
                                            DataCell(
                                                Column(
                                                  children: [
                                                    const Icon(
                                                        Icons.show_chart),
                                                    Text(
                                                      "تفاصيل",
                                                      style: Get.textTheme
                                                          .headlineSmall,
                                                    ),
                                                  ],
                                                ), onTap: () async {
                                              await showDetailsTrip(e);
                                            }),
                                          ]))
                                      .toList(),
                            ),
                          ),
                        ),
                        BottomNavigationProcess(
                          onPressedAdd: () async {
                            if (controller.dataBasciAdd!.company == null ||
                                controller.dataBasciAdd!.company!.isEmpty) {
                              await UiApp.snakNote('تنبية',
                                  "لا توجد خدمات ارجاء اضافة الخدمة اولا");
                            } else {
                              await addDialgoTrip(context);
                              controller.newTrip = null;
                            }
                          },
                        ),
                      ],
                    ),
                  )),
          ),
          const LogoBottomScreen()
        ],
      ),
    );
  }

  Future addDialgoTrip(BuildContext context) async {
    controller.newTrip = Trips();
    TextEditingController textcontroller = TextEditingController();
    ServiceMine? serviceMine;
    if (serviceMine != null) {
      controller.newTrip!.category = serviceMine.category;
    }
    Countries? countries;
    Countries? countriesTo;
    GlobalKey<FormState> keyform = GlobalKey<FormState>();

    List<CheckboxScheduler> checkScheduler = [
      CheckboxScheduler(id: 1, title: 'يوميا', value: true),
      CheckboxScheduler(id: 2, title: 'كل اسبوعين', value: false),
      CheckboxScheduler(id: 3, title: 'كل ثلاث اسابيع', value: false),
      CheckboxScheduler(id: 4, title: 'مخصص', value: false)
    ];
    CheckboxScheduler isSelected = checkScheduler.first;
    controller.newTrip!.scheduler!.days = controller.dataBasciAdd!.days!
        .where((element) => element.id != 5)
        .toList();
    controller.newTrip!.scheduler!.atCount = 1;
    controller.newTrip!.scheduler!.method =
        controller.dataBasciAdd!.methodScheduler!.first;
    return await UiApp.defaultDeialog(
        title: 'اضافة رحلة',
        titleStyle: Get.textTheme.headlineLarge,
        // backgroundColor: Get.theme.colorScheme.secondary,
        content: SingleChildScrollView(
          child: Form(
            key: keyform,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultDropDownForm(
                      label: const Text(
                        'تصنيف الرحلة',
                        // style: Get.textTheme.headlineMedium,
                      ),
                      dataList: controller.dataBasciAdd!.serviceMine,
                      onChanged: (value) {
                        if (value is ServiceMine) {
                          controller.newTrip!.idService = value.idServ;
                          controller.newTrip!.category = value.category;
                          controller.newTrip?.fromCity = null;
                          controller.newTrip?.toCity = null;
                          serviceMine = value;
                          controller.updatecompanyServicesProvider();
                          controller.updateTripGoalAllOver();
                        }
                      },
                      value: serviceMine),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<TripsDesktopController>(
                    // init: MyController(),
                    id: 'companyServicesProvider',
                    initState: (_) {},
                    builder: (_) {
                      return DefaultDropDownForm(
                          label: const Text(
                            'موفر الخدمة/الشركة',
                            // style: Get.textTheme.headlineSmall,
                          ),
                          dataList: controller.dataBasciAdd!.company!
                              .where((element) => element
                                  .servicesCompanyProvider!
                                  .any((e) => e == serviceMine))
                              .toList(),
                          onChanged: (value) {
                            if (value is Company?) {
                              controller.newTrip!.company = value;
                            }
                          },
                          value: controller.newTrip!.company);
                    },
                  ),
                  BorderCoverWidget(
                    label: 'السعر',
                    child: Row(
                      children: [
                        Expanded(
                          child: DefaultTextFormField(
                            validator: (p0) => ValidatorApp.getVaidator(
                                ValidateType.required, p0),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  // RegExp(r'^[0-9]d{3}$'

                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            isborderall: true,
                            label: 'السعر',
                            onchange: (value) {
                              if (value.isNotEmpty) {
                                controller.newTrip!.price = double.parse(value);
                              }
                            },
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 3,
                          child: DefaultDropDownForm(
                              label: const Text(
                                'نوع العملة',
                                // style: Get.textTheme.headlineSmall,
                              ),
                              dataList: controller.dataBasciAdd!.currencies,
                              validator: (p0) => ValidatorApp.getVaidator(
                                  ValidateType.required,
                                  p0 is Currencies ? p0.name : p0),
                              onChanged: (value) {
                                if (value is Currencies) {
                                  controller.newTrip!.currencie = value;
                                }
                              },
                              value: controller.newTrip!.currencie),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<TripsDesktopController>(
                      // init: AddTripController(),
                      id: 'TripGoalAllOver',
                      initState: (_) {},
                      builder: (_) {
                        return BorderCoverWidget(
                          label: 'تحديد وجهة الرحلة',
                          child: Column(
                            children: [
                              if (controller.newTrip!.category == null)
                                const SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text('قم بتحديد '),
                                  ),
                                ),
                              GetBuilder<TripsDesktopController>(
                                // init: AddTripController(),
                                id: 'TripGoalCity',
                                initState: (_) {},
                                builder: (_) {
                                  if (controller.newTrip!.category
                                          ?.levelTwoCategory ==
                                      5) {
                                    return Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: DefaultDropDownForm(
                                                label: const Text(
                                                  'من مدينة',
                                                  // style: Get
                                                  //     .textTheme.headlineSmall,
                                                ),
                                                dataList:
                                                    controller.getCiryLocal(),
                                                onChanged: (value) {
                                                  if (value is City) {
                                                    controller.newTrip!
                                                        .fromCity = value;
                                                  }
                                                  controller
                                                      .updatalocalToCity();
                                                },
                                                value: controller
                                                    .newTrip!.fromCity)),
                                        const Spacer(),
                                        Expanded(
                                            flex: 2,
                                            child: GetBuilder<
                                                TripsDesktopController>(
                                              // init: MyController(),
                                              id: 'localToCity',
                                              initState: (_) {},
                                              builder: (_) {
                                                return controller.newTrip!
                                                            .fromCity ==
                                                        null
                                                    ? Container()
                                                    : DefaultDropDownForm(
                                                        label: const Text(
                                                          'الى مدينة',
                                                          // style: Get.textTheme
                                                          //     .headlineSmall,
                                                        ),
                                                        dataList: controller
                                                            .getlocolGoalCity
                                                            .where((element) =>
                                                                element !=
                                                                controller
                                                                    .newTrip!
                                                                    .fromCity)
                                                            .toList(),
                                                        onChanged: (value) {
                                                          if (value is City) {
                                                            controller.newTrip!
                                                                .toCity = value;
                                                          }
                                                        },
                                                        value: controller
                                                            .newTrip!.toCity);
                                              },
                                            ))
                                      ],
                                    );
                                  } else if (controller.newTrip!.category
                                          ?.levelTwoCategory ==
                                      6) {
                                    return Column(
                                      children: [
                                        BorderCoverWidget(
                                          label: 'من مدينة',
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: DefaultDropDownForm(
                                                      label: const Text(
                                                        'اسم الدولة',
                                                        // style: Get.textTheme
                                                        //     .headlineSmall,
                                                      ),
                                                      dataList: controller
                                                          .dataBasciAdd!
                                                          .countries!
                                                          .where((element) =>
                                                              element.cities!
                                                                  .isNotEmpty)
                                                          .toList(),
                                                      onChanged: (value) {
                                                        // controller.updateFromCityGlobal();
                                                        if (value
                                                            is Countries?) {
                                                          countries = value;
                                                          if (value!.cities!
                                                              .isEmpty) {
                                                            controller.newTrip!
                                                                    .fromCity =
                                                                null;
                                                          } else {
                                                            controller.newTrip!
                                                                    .fromCity =
                                                                value.cities!
                                                                    .first;
                                                          }
                                                          // value!.cities != null
                                                          //     ? value.cities!.first
                                                          //     : null;
                                                        }
                                                        controller
                                                            .updateTripGoalCity();
                                                        controller
                                                            .updatetoCityForm();
                                                      },
                                                      value: countries)),
                                              const Spacer(),
                                              Expanded(
                                                  flex: 2,
                                                  child: GetBuilder<
                                                          TripsDesktopController>(
                                                      // init: TripDesktopController(),
                                                      id: 'FromCityGlobal',
                                                      initState: (_) {},
                                                      builder: (_) {
                                                        if (countries == null) {
                                                          return Container();
                                                        } else if (countries!
                                                                    .cities ==
                                                                null &&
                                                            countries!.cities!
                                                                .isEmpty) {
                                                          return Container();
                                                        }
                                                        //  else if (newTrip.fromCity != null) {
                                                        //   return Container();
                                                        // }
                                                        else {
                                                          return DefaultDropDownForm(
                                                              label: const Text(
                                                                'اسم المدينة',
                                                                // style: Get
                                                                //     .textTheme
                                                                //     .headlineSmall,
                                                              ),
                                                              dataList: controller
                                                                  .getCityGlobal(
                                                                      countries),
                                                              onChanged:
                                                                  (value) {
                                                                if (value
                                                                    is City) {
                                                                  controller
                                                                      .newTrip!
                                                                      .fromCity = value;
                                                                  // controller
                                                                  //     .updateTripGoalCity();
                                                                }
                                                              },
                                                              value: controller
                                                                  .newTrip!
                                                                  .fromCity);
                                                        }
                                                      }))
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              GetBuilder<TripsDesktopController>(
                                // init: TripDesktopController(),
                                id: 'toCityForm',
                                initState: (_) {},
                                builder: (_) {
                                  if (controller.newTrip!.category == null) {
                                    return Container();
                                  } else if (controller.newTrip!.category!
                                          .levelTwoCategory ==
                                      6) {
                                    return BorderCoverWidget(
                                      label: 'الى مدينة',
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: DefaultDropDownForm(
                                                  label: const Text(
                                                    'اسم الدولة',
                                                    // style: Get.textTheme
                                                    //     .headlineSmall,
                                                  ),
                                                  dataList: controller
                                                      .dataBasciAdd!.countries!
                                                      .where((element) =>
                                                          element.cities!
                                                              .isNotEmpty &&
                                                          element.isLocal ==
                                                              false)
                                                      .toList(),
                                                  onChanged: (value) {
                                                    // controller.updateFromCityGlobal();
                                                    if (value is Countries?) {
                                                      countriesTo = value;
                                                      if (value!
                                                          .cities!.isEmpty) {
                                                        controller.newTrip!
                                                            .toCity = null;
                                                      } else {
                                                        controller.newTrip!
                                                                .toCity =
                                                            value.cities!.first;
                                                      }
                                                      // value!.cities != null
                                                      //     ? value.cities!.first
                                                      //     : null;
                                                    }
                                                    controller
                                                        .updatetoCityGlobal();
                                                  },
                                                  value: countriesTo)),
                                          const Spacer(),
                                          Expanded(
                                              flex: 2,
                                              child: GetBuilder<
                                                      TripsDesktopController>(
                                                  // init: TripDesktopController(),
                                                  id: 'toCityGlobal',
                                                  initState: (_) {},
                                                  builder: (_) {
                                                    if (countriesTo == null) {
                                                      return Container();
                                                    } else if (countriesTo!
                                                                .cities ==
                                                            null &&
                                                        countriesTo!
                                                            .cities!.isEmpty) {
                                                      return Container();
                                                    }
                                                    //  else if (newTrip.fromCity != null) {
                                                    //   return Container();
                                                    // }
                                                    else {
                                                      return DefaultDropDownForm(
                                                          label: const Text(
                                                            'اسم المدينة',
                                                            // style: Get.textTheme
                                                            //     .headlineSmall,
                                                          ),
                                                          dataList: controller
                                                              .getCityGlobal(
                                                                  countriesTo),
                                                          onChanged: (value) {
                                                            if (value is City) {
                                                              controller
                                                                      .newTrip!
                                                                      .toCity =
                                                                  value;
                                                              // controller
                                                              //     .updateTripGoalCity();
                                                            }
                                                          },
                                                          value: controller
                                                              .newTrip!.toCity);
                                                    }
                                                  }))
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                  BorderCoverWidget(
                      label: 'جدولة الرحلة',
                      child: Column(
                        children: [
                          GetBuilder<TripsDesktopController>(
                            // init: MyController(),
                            id: 'selectCheckbox',
                            initState: (_) {},
                            builder: (_) {
                              return Row(
                                children: checkScheduler
                                    .map((e) => Expanded(
                                          child: DefaultCheckboxCustom(
                                            title: e.title,
                                            value: e == isSelected,
                                            onChanged: (value) {
                                              isSelected = e;
                                              if (isSelected.id != 4) {
                                                controller.newTrip!.scheduler!
                                                    .atCount = isSelected.id;
                                              }
                                              controller.updateselectCheckbox();
                                            },
                                          ),
                                        ))
                                    .toList(),
                              );
                            },
                          ),
                          GetBuilder<TripsDesktopController>(
                            // init: MyController(),
                            id: 'atcountCustom',
                            initState: (_) {},
                            builder: (_) {
                              return isSelected.id == 4
                                  ? Row(
                                      children: [
                                        const Spacer(
                                          flex: 2,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: DefaultTextFormField(
                                            // initialValue:
                                            //    e.value.name,
                                            isborderall: true,
                                            validator: (value) =>
                                                ValidatorApp.getVaidator(
                                                    ValidateType.required,
                                                    value),

                                            // maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  // RegExp(r'^[0-9]d{3}$'

                                                  RegExp(r'^\d+\.?\d{0,2}')),
                                            ],
                                            label: "جدولة كل",
                                            hintText:
                                                'مثل اذا كان كل اسبوع ادخل الرقم 1 او اكل اسبوعين 2 ',
                                            onchange: (value) {
                                              if (value.isNotEmpty) {
                                                controller.newTrip!.scheduler!
                                                        .atCount =
                                                    int.tryParse(value);
                                              }
                                            },
                                          ),
                                        ),
                                        const Spacer(
                                          flex: 2,
                                        ),
                                      ],
                                    )
                                  : Container();
                            },
                          ),
                          GetBuilder<TripsDesktopController>(
                            // init: MyController(),
                            id: 'checkDays',
                            initState: (_) {},
                            builder: (_) {
                              return Column(
                                children: [
                                  Text(
                                    'تحديد  الايام',
                                    style: Get.textTheme.displaySmall,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: controller.dataBasciAdd!.days!
                                            .map(
                                              (e) => Row(
                                                children: [
                                                  Checkbox(
                                                      value: controller
                                                                  .newTrip!
                                                                  .scheduler!
                                                                  .days ==
                                                              null
                                                          ? false
                                                          : controller
                                                                      .newTrip!
                                                                      .scheduler!
                                                                      .days ==
                                                                  null
                                                              ? false
                                                              : controller
                                                                  .newTrip!
                                                                  .scheduler!
                                                                  .days!
                                                                  .any((element) =>
                                                                      element ==
                                                                      e),
                                                      onChanged: (value) {
                                                        if (value == true) {
                                                          controller.newTrip!
                                                              .scheduler!.days!
                                                              .add(e);
                                                        } else {
                                                          controller.newTrip!
                                                              .scheduler!.days!
                                                              .remove(e);
                                                        }
                                                        controller
                                                            .updatecheckDays();
                                                      }),
                                                  Text(
                                                    e.name!,
                                                    style: Get
                                                        .textTheme.displaySmall,
                                                  )
                                                ],
                                              ),
                                            )
                                            .toList()),
                                  ),
                                ],
                              );
                            },
                          ),
                          GetBuilder<TripsDesktopController>(
                            // init: MyController(),
                            initState: (_) {},
                            id: 'toTimeLive',
                            builder: (_) {
                              return GetBuilder<TripsDesktopController>(
                                // init: TripsDesktopController(),
                                id: 'timeLive',
                                initState: (_) {},
                                builder: (_) {
                                  return DefaultTextFormField(
                                    width: 150,
                                    suffixIcon: Icon(
                                      Icons.alarm,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    controller: textcontroller,
                                    onTap: () async {
                                      // controller.newTrip!.timeLeave

                                      TimeOfDay? timeLeave =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());

                                      if (timeLeave != null) {
                                        controller.newTrip!.timeLeave =
                                            timeLeave;
                                        textcontroller.text =
                                            DateFormat.jm('ar').format(DateTime(
                                                2023,
                                                1,
                                                1,
                                                controller
                                                    .newTrip!.timeLeave!.hour,
                                                controller.newTrip!.timeLeave!
                                                    .minute));
                                      }

                                      // controller.updatetimeLive();
                                    },
                                    isborderall: true,
                                    label: 'وقت الرحلة',
                                    readOnly: true,
                                    // initialValue: DateFormat.jm('ar')
                                    //     .format(DateTime.now()),
                                    onEditingComplete: () {
                                      controller.updatetimeLive();
                                    },
                                  );
                                },
                              );
                            },
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        confirm: UiApp.buttonDone(
            lable: 'اضافة',
            onPressed: () async {
              if (keyform.currentState!.validate()) {
                Get.back();
                await controller.saveTrip();
              }
            }),
        onWillPop: () {
          return Future.value(false);
        },
        cancel: UiApp.buttonCansal(
            lable: 'الغاء',
            onPressed: () {
              Get.back();
            }));
  }
}

Future showDetailsTrip(Trips trip) async {
  return await UiApp.defaultDeialog(
      title: 'التفاصيل',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BorderCoverWidget(
                label: 'اسلوب الجدولة',
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'كل '.toString() +
                        ' '.toString() +
                        trip.scheduler!.method!.name! +
                        ' '.toString() +
                        trip.scheduler!.atCount!.toString(),
                    style: Get.textTheme.headlineSmall,
                  ),
                )),
            BorderCoverWidget(
                label: "ايام الرحلة",
                child: Row(
                  children: trip.scheduler!.days!
                      .map((e) => Text(
                            e.name! + ' - '.toString(),
                            style: Get.textTheme.headlineSmall,
                          ))
                      .toList(),
                ))
          ],
        ),
      ));
}

class DefaultCheckboxCustom extends StatelessWidget {
  const DefaultCheckboxCustom({
    super.key,
    this.onChanged,
    required this.value,
    required this.title,
  });
  final void Function(bool?)? onChanged;
  final bool? value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          onChanged: onChanged,
          value: value,
        ),
        Expanded(
          child: Text(
            title,
            style: Get.textTheme.headlineSmall,
          ),
        )
      ],
    );
  }
}
