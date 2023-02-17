import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/change_post_ctr.dart';
import '../../controller/favourite_ctr.dart';
import '../../model/firebase_file.dart';
import '../../views/applovinmx/Widget/mrec.dart';
import '../items/items_list.dart';

Widget items(List<Favourite> lst, bool isFavorite) {
  var _crossAxisSpacing = 5;
  var _screenWidth = 200.w;
  var _crossAxisCount = 2; //layout 1=2 and layout 2=1
  var _crossAxisCount1 = 1; //layout 1=2 and layout 2=1
  var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
      _crossAxisCount;
  var _width1 = (_screenWidth - ((_crossAxisCount1 - 1) * _crossAxisSpacing)) /
      _crossAxisCount1;
  var cellHeight = 115.h;
  var _aspectRatio = _width / cellHeight;
  var _aspectRatio1 = _width1 / 100;
  return lst.isNotEmpty
      ? GetBuilder<AddToFavourite>(builder: (_addToFavourite) {
    return _addToFavourite.isLayoutOne
        ? GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //  controller: ScrollController(keepScrollOffset: false),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount,
          childAspectRatio: _aspectRatio),
      itemCount: lst.length,
      itemBuilder: (context, index) {
        index;
        // Item rendering
        return GetBuilder<ChangePostCtr>(
            builder: (_changePostCtr) {
              return _changePostCtr.getLayoutOne(
                  lst: lst[index],
                  context: context,
                  index: lst[index].name=="Mrec"?3: _changePostCtr.idPost, index2: index, isHome: !isFavorite);
            });
      },
    )
        : GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //  controller: ScrollController(keepScrollOffset: false),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount1,
          childAspectRatio: _aspectRatio1),
      itemCount: lst.length,
      itemBuilder: (context, index) {
        index;
        // Item rendering
        return GetBuilder<ChangePostCtr>(
            builder: (changePostCtr) {
              return changePostCtr.getLayoutTwo(
                  lst: lst[index],
                  context: context,
                  index: lst[index].name=="Mrec"?3: changePostCtr.idPost, isHome:  !isFavorite,);
            });
      },
    );
  })
      : Center(
    child: emptyList(
        title: isFavorite ? 'No Favorites Yet!' : 'No Wallpaper Yet!',
        description: isFavorite
            ? 'Once you favorite a wallpapers , you\'ll see them here.'
            : 'We don\'t have wallpapers now try later.',
        isClick: isFavorite),
  );
}
