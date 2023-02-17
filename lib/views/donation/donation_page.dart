import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/favourite_ctr.dart';
import '../../controller/menu_ctt.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/app_style.dart';
import '../../core/common/color.dart';
import '../../model/donate.dart';
import '../../widget/items/items_list.dart';
import '../../widget/message_result/message_bar.dart';

import '../../route.dart';

class DonationPage extends GetView<MenuCtrl> {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
    ///final AboutCtrl _aboutCtrl = Get.find<AboutCtrl>();
    return Scaffold(
        backgroundColor: ColorChanged.secondaryColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: ColorChanged.primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, NavigatorRoutes.homePage);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.w),
            ),
            child: const Icon(
              Icons.home,
              size: 30,
              color: ColorChanged.tertiaryColor,
            ),
          ),
        ),
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
            'Donate',
            style: TextStyle(
                color: ColorChanged.tertiaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              //  fontFamily: AppFont.JollyGood
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppIcon.donate,
                    height: 220.h,
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                // Text(
                //   "Paypal",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Color.fromRGBO(149,149,149,1),
                //     fontSize: 21,
                //   ),
                // ),
                const Text(
                  "Choose donation :",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorChanged.tertiaryColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      // fontFamily: AppFont.JollyGood
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder<List<Donate>>(
                  future: controller.getDonate(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          print(snapshot.hasError);
                          return Center(
                              child: emptyList(
                                  title: "Something Wrong!",
                                  description: "",
                                  isClick: false));
                        } else {
                          final donate = snapshot.data!;
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              // the number of items in the list
                              itemCount: donate.length,
                              shrinkWrap: true,
                              // display each item of the product list
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    donate[index].paypal!.name == "Paypal" &&
                                            donate[index].paypal!.active == true
                                        ? Column(
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  width:
                                                      ScreenUtil().screenWidth /
                                                          1.5,
                                                  height: 50.h,
                                                  child: ElevatedButton(
                                                    style: AppStyle
                                                        .flatButtonStyle,
                                                    onPressed: () {
                                                      launchUrl(Uri.parse(
                                                          donate[index]
                                                              .paypal!
                                                              .link!));
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text('Donate with ',
                                                            style: TextStyle(
                                                                color: AppColor
                                                                    .paypal1,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                // fontFamily: AppFont
                                                                //     .JollyGood
                                                            )),
                                                        Expanded(
                                                          child:
                                                              SvgPicture.asset(
                                                            AppIcon.paypal,
                                                            width: 32.w,
                                                            height: 32.h,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              or()
                                            ],
                                          )
                                        : const SizedBox(),
                                    // SizedBox(
                                    //   height: 16.h,
                                    // ),
                                    // Row(children: <Widget>[
                                    //   const Expanded(
                                    //       child: Divider(
                                    //         color: AppColor.primaryColor,
                                    //         thickness: 1,
                                    //       )),
                                    //   Padding(
                                    //     padding: EdgeInsets.all(6.0.w),
                                    //     child: Text("OR",
                                    //         style: TextStyle(
                                    //           color: AppColor.primaryColor,
                                    //           fontSize: 14.sp,
                                    //           fontFamily: AppFont.knicknack,
                                    //         )),
                                    //   ),
                                    //   const Expanded(
                                    //       child: Divider(
                                    //           color: AppColor.primaryColor, thickness: 1)),
                                    // ]),
                                    // SizedBox(
                                    //   height: 16.h,
                                    // ),
                                    donate[index].buyMeaCoffee!.name ==
                                                "buy me a coffee" &&
                                            donate[index]
                                                    .buyMeaCoffee!
                                                    .active ==
                                                true
                                        ? Column(
                                            children: [
                                              Center(
                                                child: ConstrainedBox(
                                                  constraints:
                                                      BoxConstraints.tightFor(
                                                          width: ScreenUtil()
                                                                  .screenWidth /
                                                              1.5,
                                                          height: 50.h),
                                                  child: ElevatedButton(
                                                    style: AppStyle
                                                        .flatButtonStyle
                                                        .copyWith(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppColor
                                                                  .bmcColor),
                                                    ),
                                                    onPressed: () {
                                                      launchUrl(Uri.parse(
                                                          donate[index]
                                                              .buyMeaCoffee!
                                                              .link!));
                                                    },
                                                    child: SvgPicture.asset(
                                                      AppIcon.bmcFull,
                                                      width: 110.w,
                                                      height: 36.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              or()
                                            ],
                                          )
                                        : const SizedBox(),
                                    // SizedBox(
                                    //   height: 16.h,
                                    // ),
                                    // Row(children: <Widget>[
                                    //   const Expanded(
                                    //       child: Divider(
                                    //         color: AppColor.primaryColor,
                                    //         thickness: 1,
                                    //       )),
                                    //   Padding(
                                    //     padding: EdgeInsets.all(6.0.w),
                                    //     child: Text("OR",
                                    //         style: TextStyle(
                                    //           color: AppColor.primaryColor,
                                    //           fontSize: 14.sp,
                                    //           fontFamily: AppFont.knicknack,
                                    //         )),
                                    //   ),
                                    //   const Expanded(
                                    //       child: Divider(
                                    //           color: AppColor.primaryColor, thickness: 1)),
                                    // ]),
                                    donate[index].crypto!.name == "crypto" &&
                                            donate[index].crypto!.active == true
                                        ? Column(
                                            children: [
                                              Container(
                                                  margin:
                                                      const EdgeInsets.all(5.0),
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  width:
                                                      ScreenUtil().screenWidth /
                                                          1.2,
                                                  height: 70.h,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.crypto
                                                          .withOpacity(0.35),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color:
                                                              AppColor.crypto)),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Donate by CryptoCurrency :",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: ColorChanged
                                                                  .primaryColor,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              // fontFamily: AppFont
                                                              //     .JollyGood
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              donate[index]
                                                                  .crypto!
                                                                  .link!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: ColorChanged
                                                                      .tertiaryColor,
                                                                  fontSize:
                                                                      12.sp,
                                                                  // fontFamily:
                                                                  //     AppFont
                                                                  //         .JollyGood
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              Clipboard.setData(ClipboardData(
                                                                      text: donate[
                                                                              index]
                                                                          .crypto!
                                                                          .link!))
                                                                  .then(
                                                                      (value) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(createSnackBar(
                                                                        message:
                                                                            "Copied: ${donate[index].crypto!.link!}",
                                                                        bgColors:ColorChanged.primaryColor,
                                                                        txtColors:
                                                                            Colors
                                                                                .white,
                                                                        second:
                                                                            2));
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.copy_sharp,
                                                              size: 19.w,
                                                              color: ColorChanged
                                                                  .tertiaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              or()
                                            ],
                                          )
                                        : const SizedBox(),
                                    (donate[index].paypal!.active == false &&
                                            donate[index].crypto!.active ==
                                                false &&
                                            donate[index]
                                                    .buyMeaCoffee!
                                                    .active ==
                                                false)
                                        ? SizedBox()
                                    // emptyList(
                                    //         title: "No donate Yet!",
                                    //         description:
                                    //             "We don't have any type donated now, we will try later.",
                                    //         isClick: false)
                                        : const SizedBox(),
                                  ],
                                );
                              });
                        }
                    }
                  },
                ),
                Center(
                  child: SizedBox(
                    width:
                    ScreenUtil().screenWidth /
                        1.5,
                    height: 50.h,
                    child: ElevatedButton(
                      style: AppStyle
                          .flatButtonStyle.copyWith(backgroundColor: MaterialStateProperty.all(AppColor.rateBg),),
                      onPressed: () {
                        _addToFavourite.rateUs();
                      },
                      child: Row(
                        mainAxisSize:
                        MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: <Widget>[
                          const Expanded(
                            child: Text('Rate Us',
                                style: TextStyle(
                                    color: AppColor
                                        .rateUs,
                                    fontSize: 25,
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                    // fontFamily: AppFont
                                    //     .JollyGood
                                )),
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              AppIcon.star,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 90.h,
                )
              ],
            ),
          ),
        ));
  }
}

Widget or() {
  return Column(
    children: [
      SizedBox(
        height: 14.h,
      ),
      Row(children: <Widget>[
        const Expanded(
            child: Divider(
          color: ColorChanged.primaryColor,
          thickness: 1,
        )),
        Padding(
          padding: EdgeInsets.all(6.0.w),
          child: Text("OR",
              style: TextStyle(
                  color: ColorChanged.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  // fontFamily: AppFont.JollyGood
              )),
        ),
        const Expanded(
            child: Divider(color: ColorChanged.primaryColor, thickness: 1)),
      ]),
      SizedBox(
        height: 16.h,
      ),
    ],
  );
}
