// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projecttravelwin/app/models/basic/category.dart';
import 'package:projecttravelwin/app/models/basic/data_basic_add_trip.dart';
import 'package:projecttravelwin/app/models/basic/state_request.dart';
import 'package:projecttravelwin/app/models/basic/trips.dart';

import '../../models/basic/company.dart';
import '../../models/basic/country.dart';
import '../../models/basic/currencies.dart';
import '../../models/basic/data_basic.dart';
import '../../models/basic/main_requiremnt.dart';
import '../../models/basic/option_type_filed.dart';
import '../../models/basic/identitfy_card.dart';
import '../../models/basic/type_filed.dart';
import '../../models/basic/user_request.dart';
import '../../theme/color.dart';
import '../../theme/theme.dart';
import '../ServicesScreen/controllers/services_screen_controller.dart';
import '../servicesPublic/controllers/services_public_controller.dart';

class DefaultText extends StatelessWidget {
  DefaultText(this.text, {super.key, this.style});
  String text;
  TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

class DefaultDropDownForm extends StatelessWidget {
  DefaultDropDownForm(
      {super.key,
      this.title,
      this.onSaved,
      required this.dataList,
      this.helpText,
      required this.onChanged,
      required this.value,
      this.hintText,
      this.label,
      this.validator,
      this.colorTextShow = DefaultColor.textPrimary,
      this.height = 40,
      this.enableBorderColor = DefaultColor.primaryColor,
      this.focuseBorderColor = DefaultColor.sencondreColor,
      this.width = 100});
  String? title;

  Function(dynamic)? onSaved;
  List<dynamic>? dataList;
  String? helpText;
  String? hintText;
  Function(dynamic) onChanged;
  dynamic value;
  Color colorTextShow;
  double height;
  Color enableBorderColor;
  Color focuseBorderColor;
  double width;
  Widget? label;
  String? Function(dynamic)? validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
        validator: validator,
        isExpanded: true,
        onSaved: onSaved,
        alignment: Alignment.topCenter,
        // ignore: prefer_const_constructors
        style: Get.textTheme.headlineSmall,
        decoration: InputDecoration(
            floatingLabelStyle:
                Get.textTheme.headlineSmall!.merge(TextStyle(fontSize: 14)),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            label: label,
            hintText: hintText,
            // floatingLabelAlignment: FloatingLabelAlignment.center,
            helperText: helpText,
            labelStyle: Get.textTheme.headlineMedium,
            contentPadding: const EdgeInsets.all(8.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1, color: enableBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1, color: focuseBorderColor))),
        value: value,
        items: dataList!
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: DefaultText(
                    e is MartialStatus
                        ? e.nameAr!
                        : e is IdentitfyCard
                            ? e.name
                            : e is Choose?
                                ? e!.containt
                                : e is ChooseSub?
                                    ? e!.containt
                                    : e is Category
                                        ? e.nameCategoryMain
                                        : e is TypeFiled
                                            ? e.name
                                            : e is Gender
                                                ? e.nameAr
                                                : e is ServiceMine
                                                    ? e.name
                                                    : e is Company?
                                                        ? e!.name
                                                        : e is City
                                                            ? e.name
                                                            : e is Countries
                                                                ? e.countryName
                                                                : e is Method
                                                                    ? e.name
                                                                    : e is Currencies
                                                                        ? e.name
                                                                        : e is StateRequest
                                                                            ? e.name
                                                                            : e is UserRequest
                                                                                ? e.serviceName
                                                                                : e,
                  ),
                ))
            .toList(),
        onChanged: onChanged);
  }
}

class DefaultDropDown extends StatelessWidget {
  DefaultDropDown(
      {super.key,
      this.title,
      this.onSaved,
      required this.onChanged,
      this.value,
      this.hint,
      this.colorTextShow = DefaultColor.textPrimary,
      this.height = 40,
      required this.items,
      this.enableBorderColor = DefaultColor.primaryColor,
      this.focuseBorderColor = DefaultColor.sencondreColor,
      this.width,
      this.borderRadius});
  String? title;
  Function(dynamic)? onSaved;
  BorderRadius? borderRadius;
  List<DropdownMenuItem<Object>>? items;
  Function(dynamic) onChanged;
  dynamic value;
  Widget? hint;
  Color colorTextShow;
  double height;
  Color enableBorderColor;
  Color focuseBorderColor;
  double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          (title == null)
              ? Container()
              : DefaultText(
                  title!,
                ),
          Center(
            child: Neumorphic(
              style: NeumorphicStyle(
                  lightSource: LightSource.bottom,
                  color: Get.theme.colorScheme.primary.withOpacity(0.5),
                  depth: 8),
              child: DropdownButton(
                  elevation: 20,
                  hint: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: hint,
                  )),
                  underline: Container(),
                  borderRadius: borderRadius,
                  dropdownColor: Get.theme.colorScheme.primary,
                  alignment: Alignment.topCenter,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    height: 1,
                  ),
                  value: value,
                  items: items,
                  onChanged: onChanged),
            ),
          ),
        ],
      ),
    );
  }
}

