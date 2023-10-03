import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/default_widget.dart';

class ItemDrowerMenu extends StatelessWidget {
  const ItemDrowerMenu({
    super.key,
    required this.path,
    required this.name,
    this.onTap,
    required this.selected,
  });
  final String path;
  final String name;
  final void Function()? onTap;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return DefaultCountainer(
      color: selected
          ? Get.theme.colorScheme.secondary
          : Get.theme.colorScheme.primary,
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          selected: selected,
          selectedColor: Get.theme.colorScheme.secondary,
          selectedTileColor: Get.theme.colorScheme.primary,
          // splashColor: Colors.amber,
          leading: DefaultIcon.svg(
              path: path,
              height: 30,
              width: 30,
              color: selected
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.secondary),
          title: DefaultText(
            name,
            style: Get.textTheme.headlineMedium!.merge(TextStyle(
                color: selected
                    ? Get.theme.colorScheme.primary
                    : Get.theme.colorScheme.secondary)),
          ),
          //trailing: DefaultIcon(icon: Icons.arrow_drop_down),
        ),
      ),
    );
  }
}
