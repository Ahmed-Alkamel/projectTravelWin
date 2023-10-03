import 'package:get/get.dart';
import 'package:projecttravelwin/app/Helper/report_helper.dart';
import 'package:projecttravelwin/app/models/basic/user_request.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:math' as math;

/// Package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../basic/trips.dart';
// class CustomerRequestDataSourc extends DataGridSource {
//   UserRequest? data;
//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {}
// }

/// Set order's data collection to data grid source.
class CustomerRequestDataSourc extends DataGridSource {
  /// Creates the order data source class with required details.
  CustomerRequestDataSourc(
      {this.model,
      required this.isWebOrDesktop,
      this.orderDataCount,
      this.ordersCollection,
      this.culture,
      bool? isFilteringSample}) {
    this.isFilteringSample = isFilteringSample ?? false;
    orders = ordersCollection ??
        getOrders(orders, orderDataCount ?? 100, culture: culture ?? '');
    // currencySymbol = getCurrencySymbol();
    buildDataGridRows();
  }

  /// Determine to decide whether the platform is web or desktop.
  final bool isWebOrDesktop;

  /// Instance of SampleModel.
  final UserRequest? model;

  /// Localization Source.
  String? culture;

  /// Get data count of an order.
  int? orderDataCount;
  final math.Random _random = math.Random();

  /// Instance of an order.
  List<UserRequest> orders = <UserRequest>[];

  /// Instance of an order collection for rtl sample
  List<UserRequest>? ordersCollection;
  List<UserRequest> get uniqOrder {
    return ReportHelper.uniqueData(
        data: orders,
        condatioin: (value, collcation) {
          return !collcation
              .any((element) => element.serviceName == value.serviceName);
        });
  }

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Currency symbol for culture.
  String currencySymbol = '';

  /// Checks whether the source is used for the filtering sample or not.
  late bool isFilteringSample;

