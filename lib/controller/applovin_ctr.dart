import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:applovin_max/applovin_max.dart';

import 'adsUnit_ctr.dart';

enum AdLoadState { notLoaded, loading, loaded }

class AdsApplovinCtrl extends GetxController {
  String sdkKey ="";
  String interstitialAdUnitId = "";
  String rewardedAdUnitId = "";
  String bannerAdUnitId = "";
  String mrecAdUnitId = "";
  var isInitialized = false;
  var interstitialLoadState = AdLoadState.notLoaded;
  var interstitialRetryAttempt = 0;
  var rewardedAdLoadState = AdLoadState.notLoaded;
  var rewardedAdRetryAttempt = 0;
  var isProgrammaticBannerCreated = false;
  var isWidgetMRecShowing = false;
  var isProgrammaticMRecCreated = false;
  var isProgrammaticMRecShowing = false;
  var statusText = "";
  AdsUnitCtrl adsUnitCtrl = Get.find<AdsUnitCtrl>();
  @override
  void onInit() async {
    //initializePlugin();
    super.onInit();
  }

  Future<void> initializePlugin() async {
    logStatus("Initializing SDK...");
    await adsUnitCtrl.getAdsData().then((v) {
      for (var ads in v) {
        if (ads.applovin?.active??false) {
          sdkKey=ads.applovin?.sdkKey??"";
          interstitialAdUnitId= ads.applovin?.interstitialAdUnitId??"";
          bannerAdUnitId=ads.applovin?.bannerAdUnitId??"";
          rewardedAdUnitId=ads.applovin?.rewardedAdUnitId??"";
          mrecAdUnitId=ads.applovin?.mrecAdUnitId??"";
          update();
          print('applovin');
        }
      }
    }).catchError((value) => print(value));
    Map? configuration = await AppLovinMAX.initialize(sdkKey);
    if (configuration != null) {
      isInitialized = true;

      logStatus("SDK Initialized: $configuration");
      attachAdListeners();
    }
    isInitialized;
    update();
  }

  ///start interstitial
  Future<void> interstitialAdShowing() async {
    if (isInitialized) {
      bool isReady =
          (await AppLovinMAX.isInterstitialReady(interstitialAdUnitId))!;
      if (isReady) {
        AppLovinMAX.showInterstitial(interstitialAdUnitId);
      } else {
        logStatus('Loading interstitial ad...');
        interstitialLoadState = AdLoadState.loading;
        AppLovinMAX.loadInterstitial(interstitialAdUnitId);
      }
      update();
    }
  }

  ///end interstitial
  ///start rewarded
  Future<void> rewardedAdShowing() async {
    if (isInitialized) {
      bool isReady = (await AppLovinMAX.isRewardedAdReady(rewardedAdUnitId))!;
      if (isReady) {
        AppLovinMAX.showRewardedAd(rewardedAdUnitId);
      } else {
        logStatus('Loading rewarded ad...');
        rewardedAdLoadState = AdLoadState.loading;
        AppLovinMAX.loadRewardedAd(rewardedAdUnitId);
      }
      update();
    }
  }

  ///end rewarded
  ///start banner
  void programmaticBannerShowing() {
    if (isInitialized) {
      if (!isProgrammaticBannerCreated) {
        //
        // Programmatic banner creation - banners are automatically sized to 320x50 on phones and 728x90 on tablets
        //
        AppLovinMAX.createBanner(bannerAdUnitId, AdViewPosition.bottomCenter);

        // Set banner background color to black - PLEASE USE HEX STRINGS ONLY
        AppLovinMAX.setBannerBackgroundColor(bannerAdUnitId, '#000000');

        isProgrammaticBannerCreated = true;
      }

      AppLovinMAX.showBanner(bannerAdUnitId);
      update();
    }
  }

  ///start banner
  void programmaticMRecShowing() {
    if (isInitialized) {
      if (!isProgrammaticMRecCreated) {
        AppLovinMAX.createMRec(mrecAdUnitId, AdViewPosition.bottomCenter);

        isProgrammaticMRecCreated = true;
      }
      AppLovinMAX.showMRec(mrecAdUnitId);
      update();
    }
  }

  void programmaticBannerHide() {
    if (isInitialized) {
      AppLovinMAX.hideBanner(bannerAdUnitId);
    }
  }

  void showMediationDebuggerTest() {
    if (isInitialized) {
      AppLovinMAX.showMediationDebugger();
    }
  }

  Widget bannerShowing() {
    return isInitialized
        ? MaxAdView(
            adUnitId: bannerAdUnitId,
            adFormat: AdFormat.banner,
            listener: AdViewAdListener(onAdLoadedCallback: (ad) {
              logStatus('Banner widget ad loaded from ${ad.networkName}');
            }, onAdLoadFailedCallback: (adUnitId, error) {
              logStatus(
                  'Banner widget ad failed to load with error code ${error.code} and message: ${error.message}');
            }, onAdClickedCallback: (ad) {
              logStatus('Banner widget ad clicked');
            }, onAdExpandedCallback: (ad) {
              logStatus('Banner widget ad expanded');
            }, onAdCollapsedCallback: (ad) {
              logStatus('Banner widget ad collapsed');
            }, onAdRevenuePaidCallback: (ad) {
              logStatus('Banner widget ad revenue paid: ${ad.revenue}');
            }))
        : const SizedBox();
  }

