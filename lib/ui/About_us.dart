import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waqarapp/API/ContentApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/model/ContentVM.dart';

import 'Contact_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Update_useraccount.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';

class About_us extends StatefulWidget {
  @override
  _About_usState createState() => new _About_usState();
}

class _About_usState extends State<About_us> {

  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UnboundedScrollController _negativeController = new UnboundedScrollController();
  String name="";
  String email="";
@override
  void initState() {
    print("Start About App");
    super.initState();
    //post=getAboutApp();
    ContentApi.getAboutApp().then((response){
      if(response.code !=200){
        Navigator.pop(context);
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
     // this.apiCall = false ;
    });
  }
  bool apiCall = true ;
ContentVM content = new ContentVM();
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    var screenSize = MediaQuery.of(context).size;
    _context = context;
    return  Scaffold(
        key: _scaffoldKey,
        backgroundColor: gray,


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
    "عن الشركه",
    style: AqarFont.baseFontStyle(),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    elevation: 0.0,
    leading: new IconButton(
    icon: new Image.asset("images/actionback.png"),
    iconSize: 30.0,
    padding: EdgeInsets.fromLTRB(20, 17, 0, 17),
    onPressed: () => Navigator.of(context).pop()),
    actions: <Widget>[
      IconButton(
        icon: new IconButton(icon: new Image.asset("images/asset17.png")),
        iconSize: 40.0,
        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
        onPressed: () => _scaffoldKey.currentState.openEndDrawer(),

      ),
    ],
    ),

    body: Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        children: <Widget>[
         
            new Image.asset(
              "images/logo_head.png",
              height: 150.0,
              width: 150.0,
            ),
            new SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.all(16.0),
               child: this.apiCall ? Center(child: CircularProgressIndicator(),):Text(content.valueAr.toString() , 
              //child:Text('تطبيق وسيط عقاري ..................', 
            style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    //fontStyle: FontStyle.italic,
                    // padding: EdgeInsets.all(24.0),
                    color: Colors.black)),
            ),
            
          ],
      ),
    ),
    
          endDrawer: buildDrawer()
        );
  }




  restore() async {
    final SharedPreferences Prefs= await SharedPreferences.getInstance();
    setState(() {
      name=Prefs.getString('username') ?? "";
      email= Prefs.getString('email') ?? "";
    });
  }

@override
void dispose() {
  super.dispose();
}
}

