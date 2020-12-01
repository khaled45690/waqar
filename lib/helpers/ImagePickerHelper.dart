import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'dart:async';


import 'package:waqarapp/helpers/SneakBarHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
/*
* class for fetching image from device
* */

class ImagePickerHelper {
  //MARK:- Custom Dialogue Alert
  Future<File> pickImage(BuildContext context, Function callback) async {
    SneakbarHelper(context)
      ..setBackgroundColor(Colors.black26)
      ..setDuration(5)
      ..buildCustomBody(_getDialog(context, callback))
      ..show();
  }

  Future<File> pickImagebyKey(
      GlobalKey key, BuildContext context, Function callback) {
    SneakbarHelper.init(key)
      ..setBackgroundColor(Colors.black26)
      ..setDuration(5)
      ..buildCustomBody(_getDialog(context, callback))
      ..show();
  }

  Widget _getDialog(BuildContext context, Function callback) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              _pick(ImageSource.gallery, callback);
            },
            color: desgin_button1_start,
            child: Text("GALLERY",style: AqarFont.baseFontStyle()),
          ),
          // MARK:- camera option
          RaisedButton(
            onPressed: () {
              _pick(ImageSource.camera, callback);
            },
            color: desgin_button1_start,
            child: Text("CAMERA",style: AqarFont.baseFontStyle()),
          )
        ],
      ),
    );
  }

  //MARK:- Uploading image from
  void _pick(ImageSource source, Function callback) async {
    var image = await ImagePicker.pickImage(source: source);
    var selectedImage = image;
    if (selectedImage != null) {
      //  File compressedImg = await _imgCompress(selectedImage);
      callback(selectedImage);
    } else {
      callback(AssetImage("assets/profile_img.png"));
    }
  }

  // MARK- COMPRESSION
//  Future<File> _imgCompress(selectedImage) async {
//    final tempDir = await getTemporaryDirectory();
//    CompressObject compressObject = CompressObject(
//        imageFile: selectedImage,
//        path: tempDir.path,
//        quality: 85,
//        step: 6,
//        mode: CompressMode.LARGE2SMALL);
//    final path = await Luban.compressImage(compressObject);
//    File compressedImage = File(path);
//    //upload image
//    print(compressedImage.length());
//    return compressedImage;
//  }
}
