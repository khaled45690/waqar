import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:waqarapp/API/RegionApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/model/Region.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'About_us.dart';
import 'Contact_us.dart';
import 'GetLocation.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Update_useraccount.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:file_picker/file_picker.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:dio/dio.dart';


class My_services_05 extends StatefulWidget {
  @override
  _My_services_05State createState() => new _My_services_05State();
}

class _My_services_05State extends State<My_services_05> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var screenSize;
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
  var pricingPurposeKey = GlobalKey<FormFieldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();




String address = "قم بتحديد الموقع *";
LatLng position;

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
///




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
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;

    screenSize = MediaQuery.of(_context).size;

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
            "تثمين عقاري",
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
                          appButtonbgimage('نموذج طلب تثمين عقاري', () => {},
                              bgColor: desgin_button4_start,
                              bgColor2: desgin_button4_start),
                          Container(
                            height: 20,
                          ),
                          userNameInputs(),
                          appButtonbgimageWithSmallText('إرسال الطلب للمكاتب المعتمده', () => Submit(),
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
        child: Padding(
                padding: EdgeInsets.all(0),
                child: Builder(
                  builder: (cont) => SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
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
            //               labelText: "المدينه *",
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
            //             key: distinctKey,
            //             maxLength: maxLengthForCharacters,
            //             scrollPadding:
            //                 EdgeInsets.only(right: 25, left: 25, bottom: 0),
            //             maxLines: 1,
            //             textAlign: TextAlign.right,
            //             style: AqarFont.getLightFont(),
            //             decoration: InputDecoration(
            //               labelText: "الحي *",
            //               labelStyle: AqarFont.getLightFont_TextFormField(),
            //               fillColor: gray,
            //               hintText: "الحي",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        maxLines: 1,
                        key: pricingPurposeKey,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "غرض التثمين *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "غرض التثمين",
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

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
               //   onTap: openFileExplorer,
               
                  child: GestureDetector(
                            onTap: loadAssets,
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
                  
                ),
            
                  // Container(
                  //     height: 45,
                  //     width: 180,
                  //     child: appButtonbgimage('ارفاق الصور', () => {},
                  //         bgColor: desgin_button4_start,
                  //         bgColor2: desgin_button4_start),
                  // ),
                ]
            ),
            Container(
              child: Text(
                "     * تم رفع "+ lblFirstUpload.toString()+" صور  *",
                textAlign: TextAlign.center,
                style: AqarFont.getinputFont(),
              ),
            ),

            Container(
              height: 15,
            ),
            InkWell(
                        onTap: () async {
                          this.position = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => GetLocation()));
                          if (position != null) {
                            print(
                                "loaction is in : : ${position.latitude},${position.longitude}");
                            String address = await getAddress(position);
                            setState(() {
                              this.address = address;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white),
                                constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 1.3,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 7, child: Text(this.address)),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 25.0,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            // Row(

            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Container(
            //         height: 45,
            //         width: MediaQuery.of(_context).size.width-150,
            //         child: appButtonbgimage('تحديد الموقع', () => {},
            //             bgColor: desgin_button4_end,
            //             bgColor2: desgin_button4_end),
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
    RegionApi.SelectAll().then((response){
      if(response.code !=200){
      }else{
        setState(() {
          this.ReturnedResult = response.data;
          regionsVM = response.data.first;
          governmentVM = regionsVM.governments.first;
          districtVM = regionsVM.governments.first.districts.first;
          _selectedCountryId=regionsVM.regionId;
          _selectedDistrictId=districtVM.districtId;
          _selectedGovernmentId=governmentVM.governmentId;
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
    
    
    getUser().then((user){
      setState(() {
              this.userVM = user ;
      });
    });
  }

  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      name = Prefs.getString('username') ?? "";
      email = Prefs.getString('email') ?? "";
      usertype = Prefs.getString('usertype') ?? "";
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
      model.ServiceId=4;
      // if(target=="بيع"){
      //   model.ForSell=true;
      //   model.ForRent=false;
      // }else{
      //   model.ForSell=false;
      //   model.ForRent=true;
      // }
      model.City=_selectedCountry;//cityKey.currentState.value;
      model.BuildingType=aqartypeKey.currentState.value;
      model.District=_selectedDistrict;//distinctKey.currentState.value;
      // model.BuildingAge=aqarageKey.currentState.value;
      // model.BuildingPrice=double.parse(aqarpriceKey.currentState.value);
     // model.Description=aqardetailsKey.currentState.value;
      model.PricingPurpose=pricingPurposeKey.currentState.value;
      // if(adds =="١٠ ايام"){
      //    model.AddDuration=10;
      // }else if(adds=="٢٠ يوم"){
      //   model.AddDuration=20;
      // }else{
      //   model.AddDuration=30;
      // }
      
    //  if(office =="مكاتب الحي"){
    //    model.AppearingForOffice=1;
    //  }else if(office =="مكاتب المنطقة"){
    //    model.AppearingForOffice=2;
    //  }else{
    //    model.AppearingForOffice=3;
    //  }
    model.Lat =this.position.latitude;
          model.Long=this.position.longitude;
          model.Long_Lat=address;
          // print(model.latitude);
          // print(model.longitude);
    model.files=_files;
     model.UserId=userVM.Id;

     model.DistrictId = _selectedDistrictId;
     model.GovernmentId = _selectedGovernmentId;
     model.RegionId = _selectedCountryId;
     
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
    //   _bloc.addservice(
    //       target,
    //       aqartypeKey.currentState.value,
    //       category,
    //       cityKey.currentState.value,
    //       distinctKey.currentState.value,
    //       aqarageKey.currentState.value,
    //       aqarareaKey.currentState.value,
    //       aqarpriceKey.currentState.value,
    //       aqardetailsKey.currentState.value,
    //       '',
    //       adds,
    //       office,
    //       '',
    //       '',
    //       'عرض عقار',
    //       'amadian2010@gmail.com',
    //       '1');
    // } else {
    //   hideAppDialog(_context);
    // }
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
