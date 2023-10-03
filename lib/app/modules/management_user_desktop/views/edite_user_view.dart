import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EditeUserView extends GetView {
  const EditeUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditeUserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditeUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
