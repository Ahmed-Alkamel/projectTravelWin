import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/trips_desktop_controller.dart';

class TripsDesktopView extends GetView<TripsDesktopController> {
  const TripsDesktopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripsDesktopView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TripsDesktopView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
