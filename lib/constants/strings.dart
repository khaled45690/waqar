import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/ui/MyServices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String app_name = "Wasset Aqar";
const String splash_intro = "For E-Marketing & Ads";
const String Phone_number = "Phone Number";
const String password = "Passwordّ";
const String Remember = "Rememberّ";
const String forget="Forget Password?";
const String login_gmail = "Login With Gmail";
const String havent_account = "Don't have Account?";
const String create_account="Create Account";
const String login_enter="Login";
const String service_services="Our Services";
const String service_ads="Last Ads";
const String service_offers="Offers";
const String BASE_URL = "https://w-aqar.com/";//"http://waqarapp.somee.com/";//"https://w-aqar.com/";
const String GOOGLE_MAPS_API_KEY = "AIzaSyDh_fIvktqV36c8vbnByoxqxGpLLvBtzYU";
const Color PRIMARY_COLOR = Color(0xff0D3F67);
const int maxLengthForCharacters = 20;
const int imageQuality = 40;
const int imageQualityForMultipleImages = 20;

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final Firestore _db = Firestore.instance;
// Get the token, save it to the database for current user

 Future<String> _deviceToken() async {
   String fcmToken = await _firebaseMessaging.getToken();
    print("FCM : ");
    print(fcmToken);
    return fcmToken;
}
  _saveDeviceToken() async {
    // Get the current user
    String uid = 'jeffd23';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _firebaseMessaging.getToken();
    print("FCM : ");
    print(fcmToken);
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
         'createdAt': FieldValue.serverTimestamp(), // optional
         //'platform': Platform.operatingSystem // optional
      });
    }
  }
  class CallService{
  void call(String number)=>launch("tel:$number");
}
Future<String> getAddress(LatLng latLng)async{
  var address = await Geocoder.local.findAddressesFromCoordinates(new Coordinates(latLng.latitude, latLng.longitude)) ;
  return address.first.addressLine ;
}
GetIt locator=GetIt();
void set(){
 locator.registerSingleton(CallService());
}
final CallService _service = locator<CallService>();

void showInSnackBar(
    String value, BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey,
    {Color color}) {
  FocusScope.of(context).requestFocus(new FocusNode());
  _scaffoldKey.currentState?.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
    ),
    backgroundColor: color == null ? Colors.red : color,
    duration: Duration(seconds: 3),
  ));
}


void showInSnackBarAfterAddService(
    String value, BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey,
    {Color color}) {
  FocusScope.of(context).requestFocus(new FocusNode());
  _scaffoldKey.currentState?.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Container(
      child: Row(
        children: <Widget>[
       
        ],
      ),
    ),
    backgroundColor: color == null ? Colors.green : color,
    duration: Duration(seconds: 3),
  ));
}

_displayDialog(BuildContext context , int orderNum) async {
    int _currentIndex = 1;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("سيتم التواصل معكم ",
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text("رقم طلبكم هو "+orderNum.toString(),
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
            actions: <Widget>[
              FlatButton(
              child: Text("رجوع",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => My_services_01()));
              },
            ),

            FlatButton(
              child: Text("تم",
                  textAlign: TextAlign.left,
                  style: AqarFont.getLightFont_TextFormField()),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyServices()));
              },
            ),
              // new FlatButton(
              //   child: new Text('CANCEL'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // )
            ],
          );
        });
  }
  

