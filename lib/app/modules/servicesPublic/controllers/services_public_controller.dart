import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../../../Helper/function_useable.dart';
import '../../../commen/ui.dart';
import '../../../models/basic/customer.dart';
import '../../../models/basic/data_basic.dart';
import '../../../models/basic/identity_customers.dart';
import '../../../models/basic/main_requiremnt.dart';
import '../../../models/basic/request_services.dart';
import '../../../models/basic/service.dart';
import '../../../models/basic/sub_requiremnt.dart';
import '../../../models/basic/type_filed.dart';
import '../../../repository/basic_repository.dart';
import '../../../repository/services_travel.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../views/booking_screen_view.dart';

class ServicesPublicController extends GetxController {
  Rx<bool> isload = Rx<bool>(false);
  Rx<bool> isFamily = Rx<bool>(false);
  RxList<Service> services = RxList<Service>();
  Service? service;
  ServicesRepository? _servicesRepository;
  String? idCategre;
  final countAdult = 0.obs;
  final countChildern = 0.obs;
  final countbaby = 0.obs;
  final totalePersion = 0.obs;
  int lastTotalPersonal = 0;
  List<IdentitBeneficiares> identitSelected = [];

  RxList<RequestServices> requestBookingServices = RxList();
  DataBasicRepository? _basicRepository;
  Rx<DataBasic?> dataBasic = Rx<DataBasic?>(DataBasic());
  // Rx<User?> currentUser = Rx<User?>(Get.find<AuthUserService>().user);

