import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_const.dart';
import '../../core/common/app_icon.dart';
import '../../controller/change_post_ctr.dart';
import '../../controller/favourite_ctr.dart';
import '../../core/common/color.dart';
import '../../route.dart';
import '../applovinmx/Widget/banner.dart';

class SelectPostPage extends StatefulWidget {
  const SelectPostPage({Key? key}) : super(key: key);

  @override
  State<SelectPostPage> createState() => _SelectPostPageState();
}

class _SelectPostPageState extends State<SelectPostPage> {
  TutorialCoachMark? tutorialCoachMark;
  GlobalKey keyBottomNavigation1 = GlobalKey();

  @override
  void initState() {
    createTutorial();
    Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  @override
  void dispose() {
    tutorialCoachMark?.finish();
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorChanged.secondaryColor,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            // floatingActionButton: Padding(
            //   padding: const EdgeInsets.only(bottom: 12),
            //   child: FloatingActionButton(
            //     elevation: 0.0,
            //     backgroundColor: AppColor.primaryColor,
            //     onPressed: () {
            //       Navigator.pushNamed(context, NavigatorRoutes.homePage);
            //     },
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(50.w),
            //     ),
            //     child: Icon(
            //       Icons.home,
            //       size: 28.w,
            //       color: AppColor.tertiaryColor,
            //     ),
            //   ),
            // ),
            bottomNavigationBar: widgetBanner(),
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              leading: IconButton(
                icon: SvgPicture.asset(
                  AppIcon.back,
                  width: 35.w,
                  height: 35.w,
                  color: ColorChanged.tertiaryColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: ColorChanged.primaryColor,
              title: const Text(
                'Select Post',
                style: TextStyle(
                  color: ColorChanged.tertiaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // fontFamily: AppFont.JollyGood
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GetBuilder<AddToFavourite>(builder: (_Favourite) {
                    return InkWell(
                        child: SvgPicture.asset(
                          !_Favourite.isLayoutOne
                              ? AppIcon.layoutOne
                              : AppIcon.layoutTwo,
                          width: 25,
                          height: 24,
                          color: ColorChanged.tertiaryColor,
                        ),
                        onTap: () {
                          _Favourite.isLayoutOne = !_Favourite.isLayoutOne;
                          _Favourite.selectLayLoading(
                              isOne: _Favourite.isLayoutOne);
                          _Favourite.update();
                        });
                  }),
                ),
              ],
              //save change button
              centerTitle: true,
              elevation: 0,
            ),
            //list posts and validation
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: GetBuilder<AddToFavourite>(builder: (addToFavourit) {
                  return GetBuilder<ChangePostCtr>(builder: (_changePostCtr) {
                    var postd = addToFavourit.isLayoutOne
                        ? _changePostCtr.posts
                        : _changePostCtr.layouts;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 24.0, top: 18, bottom: 8),
                          child: Text(
                            'Please select Post :',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorChanged.tertiaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              // fontFamily: AppFont.JollyGood
                            ),
                          ),
                        ),
                        ListView.builder(
                            itemCount: postd.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final post = postd[index];
                              // controller.lst[index] =
                              //     addresses[index];
                              return Center(
                                child: InkWell(
                                  key: index == 1
                                      ? keyBottomNavigation1
                                      : GlobalKey(),
                                  onTap: () {
                                    _changePostCtr.idPost = index;
                                    _changePostCtr.selectPost(index);
                                    _changePostCtr.getPost();
                                    _changePostCtr.update();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(4.0),
                                    constraints: const BoxConstraints(
                                      maxHeight: double.infinity,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _changePostCtr.idPost == index
                                          ? ColorChanged.selectedBlue
                                          : ColorChanged.unselectedBlue
                                              .withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.03),
                                    ),

                                    //change color select objet
                                    height: addToFavourit.isLayoutOne
                                        ? ScreenUtil().screenHeight / 2.9
                                        : ScreenUtil().screenHeight / 3.5,
                                    width: addToFavourit.isLayoutOne
                                        ? ScreenUtil().screenWidth / 1.7
                                        : ScreenUtil().screenWidth,
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      children: <Widget>[
                                        /** Positioned WIdget **/
                                        Positioned(
                                            top: addToFavourit.isLayoutOne
                                                ? 17
                                                : 27,
                                            left: addToFavourit.isLayoutOne
                                                ? 10
                                                : 0,
                                            bottom: addToFavourit.isLayoutOne
                                                ? 10
                                                : 20,
                                            right: addToFavourit.isLayoutOne
                                                ? 10
                                                : 0,
                                            child:
                                                post //Icon //change post i have 3 posts
                                            ), //Positioned
                                        /** Positioned WIdget **/
                                        Positioned(
                                            top: 6,
                                            right: 2,
                                            child: Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                side: MaterialStateBorderSide
                                                    .resolveWith(
                                                  (states) => const BorderSide(
                                                      width: 1.5,
                                                      color: AppColor.blue),
                                                ),
                                                value: _changePostCtr.idPost ==
                                                        index
                                                    ? true
                                                    : false,
                                                activeColor:
                                                    ColorChanged.selectedBlue,
                                                onChanged: (bool? newValue) {
                                                  _changePostCtr.idPost = index;
                                                  _changePostCtr
                                                      .selectPost(index);
                                                  _changePostCtr.getPost();
                                                  _changePostCtr.update();
                                                })),
                                        Positioned(
                                            top: 4,
                                            left: 4,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 2),
                                              decoration: BoxDecoration(
                                                color: _changePostCtr
                                                    .getLayoutColor(index == 0
                                                        ? AppConst.Default
                                                        : AppConst.New)
                                                    ?.withOpacity(0.46),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Text(
                                                index == 0
                                                    ? AppConst.Default
                                                    : AppConst.New,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: _changePostCtr
                                                      .getLayoutColor(index == 0
                                                          ? AppConst.Default
                                                          : AppConst.New),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  // fontFamily:
                                                  //     AppFont.JollyGood
                                                ),
                                              ),
                                            )), //Positioned
                                      ], //<Widget>[]
                                    ),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: 50.h,
                        )
                      ],
                    );
                  });
                }))));
  }

  Future<void> showTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final values = prefs.getBool(AppConst.learnMe) ?? false;
    if (values == false) {
      tutorialCoachMark?.show(context: context);
    }
  }

  Future<void> createTutorial() async {
    final ChangePostCtr _changePostCtr = Get.find<ChangePostCtr>();
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
        onClickTarget: (target) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool(AppConst.learnMe, true);
          _changePostCtr.idPost = 1;
          _changePostCtr.selectPost(1);
          _changePostCtr.getPost();
          _changePostCtr.update();
          //     context, NavigatorRoutes.selectPostPage);
          Navigator.pushNamed(context, NavigatorRoutes.homePage);
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
          alignSkip: Alignment.topLeft,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: const [
                        Text(
                          AppConst.learnMe2,
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