//textformfield
class DefaultTextFormField extends StatefulWidget {
  DefaultTextFormField(
      {Key? key,
      this.width,
      this.height,
      this.label,
      this.hintText,
      this.colorOutlineBorder,
      this.suffixIcon,
      required this.isborderall,
      this.facaColor,
      this.enableBorderColor,
      this.lableColor,
      this.validator,
      this.hidpass,
      this.initialValue,
      this.onchange,
      this.readOnly,
      this.controller,
      this.onTap,
      this.margin,
      this.inputFormatters,
      this.keyboardType,
      this.maxLength,
      this.onEditingComplete})
      : super(key: key) {
    controlPass = hidpass;
  }

  double? width;
  double? height;
  bool? ispass;
  String? label;
  String? hintText;
  Color? colorOutlineBorder;
  // required
  Widget? suffixIcon;
  bool isborderall = false;
  Color? facaColor;
  Color? enableBorderColor;
  TextInputType? keyboardType;
  EdgeInsetsGeometry? margin;
  Color? lableColor = DefaultColor.textPrimary;
  bool? hidpass;
  String? initialValue;
  Function(String)? onchange;
  bool? controlPass;
  String? Function(String?)? validator;
  bool? readOnly;
  Function()? onTap;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final void Function()? onEditingComplete;
  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  // TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        readOnly: widget.readOnly ?? false,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        onChanged: widget.onchange,
        maxLength: widget.maxLength,
        onTap: widget.onTap,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        style: Get.textTheme.headlineMedium,
        obscureText: widget.controlPass ?? false,
        validator: widget.validator,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(

            //filled: true,
            // contentPadding: const EdgeInsets.symmetraic(horizontal: 10),
            contentPadding: const EdgeInsets.all(8.0),
            enabledBorder: widget.isborderall
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                      color: widget.enableBorderColor ??
                          Get.theme.colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  )
                : null,
            focusedBorder: widget.isborderall
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                      color: widget.facaColor ?? DefaultColor.containTheme3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  )
                : null,
            label: widget.label == null
                ? null
                : DefaultText(
                    widget.label!,
                    style: Get.textTheme.headlineMedium,
                  ),
            hintText: widget.hintText,
            hintStyle: Get.textTheme.headlineSmall,
            suffixIconColor: Get.theme.colorScheme.primary,
            suffixIcon: widget.controlPass != null
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controlPass = !widget.controlPass!;
                      });
                    },
                    icon: Icon(widget.controlPass!
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )
                : widget.suffixIcon),
      ),
    );
  }
}

