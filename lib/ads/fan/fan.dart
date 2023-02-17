
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class FANManager {

  String FB_INTERSTITIAL_AD_ID = "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617";
  bool isInterstitialAdLoaded = false;

  void loadInterstitialAd(String interstitialId) {
    FacebookInterstitialAd.loadInterstitialAd(
        placementId: interstitialId,
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED) {
            isInterstitialAdLoaded = true;
          }

          if (result == InterstitialAdResult.DISMISSED && value["invalidated"] == true) {
            isInterstitialAdLoaded = false;
            loadInterstitialAd(interstitialId);
          }
        });
  }
  showInterstitialAd() {
    if (isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
      print("Ad not loaded yet");
    }
  }
  static Widget loadBannerAd(String bannerId) {
    // setState(() {
      return FacebookBannerAd(
     //  placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047",
        placementId:bannerId,
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("$result == $value");
        },
      );
    // });
  }

  static Widget  showBannerAd({required String bannerId}) {
    return FacebookBannerAd(
      // placementId:  "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047",
      placementId: bannerId,
      keepAlive: true,
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value eee");
        switch (result) {
          case BannerAdResult.ERROR:
            print("Error: $value");
            break;
          case BannerAdResult.LOADED:
            print("Loaded: $value");
            break;
          case BannerAdResult.CLICKED:
            print("Clicked: $value");
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
            print("Logging Impression: $value");
            break;
        }
      },
    );
  }
}
