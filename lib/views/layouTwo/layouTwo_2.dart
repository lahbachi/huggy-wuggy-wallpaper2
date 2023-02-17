import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/applovin_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/color.dart';
import '../../model/firebase_file.dart';
import '../../route.dart';
import 'widget/like_dowlnd.dart';

Widget layoutTwo({required Favourite lst, required BuildContext context,required bool isHome}) {
 // final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
 // final AdsUnitCtrl _adsUnitCtrl = Get.find<AdsUnitCtrl>();
 // final ImageCtrl _imageCtrl = Get.find<ImageCtrl>();
  final AdsApplovinCtrl adsApplovinCtrl = Get.find<AdsApplovinCtrl>();
  /*Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    if (isLiked == false) {
      lst.isSelected = true;
      _addToFavourite.add(lst);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(createSnackBar(
      //     message:
      //     "Congratulations This item has been successfully added to your favourites.",
      //     bgColors: Colors.green,
      //     txtColors: Colors.white,
      //     second: 1));
    } else {
      lst.isSelected = false;
      _addToFavourite.delete(lst,isHome);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(createSnackBar(
      //     message:
      //     "This item has been successfully removed to your favourites.",
      //     bgColors: Colors.red,
      //     txtColors: Colors.white,
      //     second: 1));
    }
    _addToFavourite.update();
    print('******************************************* $isLiked');
    return !isLiked;
  }*/

  return InkWell(
    onTap: () async {
      await adsApplovinCtrl.interstitialAdShowing();
      Navigator.pushNamed(context, NavigatorRoutes.imagePage,
          arguments:
          ImagePageArguments(favourite: lst));
    },
    child: Container(
      height: 140.h,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: ColorChanged.primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(100),
          topLeft: Radius.circular(100),
          bottomLeft:  Radius.circular(100),
        ),
         ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              await adsApplovinCtrl.interstitialAdShowing();
              Navigator.pushNamed(context, NavigatorRoutes.imagePage,
                  arguments: ImagePageArguments(favourite: lst));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: ColorChanged.primaryColor,
                    borderRadius: BorderRadius.circular(27.03),
                    boxShadow: [
                      BoxShadow(color: ColorChanged.tertiaryColor, spreadRadius: 0.9.w)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.w),
                  child: CachedNetworkImage(
                      height: 140.h,
                      width: ScreenUtil().screenWidth/2.1,
                      imageUrl: lst.url!,
                      placeholder: (context, url) => Container(
                            color: Color(0xfff5f8fd),
                          ),
                      fit: BoxFit.cover),
                )
                ),
          ),
          likeAndDownload(context: context, lst: lst, isHome: isHome, isTrans: true)
        /*  Padding(
            padding: const EdgeInsets.only(left: 15,right: 22,top: 7),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.unselectedBlue.withOpacity(0.4),
                    radius: 19,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        AppIcon.download,
                        width: 18.w,
                        height: 18.w,
                        color: AppColor.tertiaryColor,
                      ),
                      onPressed: () async {
                        await _imageCtrl.download(url: lst.url!).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(createSnackBar(
                              message:
                              "This wallpaper in gallery has been successfully downloaded.",
                              bgColors: AppColor.primaryColor,
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
                  SizedBox(width: 40.w,),
                  CircleAvatar(
                    backgroundColor: AppColor.unselectedBlue.withOpacity(0.4),
                    radius: 19,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3,top: 2.5),
                      child: LikeButton(
                        onTap: onLikeButtonTapped,
                        isLiked: lst.isSelected,
                        size: 21,
                        circleColor: CircleColor(start: Colors.red, end: Colors.white),
                        bubblesColor: BubblesColor(
                            dotPrimaryColor: Colors.red,
                            dotSecondaryColor: Colors.white),
                        animationDuration: Duration(milliseconds: 1500),
                        likeBuilder: (bool isLiked) {
                          return SvgPicture.asset(
                            isLiked ? AppIcon.favorite : AppIcon.favoriteBorder,
                            width: 21.w,
                            height: 21.w,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                ]),
          )*/
        ],
      ),
    ),
  );
}
