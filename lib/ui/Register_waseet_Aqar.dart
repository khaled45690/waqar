import 'dart:io';
import 'package:flutter/material.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/API/RegionApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:path/path.dart';

import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/helpers/SneakBarHelper.dart';
import 'package:waqarapp/model/Region.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/ui/ChosseUser.dart';
import 'package:waqarapp/ui/MediatorHome.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:waqarapp/utilis/Utils.dart';

import 'About_us.dart';
import 'ConfirmationCode.dart';
import 'Contact_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:image_picker/image_picker.dart';

class Register_waseet_Aqar extends StatefulWidget {
  @override
  _Register_waseet_AqarState createState() => new _Register_waseet_AqarState();
}

class _Register_waseet_AqarState extends State<Register_waseet_Aqar> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
var nameKey = GlobalKey<FormFieldState>();
  var registerationCommercialKey = GlobalKey<FormFieldState>();
  var managerNameKey = GlobalKey<FormFieldState>();
  var emailKey = GlobalKey<FormFieldState>();
  var phoneNumberKey = GlobalKey<FormFieldState>();
  var passKey = GlobalKey<FormFieldState>();
  var addressKey = GlobalKey<FormFieldState>();
  var licenseNumberKey =GlobalKey<FormFieldState>();
  var licenceValue="";
  var cityKey = GlobalKey<FormFieldState>();
  List _cities = ["1", "2", "3","4","5","6","7","8","9","10","11","12"];
List<DropdownMenuItem<String>> _dropDownMenuCities;
String _selectedCity;
  BuildContext _context;
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
  bool monVal_8 = false;
  

  String _path;
Map<String, String> _paths;
String _extension;
FileType _pickType=FileType.ANY;
bool _multiPick = false;
String uploadTxt1="";
File file;
String firstUpload="";
int lblFirstUpload=0;
 String imagename="";

Future<File> pickImage(BuildContext context, Function callback) async {
    SneakbarHelper(context)
      ..setBackgroundColor(Colors.black26)
      ..setDuration(5)
      ..buildCustomBody(_getDialog(context, callback))
      ..show();
  }

Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery ,imageQuality: imageQuality);
_upload_Base64(image);
            String fileName = basename(image.path);
           // _image = image;
       // String filePath = _path;
        // print("FileName : $fileName");
        // print("filePath : $filePath");
        // print("_path : $_path");
      //  upload(fileName, filePath); 
    setState(() {
    //  imageURI = image;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if(image == null){
      print("null Image");
      return null;
    }
_upload_Base64(image);
            String fileName = basename(image.path);
           // _image = image;
       // String filePath = _path;
        // print("FileName : $fileName");
        // print("filePath : $filePath");
        // print("_path : $_path");
      //  upload(fileName, filePath); 
    setState(() {
    //  imageURI = image;
    });
  }


Widget _getDialog(BuildContext context, Function callback) {
  print("Get Dialog");
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                urlImage="images/Loading.gif";  
              });
              //openFileExplorer();
              getImageFromGallery();
            },
            color: lightBgColor,
            child: Text("الاستوديو"//,style: MansaFont.baseFontStyle()
            ),
          ),
          // MARK:- camera option
          RaisedButton(
            onPressed: () async {
              setState(() {
                urlImage="images/Loading.gif";  
              });
              getImageFromCamera();
              // var image = await ImagePicker.pickImage(source: ImageSource.camera);
              // print("Open Camera");
              // var selectedImage = image;
              // if (selectedImage != null) {
              //   print("NULL");
              //   //  File compressedImg = await _imgCompress(selectedImage);
              //   callback(selectedImage);
              // } else {
              //   print("Not NULL");
              //   callback(AssetImage("assets/profile_img.png"));
              // }
            //  _pick(ImageSource.camera, callback);
            },
            color: lightBgColor,
            child: Text("الكاميرا"//,style: MansaFont.baseFontStyle()
            ),
          )
        ],
      ),
    );
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
        //imagename = basename(_path);
        //_image = file;   
      }
      print("pathssssssss");
      print(_path);
      print(_path);
     // lblFirstUpload=_paths.length.toString();
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
   // hideAppDialog(_context);
    if (!mounted) return;
}