  /// Building DataGridRows.
  void buildDataGridRows() {
    dataGridRows = isWebOrDesktop
        ? uniqOrder.map<DataGridRow>((UserRequest order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(
                  columnName: getColumnName('اسم الخدمة'),
                  value: order.serviceName!),
              DataGridCell<int>(
                  columnName: getColumnName('allcount'),
                  value: orders
                      .where(
                          (element) => element.serviceName == order.serviceName)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('allDone'),
                  value: orders
                      .where((element) =>
                          element.serviceName == order.serviceName &&
                          element.state!.id == 4)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('allqidTalab'),
                  value: orders
                      .where((element) =>
                          element.serviceName == order.serviceName &&
                          element.state!.id == 1)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('allProgress'),
                  value: orders
                      .where((element) =>
                          element.serviceName == order.serviceName &&
                          element.state!.id == 2)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('allReqect'),
                  value: orders
                      .where((element) =>
                          element.serviceName == order.serviceName &&
                          element.state!.id == 3)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('allEdite'),
                  value: orders
                      .where((element) =>
                          element.serviceName == order.serviceName &&
                          element.state!.id == 5)
                      .toList()
                      .length),
              // DataGridCell<int>(
              //     columnName: getColumnName('name'), value: ),
              // DataGridCell<double>(
              //     columnName: getColumnName('freight'), value: order.freight),
              // DataGridCell<String>(
              //     columnName: getColumnName('city'), value: order.city),
              // DataGridCell<double>(
              //     columnName: getColumnName('price'), value: order.price),
            ]);
          }).toList()
        : uniqOrder.map<DataGridRow>((UserRequest order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(
                  columnName: getColumnName('customerId'), value: order.idCus),
              DataGridCell<String>(
                  columnName: getColumnName('name'),
                  value: order.customer!.nikName),
              DataGridCell<int>(
                  columnName: getColumnName('عدد الطلب'),
                  value: orders
                      .where(
                          (element) => element.serviceName == order.serviceName)
                      .toList()
                      .length),
              // DataGridCell<String>(
              //     columnName: getColumnName('city'), value: order.city),
            ]);
          }).toList();
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if (model != null && (rowIndex % 2) == 0 && culture == null) {
      backgroundColor = Get.theme.colorScheme.primary;
    }
    if (isWebOrDesktop) {
      return DataGridRowAdapter(color: backgroundColor, cells: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            row.getCells()[2].value.toString(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
              // NumberFormat.currency(locale: 'en', symbol: currencySymbol)
              //     .format(row.getCells()[3].value)
              row.getCells()[3].value.toString()),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
              // NumberFormat.currency(
              //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
              //   .format(row.getCells()[5].value)
              row.getCells()[5].value.toString()),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
              // NumberFormat.currency(
              //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
              //   .format(row.getCells()[6].value)
              row.getCells()[6].value.toString()),
        ),
      ]);
    } else {
      Widget buildWidget({
        AlignmentGeometry alignment = Alignment.centerLeft,
        EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
        TextOverflow textOverflow = TextOverflow.ellipsis,
        required Object value,
      }) {
        return Container(
          padding: padding,
          alignment: alignment,
          child: Text(
            value.toString(),
            overflow: textOverflow,
          ),
        );
      }

      return DataGridRowAdapter(
          color: backgroundColor,
          cells: row.getCells().map<Widget>((DataGridCell dataCell) {
            if (dataCell.columnName == getColumnName('id') ||
                dataCell.columnName == getColumnName('customerId')) {
              return buildWidget(
                  alignment: Alignment.centerRight, value: dataCell.value!);
            } else {
              return buildWidget(value: dataCell.value!);
            }
          }).toList(growable: false));
    }
  }

  /// Currency symbol
  String getCurrencySymbol() {
    if (culture != null) {
      final format = NumberFormat.compactSimpleCurrency(locale: 'en');
      return format.currencySymbol;
    } else {
      final format = NumberFormat.simpleCurrency();
      return format.currencySymbol;
    }
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    Widget? widget;
    Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(
          value,
          // overflow: TextOverflow.ellipsis,
          style: Get.textTheme.headlineSmall,
        ),
      );
    }

    if (summaryRow.showSummaryInRow) {
      widget = buildCell(
          summaryValue, const EdgeInsets.all(16.0), Alignment.centerLeft);
    } else if (summaryValue.isNotEmpty) {
      if (summaryColumn!.columnName == 'allcount') {
        summaryValue = 'اجمالي الطلبات: '.toString() + orders.length.toString();
      } else if (summaryColumn.columnName == 'allDone') {
        summaryValue = '  اجمالي الطلبات المكتملة'.toString() +
            orders
                .where((element) => element.state!.id == 4)
                .toList()
                .length
                .toString();
      } else if (summaryColumn.columnName == 'allqidTalab') {
        summaryValue = '  اجمالي الطلبات قيد الطلب'.toString() +
            orders
                .where((element) => element.state!.id == 1)
                .toList()
                .length
                .toString();
      } else if (summaryColumn.columnName == 'allProgress') {
        summaryValue = '  اجمالي الطلبات تحت المعالجة'.toString() +
            orders
                .where((element) => element.state!.id == 2)
                .toList()
                .length
                .toString();
      } else if (summaryColumn.columnName == 'allReqect') {
        summaryValue = '  اجمالي الطلبات الملغية'.toString() +
            orders
                .where((element) => element.state!.id == 3)
                .toList()
                .length
                .toString();
      } else if (summaryColumn.columnName == 'allReqect') {
        summaryValue = '  اجمالي الطلبات الملغية'.toString() +
            orders
                .where((element) => element.state!.id == 3)
                .toList()
                .length
                .toString();
      } else if (summaryColumn.columnName == 'allEdite') {
        summaryValue = '  اجمالي الطلبات بنتظار التعديل'.toString() +
            orders
                .where((element) => element.state!.id == 5)
                .toList()
                .length
                .toString();
      }

      widget = buildCell(
          summaryValue, const EdgeInsets.all(8.0), Alignment.centerRight);
    }
    return widget;
  }

  /// Provides the column name.
  String getColumnName(String columnName) {
    if (isFilteringSample) {
      switch (columnName) {
        case 'id':
          return 'Order ID';
        case 'customerId':
          return 'Customer ID';
        case 'name':
          return 'Name';
        case 'freight':
          return 'Freight';
        case 'city':
          return 'City';
        case 'price':
          return 'Price';
        default:
          return columnName;
      }
    }
    return columnName;
  }

  /// Update DataSource
  void updateDataSource() {
    notifyListeners();
  }

  //  Order Data's
  final List<String> _names = <String>[
    'Crowley',
    'Blonp',
    'Folko',
    'Irvine',
    'Folig',
    'Picco',
    'Frans',
    'Warth',
    'Linod',
    'Simop',
    'Merep',
    'Riscu',
    'Seves',
    'Vaffe',
    'Alfki',
  ];

  final List<String> _frenchNames = <String>[
    'Crowley',
    'Blonp',
    'Folko',
    'Irvine',
    'Folig',
    'Pico',
    'François',
    'Warth',
    'Linod',
    'Simop',
    'Merep',
    'Riscu',
    'Sèves',
    'Vaffé',
    'Alfki',
  ];

  final List<String> _spanishNames = <String>[
    'Crowley',
    'Blonp',
    'Folko',
    'Irvine',
    'Folig',
    'Cima',
    'francés',
    'Warth',
    'lindod',
    'Simop',
    'Merep',
    'Riesgo',
    'Suyas',
    'Gofre',
    'Alfki',
  ];

  final List<String> _chineseNames = <String>[
    '克勞利',
    '布隆普',
    '民間',
    '爾灣',
    '佛利格',
    '頂峰',
    '法語',
    '沃思',
    '林諾德',
    '辛普',
    '梅雷普',
    '風險',
    '塞維斯',
    '胡扯',
    '阿里基',
  ];

  final List<String> _arabicNames = <String>[
    'كراولي',
    'بلونب',
    'فولكو',
    'ايرفين',
    'فوليج',
    'بيكو',
    'فرانس',
    'وارث',
    'لينود',
    'سيموب',
    'مرحى',
    'ريسكو',
    'السباعيات',
    'فافي',
    'الفكي',
  ];

  final List<String> _cities = <String>[
    'Bruxelles',
    'Rosario',
    'Recife',
    'Graz',
    'Montreal',
    'Tsawassen',
    'Campinas',
    'Resende',
  ];

  final List<String> _chineseCties = <String>[
    '布魯塞爾',
    '羅薩里奧',
    '累西腓',
    '格拉茨',
    '蒙特利爾',
    '薩瓦森',
    '坎皮納斯',
    '重新發送',
  ];

  final List<String> _frenchCties = <String>[
    'Bruxelles',
    'Rosario',
    'Récife',
    'Graz',
    'Montréal',
    'Tsawassen',
    'Campinas',
    'Renvoyez',
  ];

  final List<String> _spanishCties = <String>[
    'Bruselas',
    'Rosario',
    'Recife',
    'Graz',
    'Montréal',
    'Tsawassen',
    'Campiñas',
    'Reenviar',
  ];

  final List<String> _arabicCties = <String>[
    ' بروكسل',
    'روزاريو',
    'ريسيفي',
    'غراتس',
    'مونتريال',
    'تساواسن',
    'كامبيناس',
    'ريسيندي',
  ];

  /// Get orders collection
  List<UserRequest> getOrders(List<UserRequest> orderData, int count,
      {String? culture}) {
    final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
        endIndex = startIndex + count;
    List<String> city;
    List<String> names;

    if (culture == 'Chinese') {
      city = _chineseCties;
      names = _chineseNames;
    } else if (culture == 'Arabic') {
      city = _arabicCties;
      names = _arabicNames;
    } else if (culture == 'French') {
      city = _frenchCties;
      names = _frenchNames;
    } else if (culture == 'Spanish') {
      city = _spanishCties;
      names = _spanishNames;
    } else {
      city = _cities;
      names = _names;
    }

    for (int i = startIndex; i < endIndex; i++) {
      orderData.add(UserRequest()
          //   OrderInfo(
          //   1000 + i,
          //   1700 + i,
          //   names[i < names.length ? i : _random.nextInt(names.length - 1)],
          //   _random.nextInt(1000) + _random.nextDouble(),
          //   city[_random.nextInt(city.length - 1)],
          //   1500.0 + _random.nextInt(100),
          // )

          );
    }
    return orderData;
  }

  @override
  Future<void> sort() async {
    notifyListeners();
  }
}

