import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/models/basic/state_request.dart';
import 'package:projecttravelwin/app/models/basic/user_request.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/default_widget.dart';
import '../controllers/report_desktop_controller.dart';

class TripReportView extends GetView<ReportDesktopController> {
  const TripReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                child: Row(
                  children: controller.typeReport
                      .asMap()
                      .entries
                      .map((e) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.currentTypeReport.value = e.key;
                              },
                              child: DefaultCountainer(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                color: controller.currentTypeReport.value == e.key ? Get.theme.colorScheme.primary : Get.theme.colorScheme.secondary,
                                child: Text(
                                  e.value,
                                  style: Get.textTheme.headlineLarge!.merge(TextStyle(
                                      color: controller.currentTypeReport.value == e.key
                                          ? Get.theme.colorScheme.secondary
                                          : Get.theme.colorScheme.primary)),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              GetBuilder<ReportDesktopController>(
                // init: MyController(),
                id: 'updateDataReportTrip',
                initState: (_) {},
                builder: (_) {
                  return getWidget()[controller.currentTypeReport.value];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getWidget() {
    return [
      SfCartesianChart(
        // legend: Legend(
        //     isVisible: true,
        //     overflowMode: LegendItemOverflowMode.wrap),
        // selectionType: SelectionType.point,
        title: titleChart('الرحلات'),
        plotAreaBorderWidth: 0,
        primaryXAxis: DateTimeAxis(
            interval: 1,
            enableAutoIntervalOnZooming: true,
            title: AxisTitle(text: 'التاريخ'),
            // intervalType: DateTimeIntervalType.days,
            dateFormat: DateFormat.MEd('ar'),
            majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            // enableAutoIntervalOnZooming: true,
            // isVisible: true,
            // minimum: controller.minmumTrip,
            // maximum: controller.maximumTrips,
            interval: 1,
            anchorRangeToVisiblePoints: true,
            title: AxisTitle(text: 'عدد'),
            axisLine: const AxisLine(width: 0),
            labelFormat: '{value} ',
            majorTickLines: MajorTickLines(color: Get.theme.colorScheme.primary)),
        series: controller.getTrips(),
        trackballBehavior: controller.trackballBehavior,
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: 400,
              child: SfDataGrid(
                showSortNumbers: true,
                allowMultiColumnSorting: true,
                columnWidthMode: ColumnWidthMode.auto,
                gridLinesVisibility: GridLinesVisibility.both,

                defaultColumnWidth: Get.width / 2,
                headerGridLinesVisibility: GridLinesVisibility.both,
                allowSorting: true,
                source: controller.dataSourceGridTripInfo,
                // tableSummaryRows: getTableSummaryRows(),
                columns: [
                  GridColumn(
                      visible: true,
                      width: double.negativeInfinity,
                      columnName: 'dataTrip',
                      label: Text(
                        'تاريخ الرحلة',
                        style: Get.textTheme.headlineMedium,
                        // textAlign: TextAlign.center,
                      )),
                  GridColumn(
                      width: double.negativeInfinity,
                      columnName: 'اسم الخدمة',
                      label: Text(
                        'عدد مرات الحجز',
                        style: Get.textTheme.headlineMedium,
                      )),
                ],
              ),
            ),
            SizedBox(
                width: 100,
                child: defaultButton(
                    isResponseve: true,
                    isIcon: true,
                    lable: 'طباعة',
                    icon: Icon(
                      Icons.picture_as_pdf,
                      color: Get.theme.colorScheme.secondary,
                    ),
                    onPressed: () async {
                      await controller.reportPdf(2);
                    }))
          ],
        ),
      ),
    ];
  }
}

class CustomerRequestReportVeiw extends GetView<ReportDesktopController> {
  const CustomerRequestReportVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                child: Row(
                  children: controller.typeReport
                      .asMap()
                      .entries
                      .map((e) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.currentTypeReport.value = e.key;
                              },
                              child: DefaultCountainer(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                color: controller.currentTypeReport.value == e.key ? Get.theme.colorScheme.primary : Get.theme.colorScheme.secondary,
                                child: Text(
                                  e.value,
                                  style: Get.textTheme.headlineLarge!.merge(TextStyle(
                                      color: controller.currentTypeReport.value == e.key
                                          ? Get.theme.colorScheme.secondary
                                          : Get.theme.colorScheme.primary)),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              GetBuilder<ReportDesktopController>(
                // init: MyController(),
                id: 'updateDataReportCustomer',
                initState: (_) {},
                builder: (_) {
                  return getWidget()[controller.currentTypeReport.value];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getWidget() {
    return [
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                width: Get.width,
                child: DefaultDropDownForm(
                  dataList: controller.allStateRequest,
                  onChanged: (value) {
                    if (value is StateRequest) {
                      controller.sortbyStateRequest(value);
                    }
                  },
                  value: null,
                  label: Text(
                    'بحث حسب',
                    style: Get.textTheme.headlineSmall,
                  ),
                )),
            SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'طلبات العملاء'),
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(axisLine: const AxisLine(width: 0), labelFormat: '{value}%', majorTickLines: const MajorTickLines(size: 0)),
              series: controller.getDefaultColumnSeries(),
              tooltipBehavior: controller.tooltipBehavior,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                width: Get.width,
                child: DefaultDropDownForm(
                  dataList: controller.getuniqRequst,
                  onChanged: (value) {
                    if (value is UserRequest) {
                      controller.currentUserrequestReport = value;
                    }
                    controller.updataReportState();
                  },
                  value: controller.currentUserrequestReport,
                  label: Text(
                    'بحث حسب',
                    style: Get.textTheme.headlineSmall,
                  ),
                )),
            GetBuilder<ReportDesktopController>(
              // init: MyController(),
              id: 'ReportState',
              initState: (_) {},
              builder: (_) {
                return controller.currentUserrequestReport == null
                    ? Container()
                    : SfCircularChart(
                        series: controller.dataServiceRequestState(
                                controller.getStateByRequest(controller.currentUserrequestReport!), controller.currentUserrequestReport!) ??
                            [],
                        title: titleChart(controller.currentUserrequestReport!.serviceName!),
                        legend: Legend(isVisible: true),
                      );
              },
            ),
          ],
        ),
      ),
      Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SfDataGrid(
              showSortNumbers: true,
              allowMultiColumnSorting: true,
              columnWidthMode: ColumnWidthMode.auto,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              allowSorting: true,
              defaultColumnWidth: Get.width / 7,
              source: controller.daataSorceCustomRequest,
              tableSummaryRows: getTableSummaryRows(),
              columns: [
                GridColumn(
                    width: double.negativeInfinity,
                    columnName: 'اسم الخدمة',
                    label: Text(
                      'اسم الخدمة',
                      style: Get.textTheme.headlineMedium,
                    )),

                GridColumn(
                    width: double.negativeInfinity,
                    columnName: 'allcount',
                    label: Text(
                      'عدد الطلبات',
                      style: Get.textTheme.headlineMedium,
                    )),
                GridColumn(
                    width: double.negativeInfinity,
                    columnName: 'عدد الخدمة',
                    label: Text(
                      'عدد الطلبات المكتملة',
                      style: Get.textTheme.headlineMedium,
                    )),
                GridColumn(
                    width: double.negativeInfinity,
                    columnName: 'allqidTalab',
                    label: Text(
                      'عدد الطلبات قيد الطلب',
                      style: Get.textTheme.headlineMedium,
                    )),
                GridColumn(
                    width: double.negativeInfinity,
                    columnName: 'عدد الخدمة',
                    label: Text(
                      'عدد الطلبات تحت المعالجة',
                      style: Get.textTheme.headlineMedium,
                    )),
                GridColumn(
                    width: double.negativeInfinity,
                    columnName: 'allReqect',
                    label: Text(
                      'عدد الطلبات الملغي',
                      style: Get.textTheme.headlineMedium,
                    )),
                GridColumn(
                    width: double.negativeInfinity,
                    columnName: 'allEdite',
                    label: Text(
                      'عدد الطلبات بنتظار التعديل',
                      style: Get.textTheme.headlineMedium,
                    )),
                //     columnName: 'اسم الخدمة', label: Icon(Icons.info)),
              ],
            ),
          ),
          SizedBox(
              width: 100,
              child: defaultButton(
                  isResponseve: true,
                  isIcon: true,
                  lable: 'طباعة',
                  icon: Icon(
                    Icons.picture_as_pdf,
                    color: Get.theme.colorScheme.secondary,
                  ),
                  onPressed: () async {
                    await controller.reportPdf(1);
                  }))
        ],
      ),
    ];
  }
}

