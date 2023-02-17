import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../ads/admob/admob.dart';
import '../../ads/fan/fan.dart';
import '../../ads/unity/unity_ads.dart';
import '../../controller/adsUnit_ctr.dart';
import '../../model/ads_unit.dart';



final AdsUnitCtrl _adsUnitCtrl = Get.find<AdsUnitCtrl>();
UnityAdsManager unityAdsManager = UnityAdsManager();
AdmobHelper admobHelper = AdmobHelper();

Widget getBanner() {
  return FutureBuilder<List<AdsUnit>>(
    future: _adsUnitCtrl.getAdsData(), // async work
    builder: (BuildContext context, AsyncSnapshot<List<AdsUnit>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Text('Loading....');
        default:
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final adsUnit = snapshot.data!;
            return ListView.builder(
                // the number of items in the list
                itemCount: adsUnit.length,
                shrinkWrap: true,
                // display each item of the product list
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      adsUnit[index].facebookAN!.active == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                height: 60.h,
                                child: FANManager.showBannerAd(
                                    bannerId: adsUnit[index].facebookAN!.bannerid!),
                              ),
                            )
                          : const SizedBox(),
                      adsUnit[index].admob!.active == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                height: 60.h,
                                child: FANManager.showBannerAd(
                                    bannerId: adsUnit[index].admob!.bannerid!),
                              ),
                            )
                          : const SizedBox(),
                      adsUnit[index].unityad!.active == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                height: 60.h,
                                child: unityAdsManager.nativeAd(
                                    adsUnit[index].unityad!.bannerid!),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                });
          }
      }
    },
  );
}
