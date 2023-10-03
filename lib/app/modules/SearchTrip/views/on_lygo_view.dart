// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:projectgetx/app/modules/BookingTrip/views/booking_trip_view.dart';
// import 'package:projectgetx/app/modules/SearchTrip/controllers/on_lugo.dart';
// import 'package:projectgetx/app/theme/color.dart';

// import '../../../models/triop.dart';
// import '../../../routes/app_pages.dart';
// import '../../widgets/default_widget.dart';

// class OnLygoView extends GetView<OnlyGoController> {
//   const OnLygoView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: controller.formKey,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: double.infinity,
//           padding: EdgeInsets.all(8.8),
//           margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: GridView(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisSpacing: 30,
//                       crossAxisCount: 2,
//                       childAspectRatio: 1.9),
//                   children: [
//                     GetBuilder<OnlyGoController>(
//                       id: 'fromcity',
//                       builder: (controller) {
//                         return DefaultDropDownForm(
//                             onChanged: (p0) => controller.chagnefromCity(p0),
//                             dataList: controller.fromCity,
//                             title: 'من مدينة',
//                             value: controller.inititalFromCity);
//                       },
//                     ),
//                     GetBuilder<OnlyGoController>(
//                       id: 'CompanyTransport',
//                       builder: (controller) {
//                         return DefaultDropDownForm(
//                             onChanged: (p0) =>
//                                 controller.chagneCompanyTransport(p0),
//                             dataList: controller.companyTransport,
//                             title: 'الشركة الناقلة',
//                             value: controller.inititalCompanyTransport);
//                       },
//                     ),
//                     GetBuilder<OnlyGoController>(
//                       id: 'ToCity',
//                       builder: (controller) {
//                         return DefaultDropDownForm(
//                             onChanged: (p0) => controller.chagneToCity(p0),
//                             dataList: controller.toCity,
//                             title: 'الى مدينة',
//                             value: controller.inititalToCity);
//                       },
//                     ),
//                     GetBuilder<OnlyGoController>(
//                       id: 'fromCity',
//                       builder: (controller) {
//                         return defaultDataTimePicker(
//                             label: defaultText('تاريخ السفر', fontSize: 16));
//                       },
//                     ),
//                     GetBuilder<OnlyGoController>(
//                         id: 'NumberCustomer',
//                         builder: (controller) {
//                           return Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               defaultTextFormField(
//                                   onchange: (p0) =>
//                                       controller.onChangedNumberCustomer(p0),
//                                   isborderall: true,
//                                   label: 'عدد المسافرين',
//                                   hintText: "عدد المسافرين البالغين"),
//                             ],
//                           );
//                         }),
//                     // GetBuilder<OnlyGoController>(
//                     //   id: 'TypeCard',
//                     //   builder: (controller) {
//                     //     return DefaultDropDownForm(
//                     //         onChanged: (p0) => controller.chagneTypeCard(p0),
//                     //         dataList: controller.typesCard,
//                     //         title: 'نوع التذكره',
//                     //         value: controller.inititaltypesCard);
//                     //   },
//                     // ),
//                     // GetBuilder<OnlyGoController>(
//                     //     id: 'NumberCustomer',
//                     //     builder: (controller) {
//                     //       return Column(
//                     //         children: [
//                     //           const SizedBox(
//                     //             height: 20,
//                     //           ),
//                     //           defaultTextFormField(
//                     //               onchange: (p0) =>
//                     //                   controller.onChangedNumberChildern(p0),
//                     //               isborderall: true,
//                     //               label: 'عدد الاطفال',
//                     //               hintText: "عدد الاطفال البالغين"),
//                     //         ],
//                     //       );
//                     //     }),
//                     // GetBuilder<OnlyGoController>(
//                     //     id: 'NumberCustomer',
//                     //     builder: (controller) {
//                     //       return Column(
//                     //         children: [
//                     //           const SizedBox(
//                     //             height: 20,
//                     //           ),
//                     //           defaultTextFormField(
//                     //               onchange: (p0) =>
//                     //                   controller.onChangedNumberChildern(p0),
//                     //               isborderall: true,
//                     //               label: 'عدد الرضع',
//                     //               hintText: "عدد الاطفال البالغين"),
//                     //         ],
//                     //       );
//                     //     }),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var searchTrips;
//           await Get.bottomSheet(BottomSheet(
//             builder: (BuildContext context) {
//               List<Trip> searchTrips = controller.trips
//                   .where((element) =>
//                       element.companyTransport ==
//                           controller.inititalCompanyTransport &&
//                       element.fromCity == controller.inititalFromCity &&
//                       element.toCity == controller.inititalToCity)
//                   .toList();
//               return Container(
//                 padding: EdgeInsets.all(8),
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: searchTrips.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           Trip itme = searchTrips[index];
//                           return GestureDetector(
//                             onTap: () async {
//                               controller.tripSelect = itme;
//                               await Get.offAllNamed(Routes.BOOKING_TRIP);
//                               //Get.offNamed(Routes.BOOKING_TRIP);
//                             },
//                             child: DefaultCountainer(
//                               child: ListTile(
//                                 title: Container(
//                                   margin: EdgeInsets.only(top: 15),
//                                   child: Text(
//                                     itme.companyTransport,
//                                     textAlign: TextAlign.start,
//                                   ),
//                                 ),
//                                 leading: Text(itme.level),
//                                 subtitle: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text('تاريخ الغادرة '),
//                                     Text(
//                                         '${itme.goTime.year}/${itme.goTime.month}/${itme.goTime.day}  ${itme.goTime.hour}:${itme.goTime.minute}'),
//                                     Text(
//                                         'من ${itme.fromCity} الى ${itme.toCity}'),
//                                     Text('السعر ${itme.price}')
//                                   ],
//                                 ),
//                                 trailing: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Expanded(child: Text("المقاعد المتاحة")),
//                                     Expanded(
//                                         child: Text(
//                                             itme.avaiableNumber.toString()))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     defaultButton(
//                         isResponseve: false,
//                         isIcon: false,
//                         lable: 'عودة',
//                         onPressed: () {
//                           Navigator.pop(context);
//                         })
//                   ],
//                 ),
//               );
//             },
//             onClosing: () {
//               'ok';
//             },
//           ));
//         },
//         child: Icon(Icons.search),
//       ),
//     );
//   }
// }
