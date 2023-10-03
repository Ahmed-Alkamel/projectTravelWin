// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

class AppTranslation implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': Locales.ar,
        'en': Locales.en,
      };
}

class LocaleKeys {
  LocaleKeys._();
  static const buttons_login = 'buttons_login';
  static const buttons_sign_in = 'buttons_sign_in';
  static const buttons_logout = 'buttons_logout';
  static const buttons_sign_in_fb = 'buttons_sign_in_fb';
  static const buttons_sign_in_google = 'buttons_sign_in_google';
  static const buttons_sign_in_apple = 'buttons_sign_in_apple';
  static const titlePage_SearchTrip = 'titlePage_SearchTrip';
  static const titlePage_CustomerInf = 'titlePage_CustomerInf';
  static const titlePage_TripInBookingTrip = 'titlePage_TripInBookingTrip';
  static const trip_fromCity = 'trip_fromCity';
  static const trip_ToCity = 'trip_ToCity';
  static const trip_price = 'trip_price';
  static const trip_company = 'trip_company';
  static const trip_servicesName = 'trip_servicesName';
  static const trip_method = 'trip_method';
  static const trip_ltinerary = 'trip_ltinerary';
  static const trip_dateAndTimeSeats = 'trip_dateAndTimeSeats';
  static const trip_numberTripComany = 'trip_numberTripComany';
  static const trip_discont = 'trip_discont';
  static const TripScreen_selectCategeory = 'TripScreen_selectCategeory';
  static const TripScreen_selectWay = 'TripScreen_selectWay';
  static const personalData_Adult = 'personalData_Adult';
  static const personalData_childern = 'personalData_childern';
  static const personalData_baby = 'personalData_baby';
  static const personalData_gender = 'personalData_gender';
  static const personalData_male = 'personalData_male';
  static const personalData_female = 'personalData_female';
  static const bottomSheetBooking_countAdult = 'bottomSheetBooking_countAdult';
  static const bottomSheetBooking_countChildern =
      'bottomSheetBooking_countChildern';
  static const bottomSheetBooking_countBaby = 'bottomSheetBooking_countBaby';
  static const authScrean_login = 'authScrean_login';
  static const authScrean_sign_in = 'authScrean_sign_in';
  static const authScrean_logout = 'authScrean_logout';
  static const authScrean_sign_in_fb = 'authScrean_sign_in_fb';
  static const authScrean_sign_in_google = 'authScrean_sign_in_google';
  static const authScrean_sign_in_apple = 'authScrean_sign_in_apple';
  static const authScrean_email_or_phone_hint =
      'authScrean_email_or_phone_hint';
  static const authScrean_identity = 'authScrean_identity';
  static const authScrean_pasword = 'authScrean_pasword';
  static const authScrean_pasword_hint = 'authScrean_pasword_hint';
  static const authScrean_aleardyAcount = 'authScrean_aleardyAcount';
  static const authScrean_createAcount = 'authScrean_createAcount';
  static const authScrean_or = 'authScrean_or';
  static const createAcount_name = 'createAcount_name';
  static const createAcount_nameHint = 'createAcount_nameHint';
  static const createAcount_phoneNumber = 'createAcount_phoneNumber';
  static const createAcount_phoneNumberHint = 'createAcount_phoneNumberHint';
  static const createAcount_email = 'createAcount_email';
  static const createAcount_emailHint = 'createAcount_emailHint';
  static const createAcount_password = 'createAcount_password';
  static const createAcount_passwordHint = 'createAcount_passwordHint';
  static const createAcount_passwordConform = 'createAcount_passwordConform';
  static const createAcount_passwordConformHint =
      'createAcount_passwordConformHint';
}

