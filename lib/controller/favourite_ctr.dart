import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/core/common/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/common/app_config.dart';
import '../core/common/app_const.dart';
import '../core/common/url_changed.dart';
import '../model/firebase_file.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'applovin_ctr.dart';

class AddToFavourite extends GetxController {
  List<Favourite> lst = <Favourite>[].obs;
  final rating = 4.5.obs;
  final ReceivePort _port = ReceivePort();
  final AdsApplovinCtrl adsApplovinCtrl = Get.find<AdsApplovinCtrl>();
  bool isLayoutOne = true;
  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  // items can change
  RxBool isItem = AppConfig.itemSelected.obs;

  @override
  void onInit() async {
    print("call onInit"); // this line not printing
    setupFavourite();
    getId();
    getLayLoading();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      update();
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.onInit();
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  selectLayLoading({required bool isOne}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(AppConst.loadingId);
    prefs.setBool(AppConst.loadingId, isOne);
    isLayoutOne = isOne;
    update();
  }

  getLayLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLayoutOne = prefs.getBool(AppConst.loadingId) ?? true;
    update();
  }

  Future<Object?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      print("---------------- devide ${androidDeviceInfo.brand}");
      return androidDeviceInfo.type; // unique ID on Android
    }
    return false;
  }

  void rateUs() {
    try {
      launchUrl(Uri.parse("market://details?id=${AppConfig.appPackageName}"));
    } catch (e) {
      launchUrl(Uri.parse("${AppUrls.playStore}${AppConfig.appPackageName}"));
    } finally {
      launchUrl(Uri.parse("${AppUrls.playStore}${AppConfig.appPackageName}"));
    }
  }

  void privatePolicy() {
    try {
      launchUrl(Uri.parse(AppChanged.pPolicyUrl));
    } catch (e) {
      launchUrl(Uri.parse(AppChanged.pPolicyUrl));
    }
  }

  List<Favourite>? dataWithMer({required List<Favourite> lst}) {
    List<Favourite> lstWithMerc = [];
    for (int i = 0; i < lst.length; i++) {
      if (adsApplovinCtrl.isMultiple(i)) {
        lstWithMerc
            .add(Favourite(name: "Mrec", url: "", isSelected: true, ref: null));
      }
      lstWithMerc.add(lst[i]);
    }
    return lstWithMerc;
  }

  setupFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    var favourite = prefs.getString(AppConst.listNotification);
    if (favourite != null) {
      print("jsonDecode ${jsonDecode(favourite)}");
      List<Favourite> favouriteList = randomExpensesFromJson(favourite);
      if (favouriteList.isEmpty) {
        // print(favouriteList.name);
        // print(favouriteList.ref);
        // print(favouriteList.url);
        // print(favouriteList.toList());
        // print('Favourite local is empty ${favouriteList.isEmpty}');
      } else {
        for (var favouriteList in favouriteList) {
          lst.add(favouriteList);
        }
        print(lst.toList());
      }
    } else {
      print('local Favourite local is empty ${favourite == null}');
    }
  }

  add(Favourite favourite) async {
    print(
        "_favourite ref ${favourite.ref} url ${favourite.url} name ${favourite.name}");
    bool isSaved = lst.any((item) => item.name == favourite.name);
    print("exist: $isSaved");
    if (!isSaved) {
      // _favourite.isSelected=false;

      lst.add(Favourite(
          name: favourite.name, url: favourite.url, isSelected: true));

      // get length where name !=Mrec
      if (adsApplovinCtrl.isMultiple(length())) {
        lst.add(Favourite(
            name: "Mrec",
            url: getRandomString(15),
            isSelected: true,
            ref: null));
      }
    }
    saveData(lst);
    // await adsApplovinCtrl.interstitialAdShowing();
    // getData().then((value) => print("save data url ${value.last.url}"));
    // prefs.setString(AppConst.listNotification, jsonEncode(lst.toList()));
  }

  delete(Favourite favourite, bool isHome) async {
    final prefs = await SharedPreferences.getInstance();

    deleteMerc(favourite);
    lst.removeWhere((element) => element.url == favourite.url);
    print("============================lst.toList() delete");
    print(lst.toList());
    saveData(lst);
    print(prefs.getString(AppConst.listNotification));
  }

  deleteMerc(Favourite favourite) async {
    int index = lst.indexWhere((element) =>
        element.url == favourite.url && element.name == favourite.name);
    int indexing = index + 1;
    if (indexing == -1) {
      indexing = index + 1;
    }
    if (indexing != -1 && lst.length != 1) {
      var indexElement = lst.elementAt((indexing));
      if (indexElement.name == "Mrec") {
        lst.removeAt(indexing);
      }
    }
    /* if(lst.length==1){
      lst.removeWhere((element) => element.name == "Mrec");
    }*/
  }

  // saveTodo(List<Favourite> favouriteList) async {
  //   print("============================saveTodo");
  //   final prefs = await SharedPreferences.getInstance();
  //    List  items = favouriteList.map((e) => e.toJson()).toList();
  //   print("items $items");
  //   // print("items ${Favourite().fromJson(favouriteList)}");
  //   prefs.setString(AppConst.listNotification,generateList(favouriteList));
  //   print("local data : ${prefs.getString(AppConst.listNotification)}");
  // }
  void saveData(List<Favourite> favouriteList) async {
    final prefs = await SharedPreferences.getInstance();
    print("save data ${randomExpensesToJson(favouriteList)}");
    prefs.setString(
        AppConst.listNotification, randomExpensesToJson(favouriteList));
  }

  void deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(
      AppConst.listNotification,
    );
  }

  int length() {
    int length = lst.where((element) => element.name != 'Mrec').length;
    return length;
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  Future<List<Favourite>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    String keyString = prefs.getString(AppConst.listNotification) ?? "";
    return keyString.isNotEmpty
        ? Future.value(randomExpensesFromJson(keyString))
        : Future.value([]);
  }

  String randomExpensesToJson(List<Favourite> favouriteList) =>
      json.encode(List<dynamic>.from(favouriteList.map((x) => x.toJson())));

  List<Favourite> randomExpensesFromJson(String str) =>
      List<Favourite>.from(json.decode(str).map((x) => Favourite.fromJson(x)));
}
