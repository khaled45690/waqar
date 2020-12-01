
//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/API/ContentApi.dart';
import 'package:waqarapp/API/UserAcceptServiceApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/model/ContactUsVM.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/ui/AllAvailableOffersNewDesign.dart';
import 'package:waqarapp/ui/HomeScreen.dart';
import 'package:waqarapp/ui/MediatorHome.dart';
import 'package:waqarapp/ui/UserHome.dart';
import 'About_us.dart';
import 'AllAvailableOffers.dart';
import 'AllAvailableOffersNewDesignByType.dart';
import 'Contact_us.dart';
import 'ForgetPass.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'My_Service_01_Details.dart';
import 'My_Service_05_Details.dart';
import 'My_Service_07_Details.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Special_users.dart';
import 'Update_useraccount.dart';

import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:waqarapp/ui/Register_new_useraccount.dart';
import 'Register_waseet_Aqar.dart';
import 'package:waqarapp/ui/Login_user.dart';
import 'package:share/share.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseUser extends StatefulWidget {
  @override
  _ChooseUserState createState() => new _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name = "";
  String email = "";
  String id = "";
  String usertype = "";
  int isuser ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;
    return WillPopScope(
        onWillPop: ()async{
          print("back button presed");
          //Categories.changeNotifierCategoriesBackPressed.sink.add("back hah ");
          return false ;
        },
        child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [gray, gray],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                image: DecorationImage(
                  image: AssetImage("images/actionbar.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: new Text(
              "الرئيسية",
              style: AqarFont.baseFontStyle(),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            elevation: 0.0,
            leading:    new IconButton(
                icon:  new Image.asset(""),
                iconSize: 30.0,
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),),
            // leading:user==null||user.Id==null? 
            //  new IconButton(
            //     icon:  new Image.asset("images/asset18.png"),
            //     iconSize: 30.0,
            //     padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            //     onPressed: () {}):CircleAvatar(
            //                 radius: 10.0,
            //                 backgroundImage:
            //                     NetworkImage(user.UserImage),
            //                 backgroundColor: Colors.transparent,
            //               ),
            actions: <Widget>[
              IconButton(
                icon:
                    new IconButton(icon: new Image.asset("images/asset17.png")),
                iconSize: 40.0,
                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                onPressed: () =>
                (id.toString().length > 2 || id != null)  == true ? _scaffoldKey.currentState.openEndDrawer() : {},
              ),
            ],
          ),
          body:  Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            main_container(),
                          ]),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(0,100, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "حقوق البرنامج محفوظه لدى مؤسسة",
                        textAlign: TextAlign.center,
                        style: AqarFont.getBoldFont(),
                      ),
                    ),
                    Container(
                      child: Text(
                        "دليل التطبيقات للإتصالات و تقنية المعلومات",
                        textAlign: TextAlign.justify,
                        style: AqarFont.getBoldFont(),
                      ),
                    ),
                  ],
                ),
              )),
          ),
          
          endDrawer:buildDrawer()
        ),
      ),



      );
    
    
  }
