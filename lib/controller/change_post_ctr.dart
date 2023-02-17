import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/controller/applovin_ctr.dart';
import '../core/common/app_color.dart';
import '../service/firebase/firebase_database_service.dart';
import '../views/applovinmx/Widget/mrec.dart';
import '../views/layouTwo/layouTwo_1.dart';
import '../views/theme_post/post_1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/common/app_const.dart';
import '../model/firebase_file.dart';
import '../views/layouTwo/layouTwo_2.dart';
import '../views/layouTwo/layouTwo_circle.dart';
import '../views/theme_post/post_2.dart';
import '../views/theme_post/post_circle.dart';

class ChangePostCtr extends GetxController {
  int idPost = 0;
  List<Widget> posts = [];
  List<Widget> layouts = [];


  @override
  void onInit() async {
    posts.clear();
    layouts.clear();
    FirebaseApi.listAll(AppConst.pathChangePost).then((value) {
      print('-------ttttt----------------- ${value.toList()}');
      posts.addAll([
        IgnorePointer(
            child: postOne(lst: value.first, context: Get.context!, index: 0, isHome: false)),
        IgnorePointer(
            child:
                postCircle(context: Get.context!, lst: value.first, index: 0, isHome: false)),
        IgnorePointer(
            child: postTwo(context: Get.context!, lst: value.first, index: 0, isHome: false))
      ]);
      layouts.addAll([
        IgnorePointer(
            child: layoutOne(lst: value.first, context: Get.context!, isHome: false)),
        IgnorePointer(
            child: layoutCircle(context: Get.context!, lst: value.first, isHome: false)),
        IgnorePointer(child: layoutTwo(context: Get.context!, lst: value.first, isHome: false))
      ]);
    });
    getPost();
    super.onInit();
  }

  selectPost(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(AppConst.postId);
    var postId = prefs.setInt(AppConst.postId, id);

    update();
    postId.then((value) => print(value));
  }

  getPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var postId = prefs.getInt(AppConst.postId);
    idPost = postId ?? 0;
    print("get : $idPost");
    update();
  }

  Color? getLayoutColor(String? get) {
    switch (get) {
      case AppConst.Default:
        return AppColor.blue;
      case AppConst.New:
        return AppColor.gold;
      default:
        return AppColor.gold;
    }
  }

  Widget getLayoutOne(
      {required Favourite lst,
      required bool isHome,
      required BuildContext context,
      required int index,
      required int index2}) {
    switch (index) {
      case 0:
        return postOne(context: context, lst: lst, index: index2, isHome: isHome);
      case 1:
        return postCircle(context: context, lst: lst, index: index2, isHome: isHome);
      case 2:
        return postTwo(context: context, lst: lst, index: index2, isHome: isHome);
      case 3:
        return widgetMrec();
      default:
        return postOne(context: context, lst: lst, index: index2, isHome: isHome);
    }
  }

  Widget getLayoutTwo(
      {required Favourite lst,
        required bool isHome,
      required BuildContext context,
      required int index}) {
    switch (index) {
      case 0:
        return layoutOne(context: context, lst: lst, isHome: isHome);
      case 1:
        return layoutCircle(context: context, lst: lst, isHome: isHome);
      case 2:
        return layoutTwo(context: context, lst: lst, isHome: isHome);
      case 3:
        return widgetMrec();
      default:
        return layoutOne(context: context, lst: lst, isHome: isHome);
    }
  }
}
