import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/controller/applovin_ctr.dart';

import '../about_ctr.dart';
import '../adsUnit_ctr.dart';
import '../change_post_ctr.dart';
import '../favourite_ctr.dart';
import '../imageView_ctr.dart';
import '../menu_ctt.dart';
import '../notification_controller.dart';

class Binding extends Bindings {
  // dependence injection attach our class.
  @override
  void dependencies() {
    Get.lazyPut<AddToFavourite>(() => AddToFavourite());
    Get.lazyPut<ImageCtrl>(() => ImageCtrl());
    Get.lazyPut<AdsUnitCtrl>(() => AdsUnitCtrl());
    Get.lazyPut<MenuCtrl>(() => MenuCtrl());
    Get.lazyPut<AboutCtrl>(() => AboutCtrl());
    Get.lazyPut<ChangePostCtr>(() => ChangePostCtr());
    Get.lazyPut<AdsApplovinCtrl>(() => AdsApplovinCtrl());
    Get.lazyPut<NotificationController>(() => NotificationController());
    // Get.put<ImageCtrl>(ImageCtrl());
  }
}
