import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/basic/customer.dart';
import '../../widgets/default_widget.dart';
import '../../widgets/main_widget.dart';
import '../controllers/services_public_controller.dart';

class BeneficiaresServicesBookingView
    extends GetView<ServicesPublicController> {
  BeneficiaresServicesBookingView({Key? key}) : super(key: key) {
    // controller.startUpBenefitesScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
              width: Get.width, height: Get.height, child: const Text('data')

              // Stack(
              //   children: [
              //     Positioned(
              //       top: 0,
              //       child: DefaultCountainer(
              //         color: Get.theme.colorScheme.primary,
              //         width: Get.width,
              //         height: 90,
              //         borderRadiusSpecific: const BorderRadius.only(
              //             bottomLeft: Radius.circular(30),
              //             bottomRight: Radius.circular(30)),
              //       ),
              //     ),
              //     Positioned(
              //         top: 100,
              //         child: SizedBox(
              //           width: Get.width,
              //           height: Get.height - 188,
              //           child: Column(
              //             children: [
              //               Text(
              //                 'ملفي الشخصي',
              //                 style: Get.textTheme.headlineMedium,
              //               ),
              //               GetBuilder<ServicesPublicController>(
              //                   id: 'isMe',
              //                   initState: (_) {},
              //                   builder: (_) {
              //                     return Container(
              //                         child: controller
              //                                     .currentUser.value!.identityMe ==
              //                                 null
              //                             ? Column(
              //                                 children: [
              //                                   Center(
              //                                     child: Text(
              //                                       'لا تملك ملف شخصي خاص بك',
              //                                       style:
              //                                           Get.textTheme.headlineSmall,
              //                                     ),
              //                                   ),
              //                                   IconButton(
              //                                       onPressed: () async {
              //                                         IdentitBeneficiares? name =
              //                                             await addIdentitBottomSheet(
              //                                                 controller);
              //                                         if (name != null) {
              //                                           controller
              //                                               .adjustSelectIdentit(
              //                                                   name,
              //                                                   true,
              //                                                   name.identityCustomer!
              //                                                       .datePirth!,
              //                                                   isMe: true);
              //                                         }
              //                                       },
              //                                       icon: const Icon(Icons.add))
              //                                 ],
              //                               )
              //                             : CustomerIdentenyItem(
              //                                 isShowonly: false,
              //                                 identity: controller
              //                                     .currentUser.value!.identityMe!,
              //                                 onChanged: (value) {
              //                                   controller.adjustSelectIdentit(
              //                                       controller.currentUser.value!
              //                                           .identityMe!,
              //                                       value!,
              //                                       controller
              //                                           .currentUser
              //                                           .value!
              //                                           .identityMe!
              //                                           .identityCustomer!
              //                                           .datePirth!);
              //                                 },
              //                               ));
              //                   }),
              //               const Divider(),
              //               const Text('اشخاص مضافون سابقا'),
              //               GetBuilder<ServicesPublicController>(
              //                   // init: ServicesScreenController(),
              //                   id: 'listnewBenefites',
              //                   initState: (_) {},
              //                   builder: (_) {
              //                     return Expanded(
              //                       child: ListView.builder(
              //                           itemCount: controller
              //                                       .currentUser.value!.benefities !=
              //                                   null
              //                               ? controller
              //                                   .currentUser.value!.benefities!.length
              //                               : 0,
              //                           itemBuilder: (context, index) {
              //                             IdentitBeneficiares identity = controller
              //                                 .currentUser.value!.benefities![index];
              //                             return CustomerIdentenyItem(
              //                               isShowonly: false,
              //                               identity: identity,
              //                               onChanged: (value) {
              //                                 controller.adjustSelectIdentit(
              //                                     identity,
              //                                     value!,
              //                                     identity
              //                                         .identityCustomer!.datePirth!);
              //                               },
              //                             );
              //                           }),
              //                     );
              //                   })
              //             ],
              //           ),
              //         )),
              //     Positioned(
              //         top: 5,
              //         right: 3,
              //         child: GestureDetector(
              //           onTap: () {
              //             controller.currentUser.value!.identityMe = null;
              //             // controller.test();
              //           },
              //           child: GetBuilder<ServicesPublicController>(
              //             id: 'badgeTravel',
              //             // init: ServicesScreenController(),
              //             initState: (_) {},
              //             builder: (_) {
              //               return Badge(
              //                   alignment: AlignmentDirectional.topStart,
              //                   label: Text(
              //                       controller.identitSelected.length.toString()),
              //                   child: Icon(
              //                     Icons.person_4_rounded,
              //                     color: Get.theme.colorScheme.secondary,
              //                     size: 40,
              //                   )
              //                   // DefaultIcon.svg(
              //                   //   path: 'icons/suitcase.svg',
              //                   //   width: 40,
              //                   //   height: 40,
              //                   // ),
              //                   );
              //             },
              //           ),
              //         )),
              //     Align(
              //         alignment: Alignment.topCenter,
              //         child: Container(
              //           margin: const EdgeInsets.only(top: 20),
              //           child: Text('بينانات الاشخاص والمستفيدين',
              //               style: Get.textTheme.bodyLarge),
              //         )),
              //     Positioned(
              //         top: 0,
              //         left: 2,
              //         child: IconButton(
              //           icon: DefaultIcon.svg(
              //             path: 'icons/profile.svg',
              //             width: 40,
              //             height: 40,
              //           ),
              //           onPressed: () {
              //             Get.back;
              //           },
              //         )),
              //     Positioned(
              //         top: 50,
              //         right: (Get.size.width - 200) / 2,
              //         child: DefaultTextFormField(
              //           width: 200,
              //           height: 30,
              //           isborderall: true,
              //           hintText: 'بحث',
              //           facaColor: Get.theme.colorScheme.primary,
              //           suffixIcon: const Icon(Icons.search),
              //         )),
              //     Positioned(
              //         bottom: 70,
              //         right: 10,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(25),
              //           child: GestureDetector(
              //             onTap: () async {
              //               IdentitBeneficiares? name =
              //                   await addIdentitBottomSheet(controller);
              //               if (name != null) {
              //                 controller.currentUser.value!.benefities!.add(name);
              //                 controller.adjustSelectIdentit(
              //                     name, true, name.identityCustomer!.datePirth!);
              //               }
              //             },
              //             child: DefaultCountainer(
              //               color: Get.theme.colorScheme.primary,
              //               width: 60,
              //               height: 60,
              //               child: Center(
              //                   child: Text(
              //                 'انشاء',
              //                 style: Get.theme.textTheme.bodyLarge!.merge(
              //                     TextStyle(color: Get.theme.colorScheme.secondary)),
              //               )),
              //             ),
              //           ),
              //         )),
              //     Positioned(
              //         bottom: 0,
              //         child: DefaultCountainer(
              //           height: 50,
              //           width: Get.width,
              //           child: Row(children: [
              //             Expanded(
              //                 flex: 2,
              //                 child: Container(
              //                   margin: const EdgeInsets.only(right: 6),
              //                   child: defaultButton(
              //                       isResponseve: true,
              //                       isIcon: false,
              //                       lable: 'متابعة',
              //                       onPressed: () async {
              //                         controller.addjustCutomerTolastStep();
              //                       }),
              //                 )),
              //             const Spacer(),
              //             Expanded(
              //               flex: 2,
              //               child: Obx(() => Row(
              //                     children: [
              //                       DefaultIcon.svg(
              //                         path: 'icons/persons.svg',
              //                         width: 40,
              //                         height: 35,
              //                         color: Get.theme.colorScheme.primary,
              //                       ),
              //                       const SizedBox(
              //                         width: 7,
              //                       ),
              //                       Text(
              //                         controller.countAdult.value.toString(),
              //                         style: Get.textTheme.headlineSmall,
              //                       ),
              //                       const Spacer(),
              //                       DefaultIcon.svg(
              //                         path: 'icons/kids.svg',
              //                         width: 40,
              //                         height: 30,
              //                         color: Get.theme.colorScheme.primary,
              //                       ),
              //                       const SizedBox(
              //                         width: 7,
              //                       ),
              //                       Text(
              //                         controller.countChildern.value.toString(),
              //                         style: Get.textTheme.headlineSmall,
              //                       ),
              //                       const Spacer(),
              //                       DefaultIcon.svg(
              //                         path: 'icons/baby.svg',
              //                         width: 40,
              //                         height: 25,
              //                         color: Get.theme.colorScheme.primary,
              //                       ),
              //                       const SizedBox(
              //                         width: 7,
              //                       ),
              //                       Text(
              //                         controller.countbaby.value.toString(),
              //                         style: Get.textTheme.headlineSmall,
              //                       )
              //                     ],
              //                   )),
              //             ),
              //           ]),
              //         ))
              //   ],
              // ),

              )),
    );
  }
}
