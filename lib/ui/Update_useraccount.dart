import 'dart:async';
import 'dart:io';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/SneakBarHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'About_us.dart';
import 'Contact_us.dart';
import 'GetLocation.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Update_useraccount extends StatefulWidget {
  @override
  _Update_useraccountState createState() =>
      new _Update_useraccountState();
}

class _Update_useraccountState extends State<Update_useraccount> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File _image = null;
  String urlImage = "";
  String name="";
  String city="";
  String phone="";
  String email="";
  String ManagerName="";


String address = "موقع المكتب";
LatLng position;


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var nameKey = GlobalKey<FormFieldState>();
  var cityKey = GlobalKey<FormFieldState>();
  var phoneKey = GlobalKey<FormFieldState>();
  var emailKey = GlobalKey<FormFieldState>();
  var passKey = GlobalKey<FormFieldState>();
  var managerNameKey = GlobalKey<FormFieldState>();


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
    var image = await ImagePicker.pickImage(source: ImageSource.gallery , imageQuality: imageQuality);
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
        _image = file;
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
    //imagename = basename(_path);
    //print('Image Name  $imagename');
    //_image = file;
    _path = fileName;
    imagename = basename(_path);
    print('Image Name  $imagename');
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

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.png"), fit: BoxFit.cover)),
                child:Scaffold(
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
          " تعديل بياناتي",
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
            child:Center(
        child: Builder(
          builder: (cont) => SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only
                (right: 30, left: 30, bottom: 50, top: 20),
              width: screenSize.width,
              //height: 650,
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
                  userProfileImage(cont),
                  Container(
                    height: 50,
                  ),
                  userNameInputs(),
                  appButtonbgimage(
                      'حفظ',
                      () => Submit(),
                      bgColor: desgin_button1_start,
                      bgColor2: desgin_button1_end),
                  Container(
                    height: 20,
                  ),


                ],

              ),

            ),





          ),
        ),
      ),
            
      ),
      
      
      endDrawer: buildDrawer()
    
    ) ,
                );
    
  }

  userNameInputs() {
    _context = _context;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Center(child: _buildCard()),
    );
  }

  Submit() {
    showAppLoading(_context);

    try {
      print(nameKey.currentState.value);
      if (_formKey.currentState.validate()) {
         // UserVM model = new UserVM();
          user.FullName=nameKey.currentState.value;
          //model.UserName=emailKey.currentState.value;
          //model.PasswordHash=passKey.currentState.value;
          //model.Email=emailKey.currentState.value;
          user.City =cityKey.currentState.value;
        //  model.UserType ="User";
         // model.UserImage="";
          user.Phone=phoneKey.currentState.value;

          
          user.Lat =this.position.latitude;
          user.Long=this.position.longitude;
          user.Long_Lat=address;


          print("Locations");
          print(user.Lat.toString());
          print(user.Long.toString());
          print(user.Long_Lat);

          if(firstUpload==""){
            user.UserImage="Not Changed";
          }else{
            user.UserImage=firstUpload;
          }

          if(user.UserType =="mediator"){
            user.ManagerName = managerNameKey.currentState.value;
          }
          AuthApi.updateProfile(user).then((response) {
          if (response.code ==200 ) {
             //hideAppDialog(_context);
             print("user Email Before Verifi");
             print(response.data.Email);
             saveUser(response.data).then((done) {
              print("Start Saving User");
              if (done){
                print(response.data);
                hideAppDialog(_context);
                Navigator.of(_context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              }
                  

            }, onError: (error) {
              print("saving user Error : :  :$error");
              hideAppDialog(_context);
            });
           
          } else {
           // showInSnackBar("${response.message}", _context, _scaffoldKey_reg);
           hideAppDialog(_context);
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
        
      } else {
        hideAppDialog(_context);
      }
    } catch (error) {
      hideAppDialog(_context);
      showInSnackBar(error.toString(), _context, _scaffoldKey);
    //  showSnack(error.toString());

    }
  }

  // #docregion Card
  Widget _buildCard() => Form(
          key: _formKey,
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Row(
                children: <Widget>[
                  Expanded( // wrap your Column in Expanded
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          maxLines: 1,
                          key: nameKey,
                          initialValue: user.FullName,
                          textAlign: TextAlign.right,
                          style: AqarFont.getLightFont(),
                          decoration: InputDecoration(
                            labelText: "الاسم",
                            labelStyle: AqarFont.getLightFont_TextFormField(),
                            fillColor: gray,
                            hintText: name,
                            contentPadding: new EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                            border:OutlineInputBorder(
                              borderSide: const BorderSide(color: gray, width: 0.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: gray, width: 1.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
              user.UserType=="mediator"? Container(
                height: 10,
              ):Container(),
              user.UserType=="mediator"? Row(
                children: <Widget>[
                  Expanded( // wrap your Column in Expanded
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          maxLines: 1,
                          key: managerNameKey,
                          initialValue: user.ManagerName,
                          textAlign: TextAlign.right,
                          style: AqarFont.getLightFont(),
                          decoration: InputDecoration(
                            labelText: "اسم المدير",
                            labelStyle: AqarFont.getLightFont_TextFormField(),
                            fillColor: gray,
                            hintText: name,
                            contentPadding: new EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                            border:OutlineInputBorder(
                              borderSide: const BorderSide(color: gray, width: 0.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: gray, width: 1.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ):Container(),
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
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          key: cityKey,
                          style: AqarFont.getLightFont(),
                          initialValue: user.City,
                          decoration: InputDecoration(
                            labelText: "المدينه",
                            labelStyle: AqarFont.getLightFont_TextFormField(),
                            fillColor: Colors.blueGrey,
                            hintText: city,
                            contentPadding: new EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                            border:OutlineInputBorder(
                              borderSide: const BorderSide(color: gray, width: 0.0),
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
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          initialValue: user.Phone,
                          key: phoneKey,
                          style: AqarFont.getLightFont(),
                          decoration: InputDecoration(
                            labelText: "رقم الجوال",
                            labelStyle: AqarFont.getLightFont_TextFormField(),
                            fillColor: Colors.blueGrey,
                            hintText: phone,
                            contentPadding: new EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                            border:OutlineInputBorder(
                              borderSide: const BorderSide(color: gray, width: 0.0),
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
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          enabled: false,
                          key: emailKey,
                          initialValue: user.Email,
                          style: AqarFont.getLightFont(),
                          decoration: InputDecoration(
                            labelText: "الايميل",
                            labelStyle: AqarFont.getLightFont_TextFormField(),
                            fillColor: Colors.blueGrey,
                            hintText: email,
                            contentPadding: new EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                            border:OutlineInputBorder(
                              borderSide: const BorderSide(color: gray, width: 0.0),
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
                height: 50,
              ),
               
            InkWell(
                        onTap: () async {
                          this.position = await Navigator.of(_context).push(
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
                                      MediaQuery.of(_context).size.width / 1.3,
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
                      Container(
              height: 15,
            ),

            ],
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
                              ? NetworkImage(user.UserImage)
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



  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    restore();
    super.initState();
    getUser().then((user){
      print("objectobjectobjectobjectobjectobjectobjectobjectobject     ");
      setState(() {
              this.user = user ;
                    print(user.ManagerName);
                    address=user.Long_Lat==null?"اختر الموقع":user.Long_Lat;
                    // position.longitude = user.Long;
                    // position.latitude=user.Lat;
              print("User Image Is : "+user.UserImage);
      });
    });
  }
UserVM user ;

    restore() async {
      final SharedPreferences Prefs = await SharedPreferences.getInstance();
      setState(() {
        name=Prefs.getString('username') ?? "";
        city=Prefs.getString('usercity') ?? "";
        phone=Prefs.getString('Phone') ?? "";
        email= Prefs.getString('email') ?? "";
        ManagerName= Prefs.getString('ManagerName') ?? "";
      });
    }



}
