import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';

import 'About_us.dart';
import 'Contact_us.dart';
import 'HomeScreen.dart';

import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:waqarapp/API/RequestsAndResponses/ForgetBloc.dart';

import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => new _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> with WidgetsBindingObserver {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";
  var emailKey = GlobalKey<FormFieldState>();



  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;
    return  Container(
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
                  "إستعاده كلمه المرور",
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
                      onPressed: () => Navigator.of(context).pop()),
              ),
              body: Directionality(
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
                                appButtonbgimage('إرسال', () => Submit(),
                                    bgColor: desgin_button1_start,
                                    bgColor2: desgin_button1_end),
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
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Image.asset(
                'images/forget.png',
                height: 300,
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
                        scrollPadding: EdgeInsets.only(
                            right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الايميل",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "الايميل/ رقم الجوال",
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

  @override
  void initState() {
    restore();
    super.initState();

  }

  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      email = Prefs.getString('email') ?? "";
    });
  }

  Submit() {
    showAppLoading(context);
    try {
      if (_formKey.currentState.validate()) {
        if (validateboth(emailKey.currentState.value.toString()) == true) {
            AuthApi.rememberPass(emailKey.currentState.value.toString()).then((response) {
                if (response.code ==200 ) {
                      print(response.data);
                      hideAppDialog(_context);
                      showInSnackBar(response.message, _context, _scaffoldKey);
                } else {
                  hideAppDialog(_context);
                  print("${response.message}");
                }
                setState(() {
                });
              }, onError: (error) {
                hideAppDialog(_context);
                print("login Error : : :$error");
                setState(() {
                });
              });

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

  bool validateboth(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      showSnack("يجب ادخال ايميل او رقم الجوال اولاً");
    } else if (!regExp.hasMatch(value)) {
      showSnack("يجب ادخال ايميل صحيح");
    }
    else {
      return true;
    }
  }

}