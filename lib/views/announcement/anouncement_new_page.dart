import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/common/app_color.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/about_ctr.dart';
import '../../core/common/color.dart';
import '../../model/social_media.dart';
import '../../widget/loading/loading_custom.dart';

class AnnouncementNewPage extends StatefulWidget {
  const AnnouncementNewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnnouncementNewPageState();
  }
}

class _AnnouncementNewPageState extends State<AnnouncementNewPage> {
  final CarouselController _controller = CarouselController();
  final AboutCtrl controller = Get.find<AboutCtrl>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
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
                List<Widget> listAnnouncement = [];
                bool isEmpty = false;
                for (int i = 0; i < files.length; i++) {
                  if (files[i].active!) {
                    isEmpty = true;
                  }
                }
                for (var index = 0; index < files.length; index++) {
                  if (files[index].active!) {
                    listAnnouncement.add(Obx(() => (controller.countryCod.value ==
                                files[index].country ||
                            "ALL" == files[index].country)
                        ? GestureDetector(
                            onTap: () async {
                              await launchUrl(Uri.parse(files[index].url!));
                            },
                            child:Stack(
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
                            ),)
                        : const SizedBox()));
                  }
                }
                return (isEmpty && files.isNotEmpty)
                    ? GetBuilder<AboutCtrl>(builder: (_aboutCtrl) {
                        return Column(children: [
                          SizedBox(
                            height: 130.h,
                            width: ScreenUtil().screenWidth,
                            child: CarouselSlider(
                              items: listAnnouncement,
                              carouselController: _controller,
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 2.0,
                                  onPageChanged: (index, reason) {
                                    _aboutCtrl.current = index;
                                    _aboutCtrl.update();
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: files.asMap().entries.map((entry) {
                              return (entry.value.active ?? false)
                                  ? GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: !(_aboutCtrl.current == entry.key)
                                            ? 6.0
                                            : 7,
                                        height: !(_aboutCtrl.current == entry.key)
                                            ? 6.0
                                            : 7,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 6.0, horizontal: 2.5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              !(_aboutCtrl.current == entry.key)
                                                  ? Colors.black.withOpacity(0.5)
                                                  : ColorChanged.tertiaryColor,
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            }).toList(),
                          ),
                        ]);
                      })
                    : const SizedBox();
              }
          }
        },
      ),
    );
  }
}
