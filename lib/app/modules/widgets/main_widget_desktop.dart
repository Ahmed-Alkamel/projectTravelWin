import 'dart:ffi' as ff;
import 'dart:io' as oi;
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as paath;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projecttravelwin/app/Helper/diohelper.dart';
import 'package:projecttravelwin/app/commen/ui.dart';

import '../../data/local/local_data.dart';
import '../../models/basic/customer.dart';
import '../../models/basic/identity_customers.dart';
import '../../models/basic/requst_service_booking.dart';
import '../../theme/color.dart';
import '../../translations/locale.dart';
import '../customer_request_desktop/controllers/customer_request_desktop_controller.dart';
import 'default_widget.dart';

class ItemCardOperationServices extends StatelessWidget {
  const ItemCardOperationServices({
    super.key,
    required this.title,
    required this.childern,
  });
  final String title;
  final List<Widget> childern;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          LableWithLine(
            title: title,
          ),
          Expanded(
            child: OpetionItem(
              children: childern,
            ),
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}

class OpetionItem extends StatelessWidget {
  const OpetionItem({
    super.key,
    required this.children,
  });
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Row(
        // childAspectRatio: 1 / 2,
        // crossAxisCount: 3,

        children: children);
  }
}

class ItemCardMain extends StatelessWidget {
  const ItemCardMain({
    super.key,
    this.onTap,
    this.color,
    required this.title,
  });
  final void Function()? onTap;
  final Color? color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        child: Center(
          child: Text(
            title,
            style: Get.textTheme.headlineLarge!
                .merge(TextStyle(color: Get.theme.colorScheme.secondary)),
          ),
        ),
      ),
    );
  }
}

class LableWithLine extends StatelessWidget {
  const LableWithLine({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 50,
      child: Stack(
        children: [
          Positioned(
              top: 12,
              child: Container(
                width: Get.width,
                child: Divider(
                  height: 5,
                  thickness: 2,
                  color: Get.theme.colorScheme.primary,
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                  color: Colors.white,
                  child: Text(
                    title,
                    style: Get.textTheme.headlineLarge,
                  )))
        ],
      ),
    );
  }
}

class IntrodicationView extends StatelessWidget {
  const IntrodicationView({
    super.key,
    required this.title,
    required this.pr1Title,
    this.pr1OnTap,
    required this.pr2Title,
    this.pr2OnTap,
    required this.pr3Title,
    this.pr3OnTap,
  });
  final String title;
  final String pr1Title;
  final void Function()? pr1OnTap;
  final String pr2Title;
  final void Function()? pr2OnTap;
  final String pr3Title;
  final void Function()? pr3OnTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ItemCardOperationServices(
          title: title,
          childern: [
            Expanded(
              child: ItemCardMain(
                title: pr1Title,
                color: DefaultColor.containTheme2,
                onTap: pr1OnTap,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: ItemCardMain(
                title: pr2Title,
                color: DefaultColor.containTheme1,
                onTap: pr2OnTap,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: ItemCardMain(
                title: pr3Title,
                color: DefaultColor.containTheme3,
                onTap: pr3OnTap,
              ),
            )
          ],
        )),
      ],
    );
  }
}

class TitleAppBarDesktop extends StatelessWidget {
  const TitleAppBarDesktop({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Get.textTheme.titleLarge,
    );
  }
}

DataColumn headerColumnDefault(String lable) {
  return DataColumn(
      label: Container(
    child: AutoSizeText(
      lable,
      maxLines: 2,
      style: Get.textTheme.headlineSmall!
          .merge(TextStyle(color: Get.theme.colorScheme.secondary)),
      overflow: TextOverflow.ellipsis,
    ),
  ));
}

class BottomNavigationProcess extends StatelessWidget {
  const BottomNavigationProcess(
      {super.key,
      this.onPressedAdd,
      this.onPressedEdite,
      this.onPressedDelete});

  final void Function()? onPressedAdd;
  final void Function()? onPressedEdite;
  final void Function()? onPressedDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: defaultButton(
          isResponseve: true,
          isIcon: true,
          lable: 'اضافة ',
          icon: Icon(
            Icons.add,
            color: Get.theme.colorScheme.secondary,
          ),
          onPressed: onPressedAdd,
        )),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: defaultButton(
              isResponseve: true,
              isIcon: true,
              lable: 'تعديل ',
              icon: Icon(
                Icons.edit,
                color: Get.theme.colorScheme.secondary,
              ),
              onPressed: onPressedEdite),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: defaultButton(
              isResponseve: true,
              isIcon: true,
              lable: 'حذف ',
              icon: Icon(
                Icons.delete,
                color: Get.theme.colorScheme.secondary,
              ),
              onPressed: onPressedDelete),
        ),
        Expanded(flex: 2, child: Container())
      ],
    );
  }
}