void _upload_Base64(File file) {
  
  UploadApi.upload_Base64(file).then((response) {
      if (response.code ==200 ) {
        _image=file;
        setState(() {
          lblFirstUpload=lblFirstUpload+1;
          firstUpload=response.data;
          print('Success ya maaaaaaaaaan');
        });
        print(response.message);
      } else {
        print("${response.message}");
        print('Fail ya maaaaaaaaaan');
      }
    });
 }
  upload(fileName, filePath) {
    file = new File(filePath);
    print("File $filePath");
    _path = filePath;
    imagename = basename(_path);
    print('Image Name  $imagename');
    //_image = file;
    _upload_Base64(file);

    _extension = fileName.toString().split('.').last;


    //_image = file;
    setState(() {
      //     imagename = basename(image.path);
                      //     _image = image;
    });
  }
  

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;

    var screenSize = MediaQuery.of(_context).size;

    return WillPopScope(
        onWillPop: ()async{
          print("back button presed");
          Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => MediatorHome()));
          //Categories.changeNotifierCategoriesBackPressed.sink.add("back hah ");
          //return false ;
        },
        child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.png"), fit: BoxFit.cover)),
                child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
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
            "وسيط عقاري",
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
                  .pushReplacement(MaterialPageRoute(builder: (context) => MediatorHome())))//Navigator.of(context).pop()),
        ),
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
          child: Builder(
            builder: (cont) => SingleChildScrollView(
              child: Container(
               // padding: EdgeInsets.all(20),
                
                child: Form(
                  key: _formKey,
                  child: Column(
                        children: <Widget>[
                          userProfileImage(cont),
                          Container(
                            child: Text(
                              'قم باختيار صوره شخصيه',
                              textAlign: TextAlign.justify,
                              style: AqarFont.getMediumFont(),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: 40, left: 40, bottom: 10, top: 10),
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
                          appButtonbgimage('تاكيد', () =>Submit(),//_displayDialog(context),// Submit(),
                              bgColor: desgin_button1_start,
                              bgColor2: desgin_button1_end),
                          Container(
                            height: 20,
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
                          
                        
                        ],
                      ),)
                
              ),
            ),
          ),
        ),
           
            ),
        endDrawer: buildDrawer()
        

    ),
                ),
        );
    
    
    
   
  }

  userNameInputs() {
    _context = _context;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(child: _buildCard()),
    );
  }

  // #docregion Card
  Widget _buildCard() => SizedBox(
    //child: Form(
      //key: _formKey,
      child:  Column(
          textDirection: TextDirection.rtl,
          children: [
            
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
                        key: nameKey,
                         scrollPadding: EdgeInsets.only(
                            right: 25, left: 25, bottom: 0),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "اسم المكتب",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "ٌإسم المكتب",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
                        maxLength: 10,
                        key: registerationCommercialKey,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "السجل التجاري",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "السجل التجار",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
            // Container(
            //   height: 10,
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       // wrap your Column in Expanded
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: <Widget>[
            //           TextFormField(
            //             key: cityKey,
            //             maxLength: maxLengthForCharacters,
            //             scrollPadding:
            //                 EdgeInsets.only(right: 25, left: 25, bottom: 0),
            //             maxLines: 1,
            //             textAlign: TextAlign.right,
            //             style: AqarFont.getLightFont(),
            //             decoration: InputDecoration(
            //               labelText: "المدينه",
            //               labelStyle: AqarFont.getLightFont_TextFormField(),
            //               fillColor: gray,
            //               hintText: "المدينه",
            //               contentPadding: new EdgeInsets.symmetric(
            //                   vertical: 14.0, horizontal: 10.0),
            //               border: OutlineInputBorder(
            //                 borderSide: const BorderSide(
            //                     color: Colors.grey, width: 0.0),
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
            Container(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
              flex: 1,
              child: Text(
                "المنطقه",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              )),
              Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                            child: new DropdownButton(
                              isExpanded: true,
                              value: _selectedCountry,
                              items: _dropDownMenuCountries,
                              onChanged: changedDropDownCountry,
                            )
                           // DropdownCountryExample("قم بالاختيار"),
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
              flex: 1,
              child: Text(
                "المدينه",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              )),
              Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                            child: new DropdownButton(
                              isExpanded: true,
                              value: _selectedGovernment,
                              items: _dropDownMenuGovernment,
                              onChanged: changedDropDownGovernment,
                            )
                           // DropdownCountryExample("قم بالاختيار"),
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
              flex: 1,
              child: Text(
                "الحي",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              )),
              Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                            child: new DropdownButton(
                              isExpanded: true,
                              value: _selectedDistrict,
                              items: _dropDownMenuDistrict,
                              onChanged: changedDropDownDistrict,
                            )
                           // DropdownCountryExample("قم بالاختيار"),
                          ),
                  ),
                  
              
              ],
            ),
            // Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     mainAxisSize: MainAxisSize.max,

            //     children: <Widget>[
            //       Container(
            //         child: Text(
            //           "المدينه",
            //           textAlign: TextAlign.center,
            //           style: AqarFont.getLightFont_TextFormField2(),
            //         ),
            //       ),
                  
            //       Container(
            //         child: new DropdownButton(
            //                   value: _selectedCity,
            //                   items: _dropDownMenuCities,
            //                   onChanged: changedDropDownCity,
            //                 )
            //         //DropdownExample("قم بالاختيار"),
            //       ),
            //     ]
            // ),
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
                        key: managerNameKey,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "اسم المدير",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "اسم المدير",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
                        key: phoneNumberKey,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: " رقم الجوال",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: ".....05",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
                        maxLines: 1,
                        key: emailKey,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الايميل",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "الايميل",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
                        maxLines: 1,
                        key: addressKey,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "العنوان",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "العنوان بالتفصيل",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
                        key: passKey,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "كلمه السر",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "كلمه السر",
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
              child: Text(
                'حدد امكانيات المكتب',
                textAlign: TextAlign.justify,
                style: AqarFont.getMediumFont(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("      بيع",style: AqarFont.getsmallFont(),),
                      Checkbox(
                        value: monVal,
                        onChanged: (bool value) {
                          setState(() {
                            monVal = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("بيع علي الخارطه",style: AqarFont.getsmallFont(),),
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("   شراء"),
                      Checkbox(
                        value: monVal_2,
                        onChanged: (bool value) {
                          setState(() {
                            monVal_2 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("           تثمين"),
                      Checkbox(
                        value: monVal_3,
                        onChanged: (bool value) {
                          setState(() {
                            monVal_3 = value;
                            value==true?_displayDialog(_context):Null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("تسويق"),
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
                ),
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("    توثيق عقود"),
                      Checkbox(
                        value: monVal_5,
                        onChanged: (bool value) {
                          setState(() {
                            monVal_5 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("تصميم"),
                Checkbox(
                  value: monVal_6,
                  onChanged: (bool value) {
                    setState(() {
                      monVal_6 = value;
                    });
                  },
                ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("      تصوير   "),
                      Checkbox(
                        value: monVal_7,
                        onChanged: (bool value) {
                          setState(() {
                            monVal_7 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: Row(
                    children: <Widget>[
                      Text("صيانه"),
                Checkbox(
                  value: monVal_8,
                  onChanged: (bool value) {
                    setState(() {
                      monVal_8 = value;
                    });
                  },
                ),
                    ],
                  ),
                ),
              ],
            ),
            
          ],
        ),
    //),
        
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
                              : AssetImage(urlImage),
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
                     pickImage(cont, () {
                        setState(() {
                          // print("image path");
                          // print(image.path);
                          // _upload_Base64(image);
                          // imagename = basename(image.path);
                          // _image = image;
                        });
                      });
                      // ImagePickerHelper().pickImage(cont, (File image) {
                      //   setState(() {
                      //     print("After pick image");
                      //     urlImage="images/Loading.gif"; 
                      //     //_image = image;
                      //      String fileName = image.path.split('/').last;
                      //      String filePath = image.path;
                      //      print(filePath);
                      //      print(fileName);
                      //      upload(fileName, filePath); 
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


List _countries = [];
List _government = [];
List _district = [];
List<Region>ReturnedResult = new List<Region>();
Region regionsVM = new Region();
 Governments governmentVM = new Governments();
 Districts districtVM = new  Districts();

List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List _countries) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in _countries) {
      items.add(new DropdownMenuItem(value: fruit, child: Row(textDirection: TextDirection.rtl, children: <Widget>[new Text(fruit ,textAlign:TextAlign.right , textDirection: TextDirection.rtl,)],)));
    }
    return items;
  }
  String _selectedCountry;
  int _selectedCountryId;

  String _selectedGovernment;
  int _selectedGovernmentId;

String _selectedDistrict;
  int _selectedDistrictId;

List<DropdownMenuItem<String>> _dropDownMenuCountries;
List<DropdownMenuItem<String>> _dropDownMenuGovernment;
List<DropdownMenuItem<String>> _dropDownMenuDistrict;
  List<DropdownMenuItem<String>> _dropDownMenuCategory;
  List<DropdownMenuItem<String>> _dropDownMenuClothStyle;
  void changedDropDownCountry(String selectedCntry) {
    setState(() {
      _selectedCountry = selectedCntry;

      _selectedCountryId = 0;
      _selectedDistrictId = 0;
      _selectedGovernmentId = 0;
    });
  ReturnedResult.forEach((s){
    if(selectedCntry == s.regionName){
      setState(() {
        _selectedCountryId=s.regionId;
        print("Selected Id = $_selectedCountryId" );
        regionsVM = s;
        print("regionsVM : ");
        print(regionsVM);
        
        if(s.governments!=null && s.governments.length>0){
          
          
          setState(() {
            governmentVM = s.governments.first;
            print("governmentVM : ");
            print(governmentVM);
            _selectedGovernment =governmentVM.governmentName;
          _selectedGovernmentId = governmentVM.governmentId;
          });
          if(governmentVM.districts!=null && governmentVM.districts.length>0){
            
            setState(() {
              districtVM = governmentVM.districts.first;
              _selectedDistrict =districtVM.districtName;
            _selectedDistrictId = districtVM.districtId;
            print("districtVM : ");
              print(districtVM);
            });
           
          }else{
            setState(() {
              districtVM=new Districts();
              _selectedDistrictId=0;
            });
          }
        }else{
          setState(() {
            governmentVM=new Governments();
            _selectedGovernmentId = 0;
          });
        }
      });

      setState(() {
        _government.clear();
        _dropDownMenuGovernment = buildAndGetDropDownMenuItems(_government);
            //  _selectedGovernment = _dropDownMenuGovernment[0].value;
      });
      if(s.governments!=null&& s.governments.length>0){
        s.governments.forEach((pp){
            setState(() {
              _government.add(pp.governmentName);
            });

        });
        setState(() {
          _dropDownMenuGovernment = buildAndGetDropDownMenuItems(_government);
              _selectedGovernment = _dropDownMenuGovernment[0].value;
             // _selectedGovernmentId=governmentVM.governmentId;
        });

      }else{
          setState(() {
            governmentVM=new Governments();
          });
        }
      
        ///////////////
        ///////////////
        setState(() {
        _district.clear();
        _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
             // _selectedDistrict = _dropDownMenuDistrict[0].value;
      });
      if(governmentVM.districts!=null && governmentVM.districts.length>0){
        governmentVM.districts.forEach((pp){
            setState(() {
              _district.add(pp.districtName);
            });
      });
      setState(() {
          _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
              _selectedDistrict = _dropDownMenuDistrict[0].value;
              _selectedDistrictId=districtVM.districtId;
        });

      }else{
          setState(() {
            districtVM=new Districts();
          });
        }
      
        /////
        
    }
  });

  print("=====================================================");
  print(_selectedCountryId.toString());
  /////
  print(_selectedGovernmentId.toString());
  /////
  print(_selectedDistrictId.toString());
  /////
  ///
  print("My Govern Id = $_selectedGovernmentId");
  }

  void changedDropDownGovernment(String selectedGov) {
    setState(() {
      _selectedGovernment = selectedGov;
    });
  regionsVM.governments.forEach((s){
    if(selectedGov == s.governmentName){
      setState(() {
        _selectedGovernmentId=s.governmentId;
        governmentVM = s;
        print("Selected Id = $_selectedGovernmentId" );
      });
    }
  });
  setState(() {
        _district.clear();
        _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
             // _selectedDistrict = _dropDownMenuDistrict[0].value;
      });
  if(governmentVM.districts.length>0){
      districtVM = governmentVM.districts.first;
      print("districtVM : ");
      print(districtVM);
      governmentVM.districts.forEach((pp){
            setState(() {
              _district.add(pp.districtName);
            });
      });
      setState(() {
          _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
              _selectedDistrict = _dropDownMenuDistrict[0].value;
              _selectedDistrictId=districtVM.districtId;
        });
          
  }else{
    districtVM = new Districts();
    setState(() {
      _selectedDistrictId = 0;
    });
  }

  print("=====================================================");
  print(_selectedCountryId.toString());
  /////
  print(_selectedGovernmentId.toString());
  /////
  print(_selectedDistrictId.toString());
  /////
  }

  void changedDropDownDistrict(String selectedDist) {
    setState(() {
      _selectedDistrict = selectedDist;
    });
  governmentVM.districts.forEach((s){
    if(selectedDist == s.districtName){
      setState(() {
        _selectedDistrictId=s.districtId;
        print("Selected Id = $_selectedDistrictId" );
      });
    }
  });
  
  
  print("=====================================================");
  print(_selectedCountryId.toString());
  /////
  print(_selectedGovernmentId.toString());
  /////
  print(_selectedDistrictId.toString());
  /////
  }

  @override
  void initState() {
    super.initState();
    // _dropDownMenuCities = buildAndGetDropDownMenuItems(_cities);
    // _selectedCity=_dropDownMenuCities[0].value;

  RegionApi.SelectAll().then((response){
      if(response.code !=200){
      }else{
        setState(() {
          this.ReturnedResult = response.data;
          regionsVM = response.data.first;
          governmentVM = regionsVM.governments.first;
          districtVM = regionsVM.governments.first.districts.first;
        });
      response.data.forEach((s){
          print(s.regionName);
          setState(() {
            _countries.add(s.regionName);
          });
      });
        setState(() {
          _dropDownMenuCountries = buildAndGetDropDownMenuItems(_countries);
        _selectedCountry = _dropDownMenuCountries[0].value;
        });
        ///////////////
      regionsVM.governments.forEach((m){
        print(m.governmentName);
        setState(() {
            _government.add(m.governmentName);
          });
          
      });
      setState(() {
          _dropDownMenuGovernment = buildAndGetDropDownMenuItems(_government);
        _selectedGovernment = _dropDownMenuGovernment[0].value;
        });
        //////////////////
      governmentVM.districts.forEach((m){
        print(m.districtName);
        setState(() {
            _district.add(m.districtName);
          });
          
      });
      setState(() {
          _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
        _selectedDistrict = _dropDownMenuDistrict[0].value;
        });

      }
      
      });

  }
_displayDialog(BuildContext context) async {
    int _currentIndex = 1;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("يتطلب تصريح تثمين ",
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: TextFormField(
                        maxLines: 1,
                        key: licenseNumberKey,
                        textAlign: TextAlign.right,
                        //style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          //labelText: "رقم الرخصه",
                          //labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "رقم الرخصه",
                          // contentPadding: new EdgeInsets.symmetric(
                          //     vertical: 10.0, horizontal: 10.0),
                          // border: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //       color: Colors.grey, width: 0.0),
                          //   borderRadius: BorderRadius.circular(25.0),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //       color: Colors.grey, width: 1.0),
                          //   borderRadius: BorderRadius.circular(25.0),
                          // ),
                        ),
                      ),
            actions: <Widget>[
            FlatButton(
              child: Text("تأكيد",
                  textAlign: TextAlign.left,
                  style: AqarFont.getLightFont_TextFormField()),
              onPressed: () {
                print("Osammmmmmmm");
                if(validateCommercialKey(licenseNumberKey.currentState.value)){
                  licenceValue=licenseNumberKey.currentState.value;
                  //Submit();
                  Navigator.of(context).pop();
                }
                
              //  Submit();
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
    // _displayDialog(context);
print("Start Submit");
    showAppLoading(_context);

    try {
      //print(nameKey.currentState.value);
      var mail = emailKey.currentState.value==null?"":emailKey.currentState.value.toString().trim();
     
      if(nameKey.currentState.value.toString().isEmpty){
        hideAppDialog(_context);
        showSnack("من فضلك قم بادخال اسم المكتب");
      }else{
        if (_formKey.currentState.validate()) {
        if (phoneNumberKey.currentState.value==null||phoneNumberKey.currentState.value=="" ||
            phoneNumberKey.currentState.value.length==0|| phoneNumberKey.currentState.value.length > 90) {
          showSnack("يجب ادخال رقم جوال صحيح");
                    hideAppDialog(_context);

        }
        else if (validateboth(mail) == true
         && validateCommercialKey(registerationCommercialKey.currentState.value.toString())) {
            //   showAppLoading(_context);
          UserVM model = new UserVM();
          model.FullName=nameKey.currentState.value;
          model.UserName=mail;
          model.PasswordHash=passKey.currentState.value;
          model.Email=mail;
          model.Address=addressKey.currentState.value;
          model.Commercial_Register=registerationCommercialKey.currentState.value;
          model.ManagerName=managerNameKey.currentState.value;
          model.City = _selectedCountry;//cityKey.currentState.value;
          model.UserType ="mediator";
          model.Phone=phoneNumberKey.currentState.value;
          model.Allowbuy=monVal_2;
          model.IsDesign = monVal_6;
          model.IsPhoto = monVal_7;
          model.IsSupport = monVal_8;
          model.AllowContractDocument=monVal_5;
          model.AllowMarketting=monVal_4;
          model.AllowPricing=monVal_3;
          model.AllowSell=monVal;
          model.AllowSellOnMap=monVal_1;
          model.License_Number=licenceValue;
          model.UserImage=firstUpload;
          
          model.RegionId= _selectedCountryId;
          model.GovernmentId = _selectedGovernmentId;
          model.DistrictId = _selectedDistrictId;
          String fcmToken = await _firebaseMessaging.getToken();
          print("My FCM : $fcmToken");
          _saveDeviceToken();
          model.DeviceToken=fcmToken;
          if(Platform.isAndroid){
            model.DeviceType=0;
          }else{
            model.DeviceType=1;
          }
          AuthApi.register(model).then((response) {
          if (response.code ==200 ) {
             hideAppDialog(_context);
             Navigator.of(_context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => ConfirmationCode(response.data)));
            //  Navigator.of(_context).push(MaterialPageRoute(
            //                      builder: (context) => ConfirmationCode(response.data)));
            // });
          } else {
            hideAppDialog(_context);
            showInSnackBar(response.message, _context, _scaffoldKey);
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
         
        }
        else {
          hideAppDialog(_context);
        }
      } else {
        hideAppDialog(_context);
      }
      }
      
    } catch (error) {
      hideAppDialog(_context);
      //showSnack("من فضلك قم بادخال اسم المكتب");
      showSnack(error.toString());

    }
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

  bool validateCommercialKey(String value) {
  //  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //  RegExp regExp = new RegExp(pattern);
    if (value.length == 10) {
     // showSnack("يجب ادخال ايميل او رقم الجوال اولاً");
     return true;
    } else {
      showSnack("يجب ادخال رقم سجل صحيح");
      return false;
    }
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
void changedDropDownCity(String selectedCity) {
    setState(() {
      _selectedCity = selectedCity;
    });
  }
  _showDialog() async {
    await showDialog<String>(
      context: _context,
      child: new _SystemPadding(child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'رقم الرحصه', hintText: '٢٠٥٨٦٣'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child:  Text('إرسال',textAlign: TextAlign.right,style: AqarFont.getLightFont_TextFormField(),),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: desgin_button1_start)
                ),
              onPressed: () {
                Navigator.pop(_context);
              })


        ],
      ),),
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
  String city;
  String title="";
  _DropdownExampleState(String s){
    title=s;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        onChanged: (String value) {
          setState(() {
            city = value;
          });
        },
        hint: Text(title),
        value: city,
        items: [
          DropdownMenuItem<String>(
            child: Text('الرياض'),
            value: 'الرياض',
          ),
          DropdownMenuItem<String>(
            child: Text('جده'),
            value: 'جده',
          ),
          DropdownMenuItem<String>(
            child: Text('المدينه المنوره'),
            value: 'المدينه المنوره',
          ),
          DropdownMenuItem<String>(
            child: Text('تبوك'),
            value: 'تبوك',
          ),
          DropdownMenuItem<String>(
            child: Text('الدمام'),
            value: 'الدمام',
          ),
          DropdownMenuItem<String>(
            child: Text('الاحساء'),
            value: 'الاحساء',
          ),
          DropdownMenuItem<String>(
            child: Text('القطيف'),
            value: 'القطيف',
          ),
          DropdownMenuItem<String>(
            child: Text('خميس مشيط'),
            value: 'خميس مشيط',
          ),
          DropdownMenuItem<String>(
            child: Text('المظيلف'),
            value: 'المظيلف',
          ),
          DropdownMenuItem<String>(
            child: Text('الهفوف'),
            value: 'الهفوف',
          ),
          DropdownMenuItem<String>(
            child: Text('المبرز'),
            value: 'المبرز',
          ),
          DropdownMenuItem<String>(
            child: Text('الطائف'),
            value: 'الطائف',
          ),
          DropdownMenuItem<String>(
            child: Text('نجران'),
            value: 'نجران',
          ),
          DropdownMenuItem<String>(
            child: Text('حفر الباطن'),
            value: 'حفر الباطن',
          ),
          DropdownMenuItem<String>(
            child: Text('الجبيل'),
            value: 'الجبيل',
          ),
          DropdownMenuItem<String>(
            child: Text('ضباء'),
            value: 'ضباء',
          ),
          DropdownMenuItem<String>(
            child: Text('الخرج'),
            value: 'الخرج',
          ),
          DropdownMenuItem<String>(
            child: Text('الثقبه'),
            value: 'الثقبه',
          ),
          DropdownMenuItem<String>(
            child: Text('ينبع البحر'),
            value: 'ينبع البحر',
          ),
          DropdownMenuItem<String>(
            child: Text('الخبر'),
            value: 'الخبر',
          ),
          DropdownMenuItem<String>(
            child: Text('عرعر'),
            value: 'عرعر',
          ),
          DropdownMenuItem<String>(
            child: Text('الحويه'),
            value: 'الحويه',
          ),
          DropdownMenuItem<String>(
            child: Text('عنيزه'),
            value: 'عنيزه',
          ),
          DropdownMenuItem<String>(
            child: Text('سكاكا'),
            value: 'سكاكا',
          ),
          DropdownMenuItem<String>(
            child: Text('جيزان'),
            value: 'جيزان',
          ),
          DropdownMenuItem<String>(
            child: Text('القريات'),
            value: 'القريات',
          ),
          DropdownMenuItem<String>(
            child: Text('الظهران'),
            value: 'الظهران',
          ),
          DropdownMenuItem<String>(
            child: Text('الباحه'),
            value: 'الباحه',
          ),
          DropdownMenuItem<String>(
            child: Text('الزلفي'),
            value: 'الزلفي',
          ),
          DropdownMenuItem<String>(
            child: Text('الرس'),
            value: 'الرس',
          ),
          DropdownMenuItem<String>(
            child: Text('وادي الدواسر'),
            value: 'وادي الدواسر',
          ),
          DropdownMenuItem<String>(
            child: Text('بيشه'),
            value: 'بيشه',
          ),
          DropdownMenuItem<String>(
            child: Text('سيهات'),
            value: 'سيهات',
          ),
          DropdownMenuItem<String>(
            child: Text('شروره'),
            value: 'شروره',
          ),
          DropdownMenuItem<String>(
            child: Text('بحره'),
            value: 'بحره',
          ),
          DropdownMenuItem<String>(
            child: Text('تاروت'),
            value: 'تاروت',
          ),
          DropdownMenuItem<String>(
            child: Text('الدوامي'),
            value: 'الدوامي',
          ),
          DropdownMenuItem<String>(
            child: Text('صبياء'),
            value: 'صبياء',
          ),
          DropdownMenuItem<String>(
            child: Text('بيش'),
            value: 'بيش',
          ),
          DropdownMenuItem<String>(
            child: Text('احد رفيده'),
            value: 'احد رفيده',
          ),
          DropdownMenuItem<String>(
            child: Text('الفريش'),
            value: 'الفريش',
          ),
          DropdownMenuItem<String>(
            child: Text('بارق'),
            value: 'بارق',
          ),
          DropdownMenuItem<String>(
            child: Text('الحوطه'),
            value: 'الحوطه',
          ),
          DropdownMenuItem<String>(
            child: Text('الافلاج'),
            value: 'الافلاج',
          ),

        ],

      ),
    );
  }
}
