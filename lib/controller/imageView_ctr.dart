import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../core/common/app_color.dart';
import '../core/common/app_icon.dart';
import '../core/common/color.dart';
import '../widget/message_result/message_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../service/image_services/image_service.dart';
import 'applovin_ctr.dart';

class ImageCtrl extends GetxController {
  Rx<BoxFit> boxFit = BoxFit.cover.obs;
  RxBool isFitCover = true.obs;
  RxBool isLoading = true.obs;
  ImageService imageService = ImageService();
  final AdsApplovinCtrl adsApplovinCtrl = Get.find<AdsApplovinCtrl>();

  Future<void> download({required String url}) async {
    try {
      await EasyLoading.show(
        status: 'downloading...',
        maskType: EasyLoadingMaskType.black,
      );

      final status = await Permission.storage.request();
      if (status.isGranted) {
        // Directory _path  = await getExternalStorageDirectory();
        //  String _localPath = _path.absolute.path + Platform.pathSeparator + 'ESPRS_Docs';
        var savedDir;
        if (Platform.isIOS) {
          savedDir = await getApplicationDocumentsDirectory();
        } else {
          savedDir = Directory('/storage/emulated/0/Download');
          // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
          // ignore: avoid_slow_async_io
          if (!await savedDir.exists()) {
            savedDir = await getExternalStorageDirectory();
          }
        }
        await savedDir.create(recursive: true).then((value) async {
          String? _downloadTaskId = await FlutterDownloader.enqueue(
            url: url,
            savedDir: savedDir.path,
            showNotification: true,
            saveInPublicStorage: true,
            openFileFromNotification: true,
            headers: {"auth": "Downloader"},
          );
          print('task: ------------------------- $_downloadTaskId');
        });
        await adsApplovinCtrl.interstitialAdShowing();
        EasyLoading.dismiss();
      } else {
        print("Permission deined");
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      throw (e.toString());
    }
  }

  SvgPicture sizeChangeIco(isFitCover) {
    if (isFitCover) {
      return SvgPicture.asset(
        AppIcon.collapse,
        width: 28.w,
        height: 28.w,
        color: ColorChanged.tertiaryColor,
      );
    } else {
      return SvgPicture.asset(
        AppIcon.expand,
        width: 28.w,
        height: 28.w,
        color: ColorChanged.tertiaryColor,
      );
    }
  }

  Future<dynamic> setApply(
      {required String url,
      required BuildContext context,
      required scaffoldKey}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                backgroundColor: ColorChanged.tertiaryColor,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Set As',
                      style: TextStyle(
                        color: ColorChanged.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        //  fontFamily: AppFont.JollyGood
                        // fontFamily: myfont
                      ),
                    ),
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorChanged.primaryColor, width: 1.5),
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                          ),
                          onPressed: () => Get.back(),
                          color: ColorChanged.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // actionsAlignment: MainAxisAlignment.end,
                // actions: [
                //
                // ],
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorChanged.primaryColor, width: 1.5),
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                      ),
                      child: ListTile(
                          title: const Text(
                            'Home And Lock Screen Wallpaper',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorChanged.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              // fontFamily: AppFont.JollyGood
                            ),
                          ),
                          onTap: () async {
                            Navigator.of(dialogContext).pop();
                            await EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await imageService
                                .setOnHomeANDLOckScreen(url: url)
                                .then((v) async {
                              await EasyLoading.dismiss();
                            }).catchError((v) async {
                              await EasyLoading.dismiss();
                            });
                            scaffoldKey.currentState.showSnackBar(createSnackBar(
                                message:
                                    "Congratulations This item has been successfully added to your Home And Lock Screen.",
                                bgColors: ColorChanged.primaryColor,
                                txtColors: Colors.white,
                                second: 2));
                            await adsApplovinCtrl.interstitialAdShowing();
                          }),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorChanged.primaryColor, width: 1.5),
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                      ),
                      child: ListTile(
                          title: const Text(
                            'Home Screen Wallpaper',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorChanged.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              //fontFamily: AppFont.JollyGood
                            ),
                          ),
                          onTap: () async {
                            Navigator.of(dialogContext).pop();
                            await EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await imageService
                                .setOnHomeScreen(url: url)
                                .then((v) async {
                              await EasyLoading.dismiss();
                            }).catchError((v) async {
                              await EasyLoading.dismiss();
                            });
                            scaffoldKey.currentState.showSnackBar(createSnackBar(
                                message:
                                    "Congratulations This item has been successfully added to your Home Screen.",
                                bgColors: ColorChanged.primaryColor,
                                txtColors: Colors.white,
                                second: 2));

                            await adsApplovinCtrl.interstitialAdShowing();
                          }),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorChanged.primaryColor, width: 1.5),
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                      ),
                      child: ListTile(
                          title: const Text(
                            'Lock Screen Wallpaper',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorChanged.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              //    fontFamily: AppFont.JollyGood
                            ),
                          ),
                          onTap: () async {
                            Navigator.of(dialogContext).pop();
                            await EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await imageService
                                .setOnLockScreen(url: url)
                                .then((v) async {
                              await EasyLoading.dismiss();
                            }).catchError((v) async {
                              await EasyLoading.dismiss();
                            });
                            scaffoldKey.currentState.showSnackBar(
                                createSnackBar(
                                    message:
                                        "Congratulations This item has been successfully added to your Lock Screen.",
                                    bgColors: ColorChanged.primaryColor,
                                    txtColors: Colors.white,
                                    second: 2)
                                //Congratulations This item has been successfully added to your Lock Screen.
                                );
                            await adsApplovinCtrl.interstitialAdShowing();
                          }),
                    ),
                  ],
                ),
              );
            });
      });
      // print('RESULT :: $result');
    } on PlatformException {
      // result = 'Failed to get wallpaper.';
    }
  }
// return    (isFitCover)
// ? sizeChangeIcon =Icon(
// Icons.fullscreen_exit,
// color: Colors.white,
// )
//     :sizeChangeIcon= Icon(
// Icons.fullscreen,
// color: Colors.white,
// );
}