class DefaultDataTable extends StatelessWidget {
  const DefaultDataTable(
      {super.key, required this.columns, required this.rows});
  final List<DataColumn> columns;
  final List<DataRow> rows;
  @override
  Widget build(BuildContext context) {
    return DataTable2(
        dataRowHeight: 56.0,
        // headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue), // Set the header row color

        dividerThickness: 2,
        decoration: BoxDecoration(
            border: Border.all(color: Get.theme.colorScheme.primary)),
        showBottomBorder: true,
        headingRowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Get.theme.colorScheme.primary;
          }
          return Get.theme.colorScheme.primary; // Use the default value.
        }),
        columns: columns,
        columnSpacing: double.minPositive,
        rows: rows);
  }
}

class DefaultWidgetDataCell extends StatelessWidget {
  const DefaultWidgetDataCell(
      {super.key, required this.data, this.textAlign, this.style});
  final String data;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign ?? TextAlign.center,
      style: style ?? Get.textTheme.headlineSmall,
    );
  }
}

class LogoBottomScreen extends StatelessWidget {
  const LogoBottomScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Get.theme.colorScheme.primary,
      child: Center(
          child: Text(
        'Yemen Travel 2023',
        style: Get.textTheme.titleSmall,
      )),
    );
  }
}

class SizedDilogContaint extends StatelessWidget {
  const SizedDilogContaint(
      {super.key, required this.child, this.width, this.height, this.color});
  final Widget? child;
  final double? width;
  final double? height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 10),
      // padding: const EdgeInsets.all(12),
      color: color ?? Get.theme.colorScheme.secondary,
      width: width ?? Get.width / 3 * 2,
      height: height ?? Get.height - 300, child: child,
    );
  }
}

class CustomerIdentenyItemDesktop extends GetView {
  const CustomerIdentenyItemDesktop(
      {super.key,
      required this.identity,
      required this.isShowonly,
      this.onChanged});
  final void Function(bool?)? onChanged;
  final bool isShowonly;
  final IdentityCustomers identity;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: DefaultIcon.svg(
        path: 'icons/profile.svg',
        width: 40,
        height: 40,
      ),
      title: Text(identity.nameid!, style: Get.textTheme.headlineMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              LocaleKeys.personalData_gender.tr +
                  DataConst.comme +
                  identity.gender.value!.nameAr!,
              style: Get.textTheme.headlineMedium),
          Text(
            'تاريخ الميلاد'.toString() +
                DataConst.comme +
                DateFormat.yMEd('ar')
                    .format(DateTime.parse(identity.datePirth!)),
            style: Get.textTheme.headlineMedium,
          ),
          Text(
              'الحالة الاجتماعية'.toString() +
                  DataConst.comme +
                  identity.martial.value!.nameAr!,
              style: Get.textTheme.headlineMedium),
          Text(
              'نوع الهوية'.toString() +
                  DataConst.comme +
                  identity.typeIdentity!.name!,
              style: Get.textTheme.headlineMedium),
        ],
      ),
    );
  }
}

