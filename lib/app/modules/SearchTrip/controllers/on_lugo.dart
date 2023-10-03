// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../models/triop.dart';
// import '../../../models/triop.dart';

// class OnlyGoController extends GetxController {
//   Key formKey = GlobalKey<FormState>();
//   List<String> fromCity = [
//     'اب',
//     'عدن',
//     '`ذمار`',
//     'تغز',
//     'صنعاء',
//     'مارب',
//   ];
//   List<String> companyTransport = [
//     'البركة',
//     'البراق',
//     'رباء الحجاز',
//     'ابو سرهد ',
//   ];

//   List<String> toCity = [
//     'الرياض',
//     'عدن',
//     'ذمار'
//         'تغز',
//     'صنعاء',
//     'مارب',
//   ];
//   List<String> typesCard = [
//     'عمره',
//     'حج'
//         'زياره',
//     'عمل',
//     'ايقامة',
//   ];

//   List<Trip> trips = [
//     Trip(
//         fromCity: 'صنعاء',
//         toCity: "الرياض",
//         goTime: DateTime.now(),
//         lineTrip: 'اب عدن الرياض',
//         companyTransport: 'رباء الحجاز',
//         level: "vip",
//         avaiableNumber: 5,
//         price: 750),
//     Trip(
//         fromCity: 'تعز',
//         toCity: "الرياض",
//         goTime: DateTime.now(),
//         lineTrip: 'اب عدن الرياض',
//         companyTransport: 'البركة',
//         level: "عادي",
//         avaiableNumber: 10,
//         price: 750),
//     Trip(
//         fromCity: 'صنعاء',
//         toCity: "الرياض",
//         goTime: DateTime.now(),
//         lineTrip: 'اب عدن الرياض',
//         companyTransport: 'البركة',
//         level: "vip",
//         avaiableNumber: 9,
//         price: 800),
//     Trip(
//         price: 600,
//         fromCity: 'اب',
//         toCity: "الرياض",
//         goTime: DateTime.now(),
//         lineTrip: 'اب عدن الرياض',
//         companyTransport: 'البركة',
//         level: "vip",
//         avaiableNumber: 5),
//     Trip(
//         price: 750,
//         fromCity: 'اب',
//         toCity: "الرياض",
//         goTime: DateTime.now(),
//         lineTrip: 'اب عدن الرياض',
//         companyTransport: 'البركة',
//         level: "vip",
//         avaiableNumber: 7),
//   ];
//   String counterOfcustomersbig = ' 0';
//   String counterchildern = ' 0';
//   String? inititalCompanyTransport;

//   String? inititalFromCity;
//   String? inititalToCity;
//   String? inititaltypesCard;
  
//   @override
//   void onInit() {
//     inititalCompanyTransport = companyTransport[0];
//     inititalFromCity = fromCity[0];
//     inititalToCity = toCity[0];
//     inititaltypesCard = typesCard[0];
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   void chagnefromCity(dynamic value) {
//     inititalFromCity = value;
//     update([
//       ['fromCity']
//     ]);
//   }

//   void chagneCompanyTransport(dynamic value) {
//     inititalCompanyTransport = value;
//     update([
//       ['CompanyTransport']
//     ]);
//   }

//   void chagneToCity(dynamic value) {
//     inititalToCity = value;
//     update([
//       ['ToCity']
//     ]);
//   }

//   void chagneTypeCard(dynamic value) {
//     inititaltypesCard = value;
//     update([
//       ['TypeCard']
//     ]);
//   }

//   void onChangedNumberCustomer(String value) {
//     counterOfcustomersbig = value;
//     print(counterOfcustomersbig);
//     //update();
//   }

//   void onChangedNumberChildern(String value) {
//     counterOfcustomersbig = value;
//     print(counterOfcustomersbig);
//     //update();
//   }
// }