Widget defaultTextFormField(
    {double? width,
    double? height,
    String? label,
    required String hintText,
    Color? colorOutlineBorder,
    // required
    Widget? suffixIcon,
    bool isborderall = false,
    Color? facaColor = DefaultColor.textPrimary,
    Color? enableBorderColor = DefaultColor.primaryColor,
    Color? lableColor = DefaultColor.textPrimary,
    bool hidpass = false,
    String? initialValue,
    Function(String)? onchange
    // required TypeValidat validate
    }) {
  TextEditingController controller = TextEditingController();

  return
      //if the text fild containt icon
      SizedBox(
    width: width,
    height: height,
    child: TextFormField(
      initialValue: initialValue,
      onChanged: onchange,
      controller: controller,
      obscureText: hidpass,
      // validator: (value) {
      //   if (validate != TypeValidat.passwordverif) {
      //     if (validate == TypeValidat.text) {
      //       return ValidatorFuction.getTypevalidate(validate, value,
      //           text: controller.text);
      //     } else if (validate == TypeValidat.numberPhone) {
      //       return ValidatorFuction.getTypevalidate(validate, value,
      //           numberPhone: controller.text);
      //     } else if (validate == TypeValidat.password) {
      //       return ValidatorFuction.getTypevalidate(validate, value,
      //           passwords: controller.text);
      //     }
      //   } else {
      //     return ValidatorFuction.getTypevalidate(
      //       validate, value,
      //       // passwords: widget.controller,
      //       // passwordverif: widget.controller
      // //     );
      //   }
      // },

      decoration: InputDecoration(

          //filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: isborderall
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: enableBorderColor!,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          focusedBorder: isborderall
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: facaColor!,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          label: label == null
              ? null
              : DefaultText(
                  label,
                ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: suffixIcon),
    ),
  );
}

Widget defaultButton(
        {Function()? onPressed,
        required bool isResponseve,
        required bool isIcon,
        required String lable,
        double width = 200,
        double height = 40,
        Widget? icon,
        Color iconColor = DefaultColor.primaryColor,
        double iconSize = 25,
        Color color = DefaultColor.primaryColor,
        Color? textColor = DefaultColor.primarySchemaColor}) =>
    isIcon
        ? SizedBox(
            width: isResponseve ? double.infinity : width,
            height: height,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: color),
                onPressed: onPressed,
                icon: icon!,
                label: DefaultText(
                  lable,
                  style: Get.textTheme.headlineMedium!
                      .merge(TextStyle(color: Get.theme.colorScheme.secondary)),
                )),
          )
        : SizedBox(
            width: isResponseve ? double.infinity : width,
            height: height,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: color),
                onPressed: onPressed,
                child: DefaultText(
                  lable,
                  style: Get.textTheme.displayMedium,
                )),
          );

class DefaultCountainer extends StatelessWidget {
  const DefaultCountainer(
      {this.width,
      this.height,
      this.borderRadius,
      this.color = Colors.white,
      this.padding,
      this.margin,
      this.borderRadiusSpecific,
      this.child,
      this.colorShadow,
      super.key,
      this.colorBorder,
      this.isborderall,
      this.alignment,
      this.offset});
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusSpecific;
  final Color? color;
  final Widget? child;
  final Color? colorShadow;
  final Color? colorBorder;
  final bool? isborderall;
  final EdgeInsetsGeometry? margin;
  final Offset? offset;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: margin,
      width: width,
      height: height,

      padding: padding,
      //  width: MediaQuery.of(context).size.width / 2 + 50,
      decoration: BoxDecoration(
        borderRadius: borderRadiusSpecific ??
            (borderRadius != null
                ? BorderRadius.circular(borderRadius!)
                : null),
        color: color,
        border: isborderall ?? false
            ? Border.all(color: Get.theme.colorScheme.primary, width: 1)
            : null,
        //     : null,
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: colorShadow ?? Colors.grey,
            offset: offset ?? const Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class BorderCoverWidget extends StatelessWidget {
  const BorderCoverWidget(
      {super.key, required this.child, this.label, this.colorBorder});
  final Widget child;
  final String? label;
  final Color? colorBorder;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  color: colorBorder ?? Get.theme.colorScheme.primary),
              borderRadius: BorderRadius.circular(15)),
          child: child,
        ),
        if (label != null)
          Positioned(
              top: 0,
              right: 20,
              child: Container(
                  color: Colors.white,
                  child: Text(
                    label!,
                    style: Get.textTheme.headlineSmall,
                  )))
      ],
    );
  }
}

class DefaultCountainerExtension extends StatelessWidget {
  const DefaultCountainerExtension(
      {this.width,
      this.height,
      this.borderRadius,
      this.color = Colors.white,
      this.padding,
      this.margin,
      this.borderRadiusSpecific,
      this.child,
      this.colorShadow,
      super.key,
      this.colorBorder,
      this.isborderall,
      this.isBoxShadow});
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusSpecific;
  final Color? color;
  final Widget? child;
  final Color? colorShadow;
  final Color? colorBorder;
  final bool? isborderall;
  final bool? isBoxShadow;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,

      padding: padding,
      //  width: MediaQuery.of(context).size.width / 2 + 50,
      decoration: BoxDecoration(
        borderRadius: borderRadiusSpecific ??
            (borderRadius != null
                ? BorderRadius.circular(borderRadius!)
                : null),
        color: color,
        border: isborderall ?? false
            ? Border.all(color: Get.theme.colorScheme.primary, width: 1)
            : null,
        // ignore: prefer_const_literals_to_create_immutables
        // boxShadow:isBoxShadow??false?  [
        //   BoxShadow(
        //     color: colorShadow ?? Colors.grey,
        //     offset: const Offset(0.0, 1.0), //(x,y)
        //     blurRadius: 2.0,
        //   ),
        // ]
      ),
      child: child,
    );
  }
}