class TripInfoDataSource extends DataGridSource {
  TripInfoDataSource(
      {this.model,
      required this.isWebOrDesktop,
      this.orderDataCount,
      this.ordersCollection,
      this.culture,
      bool? isFilteringSample}) {
    this.isFilteringSample = isFilteringSample ?? false;
    orders = ordersCollection ??
        getOrders(orders, orderDataCount ?? 100, culture: culture ?? '');
    // currencySymbol = getCurrencySymbol();
    buildDataGridRows();
  }

  /// Determine to decide whether the platform is web or desktop.
  final bool isWebOrDesktop;

  /// Instance of SampleModel.
  final Info? model;

  /// Localization Source.
  String? culture;

  /// Get data count of an order.
  int? orderDataCount;
  final math.Random _random = math.Random();

  /// Instance of an order.
  List<Info> orders = <Info>[];

  /// Instance of an order collection for rtl sample
  List<Info>? ordersCollection;
  List<Info> get uniqOrder {
    return ReportHelper.uniqueData(
        data: orders,
        condatioin: (value, collcation) {
          return !collcation.any((element) => element.dateGo == value.dateGo);
        });
  }

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Currency symbol for culture.
  String currencySymbol = '';

  /// Checks whether the source is used for the filtering sample or not.
  late bool isFilteringSample;

