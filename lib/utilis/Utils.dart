import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

class Utils{
  BuildContext context;
  Utils(this.context);


  static Widget wrapWithtinLayoutDirection(Widget widget){
    return new Directionality(
        textDirection: TextDirection.rtl,
        child:widget);
  }



  showExitDialog() async {
    if (await showBottomSheet()) exit(0);
  }
  Future<bool> showBottomSheet() async {
    return await showModalBottomSheet(
        context: context,
        builder: (b) => Utils.wrapWithtinLayoutDirection(Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                       'askQuit',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w700,
                        ),
                        softWrap: true,
                      )
                    ]),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'no',
                              style: TextStyle(
                                color:  Color(0xFF1E98DE),
                                fontSize: 14,
                                fontFamily: "Tajawal",
                              ),
                            ))),
                    GestureDetector(
                        onTap: () => Navigator.of(context).pop(true),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'yes',
                              style: TextStyle(
                                color:  Color(0xFF1E98DE),
                                fontSize: 14,
                                fontFamily: "Tajawal",
                              ),
                            ))),
                  ],
                )
              ],
            ))));
  }



}