  ///end banner
  ///mrec start
  Widget mrecShowing() {
    return isInitialized
        ? MaxAdView(
            adUnitId: mrecAdUnitId,
            adFormat: AdFormat.mrec,
            listener: AdViewAdListener(onAdLoadedCallback: (ad) {
              logStatus('MREC widget ad loaded from ${ad.networkName}');
            }, onAdLoadFailedCallback: (adUnitId, error) {
              logStatus(
                  'MREC widget ad failed to load with error code ${error.code} and message: ${error.message}');
            }, onAdClickedCallback: (ad) {
              logStatus('MREC widget ad clicked');
            }, onAdExpandedCallback: (ad) {
              logStatus('MREC widget ad expanded');
            }, onAdCollapsedCallback: (ad) {
              logStatus('MREC widget ad collapsed');
            }, onAdRevenuePaidCallback: (ad) {
              logStatus('MREC widget ad revenue paid: ${ad.revenue}');
            }))
        : const SizedBox();
  }

  /// end mrec
  void attachAdListeners() {
    /// Interstitial Ad Listeners
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        interstitialLoadState = AdLoadState.loaded;

        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        logStatus('Interstitial ad loaded from ${ad.networkName}');

        // Reset retry attempt
        interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        interstitialLoadState = AdLoadState.notLoaded;

        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        interstitialRetryAttempt = interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, interstitialRetryAttempt)).toInt();
        logStatus(
            'Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(interstitialAdUnitId);
        });
      },
      onAdDisplayedCallback: (ad) {
        logStatus('Interstitial ad displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        interstitialLoadState = AdLoadState.notLoaded;
        logStatus(
            'Interstitial ad failed to display with code ${error.code} and message ${error.message}');
      },
      onAdClickedCallback: (ad) {
        logStatus('Interstitial ad clicked');
      },
      onAdHiddenCallback: (ad) {
        interstitialLoadState = AdLoadState.notLoaded;
        logStatus('Interstitial ad hidden');
      },
      onAdRevenuePaidCallback: (ad) {
        logStatus('Interstitial ad revenue paid: ${ad.revenue}');
      },
    ));

    /// Rewarded Ad Listeners
    AppLovinMAX.setRewardedAdListener(
        RewardedAdListener(onAdLoadedCallback: (ad) {
      rewardedAdLoadState = AdLoadState.loaded;

      // Rewarded ad is ready to be shown. AppLovinMAX.isRewardedAdReady(_rewarded_ad_unit_id) will now return 'true'
      logStatus('Rewarded ad loaded from ${ad.networkName}');

      // Reset retry attempt
      rewardedAdRetryAttempt = 0;
    }, onAdLoadFailedCallback: (adUnitId, error) {
      rewardedAdLoadState = AdLoadState.notLoaded;

      // Rewarded ad failed to load
      // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
      rewardedAdRetryAttempt = rewardedAdRetryAttempt + 1;

      int retryDelay = pow(2, min(6, rewardedAdRetryAttempt)).toInt();
      logStatus(
          'Rewarded ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

      Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
        AppLovinMAX.loadRewardedAd(rewardedAdUnitId);
      });
    }, onAdDisplayedCallback: (ad) {
      logStatus('Rewarded ad displayed');
    }, onAdDisplayFailedCallback: (ad, error) {
      rewardedAdLoadState = AdLoadState.notLoaded;
      logStatus(
          'Rewarded ad failed to display with code ${error.code} and message ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('Rewarded ad clicked');
    }, onAdHiddenCallback: (ad) {
      rewardedAdLoadState = AdLoadState.notLoaded;
      logStatus('Rewarded ad hidden');
    }, onAdReceivedRewardCallback: (ad, reward) {
      logStatus('Rewarded ad granted reward');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('Rewarded ad revenue paid: ${ad.revenue}');
    }));

    /// Banner Ad Listeners
    AppLovinMAX.setBannerListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      logStatus('Banner ad loaded from ${ad.networkName}');
    }, onAdLoadFailedCallback: (adUnitId, error) {
      logStatus(
          'Banner ad failed to load with error code ${error.code} and message: ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('Banner ad clicked');
    }, onAdExpandedCallback: (ad) {
      logStatus('Banner ad expanded');
    }, onAdCollapsedCallback: (ad) {
      logStatus('Banner ad collapsed');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('Banner ad revenue paid: ${ad.revenue}');
    }));

    /// MREC Ad Listeners
    AppLovinMAX.setMRecListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      logStatus('MREC ad loaded from ${ad.networkName}');
    }, onAdLoadFailedCallback: (adUnitId, error) {
      logStatus(
          'MREC ad failed to load with error code ${error.code} and message: ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('MREC ad clicked');
    }, onAdExpandedCallback: (ad) {
      logStatus('MREC ad expanded');
    }, onAdCollapsedCallback: (ad) {
      logStatus('MREC ad collapsed');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('MREC ad revenue paid: ${ad.revenue}');
    }));
    update();
  }

  String getInterstitialButtonTitle() {
    if (interstitialLoadState == AdLoadState.notLoaded) {
      return "Load Interstitial";
    } else if (interstitialLoadState == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Interstitial"; // adLoadState.loaded
    }
  }

  String getRewardedButtonTitle() {
    if (rewardedAdLoadState == AdLoadState.notLoaded) {
      return "Load Rewarded Ad";
    } else if (rewardedAdLoadState == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Rewarded Ad"; // adLoadState.loaded
    }
  }

  String getWidgetMRecButtonTitle() {
    return isWidgetMRecShowing ? 'Hide Widget MREC' : 'Show Widget MREC';
  }

  void logStatus(String status) {
    /// ignore: avoid_print
    print(status);

    statusText = status;
    update();
  }
  //Todo : normalmont 8
  bool isMultiple(int index) {
    if ((index%2) == 0 &&index!=0) {
      return true;
    } else {
      return false;
    }
  }
}
