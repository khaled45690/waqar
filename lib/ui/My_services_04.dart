import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/strings.dart';

import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'About_us.dart';
import 'Contact_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Update_useraccount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:dio/dio.dart';


class My_services_04 extends StatefulWidget {
  @override
  _My_services_04State createState() => new _My_services_04State();
}

class _My_services_04State extends State<My_services_04> {
  BuildContext _context;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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


  String office = "";
  String adds = "";
  String category = "";
  String target = "";

  int _radioValue1 = -1;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;

  var aqartypeKey = GlobalKey<FormFieldState>();
  var distinctKey = GlobalKey<FormFieldState>();
  var cityKey = GlobalKey<FormFieldState>();
  var aqarageKey = GlobalKey<FormFieldState>();
  var aqarareaKey = GlobalKey<FormFieldState>();
  var aqarpriceKey = GlobalKey<FormFieldState>();
  var aqardetailsKey = GlobalKey<FormFieldState>();


String _path;
Map<String, String> _paths;
Map<String, String> _paths2;
String _extension;
String _extension2;
FileType _pickType=FileType.ANY;
bool _multiPick = true;
String uploadTxt1="";
File file;
String firstUpload="";
String secondUpload="";
int lblFirstUpload=0;
int lblSecondUpload =0;
List<Asset> images = List<Asset>();
 List<int> _files = List<int>();

 int imagesUploadedCount=0;
 int imagesUploadedCount_InsideUpload=0;
// List<int>_files=null;
 void _upload_Base64_V2(String base64 , String name) {
  
  UploadApi.upload_Base64AndReturnId2(base64 , name).then((response) {
      if (response.code ==200 ) {
        setState(() {
          _files.add(response.data);
          lblFirstUpload=lblFirstUpload+1;
          firstUpload=firstUpload+response.data.toString()+",";
        });
        print(response.message);
      } else {
        print("${response.message}");
      }
      setState(() {
        imagesUploadedCount_InsideUpload=imagesUploadedCount_InsideUpload+1;
      });
      if(imagesUploadedCount_InsideUpload == imagesUploadedCount){
          hideAppDialog(_context);
        }
    });
 }

Future<void> loadAssets() async {
  imagesUploadedCount = 0;
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
       //_pickImage(_context);
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: false,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          //actionBarColor: "#abcdef",
          //actionBarTitle: "Example App",
          allViewTitle: "Choose Images",
          //useDetailsView: false,
          //selectCircleStrokeColor: "#000000",
        ),
      );
      print("Assets");
      String  base64Image;
      List<MultipartFile> multipart = List<MultipartFile>();
imagesUploadedCount = resultList.length;
if(resultList.length>0){
  showAppLoading(_context);
}
                for (int i = 0; i < resultList.length; i++) {
                  //AssetImage('graphics/background.png')
                 print(resultList[i].identifier);
                 print(resultList[i]);
                 print(resultList[i].name);
                 ByteData byteData = await resultList[i].getByteData(quality: imageQualityForMultipleImages);
                 List<int> imageData = byteData.buffer.asUint8List();
                base64Image = base64Encode(imageData);
                 print(imageData);
                 print(base64Image);
                 _upload_Base64_V2(base64Image , resultList[i].name);
                //  _upload_Base64_pass_Base46(base64Image , resultList[i].name);
                //  ByteData bytes = await rootBundle.load(resultList[i].name);
                // var buffer = bytes.buffer;
                // var m = base64.encode(Uint8List.view(buffer));
                // print(m);
                } 
      print(resultList);
      
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
     // _error = error;
    });
  }
 
void openFileExplorer() async {
    try {
      
      //_path = null;
      if (_multiPick) {
        _paths = await FilePicker.getMultiFilePath(
            type: _pickType, fileExtension: _extension);
           // showAppLoading(_context);
          // lblFirstUpload="Loading ....";
        _paths.forEach((fileName, filePath) => {upload(fileName, filePath)});  
       
        print("Length");
        print( _paths.length); 
       // hideAppDialog(_context); 
      } else {
        _path = await FilePicker.getFilePath(
            type: _pickType, fileExtension: _extension);
           
      }
      print("pathssssssss");
      //print(_paths);
     // lblFirstUpload=_paths.length.toString();
    }  catch (e) {
      print("Unsupported operation");
    }
   // hideAppDialog(_context);
    if (!mounted) return;
}
// List<int>_files=null;
void _upload_Base64(File file) {
  
  UploadApi.upload_Base64AndReturnId(file).then((response) {
      if (response.code ==200 ) {
        setState(() {
          _files.add(response.data);
          lblFirstUpload=lblFirstUpload+1;
          firstUpload=firstUpload+response.data.toString()+",";
        });
        print(response.message);
      } else {
        print("${response.message}");
      }
    });
 }
  upload(fileName, filePath) {
    file = new File(filePath);
    _upload_Base64(file);
    _extension = fileName.toString().split('.').last;
    setState(() {
    });
  }
