import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/ui/ChosseUser.dart';
import 'About_us.dart';
import 'Contact_us.dart';
import 'ForgetPass.dart';
import 'HomeScreen.dart';

import 'package:waqarapp/API/RequestsAndResponses/AuthenticationBloc.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Special_users.dart';
import 'package:share/share.dart';

class Login_user extends StatefulWidget {
  @override
  _Login_userState createState() => new _Login_userState();
}

class _Login_userState extends State<Login_user> with WidgetsBindingObserver {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  var emailKey = GlobalKey<FormFieldState>();
  var passwordKey = GlobalKey<FormFieldState>();
  String tempUserName ;

UserVM user;
 
  @override
  void initState() {
    
    super.initState();
   // restore();
    print("2222222");
    print(tempUserName);
    //setState(() {
      tempUserName="ffffffff";
      
    getUser().then((user){
      setState(() {
              this.user = user ;
              print(user.tempUserName);
      });
    });
    // _bloc.loginSubject.listen((data) async {
    //   showDialog(
    //       context: context,
    //       child: new AlertDialog(
    //           title: Text('مرحبا', textAlign: TextAlign.right),
    //           titleTextStyle: AqarFont.getLightFont_TextFormField(),
    //           content: Text('تم الدخول بنجاح', textAlign: TextAlign.right),
    //           contentTextStyle: AqarFont.getLightFont_TextFormField(),
    //           actions: <Widget>[
    //             RaisedButton(
    //               child: Text('تم',
    //                   textAlign: TextAlign.left,
    //                   style: AqarFont.baseRegularFont()),
    //               color: desgin_button1_start,
    //               onPressed: () =>
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => HomeScreen(),
    //                     ),
    //                   ),
    //             ),
    //           ]));
    // }, onError: (error) {
    //   hideAppDialog(context);
    //   showSnack(error);
    // });
  }

  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      tempUserName =  Prefs.getString('tempUserName') ?? "";
      name = Prefs.getString('username') ?? "";
      email = Prefs.getString('email') ?? "";
            print("tempUserName");
            print(tempUserName);

    });
  }
  File _image = null;
  String urlImage = "";

  bool monVal = false;






  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;
    return WillPopScope(
        onWillPop: ()async{
          print("back button presed");
          Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          //Categories.changeNotifierCategoriesBackPressed.sink.add("back hah ");
          //return false ;
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
            "مرحبا",
            style: AqarFont.baseFontStyle(),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: new IconButton(icon: new Image.asset("images/asset17.png")),
              iconSize: 40.0,
              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
              onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
            ),
          ],
          leading: new IconButton(
              icon: new Image.asset("images/actionback.png"),
              iconSize: 30.0,
              padding: EdgeInsets.fromLTRB(20, 17, 0, 17),
              onPressed: () => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => ChooseUser()))),
        ),
        body:  Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
            padding: EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                // child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: 40, left: 40, bottom: 10, top: 50),
                      width: MediaQuery
                          .of(_context)
                          .size
                          .width,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            colors: [bgColor, bgColor],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.5, 2.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          userNameInputs(),
                          appButtonbgimage('الدخول', () => Submit(),
                              bgColor: desgin_button1_start,
                              bgColor2: desgin_button1_end),
                              Container(
                                height: 20,
                              ),
                          shareAppButtonbgimage(
                          ' مشاركه التطبيق',
                          () =>Share.share('قم بتحميل تطبيق منصه https://play.google.com/store', subject: 'تطبيق منصه '),
                          bgColor: desgin_button1_start, bgColor2: desgin_button1_end),    
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "حقوق البرنامج محفوظه لدي مؤسسه",
                        textAlign: TextAlign.center,
                        style: AqarFont.getBoldFont(),
                      ),
                    ),
                    Container(
                      child: Text(
                        "دليل التطبيقات للاتصالات و تقنيه المعلومات",
                        textAlign: TextAlign.justify,
                        style: AqarFont.getBoldFont(),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      
        ),
        
        
          endDrawer: buildDrawer()
        ),
        ),
        );
    
    
    
  }

  userNameInputs() {
    _context = context;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(child: _buildCard()),
    );
  }

  // #docregion Card
  Widget _buildCard() =>
      SizedBox(
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 20),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Image.asset(
                'images/logo_head.png',
                height: 150,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        key: emailKey,
                        initialValue: user.tempUserName,
                        scrollPadding: EdgeInsets.only(
                            right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الايميل/ رقم الجوال",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: " .......05",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textDirection: TextDirection.rtl,
                        textInputAction: TextInputAction.next,
                        cursorColor: desgin_button4_end,
                       // keyboardType: TextInputType.number,
                        obscureText: true,
                        key: passwordKey,
                        scrollPadding:
                        EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "كلمه السر",
                          alignLabelWithHint: true,
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "يرجي كتابه كلمه السر",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  value: monVal,
                  onChanged: (bool value) {
                    setState(() {
                      monVal = value;
                    });
                  },
                ),
                Text(
                  'تذكرني',
                  textAlign: TextAlign.start,
                  style: AqarFont.getinputFont(),
                ),
                // Container(
                //   width: 10,
                // ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgetPass()));
                    },
                    child: Text(
                      'نسيت كلمه المرور ؟', style: AqarFont.getinputFont(),),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.transparent)),
                  ),
                ),

              ],
            ),
            Container(
              height: 90,
            ),
            
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
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

  

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final Firestore _db = Firestore.instance;
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
      FirebaseMessaging().onTokenRefresh.listen((newToken) {
        // Save newToken
        print("Token expired : $newToken");
      });
    }
  }
  
  Submit() async {
    showAppLoading(_context);
    try {
      if (_formKey.currentState.validate()) {
        var mail = emailKey.currentState.value.toString().trim();
        // if (validateboth(mail,
        //     passwordKey.currentState.value.toString()) == true) {
        if (true) {
              String fcmToken = await _firebaseMessaging.getToken();
              print("My FCM : $fcmToken");
              _saveDeviceToken();
              AuthApi.login(mail, passwordKey.currentState.value ,fcmToken ).then((response) {
             //   print("after login :"+response.data.Email);
                if (response.code ==200 ) {
                  //print("inside 2oo :"+response.data.Email);
                  print(response.data.Email.toString());
                  saveUser(response.data).then((done) async {
                    if (done){
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString("tempUserName", mail);
                      print(prefs.getString('tempUserName'));
                    //  hideAppDialog(_context);
                      print(response.data);
                      hideAppDialog(_context);
                              

                      Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (_context) => MyServices()));
                    }
                        

                  }, onError: (error) {
                    print("saving user Error : :  :$error");
                  });
                  //  Navigator.of(_context).push(MaterialPageRoute(
                  //                      builder: (context) => ConfirmationCode(response.data)));
                  // });
                } else {
                  hideAppDialog(_context);
                  showInSnackBar(response.message, _context, _scaffoldKey);
                // showInSnackBar("${response.message}", _context, _scaffoldKey_reg);
                  print("${response.message}");
                  //showInSnackBar("${response.message}", context, _scaffoldKey);
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
          // _bloc.login(
          //     emailKey.currentState.value, passwordKey.currentState.value);
        }
        else {
          hideAppDialog(context);
        }
      } else {
        hideAppDialog(context);
      }


    } catch (error) {
      hideAppDialog(context);
      showSnack(error.toString());
    }
    ;
  }

  bool validateboth(String value, String value2) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      showSnack("يجب ادخال ايميل او رقم الجوال اولاً");
    } else if (!regExp.hasMatch(value)) {
      showSnack("يجب ادخال ايميل صحيح");
    }
    else if (value2.isEmpty) {
      showSnack("يجب ادخال كلمه السر اولاً");
    }
    else {
      return true;
    }
  }

}