  XFile? image;
  File? fileCurrent;
  @override
  void onInit() async {
    _basicRepository = DataBasicRepository();
    _servicesRepository = ServicesRepository();
    idCategre = Get.parameters['id'];
    await loadData();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  loadData() async {
    isload.value = true;
    dataBasic.value = await _basicRepository!.all();
    services.value =
        await _servicesRepository!.getServicedByCategory(int.parse(idCategre!));

    isload.value = false;
  }

  void endBootmSheetBookingServices(Service service) {
    if (!isFamily.value) {
      totalePersion.value -= countChildern.value + countbaby.value;
    }
    this.service = service;
    // addRequstList();
    lastTotalPersonal = totalePersion.value;
    Get.to(() => const BookingScreenView());
  }

  onchangeIsfamily(bool value) {
    isFamily.value = value;
  }

  // addRequstList() {
  //   int last = lastTotalPersonal;
  //   int newtotel = totalePersion.value;
  //   // User customer = Get.find<AuthUserService>().user!;

  //   if (last < newtotel) {
  //     for (int i = 0; i < newtotel - last; i++) {
  //       requestBookingServices.add(RequestServices(
  //         idCust: customer.idCus!,
  //         identityCustomers: IdentityCustomers(
  //             name: Name(), gender: Rx(null), martial: Rx(null)),
  //         idServ: service!.id!,
  //         detailsMain: List.generate(
  //             service!.mainRequirment!.length,
  //             (index) => RequestServicesMainDetails(
  //                 choice: Rx<Choose?>(null), choiceSub: Rx<ChooseSub?>(null))),
  //       ));
  //     }
  //   } else if (last > newtotel) {
  //     for (int i = 0; i < last - newtotel; i++) {
  //       requestBookingServices.removeLast();
  //     }
  //   } else {}
  // }

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

  // adjustSelectIdentit(
  //     IdentitBeneficiares identity, bool value, String birthDate,
  //     {bool isMe = false}) {
  //   if (value) {
  //     if (!isMe) {
  //       identitSelected.add(identity);
  //     } else {
  //       identity.isMe = true;
  //       identity.isSelected.value = false;
  //       identity.identityCustomer!.id = -404;
  //       currentUser.value!.identityMe = identity;

  //       // identitSelected.add(identity);
  //     }

  //     update(['badgeTravel', 'listnewBenefites', 'isMe']);
  //     calculateTravel(value, birthDate);
  //   } else {
  //     identitSelected.removeWhere((element) => element == identity);
  //     update(['badgeTravel', 'listnewBenefites']);
  //     calculateTravel(value, birthDate);
  //   }
  // }

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
              statusBarColor: Get.theme.colorScheme.primary,
              cropGridColor: Get.theme.colorScheme.primary,
              toolbarWidgetColor: Colors.white,
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

  confarmLogin(Service serviceSelected) {
    service = serviceSelected;
    Get.toNamed(Routes.SERVICES_Public_BENEFITES);
  }

  searchSubrequment(int index) {
    // List<SubRequiremnt>? subReq = service!.subRequiremnts;

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
    MartialStatus? selectedmartialStatus =
        requestBookingServices[index].identityCustomers.martial.value;
    Gender? selectGender =
        requestBookingServices[index].identityCustomers.gender.value;
    if (selectedmartialStatus != null && selectGender != null) {
      // requestBookingServices[index].subRequiremnt.value = subReq?.firstWhere(
      //   (element) =>
      //       element.gender == selectGender.idGender &&
      //     selectedmartialStatus.idMartial == element.idMartial &&
      //     isFamily.value == element.isFamely,
      // orElse: () {
      //   if (requestBookingServices[index].detailsSub != null) {
      //     requestBookingServices[index].detailsSub!.clear();
      //   }
      //   return SubRequiremnt(idSubRequerment: -99);
      // },
      // );
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
      Get.log('Failed to pick image: ${e.message}');
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

  checkIsFamily() {
    bool isFame = false;
    var existWoman = identitSelected.any(
        (element) => element.identityCustomer!.gender.value!.idGender == 2);
    if (existWoman || countChildern.value > 0) {
      isFame = true;
    }
    isFamily.value = isFame;
  }

  // addjustCutomerTolastStep() {
  //   if (identitSelected.isNotEmpty) {
  //     checkIsFamily();
  //     requestBookingServices.value = identitSelected.map((e) {
  //       Rxn<SubRequiremnt> sub = Rxn(getSubRequerment(e.identityCustomer!));
  //       // if (e.isMe == true) {
  //       //   e.identityCustomer!.id = currentUser.value!.idCus==null?-404;
  //       // }

  //       return RequestServices(
  //         idCust: currentUser.value!.idCus!,
  //         identityCustomers: e.identityCustomer!,
  //         idServ: service!.id!,
  //         subRequiremnt: sub,
  //         detailsMain: List.generate(
  //             service!.mainRequirment!.length,
  //             (index) => RequestServicesMainDetails(
  //                 choice: Rx<Choose?>(null), choiceSub: Rx<ChooseSub?>(null))),
  //         detailsSub: List.generate(
  //             sub.value == null
  //                 ? 0
  //                 : sub.value!.detaial == null
  //                     ? 0
  //                     : sub.value!.detaial!.length,
  //             (index) => RequestServicesMainDetails(
  //                 choice: Rx<Choose?>(null), choiceSub: Rx<ChooseSub?>(null))),
  //       );
  //     }).toList();

  //     Get.to(() => const BookingScreenView());
  //   } else {
  //     UiApp.snakfaild('خطاء', 'الرجاء اختيار الاشخاص');
  //   }
  // }

  // startUpBenefitesScreen() {
  //   currentUser.value = currentUser.value ?? Get.find<AuthUserService>().user;
  //   update();
  // }

  addRequstServer() async {
    isload.value = true;

    bool isSucess = await _servicesRepository!.addRequstServicesbooking(
        RequestServicesModelSend(data: requestBookingServices.value));
    isload.value = false;
    if (isSucess) {
      UiApp.snakSecess('تم', 'تم الحجز بنجاح');
      Get.offAllNamed(Routes.MAIN_SCREAN);
    } else {
      UiApp.snakfaild("فشل", 'فشلت عملية الحجز');
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
          isFamily.value == element.isFamely,
      orElse: () {
        return SubRequiremnt(idSubRequerment: -99);
      },
    );
    return sub;
    // }
  }
}
