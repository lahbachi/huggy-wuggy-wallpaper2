import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/common/app_color.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/about_ctr.dart';
import '../../core/common/color.dart';
import '../../model/social_media.dart';
import '../../widget/loading/loading_custom.dart';

class AnnouncementPage extends GetView<AboutCtrl> {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  final ChangePostCtr changePostCtr = Get.find<ChangePostCtr>();
    // String countryCode="";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder<List<SocialMedia>>(
        future: controller.getSocialMedia(path: "announcement"),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomWidget.roundedRectangular(
                  height: 160.h,
                  width: ScreenUtil().screenWidth / 1.05,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const SizedBox();
              } else {
                final files = snapshot.data!;
                bool isEmpty = false;
                for (int i = 0; i < files.length; i++) {
                  if (files[i].active!) {
                    isEmpty = true;
                  }
                }
                return files.isNotEmpty && isEmpty
                    ? SizedBox(
                        height: 140.h,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              print(
                                  "-----------------controller.countryCod.value");
                              print(controller.countryCod.value);
                              if (files[index].active!) {
                                return Obx(() => (controller.countryCod.value ==
                                            files[index].country ||
                                        "ALL" == files[index].country)
                                    ? GestureDetector(
                                        onTap: () async {
                                          await launchUrl(
                                              Uri.parse(files[index].url!));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(4.0),
                                          constraints: const BoxConstraints(
                                            maxHeight: double.infinity,
                                          ),
                                          //change color select objet
                                          width: ScreenUtil().screenWidth / 1.2,
                                          child: Stack(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            children: <Widget>[
                                              /** Positioned WIdget **/
                                              Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.all(4.0.w),
                                                    width: ScreenUtil()
                                                            .screenWidth /
                                                        1.2,
                                                    decoration: BoxDecoration(
                                                        color: Colors.purple,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: ColorChanged
                                                                  .tertiaryColor,
                                                              spreadRadius: 1.w)
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.h)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                files[index]
                                                                    .iconPath!),
                                                            fit: BoxFit.fill)),
                                                  ) //Icon //change post i have 3 posts
                                                  ),
                                              Positioned(
                                                  top: 11,
                                                  left: 11,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2,
                                                            right: 2,
                                                            top: 2),
                                                    decoration: BoxDecoration(
                                                      color: AppColor.adYellow
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: const Text(
                                                      "Ad",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        // fontFamily:
                                                        //     AppFont.JollyGood
                                                      ),
                                                    ),
                                                  )), //Positioned
                                            ], //<Widget>[]
                                          ),
                                        ),
                                      )
                                    : const SizedBox());
                              } else {
                                return const SizedBox();
                              }
                            }))
                    : const SizedBox();
              }
          }
        },
      ),
    );
  }
}
