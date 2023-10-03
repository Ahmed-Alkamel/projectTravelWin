import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/default_widget.dart';

class IntroMainScreanView extends GetView {
  const IntroMainScreanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('IntroMainScreanView'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: DefaultIcon.svg(
          path: 'icons/logo.svg',
          width: Get.width * 0.3,
          height: Get.width * 0.3,
          color: Get.theme.colorScheme.primary,
        ),
      ),
    );
  }
}
