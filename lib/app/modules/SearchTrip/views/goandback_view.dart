import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GoandbackView extends GetView {
  const GoandbackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoandbackView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GoandbackView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
