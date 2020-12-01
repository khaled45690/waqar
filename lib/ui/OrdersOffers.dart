import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'About_us.dart';
import 'Contact_us.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'Update_useraccount.dart';

import 'package:waqarapp/API/RequestsAndResponses/OrdersBloc.dart';
import 'package:waqarapp/utilis/json_table_column.dart';
import 'package:waqarapp/utilis/json_table.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';

class OrdersOffers extends StatefulWidget {
  @override
  _OrdersOffersState createState() => new _OrdersOffersState();
}

class _OrdersOffersState extends State<OrdersOffers> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  bool toggle = true;
  String user_id="";
  bool first=true;
  List<JsonTableColumn> columns = [
  JsonTableColumn("date", label: "التاريخ"),
  JsonTableColumn("details", label: "تفاصيل الطلب"),
  JsonTableColumn("number", label: "رقم الطلب"),
  JsonTableColumn("id", label: "رقم"),

  ];
  String   jsonSample =
      '[{"date":"١٠/١١/٢٠١٩","details":"فيلا للايجار","number":"١","id":"١","type":"١"},'
          '{"date":"١١/١٢/٢٠١٩","details":"محل للايجار","number":"٢","id":"٢","type":"١"},'
          '{"date":"١٣/١٢/٢٠١٩","details":"فيلا للايجار","number":"٣","id":"٣","type":"١"},'
          '{"date":"١٦/١٢/٢٠١٩","details":"فيلا للايجار","number":"٤","id":"٤","type":"١"},'
          '{"date":"","details":"","number":"","id":"٥","type":"١"},'
          '{"date":"","details":"","number":"","id":"٦","type":"١"},'
          '{"date":"","details":"","number":"","id":"٧","type":"١"},'
          '{"date":"","details":"","number":"","id":"٨","type":"١"},'
          '{"date":"","details":"","number":"","id":"٩","type":"١"},'
          '{"date":"","details":"","number":"","id":"١٠","type":"١"},'
          '{"date":"","details":"","number":"","id":"١١","type":"١"},'
          '{"date":"","details":"","number":"","id":"١٢","type":"١"},'
          '{"date":"","details":"","number":"","id":"١٣","type":"١"},'
          '{"date":"","details":"","number":"","id":"١٤","type":"١"},'
          '{"date":"","details":"","number":"","id":"١٥","type":"١"}'

          ']';
  @override
  void initState() {
    restore();
    super.initState();
//     _bloc.OrderSubject.listen((data) async {
// //      jsonSample =
// //      '[{"date":"١٠/١١/٢٠١٩","details":"فيلا للايجار","number":"١٢٥٨٣٣","id":"١"},'
// //          '{"date":"١١/٢/٢٠١٩","details":"شقه للايجار","number":"١٢٥٨٦٣","id":"٢"},'
// //          '{"date":"١٣/١٢/٢٠١٩","details":"شقه للايجار","number":"١٢٥٨٦١","id":"٣"},'
// //          '{"date":"١٦/١٢/٢٠١٩","details":"محطه بنزين","number":"١٢٥٣٦١","id":"٤"}'
// //          ']';

//     }, onError: (error) {
//       hideAppDialog(context);
//       showSnack(error);
//     });
  }

  restore() async {
    final SharedPreferences Prefs= await SharedPreferences.getInstance();
    setState(() {
      user_id=Prefs.getString('userID') ?? "";
    });
  }


  Submit() {
   
//    showAppLoading(_context);
//    try {
//        _bloc.getorder(user_id);
//    } catch (error) {
//      hideAppDialog(_context);
//      showSnack(error.toString());
//    };
  }



  @override
  void dispose() {
//    _bloc.OrderSubject.close();
//    _bloc.dispose();
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
  Widget build(BuildContext context) {

    var json = jsonDecode(jsonSample);

    // TODO: implement getBody
    var screenSize = MediaQuery.of(context).size;
    _context = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
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
            "الطلبات والعروض",
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


          body: Padding(
            padding: EdgeInsets.all(0),
            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "العروض الملغاه او المنتهيه ",
                        textAlign: TextAlign.center,
                        style: AqarFont.getLightFont_TextFormsmall(),
                      ),
                      appButtonbsmall('', () => {},
                          bgColor: desgin_button_red,
                          bgColor2: desgin_button_red),

                    Container(
                      width: 5,
                    ),
                      Text(
                        "العروض المرسله",
                        textAlign: TextAlign.center,
                        style: AqarFont.getLightFont_TextFormsmall(),
                      ),
                      appButtonbsmall('', () => {},
                          bgColor: desgin_button4_end,
                          bgColor2: desgin_button4_end),

                    ]
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "الطلبات الملغاه او المنتهيه ",
                        textAlign: TextAlign.center,
                        style: AqarFont.getLightFont_TextFormsmall(),
                      ),
                      appButtonbsmall('', () => {},
                          bgColor: desgin_button_red_back,
                          bgColor2: desgin_button_red_back),
//                      Container(
//                        width: 5,
//                      ),
                      Text(
                        "الطلبات المستلمه",
                        textAlign: TextAlign.center,
                        style: AqarFont.getLightFont_TextFormsmall(),
                      ),
                      appButtonbsmall('', () => {},
                          bgColor: desgin_button4_start,
                          bgColor2: desgin_button4_start),

                    ]
                ),

                Container(
                    margin: EdgeInsets.only(right: 35, left: 35, bottom: 0, top: 10),
                    width: MediaQuery.of(_context).size.width,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          colors: [bgColor, bgColor],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(0.5, 2.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(40),
                    ),

                    child: Column(
                    children: [
                      Container(
                            margin: EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 25),
                        child: Column(
                            children: [
//                            Submit(),
                            JsonTable(json, columns: columns, showColumnToggle: true),
                  ]
                        ),
                      ),

                          appButtonbgimage(
                              'طباعه الصفحه',
                                  () => {},
                              bgColor: desgin_button1_start,
                              bgColor2: desgin_button1_end),
                        ])),
//               Container(
//                        height: 20,
//                      ),
                Container(
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
                    style: AqarFont.getsmallFont(),
                  ),
                ),
                Container(
                  height: 5,
                ),
              ]),
          ),
        ),

        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                  color: gray,
                  image: DecorationImage(
                      fit: BoxFit.none,
                      alignment: Alignment.center,
                      image:AssetImage('images/asset15.png') ),
                  gradient: new LinearGradient(
                    colors: [desgin_button1_start, desgin_button1_start],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),

                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('الرئيسيه',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                onTap: () {
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('تعديل بياناتي',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Update_useraccount()));
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('خدماتي',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyServices()));
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('العضويه',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Membership(user_id)));
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('الدفع',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('الطلبات والعروض',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrdersOffers()));
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('تواصل معنا',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact_us()));
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                title: Text('عن الشركه',style: AqarFont.baseRegularcolorFont(),textAlign: TextAlign.right,),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => About_us()));
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Divider(
                indent: 40.0,
                endIndent: 40.0,
                height: 2.0,
                color: gray,
              ),

            ],
          ),
        ),

        ),
      ),
    );


  }


}
