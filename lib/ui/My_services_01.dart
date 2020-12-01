import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:waqarapp/API/RegionApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/model/Region.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/ui/MyServices.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/RequestsAndResponses/ServiceBloc.dart';
import 'HomeScreen.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
//import 'package:toast/toast.dart';
import 'package:async/async.dart';

import 'package:file_picker/file_picker.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:dio/dio.dart';

class My_services_01 extends StatefulWidget {
  @override
  _My_services_01State createState() => new _My_services_01State();
}

class _My_services_01State extends State<My_services_01>
    with WidgetsBindingObserver {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isUploading = false;
  String baseUrl = 'http://box5515.temp.domains/~waqarcom/admin/web/api/upload.php';
  String name = "";
  String email = "";
  String photonumber = 'لم يتم رفع اي صور بعد';
  String imagename = "";

  var aqartypeKey = GlobalKey<FormFieldState>();
  var distinctKey = GlobalKey<FormFieldState>();
  var cityKey = GlobalKey<FormFieldState>();
  var aqarageKey = GlobalKey<FormFieldState>();
  var aqarareaKey = GlobalKey<FormFieldState>();
  var aqarpriceKey = GlobalKey<FormFieldState>();
  var aqardetailsKey = GlobalKey<FormFieldState>();

  String user = "";
  String usertype = "";

  File _image = null;
  String urlImage = "";

  String office = "";
  String adds = "";
  String category = "";
  String target = "";
  String target2 = "";
  

  bool _radioValueForSell = false;
   bool _radioValueForRent = false;

bool _radioValueForCommercial =false;
bool _radioValueForHousing =false;
bool _radioValueForManagement =false;

  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
 int _radioValue1 = -1;


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

 void _upload_Base64_V2 (String base64 , String name) {
  
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
                 ByteData byteData = await resultList[i].getByteData(quality: imageQualityForMultipleImages);//quality: 40
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
                
                //hideAppDialog(_context);
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
    } on PlatformException catch (e) {
      print("Unsupported operation");
    }
   // hideAppDialog(_context);
    if (!mounted) return;
}


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
    return Scaffold(
              backgroundColor: gray,
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
                  "عرض عقار",
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
                padding: EdgeInsets.all(0),
                child: Builder(
                  builder: (cont) => SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  right: 35, left: 35, bottom: 0, top: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    appButtonbgimage('نموذج عرض عقار', () => {},
                                        bgColor: desgin_button4_start,
                                        bgColor2: desgin_button4_start),
                                  ])),
                          Container(
                              margin: EdgeInsets.only(
                                  right: 40, left: 40, bottom: 10, top: 10),
                              width: MediaQuery.of(_context).size.width,
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
                                userNameInputs(cont),
                                Container(
                                  height: 10,
                                ),
                              ])),
                          Container(
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
                          Container(
                            height: 20,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ),
              
              endDrawer:buildDrawer()
            );
          
          
        
  }

  userNameInputs(BuildContext cont) {
    _context = cont;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(child: _buildCard()),
    );
  }

  // #docregion Card
  Widget _buildCard() => SizedBox(
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
                Checkbox(
                      value: _radioValueForSell,
                      onChanged: (bool newValue) {
                        setState(() {
                          _radioValueForSell = newValue;
                        });
                      }),
                // Radio(
                //   value: 0,
                //   groupValue: _radioValueForSell,
                //   onChanged: _handleRadioValueChange_ForSell,
                // ),
                Text(
                  'بيع',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFont(),
                ),
                Container(
                  width: 20,
                ),
                Checkbox(
                      value: _radioValueForRent,
                      onChanged: (bool newValue) {
                        setState(() {
                          _radioValueForRent = newValue;
                        });
                      }),
               
                Text(
                  'إيجار',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFont(),
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
                        key: aqartypeKey,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "نوع العقار *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "محل او فيلا او مسكن",
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
            Container(
              child: Text(
                "التصنيف *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _radioValueForCommercial,
                  onChanged: (bool newValue) {
                    setState(() {
                      _radioValueForCommercial = newValue;
                    });
                  }),
                Text(
                  'تجاري',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Checkbox(
                  value: _radioValueForHousing,
                  onChanged: (bool newValue) {
                    setState(() {
                      _radioValueForHousing = newValue;
                    });
                  }),
                Text(
                  'سكني',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Checkbox(
                  value: _radioValueForManagement,
                  onChanged: (bool newValue) {
                    setState(() {
                      _radioValueForManagement = newValue;
                    });
                  }),
                Text(
                  'إداري',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
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
            Container(
              height: 10,
            ),
            Row(
              textDirection: TextDirection.rtl, 
              mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              //style: TextStyle(fontStyle: ),
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
            Container(
          height: 10,
        ),
        Container(
          child: Text(
            "الصفه *",
            textAlign: TextAlign.center,
            style: AqarFont.getLightFont_TextFormField3(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("مالك "),
            Radio(
              value: 0,
              groupValue: _radioValue1,
              onChanged: _handleRadioValueChange1,
            ),
            Container(
              width: 5,
            ),
            Text("وكيل"),
            Radio(
              value: 1,
              groupValue: _radioValue1,
              onChanged: _handleRadioValueChange1,
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
                        key: aqarageKey,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
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
                        key: aqarareaKey,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "المساحه *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "متر مربع",
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
                        key: aqarpriceKey,
                        keyboardType: TextInputType.number,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
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
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        key: aqardetailsKey,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 4,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الوصف ",
                          fillColor: Colors.blueGrey,
                          hintText: "كتابه الوصف ٢٠٠٠ حرف",
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
                GestureDetector(
               //   onTap: openFileExplorer,
               
                  child: GestureDetector(
                            onTap: loadAssets,
                            child: Container(
                            child: Image.asset(
                               'images/captureImage.PNG',
                              height: 40,
                              width: MediaQuery.of(_context).size.width ,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              
                            ),
                            
                          ),
                          ),
                  
                ),
            Container(
              child: Text(
                "     * تم رفع "+ lblFirstUpload.toString()+" صور  *",
                textAlign: TextAlign.center,
                style: AqarFont.getinputFont(),
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Text(
                "مده الاعلان *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _radioValue3,
                  onChanged: _handleRadioValueChange3,
                ),
                Text(
                  '١٠ ايام',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Text(
                  '         ',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue3,
                  onChanged: _handleRadioValueChange3,
                ),
                Text(
                  '٢٠ يوم',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                
              ],
            ),
            Row(
              children: <Widget>[
                
                Radio(
                  value: 2,
                  groupValue: _radioValue3,
                  onChanged: _handleRadioValueChange3,
                ),
                Text(
                  '٣٠ يوم',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Text(
                  '         ',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 3,
                  groupValue: _radioValue3,
                  onChanged: _handleRadioValueChange3,
                ),
                Text(
                  '٦٠ يوم',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Text(
                "المكاتب *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _radioValue4,
                  onChanged: _handleRadioValueChange4,
                ),
                Text(
                  'الحي',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue4,
                  onChanged: _handleRadioValueChange4,
                ),
                Text(
                  'المنطقة',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 2,
                  groupValue: _radioValue4,
                  onChanged: _handleRadioValueChange4,
                ),
                Text(
                  'الجميع',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            appButtonbgimage('إرسال الطلب', () => Submit(),
                bgColor: desgin_button1_start, bgColor2: desgin_button1_end),
          ],
        ),
      );
void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          target2 = "مالك";
          break;
        case 1:
          target2 = "وكيل";
          break;
      }
    });
  }
  
  
  
  
  void _handleRadioValueChange4(int value) {
    setState(() {
      _radioValue4 = value;

      switch (_radioValue4) {
        case 0:
          office = "مكاتب الحي";
          break;
        case 1:
          office = "مكاتب المنطقة";
          break;
        case 2:
          office = "جميع المكاتب";
          break;
      }
    });
  }

  void _handleRadioValueChange3(int value) {
    setState(() {
      _radioValue3 = value;

      switch (_radioValue3) {
        case 0:
          adds = "١٠ ايام";
          break;
        case 1:
          adds = "٢٠ يوم";
          break;
        case 2:
          adds = "٣٠ يوم";
          break;
        case 3:
          adds = "٦٠ يوم";
          break;
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
     // _radioValue2 = value;
      // if(value==0){
      //   _radioValueForCommercial = value;
      // }
      // else if(value==1){
      //   _radioValueForHousing = value;
      // }else if(value==2){
      //   _radioValueForManagement = value;
      // }
      // switch (_radioValue2) {
      //   case 0:
      //     category = "تجاري";
      //     break;
      //   case 1:
      //     category = "سكني";
      //     break;
      //   case 2:
      //     category = "إداري";
      //     break;
      // }
    });
  }

  void _handleRadioValueChange_ForSell(int value) {
    print("TTTTTTTTTTT $value");
    setState(() {
      // _radioValueForSell = value;

      // switch (_radioValueForSell) {
      //   case 0:
      //     target = "بيع";
      //     break;
      //   case 1:
      //     target = "إيجار";
      //     break;
      // }
    });
  }

  void _handleRadioValueChange_ForRent(int value) {
    setState(() {
      print(value);
      // _radioValueForRent = value;

      // switch (_radioValueForRent) {
      //   case 0:
      //     target = "بيع";
      //     break;
      //   case 1:
      //     target = "إيجار";
      //     break;
      // }
    });
  }
//
//  userProfileImage(BuildContext cont) {
//    return Container(
//        child: Column(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        // new center image
//
//        Center(
//          child: Stack(
//            fit: StackFit.loose,
//            children: <Widget>[
//              Container(
//                margin: new EdgeInsets.symmetric(vertical: 20.0),
//                width: 110,
//                height: 110,
//                decoration: BoxDecoration(
//                    boxShadow: [
//                      BoxShadow(
//                        color: bgColor,
//                        blurRadius:
//                            0.0, // has the effect of softening the shadow
//                        spreadRadius:
//                            0.0, // has the effect of extending the shadow
//                        offset: Offset(
//                          1.0, // horizontal, move right 10
//                          1.0, // vertical, move down 10
//                        ),
//                      )
//                    ],
//                    shape: BoxShape.rectangle,
//                    image: DecorationImage(
//                      fit: BoxFit.fill,
//                      image: _image != null
//                          ? FileImage(_image)
//                          : urlImage == null || urlImage.isEmpty
//                              ? AssetImage("images/profile_img.png")
//                              : NetworkImage(urlImage),
//                    )),
//              ),
//              Positioned(
//                //  bottom: 0,
//                left: 0,
//                right: 0,
//                child: IconButton(
//                    color: Colors.transparent,
//                    iconSize: 10000,
//                    icon: Icon(
//                      Icons.camera_alt,
//                      color: Colors.white,
//                    ),
//                    onPressed: () {
//                      ImagePickerHelper().pickImage(cont, (File image) {
//                        setState(() {
//                          print(image.path);
//                          imagename = imagename + basename(image.path) + ",";
//                          _image = image;
//                        });
//                      });
//                    }),
//              ),
//            ],
//          ),
//        ),
//      ],
//    ));
//  }

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
UserVM userVM ;
  @override
  void initState() {
    restore();
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
      model.ServiceId=1;
      if(_radioValueForSell){
        model.ForSell=true;
      }if(_radioValueForRent){
        model.ForRent=true;
      }
      // if(target=="بيع"){
      //   model.ForSell=true;
      //   model.ForRent=false;
      // }else{
      //   model.ForSell=false;
      //   model.ForRent=true;
      // }
      // if(target=="بيع"){
      //   model.ForSell=true;
      //   model.ForRent=false;
      // }else{
      //   model.ForSell=false;
      //   model.ForRent=true;
      // }
      print("My Target");
      print(target2);
      if(target2=="مالك"){
        model.IsOwner=true;
              print("Owner");

        //model.ForRent=false;
      }else{
        model.IsAgent=true;
        print("Agent");
        //model.ForRent=true;
      }
      model.City=_selectedCountry;//cityKey.currentState.value;
      model.BuildingType=aqartypeKey.currentState.value;
      model.District=_selectedDistrict;//distinctKey.currentState.value;
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
      model.BuildingSize=aqarareaKey.currentState.value;
      model.filesIds=firstUpload;
      model.files=_files;
      print("Fillllllles");
      print(_files);
      if(adds =="١٠ ايام"){
         model.AddDuration=10;
      }else if(adds=="٢٠ يوم"){
        model.AddDuration=20;
      }else if(adds=="٣٠ يوم"){
        model.AddDuration=30;
      }else{
        model.AddDuration=60;
      }
      
     if(office =="مكاتب الحي"){
       model.AppearingForOffice=1;
     }else if(office =="مكاتب المنطقة"){
       model.AppearingForOffice=2;
     }else{
       model.AppearingForOffice=3;
     }

     
    if(_radioValueForCommercial){
      model.IsCommercial=true;
    }if(_radioValueForHousing){
      model.IsHousing=true;
    }if(_radioValueForManagement){
      model.IsManagement=true;
    }
     
     
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

  showAlertDialog(BuildContext context , int orderNum) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("تم",
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
      onPressed: () {
        
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("سيتم التواصل معكم ",
          textAlign: TextAlign.center,
          style: AqarFont.getLightFont_TextFormField()),
      content: Text("رقم طلبكم هو "+orderNum.toString(),
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
      actions: [
        
      //  okButton,
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


  upload_2(File imageFile) async {

    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(baseUrl);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    Map<String,String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    request.headers.addAll(headers);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }


  // void upload(File image) async {
  //   final Map<String, dynamic> response = await _uploadImage(image);
  //   print(response);
  //   // Check if any error occured
  //   if (response == null || response.containsKey("error")) {
  //     Toast.show("Image Upload Failed!!!", _context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   } else {
  //     Toast.show("Image Uploaded Successfully!!!", _context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   }
  // }

  // Future<Map<String, dynamic>> _uploadImage(File image) async {
  //   setState(() {
  //     _isUploading = true;
  //   });
  //   // Find the mime type of the selected file by looking at the header bytes of the file
  //   final mimeTypeData =
  //       lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
  //   // Intilize the multipart request
  //   final imageUploadRequest =
  //       http.MultipartRequest('POST', Uri.parse(baseUrl));
  //   // Attach the file in the request
  //   final file = await http.MultipartFile.fromPath('image', image.path,
  //       contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  //   // Explicitly pass the extension of the image with request body
  //   // Since image_picker has some bugs due which it mixes up
  //   // image extension with file name like this filenamejpge
  //   // Which creates some problem at the server side to manage
  //   // or verify the file extension
  //   imageUploadRequest.fields['ext'] = mimeTypeData[1];
  //   imageUploadRequest.files.add(file);
  //   try {
  //     final streamedResponse = await imageUploadRequest.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     if (response.statusCode != 200) {
  //       return null;
  //     }
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     _resetState();
  //     return responseData;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  // void _resetState() {
  //   setState(() {
  //     _isUploading = false;
  //     _image = null;
  //   });
  // }

    }