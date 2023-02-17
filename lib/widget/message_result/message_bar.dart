import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
SnackBar createSnackBar({required String message, required Color bgColors, required Color txtColors,required int second}) {
  return SnackBar(
    duration:  Duration(seconds:second),
    elevation: 6.0,
    action: SnackBarAction(
      label: 'Done',
      textColor: txtColors,
      onPressed: () {},
    ),
    backgroundColor: bgColors,
    behavior: SnackBarBehavior.fixed,
    content: Text(
      message,
      style: TextStyle(
          color: txtColors,
          fontSize: 12,
          // fontFamily: AppFont.JollyGood
      ),
    ),
  );
}
Future  createShowDialog(String message, Color bgColors, Color txtColors,BuildContext context) {
  return  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColors,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0.w))),
          content:  Text(
          message,
          style: TextStyle(
              color: txtColors,
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              // fontFamily: AppFont.JollyGood
          ),
        ),
        actions: [
          TextButton(
            child: Text('Ok', style: TextStyle(
                color: txtColors,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                // fontFamily: AppFont.JollyGood
            ),),
            onPressed: () {
              Navigator.pop(context);
          //    Navigator.pushNamed(context, NavigatorRoutes.home,arguments: HomeDetailArguments( ),);
            },
          ),
        ],
      );
    },
  );
}