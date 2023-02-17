import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/controller/applovin_ctr.dart';
import 'package:huggy_wuggy_wallpaper/core/common/app_const.dart';
import 'package:share_plus/share_plus.dart';
import '../../controller/favourite_ctr.dart';
import '../../controller/imageView_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_config.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/app_url.dart';
import '../../core/common/color.dart';
import '../../model/firebase_file.dart';
import '../../widget/message_result/message_bar.dart';
import '../applovinmx/Widget/banner.dart';

class ImagePage extends StatefulWidget {
  final Favourite favourite;

  const ImagePage({
    Key? key,
    required this.favourite,
  }) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
  final AdsApplovinCtrl adsApplovinCtrl = Get.find<AdsApplovinCtrl>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ImageCtrl _imageCtrl = Get.find<ImageCtrl>();
    return
        //   Scaffold(
        //   appBar: AppBar(
        //     title: Text(file.name),
        //     centerTitle: true,
        //     actions: [
        //       IconButton(
        //         icon: Icon(Icons.file_download),
        //         onPressed: () async {
        //           await imageService.downloadImage(url: file.url);
        //
        //           final snackBar = SnackBar(
        //             content: Text('Downloaded ${file.name}'),
        //           );
        //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //         },
        //       ),
        //
        //       const SizedBox(width: 12),
        //       IconButton(
        //         icon: Icon(Icons.colorize_sharp),
        //         onPressed: () async {
        //           await imageService.setOnHomeScreen(url: file.url);
        //
        //           final snackBar = SnackBar(
        //             content: Text('Downloaded ${file.name}'),
        //           );
        //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //         },
        //       ),
        //       const SizedBox(width: 12),
        //       IconButton(
        //         icon: Icon(Icons.lock),
        //         onPressed: () async {
        //           await imageService.setOnLockScreen(url: file.url);
        //
        //           final snackBar = SnackBar(
        //             content: Text('Downloaded ${file.name}'),
        //           );
        //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //         },
        //       ),
        //       const SizedBox(width: 12),
        //       IconButton(
        //         icon: Icon(Icons.align_vertical_top_sharp),
        //         onPressed: () async {
        //           await imageService.setOnHomeANDLOckScreen(url: file.url);
        //
        //           final snackBar = SnackBar(
        //             content: Text('Downloaded ${file.name}'),
        //           );
        //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //         },
        //       ),
        //     ],
        //   ),
        //   body: isImage
        //       ? Image.network(
        //           file.url,
        //           height: double.infinity,
        //           fit: BoxFit.cover,
        //         )
        //       : Center(
        //           child: Text(
        //             'Cannot be displayed',
        //             style: TextStyle(
        //                 fontSize: 20, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        // );
        SafeArea(
      child: ScaffoldMessenger(
      //  key: _scaffoldKey,
        child: Scaffold(
          bottomNavigationBar: widgetBanner(),
            key: _scaffoldKey,
          backgroundColor: ColorChanged.secondaryColor,
          extendBodyBehindAppBar: true,
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            // this is ignored if animatedIcon is non null
            // child: Icon(Icons.add),
            // visible: _dialVisible,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            tooltip: 'Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            backgroundColor: ColorChanged.primaryColor,
            foregroundColor:ColorChanged.tertiaryColor,
            elevation: 0.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                  child: SvgPicture.asset(
                    AppIcon.favoriteBorder,
                    width: 20.w,
                    height: 20.w,
                    color: Colors.red,
                  ),
                  backgroundColor:ColorChanged.tertiaryColor,
                  // label: 'First',
                  // labelStyle: TextTheme(fontSize: 18.0),
                  onTap: () async {

                    await _addToFavourite.add( widget.favourite);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        createSnackBar(
                            message: "Congratulations This item has been successfully added to your favourites.",
                            bgColors: ColorChanged.primaryColor,
                            txtColors: Colors.white,
                            second: 2)
                    );
                  }
                 ),
              SpeedDialChild(
                child:  SvgPicture.asset(
                  AppIcon.download,
                  width: 20.w,
                  height: 20.w,
                  color: Colors.green,
                ),
                backgroundColor:ColorChanged.tertiaryColor,
                // label: 'Third',
                // labelStyle: TextTheme(fontSize: 18.0),
                onTap: () async {
                  await _imageCtrl.download(url: widget.favourite.url!).then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        createSnackBar(
                            message: "This wallpaper in gallery has been successfully downloaded.",
                            bgColors: ColorChanged.primaryColor,
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

                }
              ),
              SpeedDialChild(
                  child:  SvgPicture.asset(
                    AppIcon.partager,
                    width: 20.w,
                    height: 20.w,
                    color:ColorChanged.primaryColor,
                  ),
                  backgroundColor: ColorChanged.tertiaryColor,
                  // label: 'Second',
                  // labelStyle: TextTheme(fontSize: 18.0),
                  onTap: () async {
                    Get.back();
                    Share.share('${AppConst.shareMsg} ${AppUrls.playStore}${AppConfig.appPackageName}');
                  }

              ),
              SpeedDialChild(
                  child:  SvgPicture.asset(
                    AppIcon.set,
                    width: 20.w,
                    height: 20.w,
                    color:ColorChanged.primaryColor,
                  ),
                  backgroundColor:ColorChanged.tertiaryColor,
                  // label: 'Second',
                  // labelStyle: TextTheme(fontSize: 18.0),
                  onTap: () async {
                    await _imageCtrl.setApply(url:widget.favourite.url!,context: context,scaffoldKey: _scaffoldKey);
                  }

              ),
            ],
          ),

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: const IconThemeData(
              color: ColorChanged.tertiaryColor,
            ),
            leading: IconButton(
              icon:SvgPicture.asset(
                AppIcon.back,
                width: 31.w,
                height: 31.w,
                color: ColorChanged.tertiaryColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              Obx(() => IconButton(
                    icon: _imageCtrl
                        .sizeChangeIco(_imageCtrl.isFitCover.value),
                    onPressed: () {
                      _imageCtrl.isFitCover.value =
                          !_imageCtrl.isFitCover.value;
                      _imageCtrl.boxFit.value =
                          (_imageCtrl.isFitCover.value)
                              ? BoxFit.cover
                              : BoxFit.contain;
                    },
                  )),
            ],
          ),
          body:Stack(
                  children: <Widget>[
                    Obx(() =>  CachedNetworkImage(
                        height:ScreenUtil().screenHeight,
                        width: ScreenUtil().screenWidth,
                        imageUrl:  widget.favourite.url!,
                        placeholder: (context, url) => Container(
                          color: Color(0xfff5f8fd),
                        ),
                        fit: _imageCtrl.boxFit.value,)),
                    const Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                        // child: buildPhotoActions(context, artistImage, artistName,
                        //   artistProfile,  widget.curPhoto,),
                      ),
                    ),
                  ],
                )
        ),
      ),
    );
  }
}