ContactUsVM content = new ContactUsVM();
bool apiCall = true ;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final Firestore _db = Firestore.instance;
String token = "";
 _saveDeviceToken() async {
    // Get the current user
    String uid = 'jeffd23';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _firebaseMessaging.getToken();
    setState(() {
      token=fcmToken;
    });
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
      FirebaseMessaging().onTokenRefresh.listen((newToken) {
        // Save newToken
        print("Token expired : $newToken");
      });
    }
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
   if (message.containsKey('data')) {

     // Handle data message
     final dynamic data = message['data'];
     print("Osama");
     print(data);
   }

   if (message.containsKey('notification')) {
     // Handle notification message
     final dynamic notification = message['notification'];
     print("Osama");
     print(notification);
   }

   // Or do other work.
 }
  
  @override
  void initState() {
    restore();
    super.initState();
     _saveDeviceToken();
     
    _firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");
            // print("Mohammed Sharaf");
            // print(message['text']);
        
        if(Platform.isAndroid){
          if(int.parse(message['data']['notificationType'].toString())== 1){

            print("Awwwwwwwwwwwel 1 Ya os");
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: ListTile(
                        title: Text(message['notification']['title'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        subtitle: Text(message['notification']['body'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        ),
                        actions: <Widget>[
                    //     FlatButton(
                    //       color: Colors.blue,
                    // textColor: Colors.white,
                    // disabledColor: Colors.grey,
                    // disabledTextColor: Colors.black,
                    // padding: EdgeInsets.all(0.0),
                    // splashColor: Colors.blueAccent,
                    //       child: Text('قبول'),
                    //       onPressed: (){
                    //         print("Accept");
                    //         //AcceptOrRefuser(2 ,int.parse(message['data']['Id']));
                    //       },
                    //     ),
                    ],
                ),
            );
        
          }else{
            print("Awwwwwwwwwwwel 1.1 Ya os");

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: ListTile(
                        title: Text(message['notification']['title'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        subtitle: Text(message['notification']['body'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        ),
                        actions: <Widget>[
                        FlatButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(0.0),
                          splashColor: Colors.blueAccent,
                            child: Text('التفاصيل'),
                            onPressed: () {
                              ServiceDataVM model = new ServiceDataVM();
                              model.BuildingSize=message['data']['BuildingSize']==null?"":message['data']['BuildingSize'];

                              model.BuildingAge = message['data']['BuildingAge']==null?"":message['data']['BuildingAge'];
                              model.BuildingPrice = message['data']['BuildingPrice']==null? 0:double.parse(message['data']['BuildingPrice']);
                              model.AddDuration = message['data']['AddDuration']==null?0:int.parse(message['data']['AddDuration']);
                              model.AppearingForOffice = message['data']['AppearingForOffice']==null?0:int.parse(message['data']['AppearingForOffice']);


                              model.BuildingType=message['data']['BuildingType']==null?"":message['data']['BuildingType'];
                              model.City=message['data']['City'];
                              model.Country=message['data']['Country'];
                              model.creationDateTxt=message['data']['creationDateTxt'];
                              model.Description=message['data']['Description'];
                              model.District=message['data']['District'];
                              model.ElectricAccount=message['data']['ElectricAccount'];
                              model.forBuy=message['data']['forBuy'].toLowerCase() == 'true';
                              model.ForRent=message['data']['ForRent'].toLowerCase() == 'true';
                              model.ForSell=message['data']['ForSell'].toLowerCase() == 'true';
                              model.Id=int.parse(message['data']['Id']);
                              model.IsAgent=message['data']['IsAgent'].toLowerCase() == 'true';
                              model.IsCancelled=message['data']['IsCancelled'].toLowerCase() == 'true';
                              model.IsCommercial=message['data']['IsCommercial'].toLowerCase() == 'true';
                              model.IsHousing=message['data']['IsHousing'].toLowerCase() == 'true';
                              model.IsManagement=message['data']['IsManagement'].toLowerCase() == 'true';
                              model.IsOwner=message['data']['IsOwner'].toLowerCase() == 'true';
                              model.Lat = message['data']['Lat']==null? 0:double.parse(message['data']['Lat']);
                              model.Long = message['data']['Long']==null? 0:double.parse(message['data']['Long']);

                              model.LessorAddress=message['data']['LessorAddress'];
                              model.LessorEmail=message['data']['LessorEmail'];
                              model.LessorName=message['data']['LessorName'];
                              model.LessorPhone=message['data']['LessorPhone'];
                              model.Long_Lat=message['data']['Long_Lat'];
                              model.PricingPurpose=message['data']['PricingPurpose'];
                              model.ServiceId=int.parse(message['data']['ServiceId']);
                              model.ServiceName=message['data']['ServiceName'];
                              model.TenantAddress=message['data']['TenantAddress'];
                              model.TenantEmail=message['data']['TenantEmail'];
                              model.TenantName=message['data']['TenantName'];
                              model.TenantPhone=message['data']['TenantPhone'];
                              model.UserId=message['data']['UserId'];
                              
                              if(model.ServiceId==1 ||model.ServiceId==2 ||model.ServiceId==3||model.ServiceId==5||model.ServiceId==7 ){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_01_Details(model)));
                            }else if(model.ServiceId ==4){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_05_Details(model)));
                            }else if(model.ServiceId ==6){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_07_Details(model)));
                            }

                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => AllAvailableOffers()));
                            }//=> Navigator.of(context).pop(),
                        ),
                        FlatButton(
                          color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                          child: Text('قبول'),
                          onPressed: (){
                            print("Accept");
                            AcceptOrRefuser(2 ,int.parse(message['data']['Id']));
                          },
                        ),
                        FlatButton(
                          color: Colors.red,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                          child: Text('رفض'),
                          onPressed: (){
                            print("Refuse");
                            AcceptOrRefuser(1 ,int.parse(message['data']['Id']));
                          },
                        )
                    ],
                ),
            );
        
          }
              
        }else{
           if(int.parse(message['notificationType'].toString())== 1){
             print("Awwwwwwwwwwwel 2 Ya os");

             showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: ListTile(
                        title: Text(message['title'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        subtitle: Text(message['text'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        ),
                        actions: <Widget>[
                    //     FlatButton(
                    //       color: Colors.blue,
                    // textColor: Colors.white,
                    // disabledColor: Colors.grey,
                    // disabledTextColor: Colors.black,
                    // padding: EdgeInsets.all(0.0),
                    // splashColor: Colors.blueAccent,
                    //       child: Text('قبول'),
                    //       onPressed: (){
                    //         print("Accept");
                    //         //AcceptOrRefuser(2 ,int.parse(message['Id']));
                    //       },
                    //     )
                    ],
                ),
            );
        
           }else{
             print("Awwwwwwwwwwwel 2.1 Ya os");

             showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: ListTile(
                        title: Text(message['title'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        subtitle: Text(message['text'],textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
                        ),
                        actions: <Widget>[
                        FlatButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(0.0),
                          splashColor: Colors.blueAccent,
                            child: Text('التفاصيل'),
                            onPressed: () {
                              ServiceDataVM model = new ServiceDataVM();
                              
                              model.BuildingAge = message['BuildingAge'];
                              model.BuildingPrice = double.parse(message['BuildingPrice']);
                              model.AddDuration = int.parse(message['AddDuration']);
                              model.AppearingForOffice = int.parse(message['AppearingForOffice']);

                              model.BuildingSize=message['BuildingSize'];
                              model.BuildingType=message['BuildingType'];
                              model.City=message['City'];
                              model.Country=message['Country'];
                              model.creationDateTxt=message['creationDateTxt'];
                              model.Description=message['Description'];
                              model.District=message['District'];
                              model.ElectricAccount=message['ElectricAccount'];
                              model.forBuy=message['forBuy'].toLowerCase() == 'true';
                              model.ForRent=message['ForRent'].toLowerCase() == 'true';
                              model.ForSell=message['ForSell'].toLowerCase() == 'true';
                              model.Id=int.parse(message['Id']);
                              model.IsAgent=message['IsAgent'].toLowerCase() == 'true';
                              model.IsCancelled=message['IsCancelled'].toLowerCase() == 'true';
                              model.IsCommercial=message['IsCommercial'].toLowerCase() == 'true';
                              model.IsHousing=message['IsHousing'].toLowerCase() == 'true';
                              model.IsManagement=message['IsManagement'].toLowerCase() == 'true';
                              model.IsOwner=message['IsOwner'].toLowerCase() == 'true';
                              model.Lat=message['Lat'];
                              model.LessorAddress=message['LessorAddress'];
                              model.LessorEmail=message['LessorEmail'];
                              model.LessorName=message['LessorName'];
                              model.LessorPhone=message['LessorPhone'];
                              model.Long=message['Long'];
                              model.Long_Lat=message['Long_Lat'];
                              model.PricingPurpose=message['PricingPurpose'];
                              model.ServiceId=int.parse(message['ServiceId']);
                              model.ServiceName=message['ServiceName'];
                              model.TenantAddress=message['TenantAddress'];
                              model.TenantEmail=message['TenantEmail'];
                              model.TenantName=message['TenantName'];
                              model.TenantPhone=message['TenantPhone'];
                              model.UserId=message['UserId'];
                              
                              if(model.ServiceId==1 ||model.ServiceId==2 ||model.ServiceId==3||model.ServiceId==5||model.ServiceId==7 ){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_01_Details(model)));
                            }else if(model.ServiceId ==4){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_05_Details(model)));
                            }else if(model.ServiceId ==6){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_07_Details(model)));
                            }

                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => AllAvailableOffers()));
                            }//=> Navigator.of(context).pop(),
                        ),
                        FlatButton(
                          color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                          child: Text('قبول'),
                          onPressed: (){
                            print("Accept");
                            AcceptOrRefuser(2 ,int.parse(message['Id']));
                          },
                        ),
                        FlatButton(
                          child: Text('رفض'),
                          color: Colors.red,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                          onPressed: (){
                            print("Refuse");
                            AcceptOrRefuser(1 ,int.parse(message['Id']));
                          },
                        )
                    ],
                ),
            );
        
           }
        }
        
        },
        //onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          //print("On Resume Ya Osssssss");
            print("onResume: $message");
             Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChooseUser()));
            if(Platform.isAndroid){
                          
              if(int.parse(message['data']['notificationType'].toString()) == 1){
                print("Awwwwwwwwwwwel 3 Ya os");
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            content: ListTile(
                            title: Text(message['data']['title'],textAlign: TextAlign.center,
                      style: AqarFont.getLightFont_TextFormField()),
                            subtitle: Text(message['data']['message'],textAlign: TextAlign.center,
                      style: AqarFont.getLightFont_TextFormField()),
                            ),
                            actions: <Widget>[
                        //     FlatButton(
                        //       color: Colors.blue,
                        // textColor: Colors.white,
                        // disabledColor: Colors.grey,
                        // disabledTextColor: Colors.black,
                        // padding: EdgeInsets.all(0.0),
                        // splashColor: Colors.blueAccent,
                        //       child: Text('قبول'),
                        //       onPressed: (){
                        //        print("Accept");
                        //        // AcceptOrRefuser(2 ,int.parse(message['data']['Id']));
                        //       },
                        //     )
                        ],
                    ),
                );
              }else{
                print("Awwwwwwwwwwwel 3.3 Ya os");

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            content: ListTile(
                            title: Text(message['data']['title'],textAlign: TextAlign.center,
                      style: AqarFont.getLightFont_TextFormField()),
                            subtitle: Text(message['data']['message'],textAlign: TextAlign.center,
                      style: AqarFont.getLightFont_TextFormField()),
                            ),
                            actions: <Widget>[
                            FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(0.0),
                              splashColor: Colors.blueAccent,
                                child: Text('التفاصيل'),
                                onPressed: () {
                                  ServiceDataVM model = new ServiceDataVM();
                                  model.BuildingSize=message['data']['BuildingSize']==null?"":message['data']['BuildingSize'];

                                  model.BuildingAge = message['data']['BuildingAge']==null?"":message['data']['BuildingAge'];
                                  model.BuildingPrice = message['data']['BuildingPrice']==null? 0:double.parse(message['data']['BuildingPrice']);
                                  model.AddDuration = message['data']['AddDuration']==null?0:int.parse(message['data']['AddDuration']);
                                  model.AppearingForOffice = message['data']['AppearingForOffice']==null?0:int.parse(message['data']['AppearingForOffice']);


                                  model.BuildingType=message['data']['BuildingType']==null?"":message['data']['BuildingType'];
                                  model.City=message['data']['City'];
                                  model.Country=message['data']['Country'];
                                  model.creationDateTxt=message['data']['creationDateTxt'];
                                  model.Description=message['data']['Description'];
                                  model.District=message['data']['District'];
                                  model.ElectricAccount=message['data']['ElectricAccount'];
                                  model.forBuy=message['data']['forBuy'].toLowerCase() == 'true';
                                  model.ForRent=message['data']['ForRent'].toLowerCase() == 'true';
                                  model.ForSell=message['data']['ForSell'].toLowerCase() == 'true';
                                  model.Id=int.parse(message['data']['Id']);
                                  model.IsAgent=message['data']['IsAgent'].toLowerCase() == 'true';
                                  model.IsCancelled=message['data']['IsCancelled'].toLowerCase() == 'true';
                                  model.IsCommercial=message['data']['IsCommercial'].toLowerCase() == 'true';
                                  model.IsHousing=message['data']['IsHousing'].toLowerCase() == 'true';
                                  model.IsManagement=message['data']['IsManagement'].toLowerCase() == 'true';
                                  model.IsOwner=message['data']['IsOwner'].toLowerCase() == 'true';
                                  model.Lat = message['data']['Lat']==null? 0:double.parse(message['data']['Lat']);
                                  model.Long = message['data']['Long']==null? 0:double.parse(message['data']['Long']);

                                  model.LessorAddress=message['data']['LessorAddress'];
                                  model.LessorEmail=message['data']['LessorEmail'];
                                  model.LessorName=message['data']['LessorName'];
                                  model.LessorPhone=message['data']['LessorPhone'];
                                  model.Long_Lat=message['data']['Long_Lat'];
                                  model.PricingPurpose=message['data']['PricingPurpose'];
                                  model.ServiceId=int.parse(message['data']['ServiceId']);
                                  model.ServiceName=message['data']['ServiceName'];
                                  model.TenantAddress=message['data']['TenantAddress'];
                                  model.TenantEmail=message['data']['TenantEmail'];
                                  model.TenantName=message['data']['TenantName'];
                                  model.TenantPhone=message['data']['TenantPhone'];
                                  model.UserId=message['data']['UserId'];
                                  
                                  if(model.ServiceId==1 ||model.ServiceId==2 ||model.ServiceId==3||model.ServiceId==5||model.ServiceId==7 ){
                                  Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => My_Service_01_Details(model)));
                                }else if(model.ServiceId ==4){
                                  Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => My_Service_05_Details(model)));
                                }else if(model.ServiceId ==6){
                                  Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => My_Service_07_Details(model)));
                                }

                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(builder: (context) => AllAvailableOffers()));
                                }//=> Navigator.of(context).pop(),
                            ),
                            FlatButton(
                              color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(0.0),
                        splashColor: Colors.blueAccent,
                              child: Text('قبول'),
                              onPressed: (){
                                print("Accept");
                                AcceptOrRefuser(2 ,int.parse(message['data']['Id']));
                              },
                            ),
                            FlatButton(
                              color: Colors.red,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(0.0),
                        splashColor: Colors.blueAccent,
                              child: Text('رفض'),
                              onPressed: (){
                                print("Refuse");
                                AcceptOrRefuser(1 ,int.parse(message['data']['Id']));
                              },
                            )
                        ],
                    ),
                );
              }
                  
            }else{
              if(int.parse(message['notificationType'].toString()) ==1){
                print("Awwwwwwwwwwwel 3 Ya os");

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            content: ListTile(
                            title: Text(message['title']),
                            subtitle: Text(message['text']),
                            ),
                            actions: <Widget>[
                            // FlatButton(
                            //   child: Text('قبول'),
                            //   onPressed: (){
                            //     print("Accept");
                            //     //AcceptOrRefuser(2 ,int.parse(message['Id']));
                            //   },
                            // )
                        ],
                    ),
                );
              }else{
                print("Awwwwwwwwwwwel 3.1 Ya os");

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            content: ListTile(
                            title: Text(message['title']),
                            subtitle: Text(message['text']),
                            ),
                            actions: <Widget>[
                            FlatButton(
                                child: Text('التفاصيل'),
                                onPressed: () {
                                  ServiceDataVM model = new ServiceDataVM();
                                  
                                  model.BuildingAge = message['BuildingAge'];
                                  model.BuildingPrice = double.parse(message['BuildingPrice']);
                                  model.AddDuration = int.parse(message['AddDuration']);
                                  model.AppearingForOffice = int.parse(message['AppearingForOffice']);

                                  model.BuildingSize=message['BuildingSize'];
                                  model.BuildingType=message['BuildingType'];
                                  model.City=message['City'];
                                  model.Country=message['Country'];
                                  model.creationDateTxt=message['creationDateTxt'];
                                  model.Description=message['Description'];
                                  model.District=message['District'];
                                  model.ElectricAccount=message['ElectricAccount'];
                                  model.forBuy=message['forBuy'].toLowerCase() == 'true';
                                  model.ForRent=message['ForRent'].toLowerCase() == 'true';
                                  model.ForSell=message['ForSell'].toLowerCase() == 'true';
                                  model.Id=int.parse(message['Id']);
                                  model.IsAgent=message['IsAgent'].toLowerCase() == 'true';
                                  model.IsCancelled=message['IsCancelled'].toLowerCase() == 'true';
                                  model.IsCommercial=message['IsCommercial'].toLowerCase() == 'true';
                                  model.IsHousing=message['IsHousing'].toLowerCase() == 'true';
                                  model.IsManagement=message['IsManagement'].toLowerCase() == 'true';
                                  model.IsOwner=message['IsOwner'].toLowerCase() == 'true';
                                  model.Lat=message['Lat'];
                                  model.LessorAddress=message['LessorAddress'];
                                  model.LessorEmail=message['LessorEmail'];
                                  model.LessorName=message['LessorName'];
                                  model.LessorPhone=message['LessorPhone'];
                                  model.Long=message['Long'];
                                  model.Long_Lat=message['Long_Lat'];
                                  model.PricingPurpose=message['PricingPurpose'];
                                  model.ServiceId=int.parse(message['ServiceId']);
                                  model.ServiceName=message['ServiceName'];
                                  model.TenantAddress=message['TenantAddress'];
                                  model.TenantEmail=message['TenantEmail'];
                                  model.TenantName=message['TenantName'];
                                  model.TenantPhone=message['TenantPhone'];
                                  model.UserId=message['UserId'];
                                  
                                  if(model.ServiceId==1 ||model.ServiceId==2 ||model.ServiceId==3||model.ServiceId==5||model.ServiceId==7 ){
                                  Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => My_Service_01_Details(model)));
                                }else if(model.ServiceId ==4){
                                  Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => My_Service_05_Details(model)));
                                }else if(model.ServiceId ==6){
                                  Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => My_Service_07_Details(model)));
                                }

                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(builder: (context) => AllAvailableOffers()));
                                }//=> Navigator.of(context).pop(),
                            ),
                            FlatButton(
                              child: Text('قبول'),
                              onPressed: (){
                                print("Accept");
                                AcceptOrRefuser(2 ,int.parse(message['Id']));
                              },
                            ),
                            FlatButton(
                              child: Text('رفض'),
                              onPressed: (){
                                print("Refuse");
                                AcceptOrRefuser(1 ,int.parse(message['Id']));
                              },
                            )
                        ],
                    ),
                );
              }
            
            }
        },
        );
_firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    ////////////////
    




    getUser().then((user){
      setState(() {
              this.user = user ;
              if(user.Id ==null){
ContentApi.getContactUs("null").then((response){
                  if(response.code !=200){
                    clear();
                            Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => ChooseUser()));
                  }else {
                    setState(() {
                      print("response.data.ValueAr");
                    this.content = response.data;
                    setState(() {
                      this.apiCall = false ;
                    });
                      //this.apiCall = false;
                    });
                  }

                },onError: (error){
                  setState(() {
                    print("Error response.data.ValueAr");
                    //this.content = response.data;
                    //this.apiCall = false ;
                  });
                  print("getting moreDetails error : : : $error");
                });
              }else{
                ContentApi.getContactUs(user.Id).then((response){
                  if(response.code !=200){
                    clear();
                            Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => ChooseUser()));
                  }else {
                    setState(() {
                      print("response.data.ValueAr");
                    this.content = response.data;
                    setState(() {
                      this.apiCall = false ;
                    });
                      //this.apiCall = false;
                    });
                  }

                },onError: (error){
                  setState(() {
                    print("Error response.data.ValueAr");
                    //this.content = response.data;
                    //this.apiCall = false ;
                  });
                  print("getting moreDetails error : : : $error");
                });
                //Update Token
                // AuthApi.updateToken(user.Id ,token ).then((response){
                //   if(response.code !=200){
                //    // Navigator.pop(context);
                //   }else {
                //     // setState(() {
                //     //   print("response.data.ValueAr");
                //     // this.content = response.data;
                //     // setState(() {
                //     //   this.apiCall = false ;
                //     // });
                //     //   //this.apiCall = false;
                //     // });
                //   }

                // },onError: (error){
                //   setState(() {
                //     print("Error response.data.ValueAr");
                //     //this.content = response.data;
                //     //this.apiCall = false ;
                //   });
                //   print("getting moreDetails error : : : $error");
                //   //this.apiCall = false ;
                // });
              }
      });
    });
  }
