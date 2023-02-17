import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/controller/applovin_ctr.dart';
import '../../controller/favourite_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/color.dart';
import '../../model/firebase_file.dart';
import '../../route.dart';
import '../layouTwo/widget/like_dowlnd.dart';

Widget postTwo({required Favourite lst, required BuildContext context,required int index, required bool isHome,}) {
  final AddToFavourite addToFavourite = Get.find<AddToFavourite>();
  //final AdsUnitCtrl adsUnitCtrl = Get.find<AdsUnitCtrl>();
  final AdsApplovinCtrl adsApplovinCtrl = Get.find<AdsApplovinCtrl>();
  //final ImageCtrl imageCtrl = Get.find<ImageCtrl>();
 /* Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    if (isLiked == false) {
      lst.isSelected = true;
      addToFavourite.add(lst);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(createSnackBar(
      //     message:
      //     "Congratulations This item has been successfully added to your favourites.",
      //     bgColors: Colors.green,
      //     txtColors: Colors.white,
      //     second: 1));
    } else {
      lst.isSelected = false;
      addToFavourite.delete(lst,isHome);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(createSnackBar(
      //     message:
      //     "This item has been successfully removed to your favourites.",
      //     bgColors: Colors.red,
      //     txtColors: Colors.white,
      //     second: 1));
    }
    addToFavourite.update();
    print('******************************************* $isLiked');
    return !isLiked;
  }*/

  return Obx(() =>InkWell(
    onTap: () async {
      await adsApplovinCtrl.interstitialAdShowing();
      Navigator.pushNamed(context, NavigatorRoutes.imagePage,
          arguments:
          ImagePageArguments(favourite: lst));
    },
    child: SizedBox(
      height: !addToFavourite.isItem.value ? (index % 2 + 1) * 190.h :190.h,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await adsApplovinCtrl.interstitialAdShowing();
              Navigator.pushNamed(context, NavigatorRoutes.imagePage,
                  arguments: ImagePageArguments(favourite: lst));
            },
            child: Container(
                margin: const EdgeInsets.only(left: 8,right: 8,top: 8),
                decoration: BoxDecoration(
                    color: ColorChanged.primaryColor,
                    borderRadius: BorderRadius.circular(27.03),
                    boxShadow: [
                      BoxShadow(color: ColorChanged.tertiaryColor, spreadRadius: 0.9.w)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.w),
                  child: CachedNetworkImage(
                      height: !addToFavourite.isItem.value ? (index % 2 + 1) * 140.h :155.h,
                      width: ScreenUtil().screenWidth,
                      imageUrl: lst.url!,
                      placeholder: (context, url) => Container(
                            color: Color(0xfff5f8fd),
                          ),
                      fit: BoxFit.cover),
                )
                ),
          ), likeAndDownload(context: context, lst: lst, isHome: isHome, isTrans: true)
      /*    Padding(
            padding: const EdgeInsets.only(left: 18,right: 18,top: 7),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.primaryColor.withOpacity(0.6),
                    radius: 14,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3,top: 2.5),
                      child: LikeButton(
                        onTap: onLikeButtonTapped,
                        isLiked: lst.isSelected,
                        size: 16,
                        circleColor: const CircleColor(start: Colors.red, end: Colors.white),
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: Colors.red,
                            dotSecondaryColor: Colors.white),
                        animationDuration: const Duration(milliseconds: 1500),
                        likeBuilder: (bool isLiked) {
                          return SvgPicture.asset(
                            isLiked ? AppIcon.favorite : AppIcon.favoriteBorder,
                            width: 14.w,
                            height: 14.w,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColor.primaryColor.withOpacity(0.6),
                    radius: 14,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        AppIcon.download,
                        width: 14.w,
                        height: 14.w,
                        color: AppColor.tertiaryColor,
                      ),
                      onPressed: () async {
                        await imageCtrl.download(url: lst.url!).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(createSnackBar(
                              message:
                                  "This wallpaper in gallery has been successfully downloaded.",
                              bgColors:  AppColor.primaryColor,
                              txtColors: Colors.white,
                              second: 2));
                        }).catchError((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              createSnackBar(
                                  message: "download is failed.",
                                  bgColors: Colors.red,
                                  txtColors: Colors.white,
                                  second: 2));
                        });
                      },
                    ),
                  ),
                ]),
          )*/
        ],
      ),
    ),
  ));
}
