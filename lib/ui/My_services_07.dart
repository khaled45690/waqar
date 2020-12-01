import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';

import 'About_us.dart';
import 'Contact_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Update_useraccount.dart';

import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:file_picker/file_picker.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:dio/dio.dart';
class My_services_07 extends StatefulWidget {
  @override
  _My_services_07State createState() => new _My_services_07State();
}

class _My_services_07State extends State<My_services_07> {
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

String captureIdtxt ="";
int captureId =0;
int i=0;
List<Asset> images = List<Asset>();
 List<int> _files = List<int>();

  int imagesUploadedCount=0;
 int imagesUploadedCount_InsideUpload=0;
// List<int>_files=null;
 void _upload_Base64_V2(String base64 , String name) {
  
  UploadApi.upload_Base64AndReturnId2(base64 , name).then((response) {
      if (response.code ==200 ) {
        setState(() {
          captureIdtxt=captureIdtxt+captureId.toString()+",";

          // if(captureIdtxt.contains(captureId.toString())){
          // }
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
  imagesUploadedCount_InsideUpload =0;
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
                } 
      print(resultList);
      
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
     // _error = error;
    });
  }
 

 ////////////
 ///
  void _upload_Base64_V2_2(String base64 , String name) {
  
  UploadApi.upload_Base64AndReturnId2(base64 , name).then((response) {
      if (response.code ==200 ) {
        setState(() {
          captureIdtxt=captureIdtxt+captureId.toString()+",";

          // if(captureIdtxt.contains(captureId.toString())){
          // }
          _files.add(response.data);
          lblSecondUpload=lblSecondUpload+1;
          secondUpload=secondUpload+response.data.toString()+",";
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

Future<void> loadAssets_2() async {
  imagesUploadedCount = 0;
  imagesUploadedCount_InsideUpload =0;
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
                 _upload_Base64_V2_2(base64Image , resultList[i].name);
                } 
      print(resultList);
      
    } on Exception catch (e) {
      error = e.toString();
    }
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
            String fileName = _path.split('/').last;
            String filePath = _path;
        upload(fileName, filePath); 
           
      }
      setState(() {
        captureId=i;
        
      });
      print("pathssssssss");
      //print(_paths);
     // lblFirstUpload=_paths.length.toString();
    }  catch (e) {
      print("Unsupported operation");
    }
   // hideAppDialog(_context);
    if (!mounted) return;
}

void openFileExplorer2() async {
    try {
      
      //_path = null;
      if (_multiPick) {
        _paths = await FilePicker.getMultiFilePath(
            type: _pickType, fileExtension: _extension);
           // showAppLoading(_context);
          // lblFirstUpload="Loading ....";
        _paths.forEach((fileName, filePath) => {upload2(fileName, filePath)});  
       
        print("Length");
        print( _paths.length); 
       // hideAppDialog(_context); 
      } else {
        _path = await FilePicker.getFilePath(
            type: _pickType, fileExtension: _extension);
            String fileName = _path.split('/').last;
            String filePath = _path;
        upload(fileName, filePath); 
           
      }
      setState(() {
        captureId=i;
        
      });
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
          captureIdtxt=captureIdtxt+captureId.toString()+",";
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

 void _upload_Base64_2(File file) {
  
  UploadApi.upload_Base64AndReturnId(file).then((response) {
      if (response.code ==200 ) {
        setState(() {
          captureIdtxt=captureIdtxt+captureId.toString()+",";

          // if(captureIdtxt.contains(captureId.toString())){
          // }
          _files.add(response.data);
          lblSecondUpload=lblSecondUpload+1;
          secondUpload=secondUpload+response.data.toString()+",";
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
  upload2(fileName, filePath) {
    file = new File(filePath);
    _upload_Base64_2(file);
    _extension = fileName.toString().split('.').last;
    setState(() {
    });
  }
//////////////
///
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
            "عقد موحد",
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
                          appButtonbgimage('طلب تسجيل عقد موحد', () => {},
                              bgColor: desgin_button4_start,
                              bgColor2: desgin_button4_start),
                          Container(
                            height: 20,
                          ),
                          userNameInputs(),
                          appButtonbgimage('إرسال الطلب', () =>Submit(),
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
                "بيانات المؤجر ",
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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الاسم *",
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

            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Expanded(
            //       // wrap your Column in Expanded
            //       child: Column(
            //         children: <Widget>[
            //           TextFormField(
            //             maxLines: 1,
            //             key: lessorAddressKey,
            //             textAlign: TextAlign.right,
            //             style: AqarFont.getLightFont(),
            //             decoration: InputDecoration(
            //               labelText: "العنوان",
            //               labelStyle: AqarFont.getLightFont_TextFormField(),
            //               fillColor: Colors.blueGrey,
            //               hintText: "العنوان",
            //               contentPadding: new EdgeInsets.symmetric(
            //                   vertical: 14.0, horizontal: 10.0),
            //               border: OutlineInputBorder(
            //                 borderSide:
            //                 const BorderSide(color: gray, width: 0.0),
            //                 borderRadius: BorderRadius.circular(25.0),
            //               ),
            //               focusedBorder: OutlineInputBorder(
            //                 borderSide: const BorderSide(
            //                     color: Colors.grey, width: 1.0),
            //                 borderRadius: BorderRadius.circular(25.0),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   height: 10,
            // ),

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
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "رقم الجوال *",
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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الايميل *",
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
                        key: lessorBankKey,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "حساب البنك *",
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
                  onTap: (){
                    setState(() {
                      i=4;
                    });
                    loadAssets();
                  },
                  child: Container(
                  child: Image.asset(
                    'images/captureImage.PNG',
                    height: 40,
                    width: MediaQuery.of(_context).size.width-150 ,
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                    
                  ),
                  
                ),
                ),
               
                ]
            ),
            Container(
                  child: Text(
                    "ارفاق صور الهويه للمالك او الوكيل - صوره الصك - صوره الوكاله - صور العنوان الوطني - رقم العقار - رقم الحساب البنكي - رقم المبني - رقم الوحده ",
                    textAlign: TextAlign.center,
                    style: AqarFont.getinputFont(),
                  ),
                ),
            Container(
              height: 15,
            ),
            Container(
              child: Text(
                "تم رفع $lblFirstUpload صوره",
                textAlign: TextAlign.center,
                style: AqarFont.getinputFont(),
              ),
            ),
            // Row(

            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       GestureDetector(
            //       onTap: (){
            //         setState(() {
            //           i=1;
            //         });
            //         openFileExplorer();
            //       },
            //       child: Container(
            //       child: Image.asset(
            //         'images/captureImage.PNG',
            //         height: 55,
            //         width: MediaQuery.of(_context).size.width-180 ,
            //         fit: BoxFit.fill,
            //         alignment: Alignment.center,
                    
            //       ),
                  
            //     ),
            //     ),
            //     Container(
            //       child: Text(
            //         captureIdtxt.contains(1.toString())?"تم الرفع":"",
            //         textAlign: TextAlign.center,
            //         style: AqarFont.getinputFont(),
            //       ),),
            //       // Container(
            //       //   child: Image.asset(
            //       //     'images/upload.png',
            //       //     height: 50,
            //       //     width: 60,
            //       //     fit: BoxFit.fill,
            //       //     alignment: Alignment.center,
            //       //   ),
            //       // ),
            //       // Container(
            //       //   width: 5,
            //       // ),
            //       // Container(
            //       //     height: 45,
            //       //     width: 220,
            //       //     child: appButtonbgimage('ارفق صوره الملكيه ', () => {},
            //       //         bgColor: desgin_button4_start,
            //       //         bgColor2: desgin_button4_start),
            //       // ),
            //     ]
            // ),

            // Container(
            //   height: 15,
            // ),
            // Row(

            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       GestureDetector(
            //       onTap: (){
            //         setState(() {
            //           i=2;
            //         });
            //         openFileExplorer();
            //       },
            //       child: Container(
            //       child: Image.asset(
            //         'images/captureImage2.PNG',
            //         height: 55,
            //         width: MediaQuery.of(_context).size.width-180 ,
            //         fit: BoxFit.fill,
            //         alignment: Alignment.center,
                    
            //       ),
                  
            //     ),
            //     ),
            //     Container(
            //       child: Text(
            //         captureIdtxt.contains(2.toString())?"تم الرفع":"",
            //         textAlign: TextAlign.center,
            //         style: AqarFont.getinputFont(),
            //       ),),
            //       // Container(
            //       //   child: Image.asset(
            //       //     'images/upload.png',
            //       //     height: 50,
            //       //     width: 60,
            //       //     fit: BoxFit.fill,
            //       //     alignment: Alignment.center,
            //       //   ),
            //       // ),
            //       // Container(
            //       //   width: 5,
            //       // ),
            //       // Container(
            //       //     height: 45,
            //       //     width: 220,
            //       //     child: appButtonbgimage('ارفق صوره الملكيه ', () => {},
            //       //         bgColor: desgin_button4_start,
            //       //         bgColor2: desgin_button4_start),
            //       // ),
            //     ]
            // ),

            // Container(
            //   height: 15,
            // ),
            // Row(

            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       GestureDetector(
            //       onTap: (){
            //         setState(() {
            //           i=3;
            //         });
            //         openFileExplorer();
            //       },
            //       child: Container(
            //       child: Image.asset(
            //         'images/captureImage3.PNG',
            //         height: 55,
            //         width: MediaQuery.of(_context).size.width-180 ,
            //         fit: BoxFit.fill,
            //         alignment: Alignment.center,
                    
            //       ),
                  
            //     ),
            //     ),
            //     Container(
            //       child: Text(
            //         captureIdtxt.contains(3.toString())?"تم الرفع":"",
            //         textAlign: TextAlign.center,
            //         style: AqarFont.getinputFont(),
            //       ),
            //     ),
            //       // Container(
            //       //   child: Image.asset(
            //       //     'images/upload.png',
            //       //     height: 50,
            //       //     width: 60,
            //       //     fit: BoxFit.fill,
            //       //     alignment: Alignment.center,
            //       //   ),
            //       // ),
            //       // Container(
            //       //   width: 5,
            //       // ),
            //       // Container(
            //       //     height: 45,
            //       //     width: 220,
            //       //     child: appButtonbgimage('ارفق صوره الملكيه ', () => {},
            //       //         bgColor: desgin_button4_start,
            //       //         bgColor2: desgin_button4_start),
            //       // ),
            //     ]
            // ),

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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الاسم *",
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

            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Expanded(
            //       // wrap your Column in Expanded
            //       child: Column(
            //         children: <Widget>[
            //           TextFormField(
            //             maxLines: 1,
            //             key: tenantAddressKey,
            //             textAlign: TextAlign.right,
            //             style: AqarFont.getLightFont(),
            //             decoration: InputDecoration(
            //               labelText: "العنوان الوطني",
            //               labelStyle: AqarFont.getLightFont_TextFormField(),
            //               fillColor: Colors.blueGrey,
            //               hintText: "العنوان الوطني",
            //               contentPadding: new EdgeInsets.symmetric(
            //                   vertical: 14.0, horizontal: 10.0),
            //               border: OutlineInputBorder(
            //                 borderSide:
            //                 const BorderSide(color: gray, width: 0.0),
            //                 borderRadius: BorderRadius.circular(25.0),
            //               ),
            //               focusedBorder: OutlineInputBorder(
            //                 borderSide: const BorderSide(
            //                     color: Colors.grey, width: 1.0),
            //                 borderRadius: BorderRadius.circular(25.0),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   height: 10,
            // ),

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
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.phone,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "رقم الجوال *",
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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الايميل *",
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
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "رقم حساب الكهرباء *",
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
            Container(
              height: 15,
            ),
            Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                  onTap: (){
                    setState(() {
                      i=4;
                    });
                    loadAssets_2();
                  },
                  child: Container(
                  child: Image.asset(
                    'images/captureImage.PNG',
                    height: 40,
                    width: MediaQuery.of(_context).size.width-150 ,
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                    
                  ),
                  
                ),
                ),
               
                ]
            ),
            Container(
                  child: Text(
                    "ارفاق صور الهويه - كرت العائله وجهين",
                    textAlign: TextAlign.center,
                    style: AqarFont.getinputFont(),
                  ),
                ),
            Container(
              height: 15,
            ),
            Container(
              child: Text(
                "تم رفع $lblSecondUpload صوره",
                textAlign: TextAlign.center,
                style: AqarFont.getinputFont(),
              ),
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
    final SharedPreferences Prefs= await SharedPreferences.getInstance();
    setState(() {
      name=Prefs.getString('username') ?? "";
      email= Prefs.getString('email') ?? "";
      usertype= Prefs.getString('usertype') ?? "";

    });
  }
  Submit() {
    showAppLoading(_context);
    if (_formKey.currentState.validate()) {
      ServiceDataVM model = new ServiceDataVM();
      model.ServiceId=6;
      model.LessorName=lessorNameKey.currentState.value;
      // model.LessorAddress=lessorAddressKey.currentState.value;
      model.LessorEmail=lessorEmailKey.currentState.value;
      model.LessorPhone=lessorPhoneKey.currentState.value;
      // model.TenantAddress = tenantAddressKey.currentState.value;
      model.TenantEmail=tenantEmailKey.currentState.value;
      model.TenantName = tenantNameKey.currentState.value;
      model.TenantPhone=tenantPhoneKey.currentState.value;
      model.BankAccount=lessorBankKey.currentState.value;
      model.ElectricAccount=lessorElectricityKey.currentState.value;
     model.UserId=userVM.Id;
     model.files=_files;

     
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
