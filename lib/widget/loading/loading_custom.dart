import 'package:flutter/material.dart';
import '../../core/common/app_color.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const CustomWidget.rectangular(
      {this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder();

  const CustomWidget.roundedRectangular(
      {this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(27)));

  const CustomWidget.circular(
      {this.width = double.infinity,
        required this.height,
        this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!.withOpacity(0.9),
    highlightColor: Colors.grey[200]!,
    period: const Duration(milliseconds: 700),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400]!,
        shape: shapeBorder,
      ),
    ),
  );
}

class CustomWidgetLight extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

   const CustomWidgetLight.rectangular(
      {this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder();

   const CustomWidgetLight.roundedRectangular(
      {this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));

   const CustomWidgetLight.circular(
      {this.width = double.infinity,
        required this.height,
        this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.black.withOpacity(.1),
    highlightColor: AppColor.grey1.withOpacity(0.7),
    // baseColor:!Get.isDarkMode? ColorConstants.gray1:ColorConstants.gray2,
    // highlightColor:!Get.isDarkMode? ColorConstants.gray1.withOpacity(0.3):ColorConstants.gray1,
    period: const Duration(milliseconds: 700),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400]!,
        shape: shapeBorder,
      ),
    ),
  );
}