DateTimePicker defaultDataTimePicker({
  Widget? label,
  Function(String)? onChanged,
  bool isborderall = false,
  Color enableBorderColor = DefaultColor.primaryColor,
  Color facaColor = DefaultColor.sencondreColor,
  Widget? suffixIcon = const Icon(
    Icons.event,
    color: DefaultColor.primaryColor,
  ),
  EdgeInsetsGeometry? contentPadding,
}) {
  return DateTimePicker(
    style: TextStyle(fontSize: defaultSizeFont),
    onChanged: onChanged,
    decoration: InputDecoration(

        //filled: true,
        contentPadding: contentPadding,
        enabledBorder: isborderall
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: enableBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: enableBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
        focusedBorder: isborderall
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: facaColor,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: facaColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
        label: label,
        hintStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        suffixIcon: suffixIcon),

    type: DateTimePickerType.date,
    dateMask: 'd /M /yyyy',
    initialValue: DateTime.now().toString(),
    firstDate: DateTime.now(),
    //decoration: InputDecoration(),
    lastDate: DateTime(2100),
    icon: const Icon(Icons.event),
    dateLabelText: 'تاريخ الغادره',
    selectableDayPredicate: (date) {
      // Disable weekend days to select from the calendar
      if (date.weekday == 6 || date.weekday == 7) {
        return false;
      }

      return true;
    },

    validator: (val) {
      return null;
    },
    onSaved: (val) {},
  );
}

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({required this.onTap, required this.index, super.key});
  final Function(int) onTap;
  int index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: ((value) {
        onTap(value);
        index = value;
      }),
      fixedColor: Colors.white,
      currentIndex: index,

      // fixedColor: MyColor.primaryColor,
      items: [
        BottomNavigationBarItem(
          backgroundColor: DefaultColor.primaryColor,
          icon: SvgPicture.asset(
            'icons/homeone.svg',
            width: 40,
            height: 40,
          ),
          label: "الصفحة الرئيسية",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'icons/evidence.svg',
            width: 40,
            height: 40,
            color: DefaultColor.colorIconPrimary,
          ),
          label: "طلباتي",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'icons/user.svg',
            width: 40,
            height: 40,
            color: DefaultColor.colorIconPrimary,
          ),
          label: "حسابي",
        ),
      ],
    );
  }
}

class MyBottomNavigationBarUpdate extends StatelessWidget {
  MyBottomNavigationBarUpdate(
      {this.onItemSelected,
      this.controller,
      this.items,
      super.key,
      required this.screens});
  void Function(int)? onItemSelected;

  final List<Widget> screens;
  PersistentTabController? controller;
  List<PersistentBottomNavBarItem>? items;
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      decoration:
          NavBarDecoration(colorBehindNavBar: Get.theme.colorScheme.secondary),
      onItemSelected: onItemSelected,
      context,
      screens: screens,
      controller: controller,
      items: items,
      backgroundColor: Get.theme.colorScheme.primary,
      navBarStyle: NavBarStyle.style1,
    );
  }
}

class DefaultIcon extends StatelessWidget {
  DefaultIcon({super.key, this.icon, this.color, this.size});
  IconData? icon;
  double? height;
  double? width;
  double? size;
  bool _isSvg = false;
  Color? color;
  String? path;
  late AlignmentGeometry alignment;
  late BoxFit fit;
  DefaultIcon.svg(
      {super.key,
      required this.path,
      this.height,
      this.width,
      this.fit = BoxFit.contain,
      this.alignment = Alignment.center,
      this.color}) {
    _isSvg = true;
  }
  @override
  Widget build(BuildContext context) {
    return _isSvg
        ? SvgPicture.asset(
            path!,
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            // ignore: deprecated_member_use
            color: color,
          )
        : Icon(
            icon,
            color: color ?? Get.theme.colorScheme.primary,
            size: size,
          );
  }
}

