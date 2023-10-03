import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/management_user_desktop_controller.dart';

class ManagementUserDesktopView
    extends GetView<ManagementUserDesktopController> {
  const ManagementUserDesktopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManagementUserDesktopView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManagementUserDesktopView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
