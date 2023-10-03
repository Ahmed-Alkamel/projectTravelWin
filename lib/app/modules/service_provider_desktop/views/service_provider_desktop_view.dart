import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_provider_desktop_controller.dart';

class ServiceProviderDesktopView
    extends GetView<ServiceProviderDesktopController> {
  const ServiceProviderDesktopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceProviderDesktopView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ServiceProviderDesktopView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