Widget getWidgetinputElement(
  DataInputRequrment dataInputRequrment,
) {
  if (dataInputRequrment.idTypeFiled == 1) {
    if (dataInputRequrment.mainRequire == null) {
      return OtherTypeFild(
        name: dataInputRequrment.subReqDetail!.name!,
        dataInputRequrment: dataInputRequrment,
      );
    } else {
      return OtherTypeFild(
        name: dataInputRequrment.mainRequire!.name!,
        dataInputRequrment: dataInputRequrment,
      );
    }
  } else if (dataInputRequrment.idTypeFiled == 2) {
    if (dataInputRequrment.mainRequire == null) {
      return ImageTypeFild(
        path: dataInputRequrment.urlFile!,
        name: dataInputRequrment.subReqDetail!.name!,
        dataInputRequrment: dataInputRequrment,
      );
    } else {
      return ImageTypeFild(
        name: dataInputRequrment.mainRequire!.name!,
        path: dataInputRequrment.urlFile!,
        dataInputRequrment: dataInputRequrment,
      );
    }
  } else if (dataInputRequrment.idTypeFiled == 3) {
    if (dataInputRequrment.mainRequire == null) {
      return OtherTypeFild(
        name: dataInputRequrment.subReqDetail!.name!,
        dataInputRequrment: dataInputRequrment,
      );
    } else {
      return OtherTypeFild(
        name: dataInputRequrment.mainRequire!.name!,
        dataInputRequrment: dataInputRequrment,
      );
    }
  } else if (dataInputRequrment.idTypeFiled == 4) {
    if (dataInputRequrment.mainRequire == null) {
      return OtherTypeFild(
        name: dataInputRequrment.subReqDetail!.name!,
        dataInputRequrment: dataInputRequrment,
      );
    } else {
      return OtherTypeFild(
        name: dataInputRequrment.mainRequire!.name!,
        dataInputRequrment: dataInputRequrment,
      );
    }
  } else if (dataInputRequrment.idTypeFiled == 5) {
    if (dataInputRequrment.mainRequire == null) {
      return TypfildFile(
        name: dataInputRequrment.subReqDetail!.name!,
        path: dataInputRequrment.urlFile!,
        dataInputRequrment: dataInputRequrment,
      );
    } else {
      return TypfildFile(
        name: dataInputRequrment.mainRequire!.name!,
        path: dataInputRequrment.urlFile!,
        dataInputRequrment: dataInputRequrment,
      );
    }
  } else if (dataInputRequrment.idTypeFiled == 8) {
    if (dataInputRequrment.mainRequire == null) {
      return ChoiceTypeFild(
          dataInputRequrment: dataInputRequrment,
          value: dataInputRequrment.subReqDetail!.choose!
              .firstWhere((element) =>
                  element.idChooseSub == dataInputRequrment.idChoice)
              .containt!,
          name: dataInputRequrment.subReqDetail!.containt!);
    } else {
      return ChoiceTypeFild(
        name: dataInputRequrment.mainRequire!.name!,
        value: dataInputRequrment.mainRequire!.choose!
            .firstWhere((element) =>
                element.idChooseMain == dataInputRequrment.idChoice)
            .containt!,
        dataInputRequrment: dataInputRequrment,
      );
    }
  } else if (dataInputRequrment.idTypeFiled == 9) {
    if (dataInputRequrment.mainRequire == null) {
      return ChoiceTypeFild(
          name: dataInputRequrment.subReqDetail!.containt!,
          value: dataInputRequrment.subReqDetail!.choose!
              .firstWhere((element) =>
                  element.idChooseSub == dataInputRequrment.idChoice)
              .containt!,
          dataInputRequrment: dataInputRequrment);
    } else {
      return ChoiceTypeFild(
        name: dataInputRequrment.mainRequire!.name!,
        value: dataInputRequrment.mainRequire!.choose!
            .firstWhere((element) =>
                element.idChooseMain == dataInputRequrment.idChoice)
            .containt!,
        dataInputRequrment: dataInputRequrment,
      );
    }
  } else {
    return Container();
  }
}

class ChoiceTypeFild extends GetView<CustomerRequestDesktopController> {
  const ChoiceTypeFild({
    super.key,
    required this.name,
    required this.value,
    required this.dataInputRequrment,
  });
  final String name;
  final String value;
  final DataInputRequrment dataInputRequrment;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: Get.textTheme.headlineSmall),
        const SizedBox(
          height: 7,
        ),
        Text(value, style: Get.textTheme.headlineSmall),
        const SizedBox(
          height: 7,
        ),
        GetBuilder<CustomerRequestDesktopController>(
          id: 'staterequement'.toString() + dataInputRequrment.id!.toString(),
          initState: (_) {},
          builder: (_) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.databasic == null
                    ? []
                    : controller.databasic!.stateRequerment!
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    value: e,
                                    groupValue:
                                        dataInputRequrment.stateOfRequiremnt,
                                    onChanged: (value) {
                                      dataInputRequrment.stateOfRequiremnt =
                                          value;
                                      controller
                                          .addEditeData(dataInputRequrment);
                                      controller.updatestateRequement(
                                          'staterequement'.toString() +
                                              dataInputRequrment.id!
                                                  .toString());
                                    }),
                                Text(
                                  e.name!,
                                  style: Get.textTheme.headlineSmall,
                                )
                              ],
                            ))
                        .toList());
          },
        ),
      ],
    );
  }
}

