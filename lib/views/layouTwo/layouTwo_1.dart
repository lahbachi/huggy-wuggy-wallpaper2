import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/controller/applovin_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/color.dart';
import '../../model/firebase_file.dart';
import '../../route.dart';
import 'widget/like_dowlnd.dart';

Widget layoutOne({required Favourite lst, required BuildContext context, required bool isHome}){

 // final AdsUnitCtrl _adsUnitCtrl = Get.find<AdsUnitCtrl>();
  final AdsApplovinCtrl adsApplovinCtrl = Get.find<AdsApplovinCtrl>();

/*  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();
    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    if (isLiked==false) {
      lst.isSelected = true;
      _addToFavourite.add(lst);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(createSnackBar(
      //     message:
      //     "Congratulations This item has been successfully added to your favourites.",
      //     bgColors: Colors.green,
      //     txtColors: Colors.white,
      //     second: 1));
    } else{
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
     margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
          color: ColorChanged.primaryColor,
          borderRadius:  BorderRadius.only(
            topRight: Radius.circular(19.82.w),
            bottomRight: Radius.circular(19.82.w),
            topLeft:Radius.circular(19.82.w),
            bottomLeft: Radius.circular(19.82.w),
          ),
          boxShadow: [
            BoxShadow(color: ColorChanged.tertiaryColor, spreadRadius: 0.9.w)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              await adsApplovinCtrl.interstitialAdShowing();
              Navigator.pushNamed(context, NavigatorRoutes.imagePage,
                  arguments:
                  ImagePageArguments(favourite: lst));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19.82.w),
                bottomLeft: Radius.circular(19.82.w),
              ),
            //  borderRadius: BorderRadius.circular(19.82.w),
              child: CachedNetworkImage(
                  height:ScreenUtil().screenHeight,
                  width: ScreenUtil().screenWidth/2.1,
                  imageUrl: lst.url!,
                  placeholder: (context, url) => Container(
                    color: Color(0xfff5f8fd),
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          likeAndDownload(context: context, lst: lst, isHome: isHome, isTrans: false)
       /*   Padding(
            padding: const EdgeInsets.only(right: 15.0,bottom: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // !lst[index].isSelected
                  //     ? Center(
                  //       child: IconButton(
                  //           iconSize: 1,
                  //           icon: SvgPicture.asset(
                  //             AppIcon.favoriteBorder,
                  //             width: 13.w,
                  //             height: 13.w,
                  //             color: Colors.red,
                  //           ),
                  //           onPressed: () {
                  //             setState(() {
                  //               lst[index].isSelected = true;
                  //               _addToFavourite.add(lst[index]);
                  //               ScaffoldMessenger.of(context)
                  //                   .showSnackBar(createSnackBar(
                  //                       message:
                  //                           "Congratulations This item has been successfully added to your favourites.",
                  //                       bgColors: Colors.green,
                  //                       txtColors: Colors.white,
                  //                       second: 1));
                  //             });
                  //           },
                  //         ),
                  //     )
                  //     : IconButton(
                  //         icon: SvgPicture.asset(
                  //           AppIcon.favorite,
                  //           width: 13.w,
                  //           height: 13.w,
                  //           color: Colors.red,
                  //         ),
                  //         onPressed: () {
                  //           setState(() {
                  //             lst[index].isSelected = false;
                  //             _addToFavourite.delete(lst[index]);
                  //             ScaffoldMessenger.of(context)
                  //                 .showSnackBar(createSnackBar(
                  //                     message:
                  //                         "This item has been successfully removed to your favourites.",
                  //                     bgColors: Colors.red,
                  //                     txtColors: Colors.white,
                  //                     second: 1));
                  //           });
                  //         },
                  //       ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppIcon.download,
                      width: 23,
                      height: 23,
                      color: AppColor.tertiaryColor,
                    ),
                    onPressed: () async {
                      await _imageCtrl.download(url: lst.url!).then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                            createSnackBar(
                                message: "This wallpaper in gallery has been successfully downloaded.",
                                bgColors: AppColor.primaryColor,
                                txtColors: Colors.white,
                                second: 2)
                        );
                      }).catchError((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                            createSnackBar(
                                message: "download is failed.",
                                bgColors: Colors.red,
                                txtColors: Colors.white,
                                second: 2)
                        );
                      });
                    },
                  ),
                  SizedBox(width: 25.w,),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: LikeButton(
                      onTap:onLikeButtonTapped ,
                      isLiked:lst.isSelected ,
                      size: 22,
                      circleColor:
                      const CircleColor(start: Colors.red, end: Colors.white),
                      bubblesColor: const BubblesColor(
                          dotPrimaryColor:  Colors.red,
                          dotSecondaryColor: Colors.white
                      ),
                      animationDuration: Duration(milliseconds:1500),
                      likeBuilder: (bool isLiked) {
                        return SvgPicture.asset(
                          isLiked? AppIcon.favorite:AppIcon.favoriteBorder,
                          width: 23,
                          height: 23,
                          color: Colors.red,
                        );

                      },
                    ),
                  ),
                ]),
          )*/
        ],
      ),
    ),
 );
}