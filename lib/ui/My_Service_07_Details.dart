import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/API/ComplaintApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/API/UserAcceptServiceApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';

import 'About_us.dart';
import 'AllAvailableOffers.dart';
import 'Contact_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OfficeAcceptService.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'ServiceGalary.dart';
import 'Update_useraccount.dart';

import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:url_launcher/url_launcher.dart';


class My_Service_07_Details extends StatefulWidget {
  ServiceDataVM serviceData;
  My_Service_07_Details(this.serviceData);
  @override
  _My_Service_07_DetailsState createState() => new _My_Service_07_DetailsState();
}

class _My_Service_07_DetailsState extends State<My_Service_07_Details> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image = null;
  String urlImage = "";
  bool monVal = false;
  bool monVal_1 = false;
  bool monVal_2 = false;
  bool monVal_3 = false;
  bool monVal_4 = false;
  bool monVal_5 = false;
  bool monVal_6 = false;
  bool monVal_7 = false;
  String name="";
  String email="";
  String user="";
  String usertype="";


String target = "";
  String office = "";
  String adds = "";
  String category = "";

 int _radioValue1 = -1;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;

var lessorNameKey = GlobalKey<FormFieldState>();
var lessorAddressKey = GlobalKey<FormFieldState>();
  var lessorPhoneKey = GlobalKey<FormFieldState>();
  var lessorEmailKey = GlobalKey<FormFieldState>();
  var lessorElectricityKey = GlobalKey<FormFieldState>();
  var lessorBankKey = GlobalKey<FormFieldState>();

  var tenantNameKey = GlobalKey<FormFieldState>();
  var tenantPhoneKey = GlobalKey<FormFieldState>();
  var tenantEmailKey = GlobalKey<FormFieldState>();
  var tenantAddressKey = GlobalKey<FormFieldState>();
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;

    var screenSize = MediaQuery.of(_context).size;

    return Scaffold(
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
            "تفاصيل عقد موحد",
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
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: 30, left: 30, bottom: 50, top: 20),
                      width: screenSize.width,
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
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          Container(
                            height: 20,
                          ),
                          // appButtonbgimage('طلب تسجيل عقد موحد', () => {},
                          //     bgColor: desgin_button4_start,
                          //     bgColor2: desgin_button4_start),
                          Container(
                            height: 20,
                          ),
                          userNameInputs(),
                          // appButtonbgimage('إرسال الطلب', () =>Submit(),
                          //     bgColor: desgin_button1_start,
                          //     bgColor2: desgin_button1_end),
                          Container(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
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
                      height: 20,
                    ),
                  ],
                ),
              ),
            )),
        ),
        
      endDrawer: buildDrawer()

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
  Widget _buildCard() => SizedBox(
        child:  Padding(
                padding: EdgeInsets.all(0),
                child: Builder(
                  builder: (cont) => SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              child: Text(
                "بيانات المؤجر",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField3(),
              ),
            ),
            Container(
              height: 10,
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
                        maxLines: 1,
                        key: lessorNameKey,
                        initialValue: widget.serviceData.LessorName,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الاسم",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "الاسم",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: gray, width: 1.0),
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
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: lessorAddressKey,
                        textAlign: TextAlign.right,
                        initialValue: widget.serviceData.LessorAddress,
                        enabled: false,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "العنوان",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "العنوان",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: lessorPhoneKey,
                        initialValue: widget.serviceData.LessorPhone,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "رقم الجوال",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "رقم الجوال",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: lessorEmailKey,
                        initialValue: widget.serviceData.LessorEmail,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الايميل",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "لاايميل",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: lessorElectricityKey,
                        initialValue: widget.serviceData.ElectricAccount,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "رقم حساب الكهرباء",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "رقم حساب الكهرباء",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: lessorBankKey,
                        initialValue: widget.serviceData.BankAccount,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "حساب البنك ",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "حساب البنك ايبان",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 15,
            ),
            Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
               //   onTap: openFileExplorer,
                  child: Container(
                  // child: Image.asset(
                  //   'images/captureImage2.PNG',
                  //   height: 55,
                  //   width: MediaQuery.of(_context).size.width-150 ,
                  //   fit: BoxFit.fill,
                  //   alignment: Alignment.center,
                    
                  // ),
                  
                ),
                ),
                  // Container(
                  //   child: Image.asset(
                  //     'images/upload.png',
                  //     height: 50,
                  //     width: 60,
                  //     fit: BoxFit.fill,
                  //     alignment: Alignment.center,
                  //   ),
                  // ),
                  // Container(
                  //   width: 5,
                  // ),
                  // Container(
                  //     height: 45,
                  //     width: 220,
                  //     child: appButtonbgimage('ارفق صوره الملكيه ', () => {},
                  //         bgColor: desgin_button4_start,
                  //         bgColor2: desgin_button4_start),
                  // ),
                ]
            ),

            Container(
              height: 15,
            ),
            Container(
              child: Text(
                "بيانات المستاجر",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField3(),
              ),
            ),
            Container(
              height: 10,
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
                        maxLines: 1,
                        key: tenantNameKey,
                        initialValue: widget.serviceData.TenantName,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الاسم",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "الاسم",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 1.0),
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
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: tenantAddressKey,
                        initialValue: widget.serviceData.TenantAddress,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "العنوان الوطني",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "العنوان الوطني",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: tenantPhoneKey,
                        initialValue: widget.serviceData.TenantPhone,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "رقم الجوال",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "رقم الجوال",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: tenantEmailKey,
                        initialValue: widget.serviceData.TenantEmail,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الايميل",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "الايميل",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
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
              height: 10,
            ),
            widget.serviceData.mainImage.contains("noLogo.jpg")?Container():Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(_context).size.width - 130,
                    child: Column(
                      children: <Widget>[
                        appButtonbgimage(
                          'صور الاعلان',
                          (){
                            if(userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null){
                                print("HHHHHH");
                                showInSnackBar("من فضلك قم بتسجيل الدخول للاطلاع علي الصور ", _context, _scaffoldKey);
                            }else{
                              Navigator.of(_context).push(MaterialPageRoute(builder: (context) => ServiceGalary(widget.serviceData.Id)));
                            }
                          },
                          bgColor: grey_ligth2,
                          bgColor2: grey_ligth2),
                      ],
                    ),
                  ),
                ]),

            Container(
              height: 15,
            ),
            (userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null)?Container() :widget.serviceData.UserId==userVM.Id?Container():Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                    child: Text(' رفض',
                        //style: AqarFont.baseRegularFont()
                        ),
                    onPressed: (){
                      AcceptOrRefuser( 1);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                    child: Text(' بلاغ',
                        style: AqarFont.baseRegularFont()),
                    onPressed: (){
                      _ComplaintShowDialog();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                    child: Text('قبول',
                        style: AqarFont.baseRegularFont()),
                    onPressed: (){
                      AcceptOrRefuser(2);
                    }
                  ),
                ),
                
              ],
            ),

            Container(
              height: 15,
            ),

            Container(
              height: 15,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(_context).size.width - 130,
                    child: Column(
                      children: <Widget>[
                        appButtonbgimage(
                          ' مكاتب قبلت الخدمه',
                          (){
                            Navigator.of(_context).push(MaterialPageRoute(builder: (context) => OfficeAcceptService(widget.serviceData.Id)));
                          },
                          bgColor: grey_ligth2,
                          bgColor2: grey_ligth2),
                      ],
                    ),
                  ),
                ]),

            Container(
              height: 15,
            ),
            widget.serviceData.UserId==userVM.Id?Container(): Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(_context).size.width - 130,
                    child: Column(
                      children: <Widget>[
                        appButtonbgimage(
                          'تواصل مع المعلن ',
                          () async {
                             try{
                               if(userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null){
                                      print("HHHHHHHHH");
                                      showInSnackBar("من فضلك قم بتسجيل الدخول للاتصال بالمعلن", _context, _scaffoldKey);
                               }else{
                                 //  mobileNum="552358049";
                                    String s= "https://wa.me/966"+mobileNum+"?text="+"هل "+(widget.serviceData.ServiceId==2?"الطلب رقم ":"العرض  رقم ")+widget.serviceData.Id.toString()+" "
                                    +"مازال متوفر ؟";
                                      await launch(s);//https://wa.me/${}?text=Hello
                                 
                               }
                              
                             }catch(Ex){
                                new CallService().call(mobileNum);
                             }

                          },
                          bgColor: grey_ligth2,
                          bgColor2: grey_ligth2),
//                         appButtonbgimage_normal(
//                             'ارفاق الصور',
//                             () => ImagePickerHelper().pickImage(_context,
//                                     (File image) {
//                                   setState(() {
//                                     // print(image.path);
//                                     upload(image);
// //                                    upload_2(image);
// //                                    startUpload(image);
//                                     // new UploadFileInfo(image, basename(image.path));
//                                     imagename =
//                                         imagename + basename(image.path) + ",";
//                                     _image = image;
//                                   });
//                                 }),
//                             bgColor: desgin_button_start,
//                             bgColor2: desgin_button_end),
                      ],
                    ),
                  ),
                ]),
                Container(
                  height: 20,
                ),
            Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
               //   onTap: openFileExplorer,
                  child: Container(
                  // child: Image.asset(
                  //   'images/captureImage3.PNG',
                  //   height: 55,
                  //   width: MediaQuery.of(_context).size.width-150 ,
                  //   fit: BoxFit.fill,
                  //   alignment: Alignment.center,
                    
                  // ),
                  
                ),
                ),
                  // Container(
                  //   child: Image.asset(
                  //     'images/upload.png',
                  //     height: 50,
                  //     width: 60,
                  //     fit: BoxFit.fill,
                  //     alignment: Alignment.center,
                  //   ),
                  // ),
                  // Container(
                  //   width: 5,
                  // ),
                  // Container(
                  //   height: 45,
                  //   width: 220,
                  //   child: appButtonbgimage('ارفق صوره الملكيه ', () => {},
                  //       bgColor: desgin_button4_start,
                  //       bgColor2: desgin_button4_start),
                  // ),
                ]
            ),

            Container(
              height: 15,
            ),

          ],
        ),
                    ),
                  ),
                ),
            ),
        );
        
      

  userProfileImage(BuildContext cont) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // new center image

        Center(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: bgColor,
                        blurRadius:
                            0.0, // has the effect of softening the shadow
                        spreadRadius:
                            0.0, // has the effect of extending the shadow
                        offset: Offset(
                          1.0, // horizontal, move right 10
                          1.0, // vertical, move down 10
                        ),
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: _image != null
                          ? FileImage(_image)
                          : urlImage == null || urlImage.isEmpty
                              ? AssetImage("images/profile_img.png")
                              : NetworkImage(urlImage),
                    )),
              ),
              Positioned(
                //  bottom: 0,
                left: 0,
                right: 0,
                child: IconButton(
                    color: Colors.transparent,
                    iconSize: 10000,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // ImagePickerHelper().pickImage(cont, (File image) {
                      //   setState(() {
                      //     print(image.path);
                      //     _image = image;
                      //   });
                      // });
                    }),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  UserVM userVM ;
  var mobileNum="";
  @override
  void initState() {
    restore();
    AuthApi.GetMobileNumber(widget.serviceData.UserId).then((response) {
        if (response.code ==200 ) {
           //  hideAppDialog(context);
            print("Response Code is 200");
            print(response.message);
            setState(() {
              mobileNum=response.message;
            });
          } else {
            print("${response.message}");
            //showInSnackBar("${response.message}", context, _scaffoldKey);
          }
        setState(() {
         //this.loginApi = false;
        });
      }, onError: (error) {
        print("login Error : : :$error");
        setState(() {
         // this.loginApi = false;
        });
      });
    super.initState();
    getUser().then((user){
      setState(() {
              this.userVM = user ;
      });
    });
  }

 restore() async {
    final SharedPreferences Prefs= await SharedPreferences.getInstance();
    setState(() {
      name=Prefs.getString('username') ?? "";
      email= Prefs.getString('email') ?? "";
      usertype= Prefs.getString('usertype') ?? "";

    });
  }
  _showDialogV2(String txt) async {
    print(txt);
    await showDialog<String>(
      context: _context,
      child: new _SystemPadding(child: new AlertDialog(
            title: Text(txt,
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text("",
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
              },
            ),
            ],
          ),),
    );
  }

  AcceptOrRefuser(int status){
  showAppLoading(_context);
  int serviceId = widget.serviceData.Id;
  String userId = userVM.Id;
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
             _showDialog(status);
          } else {
            print("failllllll");
            hideAppDialog(_context);
            print(response.message.toString());
            _showDialogV2(response.message.toString());
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
    
  //Call Api
  //showInSnackBar("الرقم السري اقل من 6 حروف", _context, _scaffoldKey);
  
}
_showDialog(int status) async {
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
            title: Text(txt,
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text("",
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
                // Navigator.of(_context)
                //     .push(MaterialPageRoute(builder: (context) => AllAvailableOffers()));
              },
            ),
            ],
          ),),
    );
  }


  _ComplaintShowDialog() async {
  
    await showDialog<String>(
      context: _context,
      child: new AlertDialog(
            title: Text('سبب الابلاغ',
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: SingleChildScrollView(
              child: Container(
              height: 155,
              child: Column(
              children: <Widget>[
                Text("سبب الابلاغ ",
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
                TextFormField(
                        maxLines: 8,
                        //key: nameKey,
                        //  scrollPadding: EdgeInsets.only(
                        //     right: 25, left: 25, bottom: 0),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        minLines: 4,
                        
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          //labelText: "اسم المكتب",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          //hintText: " المكتب",
                          // contentPadding: new EdgeInsets.symmetric(
                          //     vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //       color: Colors.grey, width: 1.0),
                          //   borderRadius: BorderRadius.circular(25.0),
                          // ),
                        ),
                      )
              ],
            ),
            ),
            ),
            
            actions: <Widget>[
              FlatButton(
              child: Text("نعم",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                SendComplaint();
              },
            ),
            ],
          ),
    );
  }
  SendComplaint(){
    showAppLoading(_context);
  int serviceId = widget.serviceData.Id;
  String userId = userVM.Id;
  bool isAccept = false;
    String text = "text";
    ComplaintApi.AddComplaint(userId, text, serviceId).then((response) {
          if (response.code ==200 ) {
            print("Suceeeeeees");
             hideAppDialog(_context);
             Navigator.of(_context).pop();
             Navigator.of(_context).pop();
                Navigator.of(_context)
                    .push(MaterialPageRoute(builder: (context) => MyServices()));
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
    
  //Call Api
  //showInSnackBar("الرقم السري اقل من 6 حروف", _context, _scaffoldKey);
  
  }
  
  Submit() {
    showAppLoading(_context);
    if (_formKey.currentState.validate()) {
      ServiceDataVM model = new ServiceDataVM();
      model.ServiceId=6;
      model.LessorName=lessorNameKey.currentState.value;
      model.LessorAddress=lessorAddressKey.currentState.value;
      model.LessorEmail=lessorEmailKey.currentState.value;
      model.LessorPhone=lessorPhoneKey.currentState.value;
      model.TenantAddress = tenantAddressKey.currentState.value;
      model.TenantEmail=tenantEmailKey.currentState.value;
      model.TenantName = tenantNameKey.currentState.value;
      model.TenantPhone=tenantPhoneKey.currentState.value;
      
     model.UserId=userVM.Id;
     ServiceDataApi.addService(model).then((response) {
          if (response.code ==200 ) {
            hideAppDialog(_context);
            _displayDialog(_context , response.data.Id);
           // print(object)
         //   showInSnackBarAfterAddService(AppLocalizations.of(_context).lblServiceAdded, _context, _scaffoldKey);
   
           // showInSnackBar("تم اضافه الخدمه الي سله الطلبات", _context, _scaffoldKey);
           // showSnack("تم اضافه الخدمه الي سله المهملات");
          } else {
            print("${response.message}");
            //showInSnackBar("${response.message}", context, _scaffoldKey);
          }
          setState(() {
          //this.loginApi = false;
          });
        }, onError: (error) {
          print("login Error : : :$error");
          setState(() {
          // this.loginApi = false;
          });
        });
  
  
  }
  }

  @override
  void dispose() {
    super.dispose();
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
  

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("تم",textAlign: TextAlign.right,style:AqarFont.getLightFont_TextFormField()),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تاكيد",textAlign: TextAlign.right,style:AqarFont.getLightFont_TextFormField()),
      content: Text("هل تريد الخروج",textAlign: TextAlign.right,style:AqarFont.getLightFont_TextFormField()),
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
  }}


class DropdownExample extends StatefulWidget {
  String test="";
  DropdownExample(String s){
    test=s;
  }

  @override
  _DropdownExampleState createState() {
    return _DropdownExampleState(test);
  }
}

class _DropdownExampleState extends State<DropdownExample> {
  String _value;
  String title="";
  _DropdownExampleState(String s){
    title=s;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            child: Text('جازان'),
            value: 'جازان',
          ),
          DropdownMenuItem<String>(
            child: Text('عمران'),
            value: 'عمران',
          ),
        ],
        onChanged: (String value) {
          setState(() {
            _value = value;
          });
        },
        hint: Text(title),
        value: _value,
      ),
    );
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


