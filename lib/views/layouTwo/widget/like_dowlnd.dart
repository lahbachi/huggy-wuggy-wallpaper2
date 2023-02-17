import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../controller/favourite_ctr.dart';
import '../../../controller/imageView_ctr.dart';
import '../../../core/common/app_color.dart';
import '../../../core/common/app_icon.dart';
import '../../../core/common/color.dart';
import '../../../model/firebase_file.dart';
import '../../../widget/message_result/message_bar.dart';

Widget likeAndDownload({required BuildContext context,required Favourite lst,required bool isHome,required bool isTrans}){
  final AddToFavourite addToFavourite = Get.find<AddToFavourite>();
  final ImageCtrl imageCtrl = Get.find<ImageCtrl>();
  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();
    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    if (isLiked==false) {
      lst.isSelected = true;
      addToFavourite.add(lst);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(createSnackBar(
      //     message:
      //     "Congratulations This item has been successfully added to your favourites.",
      //     bgColors: Colors.green,
      //     txtColors: Colors.white,
      //     second: 1));
    } else{
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
  }
  return   Padding(
    padding: const EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 5),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: isTrans?ColorChanged.unselectedBlue.withOpacity(0.4):Colors.transparent,
            radius: 17,
            child: IconButton(
              icon: SvgPicture.asset(
                AppIcon.download,
                width: 17,
                height: 17,
                color: ColorChanged.tertiaryColor,
              ),
              onPressed: () async {
                await imageCtrl.download(url: lst.url!).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(createSnackBar(
                      message:
                      "This wallpaper in gallery has been successfully downloaded.",
                      bgColors: ColorChanged.primaryColor,
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
            backgroundColor: isTrans?ColorChanged.unselectedBlue.withOpacity(0.4):Colors.transparent,
            radius: 17,
            child: Padding(
              padding: const EdgeInsets.only(left: 3,top: 2.5),
              child: LikeButton(
                onTap: onLikeButtonTapped,
                isLiked: lst.isSelected,
                size: 20,
                circleColor: const CircleColor(start: Colors.red, end: Colors.white),
                bubblesColor: const BubblesColor(
                    dotPrimaryColor: Colors.red,
                    dotSecondaryColor: Colors.white),
                animationDuration: Duration(milliseconds: 1500),
                likeBuilder: (bool isLiked) {
                  return SvgPicture.asset(
                    isLiked ? AppIcon.favorite : AppIcon.favoriteBorder,
                    width: 17,
                    height: 17,
                    color: Colors.red,
                  );
                },
              ),
            ),
          ),
        ]),
  );
}