  /// Building DataGridRows.
  void buildDataGridRows() {
    dataGridRows = isWebOrDesktop
        ? uniqOrder.map<DataGridRow>((Info order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(
                  columnName: getColumnName('dateTrip'),
                  value: DateFormat.yMd('ar').format(order.dateGo!)),

              DataGridCell<int>(
                  columnName: getColumnName('allcount'),
                  value: orders
                      .where((element) => element.dateGo == order.dateGo)
                      .toList()
                      .length),

              // DataGridCell<int>(
              //     columnName: getColumnName('name'), value: ),
              // DataGridCell<double>(
              //     columnName: getColumnName('freight'), value: order.freight),
              // DataGridCell<String>(
              //     columnName: getColumnName('city'), value: order.city),
              // DataGridCell<double>(
              //     columnName: getColumnName('price'), value: order.price),
            ]);
          }).toList()
        : uniqOrder.map<DataGridRow>((Info order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(
                  columnName: getColumnName('dateTrip'),
                  value: DateFormat.yMd('ar').format(order.dateGo!)),

              DataGridCell<int>(
                  columnName: getColumnName('allcount'),
                  value: orders
                      .where((element) => element.dateGo == order.dateGo)
                      .toList()
                      .length),
              // DataGridCell<String>(
              //     columnName: getColumnName('city'), value: order.city),
            ]);
          }).toList();
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if (model != null && (rowIndex % 2) == 0 && culture == null) {
      backgroundColor = Get.theme.colorScheme.primary;
    }
    if (isWebOrDesktop) {
      return DataGridRowAdapter(color: backgroundColor, cells: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.center,
        //   child: Text(
        //     row.getCells()[2].value.toString(),
        //   ),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.center,
        //   child: Text(
        //       // NumberFormat.currency(locale: 'en', symbol: currencySymbol)
        //       //     .format(row.getCells()[3].value)
        //       row.getCells()[3].value.toString()),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.center,
        //   child: Text(
        //     row.getCells()[4].value.toString(),
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.center,
        //   child: Text(
        //       // NumberFormat.currency(
        //       //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
        //       //   .format(row.getCells()[5].value)
        //       row.getCells()[5].value.toString()),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //       // NumberFormat.currency(
        //       //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
        //       //   .format(row.getCells()[6].value)
        //       row.getCells()[6].value.toString()),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //       // NumberFormat.currency(
        //       //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
        //       //   .format(row.getCells()[6].value)
        //       row.getCells()[7].value.toString()),
        // ),
      ]);
    } else {
      Widget buildWidget({
        AlignmentGeometry alignment = Alignment.centerLeft,
        EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
        TextOverflow textOverflow = TextOverflow.ellipsis,
        required Object value,
      }) {
        return Container(
          padding: padding,
          alignment: alignment,
          child: Text(
            value.toString(),
            overflow: textOverflow,
          ),
        );
      }

      return DataGridRowAdapter(
          color: backgroundColor,
          cells: row.getCells().map<Widget>((DataGridCell dataCell) {
            if (dataCell.columnName == getColumnName('id') ||
                dataCell.columnName == getColumnName('customerId')) {
              return buildWidget(
                  alignment: Alignment.centerRight, value: dataCell.value!);
            } else {
              return buildWidget(value: dataCell.value!);
            }
          }).toList(growable: false));
    }
  }

  /// Currency symbol
  String getCurrencySymbol() {
    if (culture != null) {
      final format = NumberFormat.compactSimpleCurrency(locale: 'en');
      return format.currencySymbol;
    } else {
      final format = NumberFormat.simpleCurrency();
      return format.currencySymbol;
    }
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    Widget? widget;
    Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(
          value,
          // overflow: TextOverflow.ellipsis,
          style: Get.textTheme.headlineSmall,
        ),
      );
    }

    if (summaryRow.showSummaryInRow) {
      widget = buildCell(
          summaryValue, const EdgeInsets.all(16.0), Alignment.centerLeft);
    } else if (summaryValue.isNotEmpty) {
      // if (summaryColumn!.columnName == 'allcount') {
      //   summaryValue = 'اجمالي الطلبات: '.toString() + orders.length.toString();
      // } else if (summaryColumn.columnName == 'allDone') {
      //   summaryValue = '  اجمالي الطلبات المكتملة'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 4)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allqidTalab') {
      //   summaryValue = '  اجمالي الطلبات قيد الطلب'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 1)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allProgress') {
      //   summaryValue = '  اجمالي الطلبات تحت المعالجة'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 2)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allReqect') {
      //   summaryValue = '  اجمالي الطلبات الملغية'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 3)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allReqect') {
      //   summaryValue = '  اجمالي الطلبات الملغية'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 3)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allEdite') {
      //   summaryValue = '  اجمالي الطلبات بنتظار التعديل'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 5)
      //           .toList()
      //           .length
      //           .toString();
      // }

      widget = buildCell(
          summaryValue, const EdgeInsets.all(8.0), Alignment.centerRight);
    }
    return widget;
  }

  /// Provides the column name.
  String getColumnName(String columnName) {
    if (isFilteringSample) {
      switch (columnName) {
        case 'id':
          return 'Order ID';
        case 'customerId':
          return 'Customer ID';
        case 'name':
          return 'Name';
        case 'freight':
          return 'Freight';
        case 'city':
          return 'City';
        case 'price':
          return 'Price';
        default:
          return columnName;
      }
    }
    return columnName;
  }

  /// Update DataSource
  void updateDataSource() {
    notifyListeners();
  }

  /// Get orders collection
  List<Info> getOrders(List<Info> orderData, int count, {String? culture}) {
    final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
        endIndex = startIndex + count;
    List<String> city;
    List<String> names;

    // if (culture == 'Chinese') {
    //   city = _chineseCties;
    //   names = _chineseNames;
    // } else if (culture == 'Arabic') {
    //   city = _arabicCties;
    //   names = _arabicNames;
    // } else if (culture == 'French') {
    //   city = _frenchCties;
    //   names = _frenchNames;
    // } else if (culture == 'Spanish') {
    //   city = _spanishCties;
    //   names = _spanishNames;
    // } else {
    //   city = _cities;
    //   names = _names;
    // }

    for (int i = startIndex; i < endIndex; i++) {
      orderData.add(Info()
          //   OrderInfo(
          //   1000 + i,
          //   1700 + i,
          //   names[i < names.length ? i : _random.nextInt(names.length - 1)],
          //   _random.nextInt(1000) + _random.nextDouble(),
          //   city[_random.nextInt(city.length - 1)],
          //   1500.0 + _random.nextInt(100),
          // )

          );
    }
    return orderData;
  }

  @override
  Future<void> sort() async {
    notifyListeners();
  }
}

