import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../commen/ui.dart';
import '../../../models/basic/category.dart' as cat;
import '../../../models/basic/category.dart';
import '../../../models/basic/company.dart';
import '../../../models/basic/country.dart';
import '../../../models/basic/customer.dart';
import '../../../models/basic/data_basic.dart';
import '../../../models/basic/identity_customers.dart';
import '../../../models/basic/main_requiremnt.dart';
import '../../../models/basic/request_services.dart';
import '../../../models/basic/service.dart';
import '../../../models/basic/sub_requiremnt.dart';
import '../../../models/basic/trips.dart';
import '../../../models/basic/type_filed.dart';
import '../../../repository/basic_repository.dart';
import '../../../repository/category_services.dart';
import '../../../repository/companies_repository.dart';
import '../../../repository/services_travel.dart';
import '../../../repository/trips_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../views/booking_trip_view.dart';
import 'package:path/path.dart' as path;

import '../views/services_screen_view.dart';

class ServicesScreenController extends GetxController {
  Service? service;
  final company = <Company>[].obs;
  RxBool isload = false.obs;
  List<DateTime?> groupDateTrip = [];
  Rx<Category?> category = Rx<Category?>(null);
  DataBasicRepository? _basicRepository;
  CompaniesRepository? companiesRepository;
  CategoryRepository? _categoryRepository;
  ServicesRepository? _servicesRepository;
  TripsRepository? tripsRepository;
  // Rx<User?> currentUser = Rx<User?>(Get.find<AuthUserService>().user);
  DateTime? currentDate;

  Rx<cat.Category?> selectCategory = Rx<cat.Category?>(null);
  Rx<cat.Category?> selectWay = Rx<cat.Category?>(null);
  Rx<Company?> selectCompany = Rx<Company?>(null);
  Rx<Gender?> selectGender = Rx<Gender?>(null);
  final countAdult = 0.obs;
  final countChildern = 0.obs;
  final countbaby = 0.obs;
  Rx<DataBasic?> dataBasic = Rx<DataBasic?>(DataBasic());
  final groubeVauleIsFamily = false.obs;
  Rx<GFBottomSheetController> bottomSheetcontroller =
      Rx<GFBottomSheetController>(GFBottomSheetController());
  Rx<cat.Category?> way = Rx<cat.Category?>(null);
  List<Trips> trip = [];
  final scrollercontrller = ScrollController();
  RxInt indexScroll = RxInt(-1);
  List<Trips> triPSecondry = [];
  final triPSecondryBefore = <Trips>[].obs;
  RxList<RequestServices> requestBookingServices = RxList();
  List<Trips> tripCategory = [];
  MartialStatus? selectedmartialStatus;
  Choose? selectedChoose;
  Rx<Choose?> indexGroubRadio = Rx<Choose?>(null);
  final resultTripCategory = <Trips>[].obs;
  // GlobalKey keyForm = GlobalKey<FormState>();
  Rx<SubRequiremnt?> subRequiremnt = Rx<SubRequiremnt?>(null);
  XFile? image;
  int lastTotalPersonal = 0;
  Rx<int> totalePersion = 0.obs;
  Rx<int> currentTabWay = 0.obs;
  Rx<int> currentTabBody = 0.obs;
  int? idCureentTrip;
  File? fileCurrent;
  List<Trips> selectTrip = [];
  List<IdentitBeneficiares> identitSelected = [];
  List<IdentitBeneficiares> newIdentity = [];
  List<Countries>? searchCityList;
  final isShowBeforeTrip = false.obs;

  Plantrip currentPlan = Plantrip();
  Rx<Color> colorBackgroundSliver = Rx<Color>(Get.theme.colorScheme.secondary);
  ServicesScreenController() {
    _servicesRepository = ServicesRepository();
    _basicRepository = DataBasicRepository();
    companiesRepository = CompaniesRepository();
    tripsRepository = TripsRepository();
    _categoryRepository = CategoryRepository();
  }
  String errorCity = '';
  String errorDate = '';
  String errorCount = '';
  @override
  void onInit() async {
    selectTrip.add(Trips());
    await loadDataBase();

    super.onInit();
  }

  test() {
    // print('data');
  }

