import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:get/get.dart';
import '../ads/admob/admob.dart';
import '../ads/fan/fan.dart';
import '../ads/unity/unity_ads.dart';
import '../model/ads_unit.dart';
import '../service/firebase/firebase_database_service.dart';

class AdsUnitCtrl extends GetxController {
  // Rx<BoxFit> boxFit =  BoxFit.cover.obs;
  // RxBool isFitCover =  true.obs;
  RxString interstitialId = "".obs;
  RxString bannerId = "".obs;
  AdmobHelper admobHelper = AdmobHelper();
  FANManager fANManager = FANManager();
  UnityAdsManager unityAdsManager = UnityAdsManager();


  @override
  void onClose() {
    super.onClose();
    admobHelper.interstitialAd?.dispose();
  }

  @override
  void onInit() async {
    print("call AdsUnitCtrl"); // this line not printing
    getAdsData().then((v) {
      for (var ads in v) {
         if (ads.admob!.active!) {
          interstitialId.value = ads.admob!.interstitialid!;
          bannerId.value = ads.admob!.bannerid!;
          admobHelper.createInterstitialAd(ads.admob!.interstitialid!);
          print('admob');
        } else if (ads.unityad!.active!) {
          interstitialId.value = ads.unityad!.interstitialid!;
          bannerId.value = ads.unityad!.bannerid!;
          unityAdsManager.init(ads.unityad!.initid!);
          print('unityad');
        } else if (ads.facebookAN!.active!) {
          interstitialId.value = ads.facebookAN!.interstitialid!;
          bannerId.value = ads.facebookAN!.bannerid!;
          FacebookAudienceNetwork.init(
              // testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
              );
          fANManager.loadInterstitialAd(ads.facebookAN!.interstitialid!);
          print('facebookAN');
        }
      }
      print('nothing');
      print(interstitialId);
      print(bannerId);
    }).catchError((value) => print(value));
    super.onInit();
  }

  Future<List<AdsUnit>> getAdsData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseApi.getUnitAd(methode: "adsUnit");

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    //for a specific field
    // final allData1 = querySnapshot.docs.map((doc) => doc.get('Interstitialid')).toList();

    print("--------------------------------------------allData");
    print(jsonEncode(allData));
    // print(allData1);
    return adsUnitFromJson(jsonEncode(allData));
  }

  showInterAd() {
    getAdsData().then((v) {
      for (var ads in v) {
        if (ads.admob!.active!) {
          admobHelper.showInterstitialAd(ads.admob!.interstitialid!);
          print('admob');
        } else if (ads.unityad!.active!) {
          unityAdsManager.showRewardedVideoAd(ads.unityad!.interstitialid!);
          print('unityad');
        } else if (ads.facebookAN!.active!) {
          fANManager.showInterstitialAd();
          print('facebookAN');
        }
      }
      print('nothing');
    }).catchError((value) => print(value));
  }
}