class OtherTypeFild extends GetView<CustomerRequestDesktopController> {
  const OtherTypeFild({
    super.key,
    required this.name,
    required this.dataInputRequrment,
  });
  final String name;
  final DataInputRequrment dataInputRequrment;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: Get.textTheme.headlineSmall),
        const SizedBox(
          height: 7,
        ),
        Text(dataInputRequrment.textValue!, style: Get.textTheme.headlineSmall),
        const SizedBox(
          height: 7,
        ),
        GetBuilder<CustomerRequestDesktopController>(
          id: 'staterequement'.toString() + dataInputRequrment.id!.toString(),
          initState: (_) {},
          builder: (_) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.databasic == null
                    ? []
                    : controller.databasic!.stateRequerment!
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    value: e,
                                    groupValue:
                                        dataInputRequrment.stateOfRequiremnt,
                                    onChanged: (value) {
                                      dataInputRequrment.stateOfRequiremnt =
                                          value;
                                      controller
                                          .addEditeData(dataInputRequrment);
                                      controller.updatestateRequement(
                                          'staterequement'.toString() +
                                              dataInputRequrment.id!
                                                  .toString());
                                    }),
                                Text(
                                  e.name!,
                                  style: Get.textTheme.headlineSmall,
                                )
                              ],
                            ))
                        .toList());
          },
        ),
      ],
    );
  }
}

class TypfildFile extends GetView<CustomerRequestDesktopController> {
  const TypfildFile({
    super.key,
    required this.path,
    required this.name,
    required this.dataInputRequrment,
  });
  final String path;
  final String name;
  final DataInputRequrment dataInputRequrment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var dir = Directory(r'E:\test\data');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
        var filePath = paath.join(dir.path, paath.basename(path));

        var re = await DioHelpper.downloadFile(path);
        File file = File(filePath);
        file.writeAsBytes(re.data);
        if (await canLaunchUrl(Uri.directory(filePath, windows: true))) {
          await launchUrl(Uri.directory(filePath, windows: true));
        } else {
          throw 'could not launchurl $filePath';
        }
      },
      child: Column(
        children: [
          Icon(
            Icons.file_copy,
            color: Get.theme.colorScheme.primary,
          ),
          Text(name, style: Get.textTheme.headlineSmall),
          const SizedBox(
            height: 7,
          ),
          Text('فتح الملف', style: Get.textTheme.headlineSmall),
          const SizedBox(
            height: 7,
          ),
          GetBuilder<CustomerRequestDesktopController>(
            id: 'staterequement'.toString() + dataInputRequrment.id!.toString(),
            initState: (_) {},
            builder: (_) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.databasic == null
                      ? []
                      : controller.databasic!.stateRequerment!
                          .map((e) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                      value: e,
                                      groupValue:
                                          dataInputRequrment.stateOfRequiremnt,
                                      onChanged: (value) {
                                        dataInputRequrment.stateOfRequiremnt =
                                            value;
                                        controller
                                            .addEditeData(dataInputRequrment);
                                        controller.updatestateRequement(
                                            'staterequement'.toString() +
                                                dataInputRequrment.id!
                                                    .toString());
                                      }),
                                  Text(
                                    e.name!,
                                    style: Get.textTheme.headlineSmall,
                                  )
                                ],
                              ))
                          .toList());
            },
          ),
        ],
      ),
    );
  }
}

class ImageTypeFild extends GetView<CustomerRequestDesktopController> {
  ImageTypeFild(
      {super.key,
      required this.name,
      required this.path,
      // this.idStataRequement,
      required this.dataInputRequrment}) {
    // idStataRequement ??
    //     'stateRequement'.toString() + dataInputRequrment.id!.toString();
  }
  final String name;
  final String path;
  final DataInputRequrment dataInputRequrment;
  // StateRequiremnt? isSelected;