  loadServicesId(Trips trip) async {
    isload.value = true;
    service = await _servicesRepository!.getServiceById(trip.idService!);
    idCureentTrip = trip.idTrips;

    // addRequstList();
    lastTotalPersonal = totalePersion.value;
    isload.value = false;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  addRequstServer() async {
    isload.value = true;

    bool isSucess = await tripsRepository!.addRequstBooking(
        RequestServicesModelSend(data: requestBookingServices));
    isload.value = false;
    if (isSucess) {
      UiApp.snakSecess('تم', 'تم الحجز بنجاح');
      Get.offAllNamed(Routes.MAIN_SCREAN);
    } else {
      UiApp.snakfaild("فشل", 'فشلت عملية الحجز');
    }
  }

  configrageData() {}
  extractCatagerySacandry() {
    // List<CategorySecondry?>? categorySecondrytemp = service.map((e) {
    //   if (e.categorySecondry != null) {
    //     return e.categorySecondry!;
    //   }
    // }).toList();

    // categorySecondry = categorySecondrytemp.toSet().toList();
  }
  currentTabWayChange(value) {
    selectTrip = selectTrip.map((e) => Trips()).toList();
    currentTabWay.value = value;
    update(['city', 'DatTrip']);
  }

  extractCompany() {
    // List<CategorySecondry?> categorySecondrytemp = service.map((e) {
    //   if (e.categorySecondry != null) {
    //     return e.categorySecondry!;
    //   }
    // }).toList();
    // categorySecondry =
    //     categorySecondrytemp.toSet().toList() as List<CategorySecondry>;
  }
  currentTabBodychange(int p0) {
    selectTrip = selectTrip.map((e) => Trips()).toList();
    currentTabBody.value = p0;
    update(['city', 'DatTrip']);
  }

  Future<void> _cropImage() async {
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'تعديل ابعاد الصورة',
              toolbarColor: Get.theme.colorScheme.primary,
              backgroundColor: Get.theme.colorScheme.secondary,
              cropFrameColor: Get.theme.colorScheme.primary,
              statusBarColor: Get.theme.colorScheme.secondary,
              toolbarWidgetColor: Get.theme.colorScheme.secondary,
              activeControlsWidgetColor: Get.theme.colorScheme.primary,
              cropGridColor: Get.theme.colorScheme.primary,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );
      if (croppedFile != null) {
        // setState(() {
        //   this.imageCrop = croppedFile;
        // });
      }
    }
  }

  // User? get getUser {
  //   return Get.find<AuthUserService>().user;
  // }

  // startUpBenefitesScreen() {
  //   currentUser.value = currentUser.value ?? Get.find<AuthUserService>().user;
  //   update();
  // }

  saveDataRequst(
      {MainRequirment? mainRequirment,
      SubRequiremnt? subRequiremnt,
      required int indexPerson,
      required int indexTypFiled,
      int? indexMain,
      int? idMain,
      dynamic value,
      String? fileName,
      int? idSub,
      int? indexSub}) async {
    if (indexMain != null) {
      // requestBookingServices[indexPerson].details
      if (indexTypFiled == 1) {
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .idTypeFiled = indexTypFiled;
        requestBookingServices[indexPerson].detailsMain![indexMain].id =
            idMain!;
        requestBookingServices[indexPerson].detailsMain![indexMain].textValue =
            value;
      } else if (indexTypFiled == 2) {
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .idTypeFiled = indexTypFiled;
        requestBookingServices[indexPerson].detailsMain![indexMain].id =
            idMain!;
        requestBookingServices[indexPerson].detailsMain![indexMain].file =
            base64Encode((await File(value).readAsBytes()));
        requestBookingServices[indexPerson].detailsMain![indexMain].fileName =
            path.basename(value);
      } else if (indexTypFiled == 3) {
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .idTypeFiled = indexTypFiled;
        requestBookingServices[indexPerson].detailsMain![indexMain].id =
            idMain!;
        requestBookingServices[indexPerson].detailsMain![indexMain].textValue =
            value;
      } else if (indexTypFiled == 4) {
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .idTypeFiled = indexTypFiled;
        requestBookingServices[indexPerson].detailsMain![indexMain].id =
            idMain!;
        requestBookingServices[indexPerson].detailsMain![indexMain].textValue =
            value;
      } else if (indexTypFiled == 5) {
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .idTypeFiled = indexTypFiled;
        requestBookingServices[indexPerson].detailsMain![indexMain].id =
            idMain!;
        requestBookingServices[indexPerson].detailsMain![indexMain].file =
            base64Encode((await File(value).readAsBytes()));
        requestBookingServices[indexPerson].detailsMain![indexMain].fileName =
            path.basename(value);
      } else if (indexTypFiled == 9) {
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .idTypeFiled = indexTypFiled;
        requestBookingServices[indexPerson].detailsMain![indexMain].id =
            idMain!;
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .choice
            .value = value!;
      } else if (indexTypFiled == 8) {
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .idTypeFiled = indexTypFiled;
        requestBookingServices[indexPerson].detailsMain![indexMain].id =
            idMain!;
        requestBookingServices[indexPerson]
            .detailsMain![indexMain]
            .choice
            .value = value!;
      }
    } else if (indexSub != null) {
      if (indexTypFiled == 1) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson].detailsSub![indexSub].textValue =
            value;
      }
      if (indexTypFiled == 2) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson].detailsSub![indexSub].file =
            base64Encode((await File(value).readAsBytes()));
        requestBookingServices[indexPerson].detailsSub![indexSub].fileName =
            path.basename(value);
      }
      if (indexTypFiled == 3) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson].detailsSub![indexSub].textValue =
            value;
      }
      if (indexTypFiled == 3) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson].detailsSub![indexSub].textValue =
            value;
      }
      if (indexTypFiled == 4) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson].detailsSub![indexSub].textValue =
            value;
      }
      if (indexTypFiled == 5) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson].detailsSub![indexSub].file =
            base64Encode((await File(value).readAsBytes()));

        requestBookingServices[indexPerson].detailsSub![indexSub].fileName =
            path.basename(value);
      }
      if (indexTypFiled == 9) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson]
            .detailsSub![indexSub]
            .choiceSub
            .value = value;
      }
      if (indexTypFiled == 8) {
        requestBookingServices[indexPerson].detailsSub![indexSub].idTypeFiled =
            indexTypFiled;
        requestBookingServices[indexPerson].detailsSub![indexSub].id = idSub!;
        requestBookingServices[indexPerson]
            .detailsSub![indexSub]
            .choiceSub
            .value = value;
      }
    }
  }

  searchSubrequment(int index, {IdentityCustomers? identity}) {
    List<SubRequiremnt>? subReq = service!.subRequiremnts;
    // if (selectedmartialStatus != null && selectGender.value != null) {
    //   subRequiremnt.value = subReq?.firstWhere(
    //     (element) =>
    //         element.gender == selectGender.value!.idGender &&
    //         selectedmartialStatus!.idMartial == element.idMartial &&
    //         groubeVauleIsFamily.value == element.isFamely,
    //     orElse: () {
    //       return SubRequiremnt(idSubRequerment: -99);
    //     },
    //   );
    // }

    //by ahmed
    // MartialStatus? selectedmartialStatus =
    //     requestBookingServices[index].identityCustomers.martial.value;
    // Gender? selectGender =
    //     requestBookingServices[index].identityCustomers.gender.value;
    MartialStatus? selectedmartialStatus = identity!.martial.value;

    Gender? selectGender = identity.gender.value!;
    if (selectedmartialStatus != null && selectGender != null) {
      requestBookingServices[index].subRequiremnt!.value = subReq?.firstWhere(
        (element) =>
            element.gender == selectGender.idGender &&
            selectedmartialStatus.idMartial == element.idMartial &&
            groubeVauleIsFamily.value == element.isFamely,
        orElse: () {
          if (requestBookingServices[index].detailsSub != null) {
            requestBookingServices[index].detailsSub!.clear();
          }
          return SubRequiremnt(idSubRequerment: -99);
        },
      );
      requestBookingServices[index].detailsSub = List.generate(
          requestBookingServices[index].getLengthDetailsSubReq(),
          (_) => RequestServicesMainDetails(
              choice: Rx<Choose?>(null), choiceSub: Rx<ChooseSub?>(null)));
      // if (!(subRequiremnt.value == null ||
      //     subRequiremnt.value!.idSubRequerment == -99)) {
      //   requestBookingServices[index].detailsSub = List.generate(
      //       subRequiremnt.value!.detaial!.length,
      //       (index) => RequestServicesSubDetails(choice: Rx<Choose?>(null)));
      // }
    }
  }

  SubRequiremnt? getSubRequerment(IdentityCustomers identity) {
    List<SubRequiremnt>? subReq = service!.subRequiremnts;
    SubRequiremnt? sub;
    MartialStatus? selectedmartialStatus = identity.martial.value;

    Gender? selectGender = identity.gender.value;
    // if (selectedmartialStatus != null && selectGender != null) {
    sub = subReq!.firstWhere(
      (element) =>
          element.gender == selectGender!.idGender &&
          selectedmartialStatus!.idMartial == element.idMartial &&
          groubeVauleIsFamily.value == element.isFamely,
      orElse: () {
        return SubRequiremnt(idSubRequerment: -99);
      },
    );
    return sub;
    // }
  }

  pickImage(bool isCamera) async {
    try {
      var imageitem = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (imageitem != null) {
        image = imageitem;
        await _cropImage();
        Get.back();
        // setState(() {});
      }
    } on PlatformException catch (e) {
      Get.log(e.message!);
    }
  }

  filePiicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileCurrent = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  selectDropDown(int id, dynamic newValue) {
    if (id == 1) {
      selectCategory.value = newValue;
      way.value = selectCategory.value;
      selectWay.value = null;
      selectCompany.value == null;
      searchCategory(1);
    } else if (id == 2) {
      selectWay.value = newValue;
      searchCategory(2);
    } else if (id == 3) {
      selectCompany.value = newValue;
      searchCategory(3);
    }
  }

  loadDataBase() async {
    isload.value = true;
    category.value = await _categoryRepository!.getCategoryById(1);
    trip = await tripsRepository!.all();
    company.value = await companiesRepository!.all();
    // company.value = company.where((p0) => p0.idCategoryService == 1).toList();
    tripCategory = trip;

    dataBasic.value = await _basicRepository!.all();
    currentPlan = dataBasic.value!.planTrip!.first;
    //selectCategory.value = category!.subCategory!.first;
    isload.value = false;
  }

  searchCategory(int idType) {
    // if (levelTwoCategory != null) {
    //   tripCategory = trip
    //       .where((p0) => p0.category!.levelTwoCategory == levelTwoCategory)
    //       .toList();
    //   resultTripCategory.value = tripCategory;
    // } else {
    //   resultTripCategory.value = tripCategory
    //       .where((p0) => p0.category!.idCategoryMain == idWay)
    //       .toList();
    // }
    if (idType == 1) {
      if (selectCompany.value == null) {
        resultTripCategory.value = triPSecondry
            .where((element) =>
                element.category!.levelTwoCategory ==
                selectCategory.value!.idCategoryMain)
            .toList();
      } else {
        resultTripCategory.value = triPSecondry
            .where((element) =>
                element.company!.id == selectCompany.value!.id &&
                element.category!.levelTwoCategory ==
                    selectCategory.value!.idCategoryMain)
            .toList();
      }
    } else if (idType == 2) {
      if (selectCompany.value == null) {
        resultTripCategory.value = triPSecondry
            .where((element) =>
                element.category!.idCategoryMain ==
                    selectWay.value!.idCategoryMain &&
                element.category!.levelTwoCategory ==
                    selectCategory.value!.idCategoryMain)
            .toList();
      } else {
        resultTripCategory.value = triPSecondry
            .where((element) =>
                element.category!.idCategoryMain ==
                    selectWay.value!.idCategoryMain &&
                element.company!.id == selectCompany.value!.id &&
                element.category!.levelTwoCategory ==
                    selectCategory.value!.idCategoryMain)
            .toList();
      }
    } else if (idType == 3) {
      if (selectCategory.value != null) {
        if (selectWay.value == null) {
          resultTripCategory.value = triPSecondry
              .where((element) =>
                  element.company!.id == selectCompany.value!.id &&
                  element.category!.levelTwoCategory ==
                      selectCategory.value!.idCategoryMain)
              .toList();
        } else {
          resultTripCategory.value = triPSecondry
              .where((element) =>
                  element.category!.idCategoryMain ==
                      selectWay.value!.idCategoryMain &&
                  element.company!.id == selectCompany.value!.id &&
                  element.category!.levelTwoCategory ==
                      selectCategory.value!.idCategoryMain)
              .toList();
        }
      } else {
        resultTripCategory.value = triPSecondry
            .where((element) => element.company!.id == selectCompany.value!.id)
            .toList();
      }
    }
  }

  incrementCountTravels({required int id}) {
    if (id == 1) {
      countAdult.value++;
      totalePersion.value++;
    } else if (id == 2) {
      countChildern.value++;
      totalePersion.value++;
    } else {
      countbaby.value++;
      totalePersion.value++;
    }
  }

  decrementCountTravels({required int id}) {
    if (id == 1) {
      if (countAdult.value >= 1) {
        countAdult.value--;
        totalePersion.value--;
      }
    } else if (id == 2) {
      if (countChildern.value >= 1) {
        countChildern.value--;
        totalePersion.value--;
      }
    } else {
      if (countbaby.value >= 1) {
        countbaby.value--;
        totalePersion.value--;
      }
    }
  }

  choiceCurrentPlan(Plantrip planTrip) {
    if (currentPlan.id == 4) {
      selectTrip.removeRange(1, selectTrip.length);
      currentPlan = planTrip;
    } else {
      currentPlan = planTrip;
    }

    update(['PlanTrip', 'DatTrip', 'city']);
  }

  addRequstList() {
    int last = lastTotalPersonal;
    int newtotel = totalePersion.value;

    // List<TripHelperBooking> dateTrip = selectTrip
    //     .map((e) => TripHelperBooking(
    //         idTrips: e.idTrips, dateGo: e.dateGo, dateBack: e.dateBack))
    //     .toList();
    if (last < newtotel) {
      for (int i = 0; i < newtotel - last; i++) {
        // requestBookingServices.add(RequestServices(

        //     idCust: currentUser.value!.idCus!,
        //     identityCustomers: IdentityCustomers(
        //         name: NameCustomer(), gender: Rx(null), martial: Rx(null)),
        //     idServ: service!.id!,
        //     detailsMain: List.generate(
        //         service!.mainRequirment!.length,
        //         (index) => RequestServicesMainDetails(
        //             choice: Rx<Choose?>(null),
        //             choiceSub: Rx<ChooseSub?>(null))),
        //     dataTrip: dateTrip,
        //     idPlan: currentPlan.id));
      }
    } else if (last > newtotel) {
      for (int i = 0; i < last - newtotel; i++) {
        requestBookingServices.removeLast();
      }
    } else {}
  }

  checkIsFamily() {
    bool isFame = false;
    var existWoman = identitSelected.any(
        (element) => element.identityCustomer!.gender.value!.idGender == 1);
    if (existWoman || countChildern.value > 0 || countChildern.value > 0) {
      isFame = true;
    }
    groubeVauleIsFamily.value = isFame;
  }

  // addjustCutomerTolastStep() {
  //   if (identitSelected.isNotEmpty) {
  //     checkIsFamily();
  //     List<TripHelperBooking> dateTrip = selectTrip
  //         .map((e) => TripHelperBooking(
  //             idTrips: e.idTrips, dateGo: e.dateGo, dateBack: e.dateBack))
  //         .toList();
  //     requestBookingServices.value = identitSelected.map((e) {
  //       Rxn<SubRequiremnt> sub = Rxn(getSubRequerment(e.identityCustomer!));
  //       // if (e.isMe == true) {
  //       //   e.identityCustomer!.id = currentUser.value!.idCus==null?-404;
  //       // }
  //       return RequestServices(
  //           idCust: currentUser.value!.idCus!,
  //           identityCustomers: e.identityCustomer!,
  //           idServ: service!.id!,
  //           subRequiremnt: sub,
  //           detailsMain: List.generate(
  //               service!.mainRequirment!.length,
  //               (index) => RequestServicesMainDetails(
  //                   choice: Rx<Choose?>(null),
  //                   choiceSub: Rx<ChooseSub?>(null))),
  //           dataTrip: dateTrip,
  //           detailsSub: List.generate(
  //               sub.value == null
  //                   ? 0
  //                   : sub.value!.detaial == null
  //                       ? 0
  //                       : sub.value!.detaial!.length,
  //               (index) => RequestServicesMainDetails(
  //                   choice: Rx<Choose?>(null),
  //                   choiceSub: Rx<ChooseSub?>(null))),
  //           idPlan: currentPlan.id);
  //     }).toList();

  //     Get.to(() => const BookingTripView());
  //   } else {
  //     UiApp.snakfaild('خطاء', 'الرجاء اختيار الاشخاص');
  //   }
  // }

  endBootmSheetBookingTrip(Trips trip) async {
    if (!groubeVauleIsFamily.value) {
      totalePersion.value -= countChildern.value + countbaby.value;
    }
    if (currentPlan.id != 4) {
      selectTrip.first.dateGo = trip.dateGo;
      selectTrip.first.idTrips = trip.idTrips;
    }
    // setInititalPersonObject();
    Get.to(() => const BookingTripView());
    await loadServicesId(trip);
  }

  goToScreanBeneficiares(Trips trip) async {
    if (!groubeVauleIsFamily.value) {
      totalePersion.value -= countChildern.value + countbaby.value;
    }
    if (currentPlan.id != 4) {
      selectTrip.first.dateGo = trip.dateGo;
      selectTrip.first.idTrips = trip.idTrips;
    }
    await loadServicesId(trip);
    Get.toNamed(Routes.SERVICES_SCREEN_BENEFITES);
  }

  setInititalPersonObject() {
    int sum = 0;
    for (int index = 0; index < totalePersion.value; index++) {
      if (countAdult.value > index) {
        sum++;
      } else if (countAdult.value + countChildern.value > index &&
          groubeVauleIsFamily.value) {
        sum++;
      } else {
        if (groubeVauleIsFamily.value) {
          sum++;
        }
      }
    }
    Get.log(sum.toString());
  }

  changisFamily(bool value) {
    groubeVauleIsFamily.value = value;
    if (value == false) {
      countChildern.value = countbaby.value = 0;
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

  selectedCity(City city, type, index) {
    if (type == 1) {
      selectTrip[index].fromCity = city;
    } else {
      selectTrip[index].toCity = city;
    }
    update([
      'city',
    ]);
  }

  checkVaidatioin({bool isDone = true}) async {
    for (var temp in selectTrip) {
      if (temp.fromCity == null ||
          temp.fromCity!.name!.isEmpty ||
          temp.toCity == null ||
          temp.toCity!.name!.isEmpty) {
        isDone = false;
        errorCity = 'تاكد من ادخال جميع الوجهات المطلوبة ';
      } else {
        errorCity = '';
      }
      if (temp.dateGo == null ||
          ((temp.dateBack == null) &&
              (currentPlan.id == 2 || currentPlan.id == 4))) {
        isDone = false;
        errorDate = 'تاكد من ادخال جميع التاريخ المطلوبة ';
      } else {
        errorDate = '';
      }
      // if (totalePersion.value == 0) {
      //   errorCount = 'قم بادخال عدد المسافرين';
      //   isDone = false;
      // } else {
      //   errorCount = '';
      // }
    }

    if (isDone) {
      await calculetTrip();
    } else {
      update(['city', 'errorCount', 'DatTrip']);
    }
  }

  calculetTrip() async {
    isload.value = true;
    DateTime date = DateTime.now();
    currentDate = selectTrip.first.dateGo!;
    List<Trips> trips = [];
    List<Trips> tripsTemp = [];
    if (currentPlan.id != 4) {
      tripsTemp = trip
          .where((element) =>
              element.category!.idCategoryMain ==
                  category.value!.subCategory![currentTabWay.value]
                      .subCategory![currentTabBody.value].idCategoryMain &&
              element.fromCity == selectTrip.first.fromCity)
          .toList();
    }
    int index;

    for (var element in tripsTemp) {
      var dateTemp = date;
      if (element.scheduler!.method!.id == 2) {
        for (int i = 0; i < 4; i++) {
          if (i > 0) {
            dateTemp = DateUtils.addDaysToDate(
                dateTemp, 7 * element.scheduler!.atCount!);
            index = 1;
          } else {
            index = dateTemp.weekday;
          }

          for (int j = index; j <= 7; j++) {
            for (var comp in element.scheduler!.days!) {
              if (comp.id! == j) {
                trips.add(element.copyWith(
                    dateGo: DateUtils.addDaysToDate(
                        dateTemp, j - dateTemp.weekday)));
                break;
              } else {}
            }
          }
        }
      }
    }

    groupDateTrip = trips.map((e) => e.dateGo).toList();
    groupDateTrip = groupDateTrip.toSet().toList();

    triPSecondry = trips.where((element) {
      TimeOfDay time = TimeOfDay.now();
      if (date.year == element.dateGo!.year &&
          date.month == element.dateGo!.month &&
          date.day == element.dateGo!.day) {
        if (element.timeLeave!.hour < time.hour) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    })
        //     element.dateGo!.isAfter(selectTrip.first.dateGo!) ||
        //     (timeleave.isBefore(date)
        //         element.dateGo!.isBefore(selectTrip.first.dateGo!)))
        .toList()
      ..sort((x, y) => x.dateGo!.compareTo(y.dateGo!));

    isload.value = false;
    var targetDate = selectTrip.first.dateGo;
    indexScroll.value =
        (groupDateTrip.indexWhere((element) => element! == targetDate));
    if (indexScroll.value == -1) {
      DateTime? closestDate = groupDateTrip.reduce((a, b) => (a!
                  .difference(targetDate!)
                  .abs()
                  .compareTo(b!.difference(targetDate).abs())) <
              0
          ? a
          : b);

      indexScroll.value =
          groupDateTrip.indexWhere((element) => element! == closestDate);
      currentDate = groupDateTrip[indexScroll.value];
    }
    resultTripCategory.value =
        triPSecondry.where((element) => element.dateGo == currentDate).toList();
    await Get.to(() => const ServicesScreenView());
  }

  // int findIndexForDate(DateTime searchDate, List<DateTime?> dates) {
  //   int index = dates.indexOf(searchDate);
  //   if (index < 0) {
  //     // تاريخ غير موجود في القائمة ، لذلك نحتاج إلى العثور على أقرب قمة.
  //     int closestIndex = dates
  //         .map((dateTime) => dateTime!.millisecondsSinceEpoch)
  //         .toList().
  //         .binarySearch(searchDate.millisecondsSinceEpoch);
  //     index = closestIndex >= 0 ? closestIndex : (~closestIndex - 1);
  //   }
  //   return index;
  // }

  addOrDeleteSelectCity({required bool isAdd, int? index}) {
    if (isAdd) {
      selectTrip.add(Trips());
    } else {
      selectTrip.removeAt(index!);
    }
    update(['city', 'DatTrip']);
  }

  selectByDataSpecific(DateTime date) {
    currentDate = date;
    resultTripCategory.value =
        triPSecondry.where((element) => element.dateGo == date).toList();
    update(['SelectDataCategory']);
  }

  searchCity(
      {required bool isChange, String? value, List<Countries>? dataOrig}) {
    if (isChange) {
      searchCityList = dataOrig!
          .where((element) =>
              element.countryName!
                  .toLowerCase()
                  .contains(value!.toLowerCase()) ||
              element.cities!.any(
                  (e) => e.name!.toLowerCase().contains(value.toLowerCase())))
          .toList();
      update(['resueltSearchCity']);
    } else {
      update(['resueltSearchCity']);
    }
  }

  // adjustSelectIdentit(
  //     IdentitBeneficiares identity, bool value, String birthDate,
  //     {bool isMe = false}) {
  //   if (value) {
  //     if (!isMe) {
  //       identitSelected.add(identity);
  //     } else {
  //       identity.isMe = true;
  //       identity.isSelected.value = true;
  //       identity.identityCustomer!.id = -404;
  //       currentUser.value!.identityMe = identity;

  //       identitSelected.add(identity);
  //     }

  //     update(['badgeTravel', 'listnewBenefites', 'isMe']);
  //     calculateTravel(value, birthDate);
  //   } else {
  //     identitSelected.removeWhere((element) => element == identity);
  //     update(['badgeTravel', 'listnewBenefites']);
  //     calculateTravel(value, birthDate);
  //   }
  // }

  updateIsMe() {
    update(['isMe']);
  }

  calculateTravel(bool isAdd, String birthDate) {
    int date = getAge(birthDate);
    if (isAdd) {
      if (date > 12) {
        countAdult.value++;
      } else if (date > 2) {
        countChildern.value++;
      } else {
        countbaby.value++;
      }
    } else {
      if (date > 12) {
        countAdult.value--;
      } else if (date > 2) {
        countChildern.value--;
      } else {
        countbaby.value--;
      }
    }
  }

  activeOrPassTripsBefor(bool? value) {}
}
