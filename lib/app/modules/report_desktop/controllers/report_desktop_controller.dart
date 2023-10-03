import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projecttravelwin/app/models/basic/state_request.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as paath;
import 'package:syncfusion_flutter_core/localizations.dart' as locals;

import 'package:flutter/services.dart' show Uint8List, rootBundle;
import '../../../Helper/report_helper.dart';
import '../../../models/basic/trips.dart';
import '../../../models/basic/user_request.dart';
import '../../../models/report/customer_request.dart';
import '../../../repository/report_repository.dart';
import '../widget/widget_local.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportDesktopController extends GetxController {
  ReportRepository? _reportRepository;
  RxBool isLoading = RxBool(false);
  List<Info> allTripsRequest = [];
  List<UserRequest> allRequest = [];
  List<UserRequest> allRequestResault = [];

  final currentPage = 0.obs;
  List<String> typeReport = ['بياني', 'جدول'];
  final currentTypeReport = 0.obs;
  List<String> titlPage = ['طلبات العملاء', "الرحلات", "المدن"];
  List<Widget> page = [
    const CustomerRequestReportVeiw(),
    const TripReportView(),
    const CityReportView(),
  ];
  List<StateRequest> allStateRequest = [];
  TrackballBehavior? trackballBehavior;
  TooltipBehavior? tooltipBehavior;

  List<City> get getAllCitiesFromAndTo {
    var data = getAllTripFromInfo.map((e) {
      e.fromCity!.isFrom = true;
      return e.fromCity!;
    }).toList();
    data.addAll(getAllTripFromInfo.map((e) {
      e.toCity!.isFrom = false;
      return e.toCity!;
    }).toList());

    return data;
  }

  UserRequest? currentUserrequestReport;
  get maximumTrips => allTripsRequest.length.toDouble();

  get minmumTrip => 1.toDouble();

  DataGridSource get daataSorceCustomRequest => CustomerRequestDataSourc(
      isWebOrDesktop: true, ordersCollection: allRequest);

  List<UserRequest> get getuniqRequst => ReportHelper.uniqueData(
      data: allRequest,
      condatioin: (value, collection) {
        return !collection
            .any((element) => element.serviceName == value.serviceName);
      });

  DataGridSource get dataSourceGridTripInfo => TripInfoDataSource(
      isWebOrDesktop: true, ordersCollection: allTripsRequest);
  DataGridSource get dataSourceGridCityInfo => CityDataSource(
      isWebOrDesktop: true, ordersCollection: getAllCitiesFromAndTo);

