import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';



import '../../../models/basic/main_requiremnt.dart';
import '../../../models/basic/service.dart';
import '../../../theme/color.dart';
import '../../home/controllers/home_controller.dart';
import '../../widgets/default_widget.dart';
import '../controllers/user_guide_controller.dart';

class UserGuideView extends GetView<UserGuideController> {
  UserGuideView({Key? key}) : super(key: key);
  final HomeController c = Get.put(HomeController());
  final String titleBottom = 'المتطلبات الرئسية';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل المستخدم'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            defaultTextFormField(
                hintText: 'بحث عن خدمة',
                width: MediaQuery.of(context).size.width / 2,
                isborderall: true,
                suffixIcon: const Icon(
                  Icons.search,
                  color: DefaultColor.primaryColor,
                )),
            Expanded(
              child: ListView.builder(
                itemCount: c.servicsImportaint!.length,
                itemBuilder: (context, index) {
                  Service item = c.servicsImportaint![index];
                  return GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Center(child: DefaultText(titleBottom)),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: item.mainRequirment!.length,
                                    itemBuilder: (context, index) {
                                      MainRequirment itemRequermt =
                                          item.mainRequirment![index];
                                      return ListTile(
                                        leading: const Icon(
                                          Icons.sunny,
                                        ),
                                        title: DefaultText(itemRequermt.name!),
                                        //subtitle: DefaultText(ite),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    defaultButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        isResponseve: false,
                                        isIcon: false,
                                        lable: 'تم',
                                        width: 150)
                                  ],
                                )
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white);
                    },
                    child: ListTile(
                      leading: SvgPicture.asset(
                        'icons/services.svg',
                        width: 20,
                        height: 20,
                        color: DefaultColor.primaryColor,
                      ),
                      title: DefaultText(item.name!),
                      subtitle: item.category != null
                          ? DefaultText(item.category!.nameCategoryMain!)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
