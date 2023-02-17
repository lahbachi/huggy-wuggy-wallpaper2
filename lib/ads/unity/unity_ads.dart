import 'package:huggy_wuggy_wallpaper/core/common/app_config.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class UnityAdsManager {
  void init(String gameId) {
    UnityAds.init(
      gameId: gameId, //4271749
      testMode: AppConfig.unityTest,
    );
  }

  void showRewardedVideoAd(String idRV) {
    UnityAds.showVideoAd(
      placementId: idRV,
      //"rewardedVideo"
      // listener: (state, args) =>
      //     print('Interstitial Video Listener: $state => $args'),
    );
  }

  UnityBannerAd nativeAd(String idBanner) {
    return UnityBannerAd(
      placementId: idBanner,
      onLoad: (placementId) => print('Banner loaded: $placementId'),
      onClick: (placementId) => print('Banner clicked: $placementId'),
      onFailed: (placementId, error, message) =>
          print('Banner Ad $placementId failed: $error $message'),
    );
  }
}