class CheckBoxModel extends StatelessWidget {
  CheckBoxModel({super.key, required this.options});
  List<OptionTypeFiled> options;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget defaultDropDownForm(
    {String? title,
    Function(dynamic)? onSaved,
    required List<dynamic>? dataList,
    String? helpText,
    required Function(dynamic) onChanged,
    required dynamic value,
    Color colorTextShow = DefaultColor.textPrimary,
    double height = 40,
    Color enableBorderColor = DefaultColor.primaryColor,
    Color focuseBorderColor = DefaultColor.sencondreColor,
    double width = 100}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (title == null)
            ? Container()
            : DefaultText(
                title,
              ),
        Center(
          child: DropdownButtonFormField<dynamic>(
              onSaved: onSaved,
              alignment: Alignment.topCenter,
              // ignore: prefer_const_constructors
              style: TextStyle(
                height: 1,
              ),
              decoration: InputDecoration(
                  helperText: helpText,
                  contentPadding: const EdgeInsets.all(8.0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 1, color: enableBorderColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 1, color: focuseBorderColor))),
              value: value,
              items: dataList!
                  .map((e) => DropdownMenuItem<dynamic>(
                        value: e,
                        child: DefaultText(
                          e.nameArabic,
                        ),
                      ))
                  .toList(),
              onChanged: onChanged),
        ),
      ],
    ),
  );
}

class DefaultDataTimePickerWidget extends StatelessWidget {
  DefaultDataTimePickerWidget(
      {super.key,
      this.contentPadding,
      this.enableBorderColor,
      this.label,
      this.dateLabelText,
      this.suffixIcon,
      this.lastDate,
      this.firstDate,
      this.cancelText,
      this.calendarTitle,
      this.confirmText,
      this.initialDate,
      required this.isborderall,
      this.focuseColor,
      this.validator,
      this.onChanged,
      this.type});
  Function(String)? onChanged;
  EdgeInsetsGeometry? contentPadding;
  bool isborderall;
  String? dateLabelText;
  Color? enableBorderColor;
  Color? focuseColor;
  Widget? label;
  Widget? suffixIcon;
  DateTime? initialDate;
  DateTime? firstDate;
  DateTime? lastDate;
  String? calendarTitle;
  String? confirmText;
  String? cancelText;
  String? Function(String?)? validator;
  final DateTimePickerType? type;
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      cancelText: cancelText,
      // locale: const Locale('ar'),

      calendarTitle: calendarTitle,
      confirmText: confirmText,
      initialDate: initialDate,
      initialTime: TimeOfDay.now(),
      style: Get.textTheme.headlineMedium,
      onChanged: onChanged,
      decoration: InputDecoration(
          labelStyle: Get.textTheme.headlineMedium,
          //filled: true,
          contentPadding: contentPadding,
          enabledBorder: isborderall
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: enableBorderColor ?? Get.theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: enableBorderColor ?? Get.theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
          focusedBorder: isborderall
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: focuseColor ?? Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: focuseColor ?? Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
          label: label,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: suffixIcon ??
              Icon(
                Icons.event,
                color: Get.theme.colorScheme.primary,
              )),
      use24HourFormat: false,

      type: type ?? DateTimePickerType.date,
      dateMask: type != null ? null : 'd /M /yyyy',
      // initialValue: '',
      firstDate: firstDate ?? DateTime(1900),
      //decoration: InputDecoration(),
      lastDate:
          lastDate ?? DateUtils.addMonthsToMonthDate(DateTime.now(), 12 * 20),
      icon: Icon(
        Icons.lock_clock,
        color: Get.theme.colorScheme.primary,
      ),
      dateLabelText: dateLabelText,
      // selectableDayPredicate: (date) ~{

      //   if (date.weekday == 6 || date.weekday == 7) {
      //     return false;
      //   }

      //   return true;
      // },

      validator: validator,
      onSaved: (val) {},
    );
  }
}

class DefaultTimePickerWidget extends StatelessWidget {
  const DefaultTimePickerWidget(
      {super.key,
      this.contentPadding,
      this.enableBorderColor,
      this.label,
      this.suffixIcon,
      required this.isborderall,
      this.focuseColor,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.type,
      this.hintText});
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final bool isborderall;