  // final String? idStataRequement;
  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      path,
      width: Get.width * 0.5,
      height: 200,
      fit: BoxFit.contain,
    );
    return Column(
      children: [
        Column(
          children: [
            Text(name, style: Get.textTheme.headlineSmall),
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: GestureDetector(
                    onTap: () {
                      UiApp.defaultDeialog(
                          title: 'صورة',
                          content: image,
                          confirm: UiApp.buttonDone(
                              lable: 'عودة',
                              onPressed: () {
                                Get.back();
                              }));
                    },
                    child: image)),
            GetBuilder<CustomerRequestDesktopController>(
              id: 'staterequement'.toString() +
                  dataInputRequrment.id!.toString(),
              initState: (_) {},
              builder: (_) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.databasic == null
                        ? []
                        : controller.databasic!.stateRequerment!
                            .map((e) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio(
                                        value: e,
                                        groupValue: dataInputRequrment
                                            .stateOfRequiremnt,
                                        onChanged: (value) {
                                          dataInputRequrment.stateOfRequiremnt =
                                              value;
                                          controller
                                              .addEditeData(dataInputRequrment);
                                          controller.updatestateRequement(
                                              'staterequement'.toString() +
                                                  dataInputRequrment.id!
                                                      .toString());
                                        }),
                                    Text(
                                      e.name!,
                                      style: Get.textTheme.headlineSmall,
                                    )
                                  ],
                                ))
                            .toList());
              },
            ),
          ],
        ),
      ],
    );
  }
}
// Widget getWidgetinputElement(DataInputRequrment dataInputRequrment) {
//   if (dataInputRequrment.idTypeFiled == 1) {
//     if (dataInputRequrment.mainRequire == null) {
//       return Text(
//           dataInputRequrment.subReqDetail!.name! +
//               DataConst.comme +
//               dataInputRequrment.textValue!,
//           style: Get.textTheme.headlineSmall);
//     } else {
//       return Text(
//           dataInputRequrment.mainRequire!.name! +
//               DataConst.comme +
//               dataInputRequrment.textValue!,
//           style: Get.textTheme.headlineSmall);
//     }
//   } else if (dataInputRequrment.idTypeFiled == 2) {
//     if (dataInputRequrment.mainRequire == null) {
//       return Text(dataInputRequrment.subReqDetail!.name! + DataConst.comme,
//           style: Get.textTheme.headlineSmall);
//     } else {
//       return Text(dataInputRequrment.mainRequire!.name! + DataConst.comme,
//           style: Get.textTheme.headlineSmall);
//     }
//   } else if (dataInputRequrment.idTypeFiled == 3) {
//     if (dataInputRequrment.mainRequire == null) {
//       return Text(
//           dataInputRequrment.subReqDetail!.name! +
//               DataConst.comme +
//               dataInputRequrment.textValue!,
//           style: Get.textTheme.headlineSmall);
//     } else {
//       return Text(
//           dataInputRequrment.mainRequire!.name! +
//               DataConst.comme +
//               dataInputRequrment.textValue!,
//           style: Get.textTheme.headlineSmall);
//     }
//   } else if (dataInputRequrment.idTypeFiled == 4) {
//     if (dataInputRequrment.mainRequire == null) {
//       return Text(
//           dataInputRequrment.subReqDetail!.name! +
//               DataConst.comme +
//               dataInputRequrment.textValue!,
//           style: Get.textTheme.headlineSmall);
//     } else {
//       return Text(
//           dataInputRequrment.mainRequire!.name! +
//               DataConst.comme +
//               dataInputRequrment.textValue!,
//           style: Get.textTheme.headlineSmall);
//     }
//   } else if (dataInputRequrment.idTypeFiled == 5) {
//     if (dataInputRequrment.mainRequire == null) {
//       return Text(
//           dataInputRequrment.subReqDetail!.name! +
//               DataConst.comme +
//               dataInputRequrment.urlFile!,
//           style: Get.textTheme.headlineSmall);
//     } else {
//       return Text(
//           dataInputRequrment.mainRequire!.name! +
//               DataConst.comme +
//               dataInputRequrment.urlFile!,
//           style: Get.textTheme.headlineSmall);
//     }
//   } else if (dataInputRequrment.idTypeFiled == 8) {
//     if (dataInputRequrment.mainRequire == null) {
//       return Text(
//           dataInputRequrment.subReqDetail!.containt! +
//               DataConst.comme +
//               dataInputRequrment.subReqDetail!.choose!
//                   .firstWhere((element) =>
//                       element.idChooseSub == dataInputRequrment.idChoice)
//                   .containt!,
//           style: Get.textTheme.headlineSmall);
//     } else {
//       return Text(
//           dataInputRequrment.mainRequire!.name! +
//               DataConst.comme +
//               dataInputRequrment.mainRequire!.choose!
//                   .firstWhere((element) =>
//                       element.idChooseMain == dataInputRequrment.idChoice)
//                   .containt!,
//           style: Get.textTheme.headlineSmall);
//     }
//   } else if (dataInputRequrment.idTypeFiled == 9) {
//     if (dataInputRequrment.mainRequire == null) {
//       return Text(
//           dataInputRequrment.subReqDetail!.containt! +
//               DataConst.comme +
//               dataInputRequrment.subReqDetail!.choose!
//                   .firstWhere((element) =>
//                       element.idChooseSub == dataInputRequrment.idChoice)
//                   .containt!,
//           style: Get.textTheme.headlineSmall);
//     } else {
//       return Text(
//           dataInputRequrment.mainRequire!.name! +
//               DataConst.comme +
//               dataInputRequrment.mainRequire!.choose!
//                   .firstWhere((element) =>
//                       element.idChooseMain == dataInputRequrment.idChoice)
//                   .containt!,
//           style: Get.textTheme.headlineSmall);
//     }
//   } else {
//     return Container();
//   }
// }
