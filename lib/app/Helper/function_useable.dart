String? getDatetoString(DateTime? date) {
  if (date != null) {
    return '${date.day} - ${date.month} - ${date.year}';
  } else {
    return null;
  }
}

String? getDayString(DateTime? date) {
  if (date != null) {
    return '${date.day}';
  } else {
    return null;
  }
}

String? getMonthString(DateTime? date) {
  if (date != null) {
    return '${date.month}';
  } else {
    return null;
  }
}

String getDayArabic(DateTime date) {
  switch (date.weekday) {
    case 1:
      return 'الاثنين';
    case 2:
      return 'الثلاثاء';
    case 3:
      return 'الاربعاء';
    case 4:
      return 'الخميس';
    case 5:
      return 'الجمعة';
    case 6:
      return 'السبت';
    case 7:
      return 'الاحد';

    default:
      return '';
  }
}

int getAge(String dateOfBirht) {
  DateTime birthdate = DateTime.parse(dateOfBirht);
  DateTime now = DateTime.now();
  int age = now.year - birthdate.year;
  if (now.month < birthdate.month ||
      (now.month == birthdate.month && now.day < birthdate.day)) {
    age--;
  }
  return age;
}