// List<GridColumn>  get dataColumnDataGrid => CustomerRequestDataSourc(
//       isWebOrDesktop: true, ordersCollection: allRequest).;
  @override
  void onInit() async {
    tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'));

    _reportRepository = ReportRepository();
    await loadData();
    var temp = getuniqRequst.isNotEmpty ? getuniqRequst.first : null;
    if (temp != null) {
      currentUserrequestReport = temp;
    }
    super.onInit();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    allTripsRequest = await _reportRepository!.allTrip();
    allRequest = await _reportRepository!.allUserRequest();
    sortDataLoad();
    allRequestResault = allRequest;
    allStateRequest.add(StateRequest(id: -1, name: 'الكل'));
    allStateRequest.addAll(await _reportRepository!.dataBasic());
    isLoading.value = false;
  }

  sortDataLoad() {
    allRequest.sort((x, y) {
      if (x.requestTrip != null) {
        if (y.requestTrip != null) {
          return x.requestTrip!.bookingTime!
              .compareTo(y.requestTrip!.bookingTime!);
        } else {
          return x.requestTrip!.bookingTime!
              .compareTo(y.requestServicePublic!.bookingServicesDate!);
        }
      } else {
        if (y.requestTrip != null) {
          return x.requestServicePublic!.bookingServicesDate!
              .compareTo(y.requestTrip!.bookingTime!);
        } else {
          return x.requestServicePublic!.bookingServicesDate!
              .compareTo(y.requestServicePublic!.bookingServicesDate!);
        }
      }
    });
    allTripsRequest.sort((x, y) => x.dateGo!.compareTo(y.dateGo!));
  }

  @override
  void onReady() {
    // Get.defaultDialog()
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<Trips> get getAllTripFromInfo =>
      allTripsRequest.map((e) => e.trip!).toList();
  List<PieSeries<City, String>>? dataFromCity() {
    return getfromCityUniqe
        .map((e) => PieSeries<City, String>(
            explode: true,
            explodeIndex: 0,
            explodeOffset: '10%',
            dataSource: getfromCityUniqe,
            xValueMapper: (datum, index) => datum.name as String,
            yValueMapper: (datum, index) {
              int total = getAllTripFromInfo.length;

              int count = getAllTripFromInfo
                  .where((element) => element.fromCity!.id == datum.id)
                  .length;

              var resluts = (count / total) * 100;
              print('object');
              return resluts.roundToDouble();
            },
            startAngle: 90,
            endAngle: 90,
            dataLabelSettings: const DataLabelSettings(isVisible: true)))
        .toList();
  }

  List<PieSeries<StateRequest, String>>? dataServiceRequestState(
      List<StateRequest> states, UserRequest request) {
    return getfromCityUniqe
        .map((e) => PieSeries<StateRequest, String>(
            explode: true,
            explodeIndex: 0,
            explodeOffset: '10%',
            dataSource: ReportHelper.uniqueData(
                data: states,
                condatioin: (value, collection) {
                  return !collection.any((element) => element.id == value.id);
                }),
            xValueMapper: (datum, index) => datum.name as String,
            yValueMapper: (datum, index) {
              int total = allRequest
                  .where(
                      (element) => element.serviceName == request.serviceName)
                  .toList()
                  .length;

              int count = allRequest
                  .where((element) =>
                      element.serviceName == request.serviceName &&
                      element.state!.id == datum.id)
                  .length;

              var resluts = (count / total) * 100;
              print('object');
              return resluts.roundToDouble();
            },
            startAngle: 90,
            endAngle: 90,
            dataLabelSettings: const DataLabelSettings(isVisible: true)))
        .toList();
  }

  List<City> get getfromCityUniqe => ReportHelper.uniqueData<City>(
      data: getAllTripFromInfo.map((e) => e.fromCity!).toList(),
      condatioin: (value, sets) {
        return !sets.any((element) => element.id == value.id);
      });
  List<City> get getToCityUniqe => ReportHelper.uniqueData<City>(
      data: getAllTripFromInfo.map((e) => e.toCity!).toList(),
      condatioin: (value, sets) {
        return !sets.any((element) => element.id == value.id);
      });

  void test() {
    // var da = getTripsUniqe;
    var d = dataFromCity();
    // print('object');
  }

  List<PieSeries<City, String>>? dataToCity() {
    return getToCityUniqe
        .map((e) => PieSeries<City, String>(
            explode: true,
            explodeIndex: 0,
            explodeOffset: '10%',
            dataSource: getToCityUniqe,
            xValueMapper: (datum, index) => datum.name as String,
            yValueMapper: (datum, index) {
              int total = getAllTripFromInfo.length;

              int count = getAllTripFromInfo
                  .where((element) => element.toCity!.id == datum.id)
                  .length;

              var resluts = (count / total) * 100;
              // print('object');
              return resluts.roundToDouble();
            },
            startAngle: 90,
            endAngle: 90,
            dataLabelSettings: const DataLabelSettings(isVisible: true)))
        .toList();
  }

  List<LineSeries<Info, DateTime>> getTrips() {
    return <LineSeries<Info, DateTime>>[
      LineSeries<Info, DateTime>(
        emptyPointSettings: EmptyPointSettings(),
        markerSettings: MarkerSettings(isVisible: true),
        // isVisible: true,
        animationDuration: 2500,
        dataSource: allTripsRequest,
        xValueMapper: (datum, index) => datum.dateGo,
        yValueMapper: (datum, index) {
          int count = allTripsRequest
              .where((element) => element.dateGo == datum.dateGo)
              .toList()
              .length;
          print('fljsd');
          return count;
        },
        // pointColorMapper: (datum, index) =>
        //     Color.fromARGB(255, 7 + index, 197, 255 - index),
      )
    ];
  }

  List<ColumnSeries<UserRequest, String>> getDefaultColumnSeries() {
    return <ColumnSeries<UserRequest, String>>[
      ColumnSeries<UserRequest, String>(
        dataSource: ReportHelper.uniqueData(
            data: allRequestResault,
            condatioin: (value, collection) {
              return allRequestResault
                  .any((element) => element.serviceName == value.serviceName);
            }),
        xValueMapper: (sales, _) => sales.serviceName,
        yValueMapper: (sales, _) =>
            (allRequestResault
                    .where(
                        (element) => element.serviceName == sales.serviceName)
                    .toList()
                    .length /
                allRequestResault.length) *
            100.roundToDouble(),
        dataLabelSettings: DataLabelSettings(
            labelPosition: ChartDataLabelPosition.outside,
            labelAlignment: ChartDataLabelAlignment.top,
            isVisible: true,
            textStyle: Get.textTheme.headlineLarge!),
      )
    ];
  }

  void sortbyStateRequest(StateRequest value) {
    if (value.id == -1) {
      allRequestResault = allRequest;
    } else {
      allRequestResault =
          allRequest.where((element) => element.state!.id == value.id).toList();
    }

    update(['updateDataReportCustomer']);
  }

  List<StateRequest> getStateByRequest(UserRequest value) {
    return allRequest
        .where((element) => element.serviceName == value.serviceName)
        .toList()
        .map((e) => e.state!)
        .toList();
  }

  void updataReportState() {
    update(['ReportState']);
  }

  Future<void> createPdfTrip() async {
    final PdfDocument document = PdfDocument();

    try {
      //Add page to the PDF
      final PdfPage page = document.pages.add();
      final Size pageSize = page.getClientSize();

      final Uint8List fontData =
          File('fonts/AdobeArabic.ttf').readAsBytesSync();
      final PdfFont font =
          PdfTrueTypeFont(fontData, 16, style: PdfFontStyle.regular);
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
          pen: PdfPen(PdfColor(0, 0, 0)));
      final PdfGrid grid = _getGridTrip(font, pageSize);
      // final PdfGrid gridSummry = _getGridCustomerRequestSummry(font);

      final PdfLayoutResult result =
          await drowerHeaderPdf(page, pageSize, grid, font, 'تقرير الرحلات');

      final PdfLayoutResult resultsummry =
          _drawGrid(page, grid, result, font, 2);

      grid.allowRowBreakingAcrossPages = true;

      final List<int> bytes = await document.save();
      document.dispose();
      await saveAndLaunch(
          data: bytes,
          name: 'reprot3'.toString() + Random().nextInt(101).toString());

      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
      document.dispose();
    }
  }

  Future<void> createPdf() async {
    final PdfDocument document = PdfDocument();

    try {
      //Add page to the PDF
      final PdfPage page = document.pages.add();
      final Size pageSize = page.getClientSize();

      final Uint8List fontData =
          File('fonts/AdobeArabic.ttf').readAsBytesSync();
      final PdfFont font =
          PdfTrueTypeFont(fontData, 16, style: PdfFontStyle.regular);
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
          pen: PdfPen(PdfColor(0, 0, 0)));
      final PdfGrid grid = _getGridCustomerRequest(font);
      final PdfGrid gridSummry = _getGridCustomerRequestSummry(font);

      final PdfLayoutResult result = await drowerHeaderPdf(
          page, pageSize, grid, font, 'تقرير طلبات العملاء');

      final PdfLayoutResult resultsummry =
          _drawGrid(page, grid, result, font, 1);

      final page2 = document.pages.add();
      page2.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
          pen: PdfPen(PdfColor(0, 0, 0)));
      _drawGridSummry(page2, gridSummry, result, font);

      grid.allowRowBreakingAcrossPages = true;

      final List<int> bytes = await document.save();
      document.dispose();
      await saveAndLaunch(
          data: bytes,
          name: 'reprot3'.toString() + Random().nextInt(101).toString());

      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
      document.dispose();
    }
  }

  Future<PdfLayoutResult> drowerHeaderPdf(PdfPage page, Size pageSize,
          PdfGrid grid, PdfFont font, String title) =>
      _drawHeader(page, pageSize, grid, font, title);

  Future<void> saveAndLaunch(
      {required List<int> data, required String name}) async {
    //Get page client size
    var dir = Directory(r'E:\test\data\pdf');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    var filePath = paath.join(dir.path, name + '.pdf'.toString());
    locals.SfLocalizations;
    File file = File(filePath);
    await file.writeAsBytes(data);
    if (await canLaunchUrl(Uri.directory(filePath, windows: true))) {
      await launchUrl(Uri.directory(filePath, windows: true));
    } else {
      throw 'could not launchurl $filePath';
    }
  }

  PdfGrid _getGridCustomerRequest(PdfFont font) {
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 7);
    final color = Get.theme.colorScheme.primary;
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.style.font = font;
    headerRow.style.backgroundBrush = PdfSolidBrush(
        PdfColor(color.red, color.green, color.blue, color.alpha));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'عدد الطلبات بانتظار التعديل';
    headerRow.cells[0].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);
    // headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'عدد الطلبات الملغيه';
    headerRow.cells[1].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);

    headerRow.cells[2].value = 'عدد الطلبات تحت المعالجة';
    headerRow.cells[2].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);

    headerRow.cells[3].value = 'عدد الطلبات قيد الطلب';
    headerRow.cells[3].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);

    headerRow.cells[4].value = 'عدد الطلبات المكتملة';
    headerRow.cells[4].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);

    headerRow.cells[5].value = 'عدد الطلبات';
    headerRow.cells[5].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);

    headerRow.cells[6].value = 'اسم الخدمة';
    headerRow.cells[6].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);

    _addCustomerRequest(getuniqRequst, grid, font);

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable4Accent5,
        settings: PdfGridBuiltInStyleSettings());
    grid.columns[6].width = 100;
    grid.columns[6].format = PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.middle);
    // grid.columns[6].format = PdfStringFormat(alignment: PdfTextAlignment.right);
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
        cell.style.stringFormat = PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            wordWrap: PdfWordWrapType.word);
      }
    }
    return grid;
  }

  void _addCustomerRequest(
      List<UserRequest> request, PdfGrid grid, PdfFont font) {
    for (var element in request) {
      final PdfGridRow row = grid.rows.add();
      row.style = PdfGridRowStyle(font: font);
      row.cells[0].value = allRequest
          .where(
              (e) => element.serviceName == e.serviceName && e.state!.id == 5)
          .toList()
          .length
          .toString();
      row.cells[1].value = allRequest
          .where(
              (e) => element.serviceName == e.serviceName && e.state!.id == 3)
          .toList()
          .length
          .toString();

      row.cells[2].value = allRequest
          .where(
              (e) => element.serviceName == e.serviceName && e.state!.id == 2)
          .toList()
          .length
          .toString();
      row.cells[3].value = allRequest
          .where(
              (e) => element.serviceName == e.serviceName && e.state!.id == 1)
          .toList()
          .length
          .toString();
      row.cells[4].value = allRequest
          .where(
              (e) => element.serviceName == e.serviceName && e.state!.id == 4)
          .toList()
          .length
          .toString();
      row.cells[5].value = allRequest
          .where((e) => element.serviceName == e.serviceName)
          .toList()
          .length
          .toString();
      row.cells[6].value = element.serviceName!;
    }
  }

  Future<PdfLayoutResult> _drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
      PdfFont font, String title) async {
    final file = await File('images/logo.png').readAsBytesSync();

    PdfImage imageLogo = PdfBitmap(file);

    final Uint8List fontData = File('fonts/AdobeArabic.ttf').readAsBytesSync();
    final PdfFont fonts =
        PdfTrueTypeFont(fontData, 16, style: PdfFontStyle.regular);
    final color = Get.theme.colorScheme.primary;
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(
            PdfColor(color.red, color.green, color.blue, color.alpha)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
    //Draw string
    double titleWidth = pageSize.width - 115;

    page.graphics.drawString(
      title,
      font,
      brush: PdfBrushes.white,
      bounds:
          Rect.fromLTWH((pageSize.width - titleWidth) / 2, 25, titleWidth, 90),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle,
          textDirection: PdfTextDirection.rightToLeft),
    );
    // page.graphics.drawRectangle(
    //     bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
    //     brush: PdfSolidBrush(PdfColor(65, 104, 205)));
    double imageWidth = 70;

    page.graphics.drawImage(imageLogo,
        Rect.fromLTWH((pageSize.width - imageWidth) / 2, 0, imageWidth, 50));
    // final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    // final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    // page.graphics.drawString('Amount', contentFont,
    //     brush: PdfBrushes.white,
    //     bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
    //     format: PdfStringFormat(
    //         alignment: PdfTextAlignment.center,
    //         lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('ar');
    final String invoiceNumber =
        'تاريخ اصدار التقرير: ' + format.format(DateTime.now());

    final size = fonts.measureString(invoiceNumber);
    // final Size contentSize = contentFont.measureString(invoiceNumber);
    // const String address =
    //     'Bill To: \r\n\r\nAbraham Swearegin, \r\n\r\nUnited States, California, San Mateo, \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136';
    return PdfTextElement(
            text: invoiceNumber,
            font: font,
            format:
                PdfStringFormat(textDirection: PdfTextDirection.rightToLeft))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageSize.width - 150, 120, size.width, pageSize.height - 120))!;

    // PdfTextElement(text: address, font: contentFont).draw(
    //     page: page,
    //     bounds: Rect.fromLTWH(30, 120,
    //         pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  Future<List<int>> getFileAssete(String path) async {
    final bytdata = await rootBundle.load('images/$path');

    return bytdata.buffer.asInt8List();
  }

  PdfLayoutResult _drawGrid(
      PdfPage page, PdfGrid grid, PdfLayoutResult result, font, int type) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    final PdfLayoutFormat format = PdfLayoutFormat(
      layoutType: PdfLayoutType.paginate,
    );

    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.

    grid.style = PdfGridStyle(
      font: font,
    );
    double postion = type == 1
        ? result.bounds.bottom + 50
        : type == 2
            ? result.bounds.bottom + 50
            : result.bounds.bottom + 50;
    result = grid.draw(
      page: page,
      format: format,
      bounds: Rect.fromLTWH(0, postion, 0, 0),
    )!;
    return result;
  }

  PdfGrid _getGridCustomerRequestSummry(PdfFont font) {
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 2);
    final color = Get.theme.colorScheme.primary;
    // final PdfGridRow headerRow = grid.headers.add(1)[0];
    // headerRow.style.font = font;
    // headerRow.style.backgroundBrush = PdfSolidBrush(
    //     PdfColor(color.red, color.green, color.blue, color.alpha));
    // headerRow.style.textBrush = PdfBrushes.white;
    // headerRow.cells[0].value = 'اجمالي الطلبات بانتظار التعديل';
    // headerRow.cells[0].stringFormat =
    //     PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);
    // headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    // headerRow.cells[1].value = 'اجمالي الطلبات الملغيه';
    // headerRow.cells[1].stringFormat =
    //     PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);

    // headerRow.cells[2].value = 'اجمالي الطلبات تحت المعالجة';
    // headerRow.cells[2].stringFormat =
    //     PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);

    // headerRow.cells[3].value = 'اجمالي الطلبات قيد الطلب';
    // headerRow.cells[3].stringFormat =
    //     PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);

    // headerRow.cells[4].value = 'اجمالي الطلبات المكتملة';
    // headerRow.cells[4].stringFormat =
    //     PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);

    // headerRow.cells[5].value = 'اجمالي عدد الطلبات';
    // headerRow.cells[5].stringFormat =
    //     PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);

    // headerRow.cells[6].value = 'اسم الخدمة';
    // headerRow.cells[6].stringFormat =
    //     PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);

    // _addCustomerRequest(getuniqRequst, grid, font);
    _addCustomerRequestsummry(getuniqRequst, grid, font);

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable4Accent5,
        settings: PdfGridBuiltInStyleSettings());
    grid.columns[0].width = 100;
    grid.columns[0].format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
    grid.columns[1].width = 200;
    grid.columns[1].format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
    // grid.columns[6].format = PdfStringFormat(alignment: PdfTextAlignment.right);

    // for (int i = 0; i < headerRow.cells.count; i++) {
    //   headerRow.cells[i].style.cellPadding =
    //       PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    // }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
        cell.style.stringFormat = PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            wordWrap: PdfWordWrapType.word);
      }
    }
    return grid;
  }

  void _addCustomerRequestsummry(
      List<UserRequest> getuniqRequst, PdfGrid grid, PdfFont font) {
    // List<UserRequest> request, PdfGrid grid, PdfFont font) {
    // for (var element in getuniqRequst) {
    final PdfGridRow row = grid.rows.add();
    row.style = PdfGridRowStyle(font: font);

    row.cells[0].value = allRequest.length.toString();
    row.cells[1].value = 'اجمالي عدد الطلبات';
    final PdfGridRow row1 = grid.rows.add();
    row1.style = PdfGridRowStyle(font: font);

    row1.cells[0].value =
        allRequest.where((e) => e.state!.id == 4).toList().length.toString();
    row1.cells[1].value = 'اجمالي عدد الطلبات المكتملة';

    final PdfGridRow row2 = grid.rows.add();
    row2.style = PdfGridRowStyle(font: font);
    row2.cells[0].value =
        allRequest.where((e) => e.state!.id == 1).toList().length.toString();
    row2.cells[1].value = 'اجمالي عدد قيد الطلبات الطلب';

    final PdfGridRow row3 = grid.rows.add();
    row3.style = PdfGridRowStyle(font: font);

    row3.cells[0].value =
        allRequest.where((e) => e.state!.id == 2).toList().length.toString();
    row3.cells[1].value = 'اجمالي عدد الطلبات تحت المعالجة';
    final PdfGridRow row4 = grid.rows.add();
    row4.style = PdfGridRowStyle(font: font);

    row4.cells[0].value =
        allRequest.where((e) => e.state!.id == 3).toList().length.toString();
    row4.cells[1].value = 'اجمالي عدد الطلبات الملغية';
    final PdfGridRow row5 = grid.rows.add();
    row5.style = PdfGridRowStyle(font: font);

    row5.cells[0].value =
        allRequest.where((e) => e.state!.id == 5).toList().length.toString();
    row5.cells[1].value = 'اجمالي عدد الطلبات  بنتظار التعديل';
    // row.cells[0].value = allRequest
    //     .where(
    //         (e) => element.serviceName == e.serviceName && e.state!.id == 5)
    //     .toList()
    //     .length
    //     .toString();
    // row.cells[1].value = allRequest
    //     .where(
    //         (e) => element.serviceName == e.serviceName && e.state!.id == 3)
    //     .toList()
    //     .length
    //     .toString();

    // row.cells[2].value = allRequest
    //     .where(
    //         (e) => element.serviceName == e.serviceName && e.state!.id == 2)
    //     .toList()
    //     .length
    //     .toString();
    // row.cells[3].value = allRequest
    //     .where(
    //         (e) => element.serviceName == e.serviceName && e.state!.id == 1)
    //     .toList()
    //     .length
    //     .toString();
    // row.cells[4].value = allRequest
    //     .where(
    //         (e) => element.serviceName == e.serviceName && e.state!.id == 4)
    //     .toList()
    //     .length
    //     .toString();
    // row.cells[5].value = allRequest
    //     .where((e) => element.serviceName == e.serviceName)
    //     .toList()
    //     .length
    //     .toString();
    // row.cells[6].value = element.serviceName!;
    // }
  }

  void _drawGridSummry(
      PdfPage page, PdfGrid grid, PdfLayoutResult result, PdfFont font) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    final PdfLayoutFormat format = PdfLayoutFormat(
      layoutType: PdfLayoutType.paginate,
    );

    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    grid.allowRowBreakingAcrossPages = true;
    grid.style = PdfGridStyle(
      font: font,
    );
    result = grid.draw(
      page: page,
      format: format,
      bounds: Rect.fromLTWH(result.bounds.width + 10, 0 + 40, 0, 0),
    )!;
  }

  reportPdf(int type) async {
    {
      if (type == 1) {
        isLoading.value = true;
        await createPdf();
        isLoading.value = false;
      } else if (type == 2) {
        isLoading.value = true;

        await createPdfTrip();
      } else {
        isLoading.value = true;

        await createPdfCity();
      }
    }
  }

  PdfGrid _getGridTrip(PdfFont font, Size page2) {
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 2);

    final color = Get.theme.colorScheme.primary;
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.style.font = font;
    headerRow.style.backgroundBrush = PdfSolidBrush(
        PdfColor(color.red, color.green, color.blue, color.alpha));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'عدد مرات الحجز';
    headerRow.cells[0].stringFormat = PdfStringFormat(
        measureTrailingSpaces: true,
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);
    // headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'تاريخ الحجز';
    headerRow.cells[1].stringFormat = PdfStringFormat(
        measureTrailingSpaces: true,
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center);
    _addReportGridDetailsTrip(
        ReportHelper.uniqueData(
            data: allTripsRequest,
            condatioin: (value, collecation) {
              return !collecation
                  .any((element) => element.dateGo == value.dateGo);
            }),
        grid,
        font);

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable4Accent5,
        settings: PdfGridBuiltInStyleSettings());
    grid.columns[0].width = page2.width / 2;
    grid.columns[0].format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
    grid.columns[1].width = page2.width / 2;
    grid.columns[1].format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
    // grid.columns[6].format = PdfStringFormat(alignment: PdfTextAlignment.right);
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
        cell.style.stringFormat = PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.center,
            wordWrap: PdfWordWrapType.word);
      }
    }
    return grid;
  }

  void _addReportGridDetailsTrip(List<Info> trip, PdfGrid grid, PdfFont font) {
    for (var element in trip) {
      final PdfGridRow row = grid.rows.add();
      row.style = PdfGridRowStyle(font: font);

      row.cells[0].value = allTripsRequest
          .where((e) => element.dateGo == e.dateGo)
          .toList()
          .length
          .toString();
      row.cells[1].value = DateFormat.yMd('ar').format(element.dateGo!);
    }
  }

  Future<void> createPdfCity() async {
    final PdfDocument document = PdfDocument();

    try {
      //Add page to the PDF
      final PdfPage page = document.pages.add();
      final Size pageSize = page.getClientSize();

      final Uint8List fontData =
          File('fonts/AdobeArabic.ttf').readAsBytesSync();
      final PdfFont font =
          PdfTrueTypeFont(fontData, 16, style: PdfFontStyle.regular);
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
          pen: PdfPen(PdfColor(0, 0, 0)));
      final PdfGrid grid = _getGridCity(font);
      // final PdfGrid gridSummry = _getGridCustomerRequestSummry(font);

      final PdfLayoutResult result =
          await drowerHeaderPdf(page, pageSize, grid, font, "تقرير المدن");

      final PdfLayoutResult resultsummry =
          _drawGrid(page, grid, result, font, 3);

      grid.allowRowBreakingAcrossPages = true;

      final List<int> bytes = await document.save();
      document.dispose();
      await saveAndLaunch(
          data: bytes,
          name: 'reprot3'.toString() + Random().nextInt(101).toString());

      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
      document.dispose();
    }
  }

  PdfGrid _getGridCity(PdfFont font) {
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    final color = Get.theme.colorScheme.primary;
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.style.font = font;
    headerRow.style.backgroundBrush = PdfSolidBrush(
        PdfColor(color.red, color.green, color.blue, color.alpha));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = "الاجمالي";
    headerRow.cells[0].stringFormat =
        PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = "مرات السفر اليها";
    headerRow.cells[1].stringFormat =
        PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);
    headerRow.cells[2].value = "مرات السفر منها";
    headerRow.cells[2].stringFormat =
        PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);
    headerRow.cells[3].value = "الاسم";
    headerRow.cells[3].stringFormat =
        PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);
    headerRow.cells[4].value = "الرقم";
    headerRow.cells[4].stringFormat =
        PdfStringFormat(textDirection: PdfTextDirection.rightToLeft);

    _addReportGridCity(
        ReportHelper.uniqueData(
            data: getAllCitiesFromAndTo,
            condatioin: (value, collection) {
              return !collection.any((element) => element.hashCode == value.id);
            }),
        grid,
        font);

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable4Accent5,
        settings: PdfGridBuiltInStyleSettings());
    grid.columns[3].width = 150;
    grid.columns[3].format = PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.middle);
    // grid.columns[1].width = 150;
    // grid.columns[1].format = PdfStringFormat(
    //     alignment: PdfTextAlignment.right,
    //     lineAlignment: PdfVerticalAlignment.middle);
    // grid.columns[6].format = PdfStringFormat(alignment: PdfTextAlignment.right);
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
        cell.style.stringFormat = PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            wordWrap: PdfWordWrapType.word);
      }
    }
    return grid;
  }

  void _addReportGridCity(List<City> city, PdfGrid grid, PdfFont font) {
    for (var element in city) {
      final PdfGridRow row = grid.rows.add();
      row.style = PdfGridRowStyle(font: font);
      row.cells[0].value = getAllCitiesFromAndTo
          .where((e) => element.id == e.id)
          .toList()
          .length
          .toString();
      row.cells[1].value = getAllCitiesFromAndTo
          .where((e) => element.id == e.id && !e.isFrom!)
          .toList()
          .length
          .toString();
      row.cells[2].value = getAllCitiesFromAndTo
          .where((e) => element.id == e.id && e.isFrom!)
          .toList()
          .length
          .toString();
      row.cells[3].value = element.name;
      row.cells[4].value = element.id.toString();
      // row.cells[1].value = DateFormat.yMd('ar').format(element.dateGo!);
    }
  }
}