  final Color? enableBorderColor;
  final Color? focuseColor;
  final Widget? label;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final DateTimePickerType? type;
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      initialTime: TimeOfDay.now(),
      style: Get.textTheme.headlineMedium,
      // timePickerEntryModeInput: f,
      locale: Locale('en'),
      onChanged: onChanged,
//  textInputAction:TextInputAction.done,
      // dateMask: 'h:mm a',
      timeFieldWidth: 50,
      decoration: InputDecoration(
          hintText: hintText,
          labelStyle: Get.textTheme.headlineMedium,
          contentPadding: contentPadding,
          enabledBorder: isborderall
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: enableBorderColor ?? Get.theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: enableBorderColor ?? Get.theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
          focusedBorder: isborderall
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: focuseColor ?? Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: focuseColor ?? Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
          label: label,
          hintStyle: Get.textTheme.displaySmall,
          suffixIcon: suffixIcon ??
              Icon(
                Icons.lock_clock,
                color: Get.theme.colorScheme.primary,
              )),
      use24HourFormat: false,
      type: DateTimePickerType.time,
      icon: Icon(
        Icons.lock_clock,
        color: Get.theme.colorScheme.primary,
      ),
      validator: validator,
      onSaved: onSaved,
      // onFieldSubmitted:onFieldSubmitted ,
    );
  }
}

Widget selectTypeFiledWidget(MainRequirment main) {
  if (main.typeFiled!.id == 1) {
    return DefaultTextFormField(
      label: main.name,
      hintText: '',
      isborderall: true,
    );
  } else if (main.typeFiled!.id == 2) {
    return Column(
      children: const [],
    );
  } else {
    return const Text('');
  }
}

class DefaultImagePicker extends StatelessWidget {
  DefaultImagePicker(
      {super.key, this.icon, required this.main, required this.onTap});
  Widget? icon;
  Function()? onTap;
  dynamic main;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: icon ?? const Icon(Icons.image),
        title: Text(
          main.name ?? main.containt!,
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }
}

Row itemIsFamilyWidget(controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: GFRadioListTile(
          titleText: 'عائلي',
          color: Get.theme.colorScheme.secondary,
          radioColor: Get.theme.colorScheme.primary,
          groupValue: controller is ServicesScreenController
              ? controller.groubeVauleIsFamily.value
              : controller is ServicesPublicController
                  ? controller.isFamily.value
                  : 0,
          value: true,
          onChanged: (value) {
            // controller.groubeVauleIsFamily.value = value;
            if (controller is ServicesScreenController) {
              controller.changisFamily(value);
            } else if (controller is ServicesPublicController) {
              controller.onchangeIsfamily(value);
            }
          },
        ),
      ),
      Expanded(
        child: GFRadioListTile(
          selected: true,
          color: Get.theme.colorScheme.secondary,
          radioColor: Get.theme.colorScheme.primary,
          titleText: 'غير عائلي',
          groupValue: controller is ServicesScreenController
              ? controller.groubeVauleIsFamily.value
              : controller is ServicesPublicController
                  ? controller.isFamily.value
                  : 0,
          value: false,
          onChanged: (value) {
            if (controller is ServicesScreenController) {
              controller.changisFamily(value);
            } else if (controller is ServicesPublicController) {
              controller.onchangeIsfamily(value);
            }
          },
        ),
      ),
    ],
  );
}

class DefaultRadioList extends StatelessWidget {
  DefaultRadioList(
      {Key? key,
      required this.data,
      this.titleText,
      required this.onChanged,
      required this.groupValue})
      : super(key: key);
  String? titleText;
  dynamic groupValue;
  Function(dynamic)? onChanged;

  final List data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: data
            .map(
              (e) => Expanded(
                child: RadioListTile(
                    title: Text(
                      e is Gender
                          ? e.nameAr!
                          : e is Choose?
                              ? e!.containt!
                              : e is MainRequirment
                                  ? e.name ?? e.containt!
                                  : e is Plantrip?
                                      ? e!.name!
                                      : e is String
                                          ? e
                                          : titleText ?? '',
                      style: Get.textTheme.headlineMedium,
                    ),
                    // color: Get.theme.colorScheme.secondary,
                    //   radioColor: Get.theme.colorScheme.primary,
                    groupValue: groupValue,
                    value: e,
                    onChanged: onChanged),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DefaultFilePicker extends StatelessWidget {
  DefaultFilePicker(
      {super.key, this.icon, required this.main, required this.onTap});
  Widget? icon;
  Function()? onTap;
  dynamic main;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: icon ?? const Icon(Icons.file_open),
        title: Text(
          main.name ?? main.containt!,
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class FilePickerApp extends StatelessWidget {
  FilePickerApp(
      {super.key, this.icon, required this.main, required this.onTap});
  Widget? icon;
  Function()? onTap;
  dynamic main;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: icon ?? const Icon(Icons.file_open),
        title: Text(
          main is String ? main : '',
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
