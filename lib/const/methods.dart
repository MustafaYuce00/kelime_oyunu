import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class Methods {
  static void ustbildirimError(
    context,
    String aciklama,
  ) {
    MotionToast(
      // icon: Icons.error,
      // iconSize: 30,
      primaryColor: Colors.white,
      secondaryColor: Colors.red,
      //  padding: EdgeInsets.all(10),
      animationType: AnimationType.fromBottom,
      displaySideBar: false,
      displayBorder: false,
      animationCurve: Curves.linearToEaseOut,
      enableAnimation: false,
//backgroundType: BackgroundType.solid,
      description: Row(
        children: [
          SizedBox(
            width: 12,
          ),
          Icon(
            Icons.error,
            color: Colors.red,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              aciklama,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.red,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  wordSpacing: 1.5),
            ),
          ),
        ],
      ),
      position: MotionToastPosition.top,
      width: 300,
      height: 80,
    ).show(context);
  }

  static void ustbildirimSucces(
    context,
    String aciklama,
  ) {
    MotionToast(
      //  icon: Icons.check_circle,
      //  iconSize: 30,

      primaryColor: Colors.white,
      secondaryColor: Colors.green,
      //    padding: EdgeInsets.all(10),
      animationType: AnimationType.fromBottom,
      animationCurve: Curves.linearToEaseOut,
      displaySideBar: false,
      displayBorder: false,
      enableAnimation: false,
//backgroundType: BackgroundType.solid,
      description: Row(
        children: [
          SizedBox(
            width: 12,
          ),
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              aciklama,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  wordSpacing: 1.5),
            ),
          ),
        ],
      ),
      position: MotionToastPosition.top,
      width: 320,
      height: 80,
    ).show(context);
  }
}
