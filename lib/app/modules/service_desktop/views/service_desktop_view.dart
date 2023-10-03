import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_desktop_controller.dart';

class ServiceDesktopView extends GetView<ServiceDesktopController> {
  const ServiceDesktopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceDesktopView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ServiceDesktopView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
