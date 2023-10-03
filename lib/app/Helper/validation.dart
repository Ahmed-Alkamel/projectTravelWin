import 'package:get/get.dart';

enum ValidateType {
  text,
  name,
  passwordConfigre,
  number,
  required,
  requiredAdnlength,
  passord,
  email
}

class ValidatorApp {
  static String? getVaidator(ValidateType validate, String? value,
      {String? confirm}) {
    switch (validate) {
      case ValidateType.required:
        {
          if (value == null || value.isEmpty) {
            return 'لا تترك الحقل فارغا';
          } else {
            return null;
          }
        }
      case ValidateType.passwordConfigre:
        {
          if (value == null || value.isEmpty) {
            return 'لا تترك الحقل فارغا';
          } else if (value != confirm) {
            return 'كلمة السر غير متطابقة';
          } else {
            return null;
          }
        }

      case ValidateType.passord:
        {
          if (value!.isEmpty) {
            return 'لا تترك الحقل فارغا';
          } else if (value.length < 8) {
            return 'يجب ان لا تقل كلمة السر عن 8 حروف وعلا الاقل رقم واحد';
          } else if (value.length > 190) {
            return 'لقد تجاوزت الحد المسموح للخانات';
          } else {
            return null;
          }
        }
      case ValidateType.number:
        {
          if (value!.isEmpty) {
            return 'لا تترك الحقل فارغا';
          } else if (value.length > 15) {
            return 'يجب ان لا تقل كلمة السر عن 8 حروف وعلا الاقل رقم واحد';
          } else {
            return null;
          }
        }
      case ValidateType.email:
        {
          if (value!.isEmpty) {
            return 'لا تترك الحقل فارغا';
          } else if (!value.isEmail) {
            return 'قم بكتابة البريد بشكل صحيح يجب ان ينتهي @gmail.com';
          } else {
            return null;
          }
        }
      default:
        return '';
    }
  }
}
