class ReportHelper {
  static List<T> uniqueData<T>(
      {required List<T> data,
      required bool Function(T value, Set<T>) condatioin}) {
    Set<T> uniqudata = Set<T>();
    for (var iteme in data) {
      if (condatioin(iteme, uniqudata)) {
        uniqudata.add(iteme);
      }
    }
    return uniqudata.toList();
  }
}
