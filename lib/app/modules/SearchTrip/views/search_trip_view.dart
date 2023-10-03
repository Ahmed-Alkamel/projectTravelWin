// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:projectgetx/app/theme/color.dart';

// import '../controllers/search_trip_controller.dart';
// import 'on_lygo_view.dart';

// // ignore: must_be_immutable
// class SearchTripView extends GetView<SearchTripController> {
//   SearchTripView({Key? key}) : super(key: key);

//   @override
//   SearchTripController controller = Get.put(SearchTripController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'البحث عن رحلة',
//             style: TextStyle(color: DefaultColor.colorTextSecandry),
//           ),
//           centerTitle: true,
//         ),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           child: OnLygoView(),
//         ));
//   }
// }