class CityReportView extends GetView<ReportDesktopController> {
  const CityReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: Get.width,
                  child: Row(
                    children: controller.typeReport
                        .asMap()
                        .entries
                        .map((e) => Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.currentTypeReport.value = e.key;
                                },
                                child: DefaultCountainer(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8.0),
                                  color:
                                      controller.currentTypeReport.value == e.key ? Get.theme.colorScheme.primary : Get.theme.colorScheme.secondary,
                                  child: Text(
                                    e.value,
                                    style: Get.textTheme.headlineLarge!.merge(TextStyle(
                                        color: controller.currentTypeReport.value == e.key
                                            ? Get.theme.colorScheme.secondary
                                            : Get.theme.colorScheme.primary)),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                GetBuilder<ReportDesktopController>(
                  // init: MyController(),
                  id: 'updataDataReportCity',
                  initState: (_) {},
                  builder: (_) {
                    return getWidget()[controller.currentTypeReport.value];
                  },
                ),
              ],
            ),
          )),
    );
  }

  List<Widget> getWidget() {
    return [
      SingleChildScrollView(
        child: Column(
          children: [
            SfCircularChart(
              series: controller.dataFromCity() ?? [],
              title: titleChart('المدن الكثر سفر منها'),
              legend: Legend(isVisible: true),
            ),
            SfCircularChart(
              series: controller.dataToCity() ?? [],
              title: titleChart('المدن الكثر سفر اليها'),
              legend: Legend(isVisible: true),
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: 400,
              child: SfDataGrid(
                showSortNumbers: true,
                allowMultiColumnSorting: true,
                columnWidthMode: ColumnWidthMode.auto,
                gridLinesVisibility: GridLinesVisibility.both,
                allowColumnsResizing: true,
                defaultColumnWidth: Get.width / 5,
                headerGridLinesVisibility: GridLinesVisibility.both,
                // allowSorting: true,
                source: controller.dataSourceGridCityInfo,
                // tableSummaryRows: getTableSummaryRows(),
                columns: [
                  GridColumn(
                      width: double.negativeInfinity,

                      // visible: true,
                      columnName: 'id',
                      label: Text(
                        ' رقم المدينة',
                        style: Get.textTheme.headlineMedium,
                        // textAlign: TextAlign.center,
                      )),
                  GridColumn(
                      width: double.negativeInfinity,

                      // visible: true,
                      columnName: 'name',
                      label: Text(
                        "الاسم",
                        style: Get.textTheme.headlineMedium,
                        // textAlign: TextAlign.center,
                      )),
                  GridColumn(
                      width: double.negativeInfinity,
                      columnName: "countCityFrom",
                      label: Text(
                        'مرات السفر منها',
                        style: Get.textTheme.headlineMedium,
                      )),
                  GridColumn(
                      width: double.negativeInfinity,
                      columnName: "countCityTo",
                      label: Text(
                        'مرات السفر اليها',
                        style: Get.textTheme.headlineMedium,
                      )),
                  GridColumn(
                      width: double.negativeInfinity,
                      columnName: "total",
                      label: Text(
                        'الاجمالي',
                        style: Get.textTheme.headlineMedium,
                      )),
                ],
              ),
            ),
            SizedBox(
                width: 100,
                child: defaultButton(
                    isResponseve: true,
                    isIcon: true,
                    lable: 'طباعة',
                    icon: Icon(
                      Icons.picture_as_pdf,
                      color: Get.theme.colorScheme.secondary,
                    ),
                    onPressed: () async {
                      await controller.reportPdf(3);
                    }))
          ],
        ),
      ),
    ];
  }
}

