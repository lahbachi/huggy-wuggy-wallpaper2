import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/favourite_ctr.dart';
import '../../model/firebase_file.dart';
import '../../service/image_services/image_service.dart';
import '../../widget/items/items_list.dart';
import '../../widget/items_grid/item_grid_view.dart';
import '../../widget/items_grid/masonry_grid_view.dart';
import '../../widget/loading/loading_custom.dart';

class PicturePage extends StatefulWidget {
  final Future<List<Favourite>> futureFavourite;
  final bool isFavorite;

  const PicturePage({
    Key? key,
    required this.isFavorite,
    required this.futureFavourite,
  }) : super(key: key);

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage>
    with AutomaticKeepAliveClientMixin<PicturePage> {
  // late Future<List<Favourite>> futureFavourite;
  final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // futureFavourite = FirebaseApi.listAll('/pictures/');
  }

  ImageService imageService = ImageService();

  @override
  Widget build(BuildContext context) {
    return !widget.isFavorite
        ? FutureBuilder<List<Favourite>>(
            future: widget.futureFavourite,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child:
                        GetBuilder<AddToFavourite>(builder: (_addToFavourit) {
                      return Wrap(
                        children: [
                          for (int i = 0; i < 6; i++)
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: CustomWidget.roundedRectangular(
                                height: _addToFavourit.isLayoutOne
                                    ? ScreenUtil().screenHeight / 3.5
                                    : ScreenUtil().screenHeight / 5,
                                width: _addToFavourit.isLayoutOne
                                    ? ScreenUtil().screenWidth / 2.15
                                    : ScreenUtil().screenWidth,
                              ),
                            )
                        ],
                      );
                    }),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: emptyList(
                          title: 'Some error occurred!',
                          description: '',
                          isClick: true),
                    );
                  } else {
                    final files =
                        _addToFavourite.dataWithMer(lst: snapshot.data ?? []);
                    return Obx(() => _addToFavourite.isItem.value
                        ? items(files ?? [], false)
                        : items2(files ?? [], false));
                  }
              }
            } ,
          )
        : Obx(() => _addToFavourite.isItem.value
            ? items(_addToFavourite.lst, true)
            : items2(_addToFavourite.lst, true));
  }

  @override
  bool get wantKeepAlive => true;
}