class CityDataSource extends DataGridSource {
  CityDataSource(
      {this.model,
      required this.isWebOrDesktop,
      this.orderDataCount,
      this.ordersCollection,
      this.culture,
      bool? isFilteringSample}) {
    this.isFilteringSample = isFilteringSample ?? false;
    orders = ordersCollection ??
        getOrders(orders, orderDataCount ?? 100, culture: culture ?? '');
    // currencySymbol = getCurrencySymbol();
    buildDataGridRows();
  }

  /// Determine to decide whether the platform is web or desktop.
  final bool isWebOrDesktop;

  /// Instance of SampleModel.
  final City? model;

  /// Localization Source.
  String? culture;

  /// Get data count of an order.
  int? orderDataCount;
  final math.Random _random = math.Random();

  /// Instance of an order.
  List<City> orders = <City>[];

  /// Instance of an order collection for rtl sample
  List<City>? ordersCollection;
  List<City> get uniqOrder {
    return ReportHelper.uniqueData(
        data: orders,
        condatioin: (value, collcation) {
          return !collcation.any((element) => element.id == value.id);
        });
  }

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Currency symbol for culture.
  String currencySymbol = '';

  /// Checks whether the source is used for the filtering sample or not.
  late bool isFilteringSample;

  /// Building DataGridRows.
  void buildDataGridRows() {
    dataGridRows = isWebOrDesktop
        ? uniqOrder.map<DataGridRow>((City order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(
                  columnName: getColumnName('idCity'), value: order.id!),
              DataGridCell<String>(
                  columnName: getColumnName('nameCity'), value: order.name!),

              DataGridCell<int>(
                  columnName: getColumnName('countTripFrom'),
                  value: orders
                      .where((element) =>
                          element.id == order.id && element.isFrom!)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('countTripTo'),
                  value: orders
                      .where((element) =>
                          element.id == order.id && !element.isFrom!)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('countTripTotol'),
                  value: orders
                      .where((element) => element.id == order.id)
                      .toList()
                      .length),

              // DataGridCell<int>(
              //     columnName: getColumnName('name'), value: ),
              // DataGridCell<double>(
              //     columnName: getColumnName('freight'), value: order.freight),
              // DataGridCell<String>(
              //     columnName: getColumnName('city'), value: order.city),
              // DataGridCell<double>(
              //     columnName: getColumnName('price'), value: order.price),
            ]);
          }).toList()
        : uniqOrder.map<DataGridRow>((City order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(
                  columnName: getColumnName('id'), value: order.id),
              DataGridCell<String>(
                  columnName: getColumnName('name'), value: order.name!),

              DataGridCell<int>(
                  columnName: getColumnName('countTripFrom'),
                  value: orders
                      .where((element) =>
                          element.id == order.id && element.isFrom!)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('countTripTo'),
                  value: orders
                      .where((element) =>
                          element.id == order.id && !element.isFrom!)
                      .toList()
                      .length),
              DataGridCell<int>(
                  columnName: getColumnName('countTripTotol'),
                  value: orders
                      .where((element) => element.id == order.id)
                      .toList()
                      .length),
              // DataGridCell<String>(
              //     columnName: getColumnName('city'), value: order.city),
            ]);
          }).toList();
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if (model != null && (rowIndex % 2) == 0 && culture == null) {
      backgroundColor = Get.theme.colorScheme.primary;
    }
    if (isWebOrDesktop) {
      return DataGridRowAdapter(color: backgroundColor, cells: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            row.getCells()[3].value.toString(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            row.getCells()[4].value.toString(),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.center,
        //   child: Text(
        //       // NumberFormat.currency(locale: 'en', symbol: currencySymbol)
        //       //     .format(row.getCells()[3].value)
        //       row.getCells()[4].value.toString()),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.center,
        //   child: Text(
        //     row.getCells()[4].value.toString(),
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.center,
        //   child: Text(
        //       // NumberFormat.currency(
        //       //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
        //       //   .format(row.getCells()[5].value)
        //       row.getCells()[5].value.toString()),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //       // NumberFormat.currency(
        //       //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
        //       //   .format(row.getCells()[6].value)
        //       row.getCells()[6].value.toString()),
        // ),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //       // NumberFormat.currency(
        //       //       locale: 'en_US', symbol: currencySymbol, decimalDigits: 0)
        //       //   .format(row.getCells()[6].value)
        //       row.getCells()[7].value.toString()),
        // ),
      ]);
    } else {
      Widget buildWidget({
        AlignmentGeometry alignment = Alignment.centerLeft,
        EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
        TextOverflow textOverflow = TextOverflow.ellipsis,
        required Object value,
      }) {
        return Container(
          padding: padding,
          alignment: alignment,
          child: Text(
            value.toString(),
            overflow: textOverflow,
          ),
        );
      }

      return DataGridRowAdapter(
          color: backgroundColor,
          cells: row.getCells().map<Widget>((DataGridCell dataCell) {
            if (dataCell.columnName == getColumnName('id') ||
                dataCell.columnName == getColumnName('customerId')) {
              return buildWidget(
                  alignment: Alignment.centerRight, value: dataCell.value!);
            } else {
              return buildWidget(value: dataCell.value!);
            }
          }).toList(growable: false));
    }
  }

  /// Currency symbol
  String getCurrencySymbol() {
    if (culture != null) {
      final format = NumberFormat.compactSimpleCurrency(locale: 'en');
      return format.currencySymbol;
    } else {
      final format = NumberFormat.simpleCurrency();
      return format.currencySymbol;
    }
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    Widget? widget;
    Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(
          value,
          // overflow: TextOverflow.ellipsis,
          style: Get.textTheme.headlineSmall,
        ),
      );
    }

    if (summaryRow.showSummaryInRow) {
      widget = buildCell(
          summaryValue, const EdgeInsets.all(16.0), Alignment.centerLeft);
    } else if (summaryValue.isNotEmpty) {
      // if (summaryColumn!.columnName == 'allcount') {
      //   summaryValue = 'اجمالي الطلبات: '.toString() + orders.length.toString();
      // } else if (summaryColumn.columnName == 'allDone') {
      //   summaryValue = '  اجمالي الطلبات المكتملة'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 4)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allqidTalab') {
      //   summaryValue = '  اجمالي الطلبات قيد الطلب'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 1)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allProgress') {
      //   summaryValue = '  اجمالي الطلبات تحت المعالجة'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 2)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allReqect') {
      //   summaryValue = '  اجمالي الطلبات الملغية'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 3)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allReqect') {
      //   summaryValue = '  اجمالي الطلبات الملغية'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 3)
      //           .toList()
      //           .length
      //           .toString();
      // } else if (summaryColumn.columnName == 'allEdite') {
      //   summaryValue = '  اجمالي الطلبات بنتظار التعديل'.toString() +
      //       orders
      //           .where((element) => element.state!.id == 5)
      //           .toList()
      //           .length
      //           .toString();
      // }

      widget = buildCell(
          summaryValue, const EdgeInsets.all(8.0), Alignment.centerRight);
    }
    return widget;
  }

  /// Provides the column name.
  String getColumnName(String columnName) {
    if (isFilteringSample) {
      switch (columnName) {
        case 'id':
          return 'Order ID';
        case 'customerId':
          return 'Customer ID';
        case 'name':
          return 'Name';
        case 'freight':
          return 'Freight';
        case 'city':
          return 'City';
        case 'price':
          return 'Price';
        default:
          return columnName;
      }
    }
    return columnName;
  }

  /// Update DataSource
  void updateDataSource() {
    notifyListeners();
  }

  /// Get orders collection
  List<City> getOrders(List<City> orderData, int count, {String? culture}) {
    final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
        endIndex = startIndex + count;
    List<String> city;
    List<String> names;

    // if (culture == 'Chinese') {
    //   city = _chineseCties;
    //   names = _chineseNames;
    // } else if (culture == 'Arabic') {
    //   city = _arabicCties;
    //   names = _arabicNames;
    // } else if (culture == 'French') {
    //   city = _frenchCties;
    //   names = _frenchNames;
    // } else if (culture == 'Spanish') {
    //   city = _spanishCties;
    //   names = _spanishNames;
    // } else {
    //   city = _cities;
    //   names = _names;
    // }

    for (int i = startIndex; i < endIndex; i++) {
      orderData.add(City()
          //   OrderInfo(
          //   1000 + i,
          //   1700 + i,
          //   names[i < names.length ? i : _random.nextInt(names.length - 1)],
          //   _random.nextInt(1000) + _random.nextDouble(),
          //   city[_random.nextInt(city.length - 1)],
          //   1500.0 + _random.nextInt(100),
          // )

          );
    }
    return orderData;
  }

  @override
  Future<void> sort() async {
    notifyListeners();
  }
}
