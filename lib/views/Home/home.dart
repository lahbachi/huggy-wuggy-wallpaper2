import 'dart:isolate';
import 'dart:ui';
import 'package:badges/badges.dart' as badge;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/controller/about_ctr.dart';
import '../../ads/admob/admob.dart';
import '../../ads/fan/fan.dart';
import '../../ads/unity/unity_ads.dart';
import '../../controller/favourite_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_config.dart';
import '../../core/common/app_const.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/color.dart';
import '../../views/menu/menu_page.dart';
import '../../views/picture/picture_page.dart';
import '../../views/posts/post_wallpaper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/notification_controller.dart';
import '../../widget/empty_state.dart';
import '../../widget/package_info_compare/compare_info.dart';
import '../applovinmx/Widget/banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
  final AboutCtrl _aboutCtrl = Get.find<AboutCtrl>();


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AdmobHelper admobHelper = AdmobHelper();
  FANManager fANManager = FANManager();
  UnityAdsManager unityAdsManager = UnityAdsManager();
  NotificationController notificationController = Get.find();
  final ReceivePort _port = ReceivePort();
  void privetPolicy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final values = prefs.getBool(AppConst.agree) ?? false;
    if (values == false) {
      await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: true,
        context: Get.context!,
        //builder: (_) => chooseAnCard(),s
        builder: (_) =>
            popupMessage(description: 'direct link', title: 'Privacy Policy'),
      ).then((value) async {
        await prefs.setBool(AppConst.agree, true);
      });
    }

  }
  void infoCompare() async {
    String isField = await _aboutCtrl.packageInfoCompare();
    if (isField.isNotEmpty) {
     await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: true,
        context: Get.context!,
        //builder: (_) => chooseAnCard(),s
        builder: (_) =>
            compareInfo(title: 'Field info is not correct: $isField'),
      );
    }

  }
  @override
  void initState()  {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("android ----------- ${android?.toMap()}");
      // final String largeIconPath = await _downloadAndSaveFile(android?.imageUrl?? 'https://via.placeholder.com/48x48', 'largeIcon');
      if (notification != null && android != null) {
        await notificationController.showNotificationsPlugin(
            notification: notification, android: android);
      }
    });
    FirebaseMessaging.onMessage.listen((event) async {
      // do something
      print("on Message: ${event.data}");
    });
    privetPolicy();
    infoCompare();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
         // bottomNavigationBar: getBanner(),
          bottomNavigationBar: widgetBanner(),
          key: _scaffoldKey,
          // backgroundColor: AppColor.greyLight,
          backgroundColor: ColorChanged.secondaryColor,
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: ColorChanged.tertiaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  icon: SvgPicture.asset(
                    AppIcon.fire,
                    width: 27,
                    height: 27,
                    // color: AppColor.fireColor,
                    color: ColorChanged.tertiaryColor,
                  ),
                ),
                Tab(
                  icon: Obx(
                    () => (badge.Badge(
                      position: badge.BadgePosition.topEnd(end: -10, top: -11),
                      //badgeColor: Colors.red,
                      badgeContent: Text(
                        _addToFavourite.length() > 9
                            ? "+9"
                            :   _addToFavourite.length().toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      child: SvgPicture.asset(
                        AppIcon.favorite,
                        width: 23,
                        height: 23,
                        color: ColorChanged.tertiaryColor,
                      ),
                    )),
                  ),
                ),
              ],
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            leading: IconButton(
              icon: SvgPicture.asset(
                AppIcon.menu,
                width: 18,
                height: 18,
                color: ColorChanged.tertiaryColor,
              ),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              // Navigator.pop(context),
              color: Colors.white,
            ),
            backgroundColor: ColorChanged.primaryColor,
            title:  Text(
              AppConfig.appName,
              style: const TextStyle(
                color: ColorChanged.tertiaryColor,
                fontSize: 21,
                fontWeight: FontWeight.bold,
                // fontFamily: AppFont.JollyGood
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 9.0),
                child: GetBuilder<AddToFavourite>(builder: (_Favourite) {
                  return InkWell(
                      child: SvgPicture.asset(
                        !_Favourite.isLayoutOne
                            ? AppIcon.layoutOne
                            : AppIcon.layoutTwo,
                        width: 25,
                        height: 25,
                        color: ColorChanged.tertiaryColor,
                      ),
                      onTap: () {
                        _Favourite.isLayoutOne = !_Favourite.isLayoutOne;
                        //   _addToFavourite.isItem.value=! _addToFavourite.isItem.value;
                        _Favourite.selectLayLoading(
                            isOne: _Favourite.isLayoutOne);
                        _Favourite.update();
                      });
                }),
              ),
            ],
            centerTitle: true,
            elevation: 0,
          ),
          drawer: const MenuPage(),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              MainPage(contextHome: context,),
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GetBuilder<AddToFavourite>(builder: (_addToFavourit) {
                        return _addToFavourit.lst.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 12, right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    _addToFavourite.lst.clear();
                                    _addToFavourite.deleteData();
                                    _addToFavourite.update();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: SvgPicture.asset(
                                          AppIcon.delete,
                                          width: 15,
                                          height: 15,
                                          color: ColorChanged.tertiaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      const Text(
                                        'CLEAR ALL',
                                        style: TextStyle(
                                          //  decoration: TextDecoration.underline,
                                          color: ColorChanged.tertiaryColor,
                                          fontWeight: FontWeight.w700,
                                          // fontFamily: AppFont.JollyGood,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox();
                      }),

                      PicturePage(
                        futureFavourite: _addToFavourite.getData(),
                        isFavorite: true,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
