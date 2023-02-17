import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/favourite_ctr.dart';
import '../../core/common/app_config.dart';
import '../../core/common/color.dart';
import '../../widget/items/items_list.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/about_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/app_style.dart';
import '../../model/social_media.dart';
import '../../route.dart';
import '../applovinmx/Widget/banner.dart';

class AboutView extends GetView<AboutCtrl> {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
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
      bottomNavigationBar: widgetBanner(),
      // bottomNavigationBar:admobact==false? UnityAdsManager.bannerAd(bannerid):Container(width: 0,height: 0,),
      backgroundColor: ColorChanged.secondaryColor,
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
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              AppIcon.about,
              width: 22.w,
              height: 22.w,
              color: ColorChanged.tertiaryColor,
            ),
            onPressed: () {
              final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
              _addToFavourite.privatePolicy();
            },
          )
        ],
        backgroundColor: ColorChanged.primaryColor,
        title: const Text(
          "About",
          style: TextStyle(
            //  color: Colors.white,
            color: ColorChanged.tertiaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            // fontFamily: AppFont.JollyGood
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<List<SocialMedia>>(
                future: controller.getSocialMedia(path: 'socail'),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.data!.isEmpty) {
                        return Center(
                            child: emptyList(
                                title: "No Social Media Yet!",
                                description: "",
                                isClick: false));
                      }
                      if (snapshot.hasError) {
                        print(snapshot.hasError);
                        return Center(
                            child: emptyList(
                                title: "Something Wrong!",
                                description: "",
                                isClick: false));
                      } else {
                        final socailMedia = snapshot.data!;
                        bool isnan = false;
                        socailMedia.forEach((element) {
                          print("element ---------------------");
                          isnan = (element.active ?? false);
                        });
                        return isnan
                            ? Container(
                                decoration: AppStyle.listShadowDecoration,
                                padding: const EdgeInsets.all(15.0),
                                width: ScreenUtil().screenWidth,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Social Media",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        //fontFamily: AppFont.JollyGood
                                      ),
                                    ),
                                    SizedBox(height: 17.h),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15),
                                      child: Wrap(
                                        spacing: 10.w,
                                        runSpacing: 15.h,
                                        children: [
                                          for (int index = 0;
                                              index < socailMedia.length;
                                              index++)
                                            socailMedia[index].active!
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.all(6.0.w),
                                                    child: socialMedia(
                                                      iconPath:
                                                          socailMedia[index]
                                                              .iconPath!,
                                                      color: _getColor(
                                                          socailMedia[index]
                                                              .name!),
                                                      url: socailMedia[index]
                                                          .url!,
                                                    ))
                                                : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox();
                      }
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: FutureBuilder<List<SocialMedia>>(
                        future: controller.getSocialMedia(path: 'moreApps'),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());
                            default:
                              if (snapshot.hasError) {
                                print(snapshot.hasError);
                                return const Center(
                                    child: Text('Some error occurred!'));
                              } else {
                                final moreApp = snapshot.data!;
                                bool isnan = false;
                                moreApp.forEach((element) {
                                  print("element ---------------------");
                                  isnan = (element.active ?? false);
                                });
                                return isnan
                                    ? Container(
                                        decoration:
                                            AppStyle.listShadowDecoration,
                                        padding: const EdgeInsets.all(15.0),
                                        width: ScreenUtil().screenWidth,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "More Apps",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                // fontFamily: AppFont.JollyGood
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                            Wrap(
                                              spacing: 45.w,
                                              runSpacing: 20.h,
                                              children: [
                                                for (int index = 0;
                                                    index < moreApp.length;
                                                    index++)
                                                  moreApp[index].active!
                                                      ? moreApps(
                                                          name: moreApp[index]
                                                              .name!,
                                                          iconPath:
                                                              moreApp[index]
                                                                  .iconPath!,
                                                          color: _getColor(
                                                              moreApp[index]
                                                                  .name!),
                                                          url: moreApp[index]
                                                              .url!,
                                                        )
                                                      : const SizedBox()
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox();
                              }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ]),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Privacy Policy",
                  description:
                      "${AppConfig.brandName} built the sad wallpaper app as a Free app. This SERVICE is provided by ${AppConfig.brandName} at no cost and is intended for use as is. This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at sad wallpaper unless otherwise defined in this Privacy Policy."),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Information Collection and Use",
                  description:
                      "For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way. The app does use third-party services that may collect information used to identify you. Link to the privacy policy of third-party service providers used by the app Google Play Services Facebook Unity"),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Service Providers",
                  description:
                      "I may employ third-party companies and individuals due to the following reasons: To facilitate our Service; To provide the Service on our behalf; To perform Service-related services; or To assist us in analyzing how our Service is used. I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose."),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Security",
                  description:
                      'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.'),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Links to Other Sites",
                  description:
                      'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.'),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Children’s Privacy",
                  description:
                      "These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions."),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Changes to This Privacy Policy",
                  description:
                      'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of 2022-05-03'),
              SizedBox(
                height: 10.h,
              ),
              blocText(
                  title: "Contact Us",
                  description:
                      'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at ${AppConfig.email}.'),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                AppConfig.brandName,
                style: TextStyle(
                  color: ColorChanged.tertiaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  //  fontFamily: AppFont.JollyGood
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget blocText({required String title, required String description}) {
    return Container(
        decoration: AppStyle.listShadowDecoration,
        padding: const EdgeInsets.all(15.0),
        width: ScreenUtil().screenWidth,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  //fontFamily: AppFont.JollyGood
                ),
              ),
              SizedBox(height: 13.h),
              Text(
                description,
                style: const TextStyle(
                  color: AppColor.grey,
                  fontSize: 13,
                  // fontFamily: AppFont.JollyGood
                ),
              ),
            ]));
  }

  Widget socialMedia(
      {required String iconPath, required Color color, required String url}) {
    return GestureDetector(
      onTap: () async {
        await launchUrl(Uri.parse(url));
      },
      child: Container(
        height: 65.0.w,
        width: 65.0.w,
        padding: const EdgeInsets.all(10.0),
        decoration: AppStyle.listShadowDecoration.copyWith(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: SvgPicture.asset(
          iconPath,
          color: ColorChanged.tertiaryColor,
        ),
      ),
    );
  }

  Widget moreApps(
      {required String iconPath,
      required Color color,
      required String url,
      required String name}) {
    return GestureDetector(
      onTap: () async {
        await launchUrl(Uri.parse(url));
      },
      child: Container(
        width: ScreenUtil().screenWidth / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(image: NetworkImage(iconPath))),
              child: SizedBox(
                height: 90.0.w,
                width: 90.0.w,
              ) /* add child content here */,
            ),
            SizedBox(height: 5.h),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                //fontFamily: AppFont.JollyGood
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getColor(String value) {
  switch (value) {
    case 'facebook':
      return AppColor.facebook;
    case 'telegram':
      return AppColor.telegram;
    case 'instagram':
      return AppColor.instagram;
    case 'twitter':
      return AppColor.twitter;
    case 'youtube':
      return AppColor.youtube;
    case 'discord':
      return AppColor.discord;
    case 'tiktok':
      return Colors.black;
    default:
      return ColorChanged.primaryColor;
  }
}
