import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/common/app_config.dart';
import '../../core/common/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../core/common/app_color.dart';
import '../../core/common/color.dart';
import '../../model/firebase_file.dart';
import '../../service/firebase/firebase_database_service.dart';
import '../../views/announcement/announcement_page.dart';
import '../../views/picture/picture_page.dart';
import '../../core/common/app_icon.dart';
import '../../route.dart';
import '../announcement/anouncement_new_page.dart';
import '../gameAd/sponsoreGame.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.contextHome}) : super(key: key);
  final BuildContext contextHome;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Favourite>> futureFavourites;

//  final CoachMeCtr _coachMeCtr = Get.find<CoachMeCtr>();
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyBottomNavigation1 = GlobalKey();

  // final AdsUnitCtrl _adsUnitCtrl = Get.find<AdsUnitCtrl>();
  @override
  void initState()  {
    futureFavourites = FirebaseApi.listAll(AppConst.pathPictures);
    getData();
    // FirebaseApi.getUnitAd(methode: "admob").then(


    super.initState();
  }

  @override
  void dispose() {
    tutorialCoachMark.finish();
    super.dispose();
    //...
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseApi.getUnitAd(methode: "adsUnit");

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    //for a specific field
    // final allData1 = querySnapshot.docs.map((doc) => doc.get('Interstitialid')).toList();
    await createTutorial();
    await showTutorial();
    print("--------------------------------------------allData");
    print(jsonEncode(allData));
    // print(allData1);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      // color: AppColor.greyLight,
      color: ColorChanged.secondaryColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppConfig.announcementOne
                ? const AnnouncementNewPage()
                : const AnnouncementPage(),
            //   Container(color:Colors.red,child: _adsUnitCtrl.showBannerAd(),),
            const SponsoredAdsView(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '# ALL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorChanged.tertiaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      // fontFamily: AppFont.JollyGood
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, NavigatorRoutes.selectPostPage);
                    },
                    child: Container(
                      key: keyBottomNavigation1,
                      padding: const EdgeInsets.only(
                          left: 10, right: 12, top: 4, bottom: 2),
                      decoration: BoxDecoration(
                        color: ColorChanged.tertiaryColor,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: SvgPicture.asset(
                              AppIcon.edit,
                              width: 13,
                              height: 13,
                              color: ColorChanged.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          const Text(
                            'Change',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorChanged.primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              // fontFamily: AppFont.JollyGood
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            PicturePage(
              futureFavourite: futureFavourites,
              isFavorite: false,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final values = prefs.getBool(AppConst.learnMe) ?? false;
    if (values == false) {
      tutorialCoachMark.show(context: widget.contextHome);
    }
  }

  Future<void> createTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final values = prefs.getBool(AppConst.learnMe) ?? false;
    if (values == false) {
      tutorialCoachMark = TutorialCoachMark(
        targets: _createTargets(),
        colorShadow: ColorChanged.primaryColor,
        textSkip: "SKIP",
        paddingFocus: 10,
        opacityShadow: 0.8,
        onFinish: () async {
          // await Navigator.pushNamed(context, NavigatorRoutes.selectPostPage);
          // print("finish");
        },
        onClickTarget: (target) {
          Navigator.pushNamed(context, NavigatorRoutes.selectPostPage);
          print('onClickTarget: $target');
        },
        onClickTargetWithTapPosition: (target, tapDetails) {
          print("target: $target");
          print(
              "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
        },
        onClickOverlay: (target) {
          print('onClickOverlay: $target');
        },
        onSkip: () async {
          // await Navigator.pushNamed(
          //     context, NavigatorRoutes.selectPostPage);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool(AppConst.learnMe, true);
          print("skip");
        },
      );
    }
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
          identify: "keyBottomNavigation1",
          keyTarget: keyBottomNavigation1,
          alignSkip: Alignment.topRight,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                           AppConst.learnMe1,
                            style: TextStyle(
                              color: ColorChanged.tertiaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              // fontFamily: AppFont.JollyGood
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          shape: ShapeLightFocus.RRect,
          radius: 10),
    );
    return targets;
  }
}
