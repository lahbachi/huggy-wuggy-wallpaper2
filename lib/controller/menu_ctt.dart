import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/donate.dart';
import '../service/firebase/firebase_database_service.dart';

class MenuCtrl extends GetxController {
  // Rx<BoxFit> boxFit =  BoxFit.cover.obs;
  // RxBool isFitCover =  true.obs;
  RxString interstitialId = "".obs;
  RxString bannerId = "".obs;



  Future<List<Donate>> getDonate() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseApi.getUnitAd(methode: "donate");
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    //for a specific field
    // final allData1 = querySnapshot.docs.map((doc) => doc.get('Interstitialid')).toList();

    print("--------------------------------------------allData");
    print(jsonEncode(allData));
    // print(allData1);
    return donateFromJson(jsonEncode(allData));
  }
}
