import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/common/app_config.dart';
import '../core/common/app_const.dart';
import '../model/social_media.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/image_services/image_service.dart';

class AboutCtrl extends GetxController {
  // Rx<BoxFit> boxFit =  BoxFit.cover.obs;
  // RxBool isFitCover =  true.obs;
  RxString interstitialId = "".obs;
  RxString bannerId = "".obs;
  RxString countryCod = "".obs;
  final _imageService = ImageService();
  int current = 0;
  String version = "";



  @override
  void onInit() async {
   await countryCode().then((value) {
     countryCod.value=value!;
   });
    print("----------------onInit1  ${ countryCod.value}");
    super.onInit();
  }

  Future<List<SocialMedia>> getSocialMedia({required String path}) async {
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection(path);
    print('thi is -----------------------------1');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  final data=jsonEncode(allData);
    print(jsonEncode(allData));
    print('thi is -----------------------------2');
    return socialMediaFromJson(data);
  }

  Future<String?> countryCode() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var countryCode = prefs.getString(AppConst.contactId);
      if(countryCode==null){
        return await _imageService.getCountryPhoneCode()
            .then((value) {
          prefs.setString(AppConst.contactId,value.countryCode!);
          print("srver---------------- ${value.countryCode}");
          countryCod.value=value.countryCode!;
          return value.countryCode;
        });
      }
      else{
        print("local---------------- $countryCode");
        countryCod.value=countryCode;
        return countryCode;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<String> packageInfoCompare()  async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String valid="";

    if(AppConfig.appPackageName!=packageName){
      valid+="packageName, ";
    }
    if(AppConfig.appName!=appName){
      valid+="appName, " ;
    }
    if(AppConfig.appVersion!=version){
      valid+="version, " ;
    }
    if(AppConfig.buildNumber!=buildNumber){
      valid+="buildNumber, " ;
    }

   return valid;
  }
  Future<String> getAppVersion()  async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    version='$version+$buildNumber';
    return version;
  }
  launchUrl(String url1) async {
    final url = url1;
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
  }
}