class Locales {
  static const ar = {
    'buttons_login': 'تسجيل دخول',
    'buttons_sign_in': 'انشاء حساب',
    'buttons_logout': 'تسجيل خروج',
    'buttons_sign_in_fb': 'تسجيل دخول فيسبوك',
    'buttons_sign_in_google': 'تسجيل دخول جوجل',
    'buttons_sign_in_apple': 'تسجيل دخول ابل',
    'titlePage_SearchTrip': 'البحث عن رحلة',
    'titlePage_CustomerInf': 'المعلومات الشخصية',
    'titlePage_TripInBookingTrip': 'الرحلة',
    'trip_fromCity': 'من مدينة',
    'trip_ToCity': 'الى مدينة',
    'trip_price': 'السعر',
    'trip_company': 'الشركة',
    'trip_servicesName': 'اسم الخدمة',
    'trip_method': 'نوع الرحلة',
    'trip_ltinerary': 'خط الرحلة',
    'trip_dateAndTimeSeats': 'تاريخ  الرحلة',
    'trip_numberTripComany': 'رقم الرحلة',
    'trip_discont': 'التخفيض',
    'TripScreen_selectCategeory': 'اختيار التصنيف',
    'TripScreen_selectWay': 'طريقة الرحلة',
    'personalData_Adult': 'البالغين',
    'personalData_childern': 'الاطفال',
    'personalData_baby': 'الرضع',
    'personalData_gender': 'الجنس',
    'personalData_male': 'ذكر',
    'personalData_female': 'انثي',
    'bottomSheetBooking_countAdult': 'عدد البالغين',
    'bottomSheetBooking_countChildern': 'عدد الاطفال',
    'bottomSheetBooking_countBaby': 'عدد الرضع',
    'authScrean_login': 'تسجيل دخول',
    'authScrean_sign_in': 'تسجيل حساب',
    'authScrean_logout': 'تسجيل خروج',
    'authScrean_sign_in_fb': 'تسجيل دخول فيسبوك',
    'authScrean_sign_in_google': 'تسجيل دخول جوجل',
    'authScrean_sign_in_apple': 'تسجيل دخول ابل',
    'authScrean_email_or_phone_hint': 'ادخل اللإميل او رقم الهاتف',
    'authScrean_identity': 'المعرف',
    'authScrean_pasword': 'كلمة السر',
    'authScrean_pasword_hint': 'ادخل كلمة السر',
    'authScrean_aleardyAcount': 'لا املك حساب انشاء حساب',
    'authScrean_createAcount': 'انشاء حساب',
    'authScrean_or': 'او',
    'createAcount_name': 'الاسم',
    'createAcount_nameHint': 'ادخل الاسم',
    'createAcount_phoneNumber': 'رقم الجوال',
    'createAcount_phoneNumberHint': 'ادخل رقم الجوال',
    'createAcount_email': 'البريد الاكتروني',
    'createAcount_emailHint': 'ادخل البريد الالكتروني',
    'createAcount_password': 'كلمة السر',
    'createAcount_passwordHint': 'ادخل كلمة السر',
    'createAcount_passwordConform': 'تاكيد كلمة السر',
    'createAcount_passwordConformHint': 'ادخل تاكيد كلمة السر',
  };
  static const en = {
    'buttons_login': 'Login',
    'buttons_sign_in': 'Sign-in',
    'buttons_logout': 'Logout',
    'buttons_sign_in_fb': 'Sign-in with Facebook',
    'buttons_sign_in_google': 'Sign-in with Google',
    'buttons_sign_in_apple': 'Sign-in with Apple',
    'titlePage_SearchTrip': 'Search Trip',
    'titlePage_CustomerInf': 'personal Infomation',
    'titlePage_TripInBookingTrip': 'Trip',
    'trip_fromCity': 'fromCity',
    'trip_ToCity': 'ToCity',
    'trip_price': 'price',
    'trip_company': 'company',
    'trip_servicesName': 'servicesName',
    'trip_method': 'method',
    'trip_ltinerary': 'ltinerary',
    'trip_dateAndTimeSeats': 'dateAndTimeSeats',
    'trip_numberTripComany': 'numberTripComany',
    'trip_discont': 'discont',
    'TripScreen_selectCategeory': 'Category',
    'TripScreen_selectWay': 'way Trip',
    'personalData_Adult': 'Adult',
    'personalData_childern': 'childern',
    'personalData_baby': 'baby',
    'personalData_gender': 'gender',
    'personalData_male': 'male',
    'personalData_female': 'female',
    'bottomSheetBooking_countAdult': 'Count Adult',
    'bottomSheetBooking_countChildern': 'Count Childern',
    'bottomSheetBooking_countBaby': 'Count Baby',
    'authScrean_login': 'Login',
    'authScrean_sign_in': 'Sign-in',
    'authScrean_logout': 'Logout',
    'authScrean_sign_in_fb': 'Sign-in with Facebook',
    'authScrean_sign_in_google': 'Sign-in with Google',
    'authScrean_sign_in_apple': 'Sign-in with Apple',
    'authScrean_email_or_phone_hint': 'Enter Email or Phone Number ',
    'authScrean_identity': 'id',
    'authScrean_pasword': 'Passowrd',
    'authScrean_pasword_hint': 'Enter your Password',
    'authScrean_aleardyAcount': 'I have Acount',
    'authScrean_createAcount': 'Create Acount',
    'authScrean_or': 'Or',
    'createAcount_name': 'name',
    'createAcount_nameHint': 'name Hint',
    'createAcount_phoneNumber': 'phoneNumber',
    'createAcount_phoneNumberHint': 'phoneNumberHint',
    'createAcount_email': 'email',
    'createAcount_emailHint': 'emailHint',
    'createAcount_password': 'password',
    'createAcount_passwordHint': 'passwordHint',
    'createAcount_passwordConform': 'passwordConform',
    'createAcount_passwordConformHint': 'passwordConformHint',
  };
}