_showDialog(int status ) async {
  String txt = "";
    if(status==1){//refus
      txt = " تم تاكيد الرفض بنجاح  ";
    }else if(status==2){//refus
      txt = " تم تاكيد القبول بنجاح  ";
    }
    print(txt);
    await showDialog<String>(
      context: _context,
      child: new _SystemPadding(child: new AlertDialog(
            title: Text(" تم بنجاح  ",
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text(txt,
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
            actions: <Widget>[
              FlatButton(
              child: Text("نعم",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                Navigator.of(_context).pop();
                //Navigator.of(_context).pop();
                //  Navigator.of(_context)
                //      .push(MaterialPageRoute(builder: (_context) => AllAvailableOffers()));
              },
            ),
            ],
          ),),
    );
  }
AcceptOrRefuser(int status, int serviceId){
  showAppLoading(_context);
  //int serviceId = widget.serviceData.Id;
  String userId = user.Id;
  bool isAccept = false;
    if(status==1){//refus
      isAccept=false;
    }else if(status==2){//refus
      isAccept=true;
    }
    UserAcceptServiceApi.UserAcceptService(userId, "text", serviceId, isAccept).then((response) {
          if (response.code ==200 ) {
            print("Suceeeeeees");
             hideAppDialog(_context);
             Navigator.of(_context).pop();
             _showDialog(status);
          } else {
            print("failllllll");
            hideAppDialog(_context);
          }
          setState(() {
          //this.loginApi = false;
          });
        }, onError: (error) {
          hideAppDialog(_context);
          print("login Error : : :$error");
          setState(() {
          // this.loginApi = false;
          });
        });
}

UserVM user ;
  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      if(Prefs.getString('id')!= null){
        id= Prefs.getString('id')?? "";
        name= Prefs.getString('name')?? "";
        email= Prefs.getString('email')?? "";
        usertype= Prefs.getString('usertype')?? "";
        isuser= Prefs.getInt('isuser')?? 0;
      }
    });
  }





  void showSnack(String msg, {Duration duration}) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        msg,
        style: AqarFont.getRegularFont(),
      ),
      duration: duration == null ? Duration(seconds: 5) : duration,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("تم",
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChooseUser()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تاكيد",
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
      content: Text("هل تريد الخروج",
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//  Future<bool> clear() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
// print("Clear shared preffffffff");
// print(prefs.getString("Email"));
//     prefs.clear() ;
//     print(prefs.getString("Email"));
//     return true ;
// }
  main_container() {
    return Container(
        margin: EdgeInsets.only(right: 40, left: 40, bottom: 10, top: 30),
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: [bgColor, bgColor],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.5, 2.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 10),
            child: Image.asset(
              'images/Logo-02.png',//'images/Logo-01.png',//'images/logo_head.png',
              height: 150,
            ),
          ),
          // user.Id==null?appButtonbgimage(
          //     'دخول مقدم خدمه',
          //     () =>
          //      Navigator.of(context)
          //         .pushReplacement(MaterialPageRoute(builder: (context) => Login_user())),
          //     bgColor: desgin_button1_start,
          //     bgColor2: desgin_button1_end):Container(),
          // Container(
          //   height: 10,
          // ),
          // user.Id==null?appButtonbgimage(
          //     'دخول مستخدم',
          //     () => Navigator.of(context)
          //         .pushReplacement(MaterialPageRoute(builder: (context) => Login_user())),
          //     bgColor: desgin_button1_start,
          //     bgColor2: desgin_button1_end):Container(),
          // Container(
          //   height: 10,
          // ),
          // user.Id==null?appButtonbgimage(
          //     'تسجيل مقدم خدمه',
          //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          //         builder: (context) => Register_waseet_Aqar())),
          //     bgColor: desgin_button1_start,
          //     bgColor2: desgin_button1_end):Container(),
          // Container(
          //   height: 10,
          // ),
          // user.Id==null?appButtonbgimage(
          //     'تسجيل مستخدم',
          //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          //         builder: (context) => Register_new_useraccount())),
          //     bgColor: desgin_button1_start,
          //     bgColor2: desgin_button1_end):Container(),
          // Container(
          //   height: 10,
          // ),
          // user.Id==null?appButtonbgimage('استعاده كلمه السر',
          //         () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPass())),
          //     bgColor: desgin_button1_start, bgColor2: desgin_button1_end):Container(),
          // Container(
          //   height: 30,
          // ),
          // user.Id==null?Container():
          // appButtonbgimage('تسجيل خروج',
          //         (){
          //         clear();
          //        Navigator.pop(context);
          //         Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => ChooseUser()));
          //         },
          //     bgColor: desgin_button1_start, bgColor2: desgin_button1_end),
          appButtonbgimage(' مقدم خدمه',
                  (){
                 // clear();
                //  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MediatorHome()));
                  },
              bgColor: desgin_button1_start, bgColor2: desgin_button1_end),
          Container(
            height: 10,
          ),

          appButtonbgimage(' مستخدم ',
                  (){
                 // clear();
                //  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserHome()));
                  },
              bgColor: desgin_button1_start, bgColor2: desgin_button1_end),
          Container(
            height: MediaQuery.of(context).size.height-400,
          ),
          
        ]));
  }
}



class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}