//////////////
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
            "بيانات العقار(التقبيل)",
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
                          appButtonbgimage('تنازل', () => {},
                              bgColor: desgin_button4_start,
                              bgColor2: desgin_button4_start),
                          Container(
                            height: 20,
                          ),
                          userNameInputs(),
                          appButtonbgimage('إرسال الطلب', () => {},
                              bgColor: desgin_button1_start,
                              bgColor2: desgin_button1_end),
                          Container(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Membership(userVM.Id)));
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
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
        child: Padding(
                padding: EdgeInsets.all(0),
                child: Builder(
                  builder: (cont) => SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
          textDirection: TextDirection.rtl,
          children: [
            Text(
                  '*',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFont(),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("إيجار"),
                Checkbox(
                  value: monVal,
                  onChanged: (bool value) {
                    setState(() {
                      monVal = value;
                    });
                  },
                ),
                Container(
                  width: 30,
                ),
                Text("بيع"),
                Checkbox(
                  value: monVal_1,
                  onChanged: (bool value) {
                    setState(() {
                      monVal_1 = value;
                    });
                  },
                ),
              ],
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
                        key: aqartypeKey,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "نوع العقار *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "نوع العقار",
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
            Container(
              child: Text(
                "التصنيف *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField3(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("اداري"),
                Checkbox(
                  value: monVal_2,
                  onChanged: (bool value) {
                    setState(() {
                      monVal_2 = value;
                    });
                  },
                ),
                Container(
                  width: 5,
                ),
                Text("سكني"),
                Checkbox(
                  value: monVal_3,
                  onChanged: (bool value) {
                    setState(() {
                      monVal_3 = value;
                    });
                  },
                ),
                Container(
                  width: 5,
                ),
                Text("تجاري"),
                Checkbox(
                  value: monVal_4,
                  onChanged: (bool value) {
                    setState(() {
                      monVal_4 = value;
                    });
                  },
                ),
              ],
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
                        key: cityKey,
                        maxLength: maxLengthForCharacters,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "المدينه *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "المدينه",
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
                        key: distinctKey,
                        maxLength: maxLengthForCharacters,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الحي *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "الحي",
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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "عمر العقار *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "العمر",
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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "المساحه *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "+متر مربع",
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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "السعر *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "12.3",
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


            Container(
              child: Text(
                "مواصفات العقار *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),

            Container(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded( // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLength: 2000,
                        maxLines: 3,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الوصف ",
                          fillColor: Colors.blueGrey,
                         // hintText: "Description in 2000 characters",
                          border:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'images/upload.png',
                      height: 50,
                      width: 60,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    width: 5,
                  ),
                  Container(
                      height: 45,
                      width: 180,
                      child: appButtonbgimage('ارفاق الصور', () => {},
                          bgColor: desgin_button4_start,
                          bgColor2: desgin_button4_start),
                  ),
                ]
            ),

            Container(
              height: 10,
            ),

            Container(
              child: Text(
                "بيانات المعلن *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
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
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "زقم الجوال *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "زقم الجوال",
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

                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
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
  @override
  void initState() {
    restore();
    super.initState();
    getUser().then((user){
      setState(() {
              this.userVM = user ;
      });
    });
  }

  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      
    });
  }

  Submit() {
    showAppLoading(_context);
    if(aqartypeKey.currentState.value==null || aqartypeKey.currentState.value ==""){
      hideAppDialog(_context);
        showInSnackBar("من فضلك قم بادخال نوع العقار", _context, _scaffoldKey);
    }else{
      if (_formKey.currentState.validate()) {
      ServiceDataVM model = new ServiceDataVM();
      model.ServiceId=3;
      if(target=="بيع"){
        model.ForSell=true;
        model.ForRent=false;
      }else{
        model.ForSell=false;
        model.ForRent=true;
      }
      model.City=cityKey.currentState.value;
      model.BuildingType=aqartypeKey.currentState.value;
      model.District=distinctKey.currentState.value;
      model.BuildingAge=aqarageKey.currentState.value;
      String price = aqarpriceKey.currentState.value.toString()
      .replaceAll("٠", "0")
      .replaceAll("١", "1").replaceAll("٢", "2").replaceAll("٣", "3")
      .replaceAll("٤", "4").replaceAll("٥", "5").replaceAll("٦", "6")
      .replaceAll("٧", "7").replaceAll("٨", "8")
      .replaceAll("٩", "9").replaceAll(" ", "").replaceAll(".", "").trim();
      print(price);
      print(aqarpriceKey.currentState.value.toString());
      model.BuildingPrice=double.parse(price);
      model.Description=aqardetailsKey.currentState.value;
     model.files=_files;
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


  @override
  void dispose() {
    super.dispose();
  }
}


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
