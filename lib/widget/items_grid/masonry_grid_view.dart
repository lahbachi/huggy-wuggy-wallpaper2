import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../controller/change_post_ctr.dart';
import '../../controller/favourite_ctr.dart';
import '../../model/firebase_file.dart';
import '../items/items_list.dart';

Widget items2(List<Favourite> lst, bool isFavorite) {
  return lst.isNotEmpty
      ? GetBuilder<AddToFavourite>(builder: (addToFavourite) {
          return addToFavourite.isLayoutOne
              ? MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lst.length,
                  itemBuilder: (context, index) {
                    index;
                    // Item rendering
                    return GetBuilder<ChangePostCtr>(builder: (changePostCtr) {
                      return changePostCtr.getLayoutOne(
                          lst: lst[index],
                          context: context,
                          index: changePostCtr.idPost,
                          index2: index, isHome:  !isFavorite);
                    });
                  },
                )
              : MasonryGridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lst.length,
                  itemBuilder: (context, index) {
                    index;
                    // Item rendering
                    return GetBuilder<ChangePostCtr>(builder: (changePostCtr) {
                      return changePostCtr.getLayoutTwo(
                          lst: lst[index],
                          context: context,
                          index: changePostCtr.idPost, isHome:  !isFavorite);
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
