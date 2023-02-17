import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/applovin_ctr.dart';

Widget widgetBanner() {
  return GetBuilder<AdsApplovinCtrl>(
      builder: (aplController) => aplController.bannerShowing());
}
