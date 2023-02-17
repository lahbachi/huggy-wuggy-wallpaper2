import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/about_ctr.dart';
import '../../core/common/app_color.dart';

import '../../core/common/app_icon.dart';
import '../../core/common/color.dart';
import '../../route.dart';
import '../../widget/menu_item/menu_items.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AboutCtrl aboutCtrl = Get.find<AboutCtrl>();
     aboutCtrl.getAppVersion().then((value) {
       aboutCtrl.version=value;
       aboutCtrl.update();
    } );
    return Drawer(
      child: Container(
        color: ColorChanged.secondaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15.h,
            ),
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: SizedBox(
                  height: 150.h,
                  width: ScreenUtil().screenWidth,
                  child: Image.asset(AppIcon.iconApp)),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(
              //       color: Colors.black,
              //     )),
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*   GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NavigatorRoutes.applovinView);
                    },
                    child: menuItem(
                      title: 'Test Ads',
                      icon: AppIcon.rate,
                    )),*/
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NavigatorRoutes.adGameOnlineView);
                    },
                    child: menuItem(
                      title: 'Play games',
                      icon: AppIcon.game,
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NavigatorRoutes.rateApp);
                    },
                    child: menuItem(
                      title: 'Rate us',
                      icon: AppIcon.rate,
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NavigatorRoutes.donation);
                    },
                    child: menuItem(
                      title: 'Donate',
                      icon: AppIcon.gift,
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, NavigatorRoutes.selectPostPage);
                    },
                    child: menuItem(
                      title: 'Change post',
                      icon: AppIcon.swap,
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, NavigatorRoutes.shareAppView);
                    },
                    child: menuItem(
                      title: 'Refer a friend',
                      icon: AppIcon.share,
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NavigatorRoutes.aboutView);
                    },
                    child: menuItem(
                      title: 'About',
                      icon: AppIcon.about,
                    )),
              ],
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40.h,
                width: ScreenUtil().screenWidth,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: ColorChanged.primaryColor,
                ),
                child:  GetBuilder<AboutCtrl>(builder: (_aboutCtrl) {
                    return Center(
                      child: Text(
                        'V ${ _aboutCtrl.version}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          // fontFamily: AppFont.JollyGood,
                          fontSize: 20,
                          color: ColorChanged.tertiaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