ChartTitle titleChart(String title) {
  return ChartTitle(alignment: ChartAlignment.center, text: title);
}

List<GridTableSummaryRow> getTableSummaryRows() {
  // final Color color =
  //     model.themeData.colorScheme.brightness == Brightness.light
  // ? const Color(0xFFEBEBEB)
  // : const Color(0xFF3B3B3B);
  return <GridTableSummaryRow>[
    // GridTableSummaryRow(
    //     // color: Get.theme.colorScheme.primary,
    //     title: 'Total Order Count: {count}',
    //     columns: <GridSummaryColumn>[
    //       const GridSummaryColumn(
    //           name: 'count',
    //           columnName: 'id',
    //           summaryType: GridSummaryType.count),
    //     ],
    //     position: GridTableSummaryRowPosition.top),

    // GridTableSummaryRow(
    //     // color: Get.theme.colorScheme.primary,
    //     showSummaryInRow: false,
    //     columns: <GridSummaryColumn>[
    //       const GridSummaryColumn(
    //           name: 'allcount',
    //           columnName: 'allcount',
    //           summaryType: GridSummaryType.sum),
    //       const GridSummaryColumn(
    //           name: 'price',
    //           columnName: 'allDone',
    //           summaryType: GridSummaryType.sum),
    //       const GridSummaryColumn(
    //           name: 'price',
    //           columnName: 'allqidTalab',
    //           summaryType: GridSummaryType.sum),
    //       const GridSummaryColumn(
    //           name: 'price',
    //           columnName: 'allProgress',
    //           summaryType: GridSummaryType.sum),
    //       const GridSummaryColumn(
    //           name: 'price',
    //           columnName: 'allReqect',
    //           summaryType: GridSummaryType.sum),
    //       const GridSummaryColumn(
    //           name: 'price',
    //           columnName: 'allEdite',
    //           summaryType: GridSummaryType.sum),
    //     ],
    //     position: GridTableSummaryRowPosition.bottom),
  ];
}
