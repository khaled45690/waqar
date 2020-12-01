
import 'package:flutter/material.dart';
import 'package:waqarapp/API/ContentApi.dart';
import 'package:waqarapp/API/PaymentAccountApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/helpers/SneakBarHelper.dart';
import 'package:waqarapp/model/ContentVM.dart';
import 'package:waqarapp/model/PaymentAccountVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/ui/HomeScreen.dart';
import 'dart:io';
import 'About_us.dart';
import 'Contact_us.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Update_useraccount.dart';

import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => new _PaymentState();
}

class _PaymentState extends State<Payment> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
GlobalKey<FormState> _form_log = GlobalKey<FormState>();
  bool _isButtonDisabled;
  String name="";
  String email="";
  String imageprofile="";
  int orderNum=0;
List _accounts = ["الاهلي", "الراجحي", "سامبا","الانما","ساب"];
  List _Years = ["1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"];
List<DropdownMenuItem<String>> _dropDownMenuyears;
  String _selectedfromYear;

String title="";
String accountName="";
String account_IBAN="";
String account_No="";
 var customerNameKey_log = GlobalKey<FormFieldState>();
  var accountTransferKey_log = GlobalKey<FormFieldState>();
  var accountTransferToKey_log = GlobalKey<FormFieldState>();
  var phone1Key_log = GlobalKey<FormFieldState>();
  var phone2Key_log = GlobalKey<FormFieldState>();
  var emailKey_log = GlobalKey<FormFieldState>();
  var nameWhoTransferKey_log = GlobalKey<FormFieldState>();

  List<DropdownMenuItem<String>> _dropDownMenuAccounts;
  String _selectedAccount;


int totalSubscription=0;
  String _path;
Map<String, String> _paths;
Map<String, String> _paths2;
String _extension;
String _extension2;
FileType _pickType;
bool _multiPick = false;
String uploadTxt1="";
File file;
String firstUpload="";
String lblFirstUpload="ارفق ايصال الدفع";
Future<File> pickImage(BuildContext context, Function callback) async {
    SneakbarHelper(context)
      ..setBackgroundColor(Colors.black26)
      ..setDuration(5)
      ..buildCustomBody(_getDialog(context, callback))
      ..show();
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
        print("pathssssssss 1");
      print(_path);
        upload(fileName, filePath);
        print("pathssssssss 2");
      print(_path);
      }
      print("pathssssssss");
      print(_path);
     // lblFirstUpload=_paths.length.toString();
    }  catch (e) {
      print("Unsupported operation" + e.toString());
    }
   // hideAppDialog(_context);
    if (!mounted) return;
}
void _upload_Base64(File file) {
  
  UploadApi.upload_Base64(file).then((response) {
      if (response.code ==200 ) {
        setState(() {
          firstUpload=response.data;
          lblFirstUpload="تم ارفاق الملف بنجاح";
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
  @override
  Widget build(BuildContext context) {
    _context = context;
    var screenSize = MediaQuery.of(_context).size;
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
            "الدفع",
            style: AqarFont.baseFontStyle(),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Image.asset("images/actionback.png"),
              iconSize: 30.0,
              padding: EdgeInsets.fromLTRB(20, 17, 0, 17),
              onPressed: () => Navigator.of(_context).pop()),
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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(0),
              child: Form(
                    child: _isButtonDisabled ? sucessview() : paymentview(),
            
            
              ),
            ),
          ),
          endDrawer: buildDrawer()
          
          
          
          
        // SingleChildScrollView(
        //   child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //             margin: EdgeInsets.only(right: 40, left: 40, bottom: 20, top: 30),
        //             width: screenSize.width,
        //             height: 600,
        //             decoration: new BoxDecoration(
        //               gradient: LinearGradient(
        //                   colors: [bgColor, bgColor],
        //                   begin: FractionalOffset(0.0, 0.0),
        //                   end: FractionalOffset(0.5, 2.0),
        //                   stops: [0.0, 1.0],
        //                   tileMode: TileMode.clamp),
        //               borderRadius: BorderRadius.circular(40),
        //             ),
        //             child: Column(
        //                 children: [

        //                   Container(
        //                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 20),
        //                     child: Text(
        //                       "ادفع الان بواسطه",
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.getLightFont_TextFormFieldtextheader(),
        //                     ),
        //                   ),
        //                   Container(
        //                     height: 10,
        //                   ),
        //                   Container(
        //                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 0),
        //                     child: Text(
        //                       "حواله بنكيه علي حسابنا لدي بنك الانماء",
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.baseRegularcolorFont(),
        //                     ),
        //                   ),
        //                   Container(
        //                     height: 10,
        //                   ),
        //                   Container(
        //                     margin: EdgeInsets.only(right: 15, left: 15, bottom: 0, top: 0),
        //                     child: Text(
        //                       "الاسم",
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.getLightFont_TextFormFieldtextheader(),
        //                     ),
        //                   ),


        //                   Container(
        //                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 0),
        //                     child: Text(
        //                       "مؤسسه دليل التطبيقات للإتصالات وتقنيه المعلومات",
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.baseRegularcolorFont(),
        //                     ),
        //                   ),

        //                   Container(
        //                     height: 10,
        //                   ),
        //                   Container(
        //                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 0),
        //                     child: Text(
        //                       "رقم الحساب الآيبان",
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.getLightFont_TextFormFieldtextheader(),
        //                     ),
        //                   ),

        //                   Container(
        //                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 0),
        //                     child: SelectableText(
        //                       "SA8405000068202491825000",
        //                       showCursor: true,
        //                       toolbarOptions: ToolbarOptions(
        //                           copy: true,
        //                           selectAll: true,
        //                           cut: false,
        //                           paste: false
        //                       ),
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.getLightFont_TextFormFieldtext(),
        //                     ),
        //                   ),
        //                   Container(
        //                     height: 10,
        //                   ),
        //                   Container(
        //                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 0),
        //                     child: Text(
        //                       "رقم الحساب",
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.getLightFont_TextFormFieldtextheader(),
        //                     ),
        //                   ),

        //                   Container(
        //                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 0),
        //                     child: SelectableText(
        //                       "68202491825000",
        //                       showCursor: true,
        //                       toolbarOptions: ToolbarOptions(
        //                           copy: true,
        //                           selectAll: true,
        //                           cut: false,
        //                           paste: false
        //                       ),
        //                       textAlign: TextAlign.center,
        //                       style: AqarFont.getLightFont_TextFormFieldtext(),
        //                     ),
        //                   ),

        //                   appButtonbgimage(
        //                       'التحويل',
        //                           () => {},
        //                       bgColor: desgin_button1_start,
        //                       bgColor2: desgin_button1_end),


        //                 ])),
        //         Container(
        //           child: Text(
        //             "حقوق البرنامج محفوظه لدي مؤسسه",
        //             textAlign: TextAlign.center,
        //             style: AqarFont.getBoldFont(),
        //           ),
        //         ),
        //         Container(
        //           child: Text(
        //             "دليل التطبيقات للاتصالات و تقنيه المعلومات",
        //             textAlign: TextAlign.justify,
        //             style: AqarFont.getsmallFont(),
        //           ),
        //         ),
        //       ]),
        // ),
        
        ),
      ),
    );


  }
Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery , imageQuality: imageQuality);
_upload_Base64(image);
       //     String fileName = basename(image.path);
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
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600 , imageQuality: imageQuality);
    if(image == null){
      print("null Image");
      return null;
    }
_upload_Base64(image);
      //      String fileName = basename(image.path);
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
  String urlImage = "";


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


ContentVM content = new ContentVM();
bool apiCall = true ;

  @override
  void initState() {
    super.initState();
        _dropDownMenuyears = buildAndGetDropDownMenuItems(_Years);

    _selectedfromYear=_dropDownMenuyears[0].value;
    getUser().then((user){
      setState(() {
        this.user = user ;
       
      });
    });
    _dropDownMenuAccounts = buildAndGetDropDownMenuItems(_accounts);
    _selectedAccount=_dropDownMenuAccounts[3].value;
    _isButtonDisabled = false;
    ContentApi.SubscriptionValueInYear().then((response){
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
    
    PaymentAccountApi.getPaymentAccounts().then((response) {
          if (response.code ==200 ) {
            setState(() {
              _paymentAccount=response.data;
              title="الانما";
        account_No=_paymentAccount.AlEnma_ACCountNO;
        accountName=_paymentAccount.AlEnma_BankNameAr;
        account_IBAN=_paymentAccount.AlEnma_IBAN;
            });
          } else {
            print("${response.message}");
          }
          setState(() {
          });
        });
  }
  UserVM user ;
  PaymentAccountVM _paymentAccount = new PaymentAccountVM();

  @override
  void dispose() {
    super.dispose();
  }


  paymentview() {
    return Column(
      mainAxisSize: MainAxisSize.max, 
      children: [
        
      // Container(
      //   margin: EdgeInsets.only(right: 0, left: 0, bottom: 0, top: 20),
      //   width: MediaQuery.of(context).size.width,
      //   color: grey_ligth,
      //   child: Column(mainAxisSize: MainAxisSize.max, children: [
      //     Container(
      //       height: 5,
      //     ),
      //     new Text("Order : 2331",
      //         textAlign: TextAlign.center,
      //          style: MansaFont.gettitleFont()),
      //     new Text("Total : 440 SR",
      //         textAlign: TextAlign.center, style: MansaFont.gettitleFont()),
      //     Container(
      //       height: 5,
      //     ),
      //   ]),
      // ),
      Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 20),
        width: MediaQuery.of(_context).size.width,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: [grey_ligth, grey_ligth],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.5, 2.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userNameInputs(),
            appButtonbgimage(_isButtonDisabled ? "حسنا" : "التالي",
                () => _isButtonDisabled ? null : Transfere_payment(),
                bgColor: _isButtonDisabled ? gray : lightBgColor,
                bgColor2: _isButtonDisabled ? gray : transColor),
            Container(
              height: 10,
            ),
          ],
        ),
      ),
    ]);
  }
  sucessview() {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Container(
        margin: EdgeInsets.only(right: 0, left: 0, bottom: 0, top: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          SizedBox(
            height: 80,
          ),
          Container(
            child: Image.asset(
              'images/asset2.png',
              height: 200,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          new Text("تم بنجاح",
              textAlign: TextAlign.center, style: MansaFont.gettitleFont_payment_1()),
          SizedBox(
            height: 40,
          ),
          new Text("شكرا لثقتك  " ,
              textAlign: TextAlign.center, style: MansaFont.gettitleFont_payment_2()),
          new Text("تم تجديد الاشتراك بنجاح لمدفوعات رقم" + orderNum.toString(),
              textAlign: TextAlign.center, style: MansaFont.gettitleFont_payment_2()),
          SizedBox(
            height: 40,
          ),
          appButtonbgimage("حسنا",
                  () => Transfere_payment(),
              bgColor: lightBgColor,
              bgColor2: transColor),
        ]),
      ),
    ]);
  }
  userNameInputs() {
    _context = context;

    return Container(
      padding: EdgeInsets.all(10),
      child: Container(child: _buildCard()),
    );
  }

  Transfere_payment() {
    if(_isButtonDisabled){
      
      setState(() {
        _isButtonDisabled = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyServices(),));
    }
    else {
      if(
        phone1Key_log.currentState.value==null||phone1Key_log.currentState.value==""||
        // phone2Key_log.currentState.value==null||phone2Key_log.currentState.value==""||
        emailKey_log.currentState.value==null||emailKey_log.currentState.value==""||
        customerNameKey_log.currentState.value==null||customerNameKey_log.currentState.value==""||
        // accountTransferKey_log.currentState.value==null||accountTransferKey_log.currentState.value==""||
        // accountTransferToKey_log.currentState.value==null||accountTransferToKey_log.currentState.value==""||
        nameWhoTransferKey_log.currentState.value==null||nameWhoTransferKey_log.currentState.value==""){
          print("objectobjectobjectobjectobjectobjectobject");
        //  showInSnackBar(AppLocalizations.of(_context).lblEnterYourData, _context, _scaffoldKey);
        }else{
          showAppLoading(_context);
          CreatePaymentVM obj = new CreatePaymentVM();
          print(emailKey_log.currentState.value);
          obj.email=emailKey_log.currentState.value;
          obj.phone1=phone1Key_log.currentState.value;
          obj.phone2=phone2Key_log.currentState.value;
          obj.customerName=customerNameKey_log.currentState.value ;
          obj.accountTransfer=totalSubscription.toString();
          // obj.accountTransfer=accountTransferKey_log.currentState.value;
         // obj.accountTransferTo = accountTransferToKey_log.currentState.value;
          obj.nameWhoTransfer=nameWhoTransferKey_log.currentState.value;
          obj.userId=user.Id;
          obj.bankName=_selectedAccount;
          obj.Orderfile=firstUpload;
          PaymentAccountApi.createPayment(obj).then((response) {
          if (response.code ==200 ) {
            setState(() {
            _isButtonDisabled = true;
            orderNum=int.parse(response.message);
          });
          hideAppDialog(_context);
          } else {
            print("${response.message}");
          }
          setState(() {
          });
        }, onError: (error) {
          print("login Error : : :$error");
          setState(() {
          });
        });
        
        }
      
    }

  }

  void showSnack(String msg, {Duration duration}) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        msg,
        style: MansaFont.getRegularFont(),
      ),
      duration: duration == null ? Duration(seconds: 5) : duration,
    ));
  }
  Widget _buildCard() => Container(
        child: Form(
          key: _form_log,
          child: Column(children: [
            
            Container(
              margin: EdgeInsets.only(right: 5, left: 5, bottom: 0, top: 20),
              child: Text("ادفع الان بواسطه",//"Bank Transaction on our Bank Account",
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormFieldtextheader()
                  ),
            ),
            Container(
              height: 40,
            ),
            Row(
              children: <Widget>[
                Text("حساب بنك "),
                Text("    "),
                new DropdownButton(
                              value: _selectedAccount,
                              items: _dropDownMenuAccounts,
                              onChanged: changedDropDownAccount,
                            )
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
                children: <Widget>[
                  Container(
                    child: Text(title,
                      textAlign: TextAlign.left,
                      style: MansaFont.gettitleFontinside()
                      ),
                  ),
                ]
            ),
            Row(
                children: <Widget>[
                  Container(
                    child: SelectableText(
                        accountName,//"Akraz Al Janoub EST",
                        showCursor: true,
                        toolbarOptions: ToolbarOptions(
                            copy: true, selectAll: true, cut: false, paste: false),
                        textAlign: TextAlign.left,
                        style: MansaFont.gettitleFontinside_blueV2(),
                      ),
                  ),
                  Text("    "),
                  Text("انسخ",
                      textAlign: TextAlign.left,
                      //style: MansaFont.gettitleFontinside()
                      ),
                ]
            ),

            Container(
              height: 20,
            ),

            Row(
                children: <Widget>[
                  Container(
                    child:  Text("الايبان ",
                        textAlign: TextAlign.left,
                        //style: MansaFont.gettitleFontinside()
                        ),
                        ),
                ]
            ),
            
            
            Row(
                children: <Widget>[
                  Container(
                    child: SelectableText(
                        account_IBAN,//"SA 6410000047890911000101",
                        showCursor: true,
                        toolbarOptions: ToolbarOptions(
                            copy: true, selectAll: true, cut: false, paste: false),
                        textAlign: TextAlign.center,
                        style: MansaFont.gettitleFontinside_blueV2(),
                      ),
                  ),
                  Text("    "),
                  Text("انسخ",
                      textAlign: TextAlign.left,
                     // style: MansaFont.gettitleFontinside()
                      ),
                ]
            ),
          
            Container(
              height: 20,
            ),
            Row(
                children: <Widget>[
                  Container(
                    child:  Text("رقم الحساب",
                      textAlign: TextAlign.left,
                      //style: MansaFont.gettitleFontinside()
                      ),
                        ),
                ]
            ),
            Row(
                children: <Widget>[
                  Container(
                    child: SelectableText(
                      account_No,//"47890911000101",
                      showCursor: true,
                      toolbarOptions: ToolbarOptions(
                          copy: true, selectAll: true, cut: false, paste: false),
                      textAlign: TextAlign.center,
                      style: MansaFont.gettitleFontinside_blueV2(),
                    ),
                  ),
                  Text("    "),
                  Text("انسخ",
                      textAlign: TextAlign.left,
                      //style: MansaFont.gettitleFontinside()
                      ),
                ]
            ),
          Container(
            height: 20,
          ),
            Row(
              children: <Widget>[
                Expanded(
                flex: 1,
                child: Text("اسم العميل", 
                  //textAlign: TextAlign.center,
                  style: MansaFont.baseFontStyleWithBackground(),),
              ),
              Expanded( // wrap your Column in Expanded
              flex: 1,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: customerNameKey_log,
                      maxLines: 1,
                     // textAlign: TextAlign.left,
                      style: MansaFont.getLightFontV2(),
                      decoration: InputDecoration(
                        labelText: "اسم العميل",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 10.0),
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
             Row(
              children: <Widget>[
                Expanded(
                flex: 2,
                child: Text(" مده الاشتراك سنويا ", 
                  //textAlign: TextAlign.center,
                  style: MansaFont.baseFontStyleWithBackground(),),
              ),
              Expanded( // wrap your Column in Expanded
              flex: 1,
                child: Container(
                  child: new DropdownButton(
                        value: _selectedfromYear,
                        items: _dropDownMenuyears,
                        onChanged: changedDropDownfromyear,
                      )
                      //Dropdowndays("1"),
                ),
              ),
              ],
            ),
           
            Container(
              height: 20,
            ),

            Row(
              children: <Widget>[
                Expanded(
                flex: 1,
                child: Text("قيمه الاشتراك ",//"Account Transfered", 
                  //textAlign: TextAlign.center,
                  style: MansaFont.baseFontStyleWithBackground(),),
              ),
              Expanded( // wrap your Column in Expanded
              flex: 1,
                child: Column(
                  children: <Widget>[
                    Text("$totalSubscription"),
                    // TextFormField(
                    //   key: accountTransferKey_log,
                    //   initialValue: "$totalSubscription",
                    //   enabled: false,
                      
                    //   keyboardType: TextInputType.number,
                    //   maxLines: 1,
                    //   style: MansaFont.getLightFont(),
                    //   decoration: InputDecoration(
                    //     labelText: "قيمه الاشتراك",
                    //     contentPadding: new EdgeInsets.symmetric(
                    //         vertical: 14.0, horizontal: 10.0),
                    //   ),
                    // )
                  ],
                ),
              )
              ],
            ),
            // Container(
            //   height: 20,
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //     flex: 1,
            //     child: Text(AppLocalizations.of(context).lblAccountTransferTo, 
            //       //textAlign: TextAlign.center,
            //       style: MansaFont.baseFontStyleWithBackground(),),
            //   ),
            //   Expanded( // wrap your Column in Expanded
            //   flex: 1,
            //     child: Column(
            //       children: <Widget>[
            //         TextFormField(
            //           key: accountTransferToKey_log,
            //           maxLines: 1,
            //           textAlign: TextAlign.left,
            //           style: MansaFont.getLightFont(),
            //           decoration: InputDecoration(
            //             labelText: AppLocalizations.of(context).lblAccountTransferTo,
            //             contentPadding: new EdgeInsets.symmetric(
            //                 vertical: 14.0, horizontal: 10.0),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            //   ],
            // ),
            Container(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                flex: 1,
                child: Text("من المحول ",//"Name Who Transfer", 
                  //textAlign: TextAlign.center,
                  style: MansaFont.baseFontStyleWithBackground(),),
              ),
              Expanded( // wrap your Column in Expanded
              flex: 1,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: nameWhoTransferKey_log,
                      maxLines: 1,
                      //textAlign: TextAlign.left,
                      style: MansaFont.getLightFontV2(),
                      decoration: InputDecoration(
                        labelText: "الدافع",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 10.0),
                      ),
                    )
                  ],
                ),
              ),
              ],
            ),
            Container(
              height: 40,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "معلومات الاتصال",
                      textAlign: TextAlign.center,
                      style: MansaFont.getBoldFontinside(),
                    ),
                  ),
                ]
            ),
              Container(
                height: 20,
              ),    
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                flex: 1,
                child: Text("رقم الجوال الاول", 
                  //textAlign: TextAlign.center,
                  style: MansaFont.baseFontStyleWithBackground(),),
              ),
              Expanded( // wrap your Column in Expanded
              flex: 1,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: phone1Key_log,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      //textAlign: TextAlign.left,
                      style: MansaFont.getLightFont(),
                      decoration: InputDecoration(
                        labelText: "الرقم الاول",
                        // labelStyle:
                        // MansaFont.getLightFont_TextFormField(),
                        // fillColor: Colors.blueGrey,
                        // hintText: AppLocalizations.of(context).lblFirstNumPlaceholder,
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 10.0),
                        // border: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(color: grey_ligth, width: 0.0),
                        //   borderRadius: BorderRadius.circular(25.0),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(color: grey_ligth, width: 1.0),
                        //   borderRadius: BorderRadius.circular(25.0),
                        // ),
                      ),
                    )
                  ],
                ),
              ),
                ],
              ),
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              

              Expanded(
                flex: 1,
                child: Text("رقم الجوال التاني", 
                  textAlign: TextAlign.center,
                  style: MansaFont.baseFontStyleWithBackground(),),
              ),
              Expanded( // wrap your Column in Expanded
                flex: 1,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: phone2Key_log,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      //textAlign: TextAlign.left,
                      style: MansaFont.getLightFont(),
                      decoration: InputDecoration(
                        labelText:"الرقم التاني",
                        // labelStyle:
                        // MansaFont.getLightFont_TextFormField(),
                        // fillColor: Colors.blueGrey,
                        // hintText: AppLocalizations.of(context).lblSecondNumPlaceholder,
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 10.0),
                        // border: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(color: grey_ligth, width: 0.0),
                        //   borderRadius: BorderRadius.circular(25.0),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(color: grey_ligth, width: 1.0),
                        //   borderRadius: BorderRadius.circular(25.0),
                        // ),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                
                flex: 1,
                child: Text("البريد الالكتروني", 
                  //textAlign: TextAlign.center,
                  style: MansaFont.baseFontStyleWithBackground(),),
              ),
              Expanded( // wrap your Column in Expanded
              flex: 1,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: emailKey_log,
                      maxLines: 1,
                      //textAlign: TextAlign.left,
                      style: MansaFont.getLightFontV2(),
                      decoration: InputDecoration(
                        labelText: "البريد الالكتروني",
                        // labelStyle:
                        // MansaFont.getLightFont_TextFormField(),
                        // fillColor: Colors.blueGrey,
                        // hintText: AppLocalizations.of(context).lblEmailSample,
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 10.0),
                        // border: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(color: grey_ligth, width: 0.0),
                        //   borderRadius: BorderRadius.circular(25.0),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(color: grey_ligth, width: 1.0),
                        //   borderRadius: BorderRadius.circular(25.0),
                        // ),
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
              child: Builder(
              builder: (cont) => SingleChildScrollView(
                child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 230,
                        child: Column(
                          children: <Widget>[
                            appButtonbgimage_normal(
                                // Strings.getupload(),
                                //     () => Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => Emarkiting_campaigns())),
                                "ارفق الايصال",
                                    (){
                                      pickImage(cont, () {
                        setState(() {
                          // print("image path");
                          // print(image.path);
                          // _upload_Base64(image);
                          // imagename = basename(image.path);
                          // _image = image;
                        });
                      });
                                    //   ImagePickerHelper().pickImage(cont, (File image) {
                                    //   setState(() {
                                    //     print("After pick image");
                                        
                                    //    // _image = image;
                                    //     String fileName = image.path.split('/').last;
                                    //     String filePath = image.path;
                                    //     print(filePath);
                                    //     print(fileName);
                                    //     upload(fileName, filePath); 
                                    //   });
                                    // });
                                    },
                                bgColor: desgin_button1_start,
                                bgColor2: desgin_button1_end),
                            Container(
                              child: Text(
                                 lblFirstUpload,//AppLocalizations.of(context).lblgetupload_text
                                textAlign: TextAlign.center,
                                style: MansaFont.getRegularFontinside(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
                )),
            ),
            

                Container(
                  height: 20,
                ),
          ]),
        ),
      );

void changedDropDownAccount(String selectedS) {
    setState(() {
      _selectedAccount = selectedS;
      if(selectedS=="الاهلي"){
        //title="الاهلي";
        account_No=_paymentAccount.AlAhly_ACCountNO;
        accountName=_paymentAccount.AlAhly_BankNameAr;
        account_IBAN=_paymentAccount.AlAhly_IBAN;
      }else if(selectedS=="الراجحي"){
        //title="الراجحي";
        account_No=_paymentAccount.AlRaghy_ACCountNO;
        accountName=_paymentAccount.AlRaghy_BankNameAr;
        account_IBAN=_paymentAccount.AlRaghy_IBAN;
      }else if(selectedS=="سامبا"){
        //title="سامبا";
        account_No=_paymentAccount.Sampa_ACCountNO;
        accountName=_paymentAccount.Sampa_BankNameAr;
        account_IBAN=_paymentAccount.Sampa_IBAN;
      }else if(selectedS=="الانما"){
        //title="الانما";
        account_No=_paymentAccount.AlEnma_ACCountNO;
        accountName=_paymentAccount.AlEnma_BankNameAr;
        account_IBAN=_paymentAccount.AlEnma_IBAN;
      }else if(selectedS=="ساب"){
        //title="ساب";
        account_No=_paymentAccount.Sap_ACCountNO;
        accountName=_paymentAccount.Sap_BankNameAr;
        account_IBAN=_paymentAccount.Sap_IBAN;
      }
      title=selectedS;
    });
  }
  
  
  
  void changedDropDownfromyear(String selectedD) {
    setState(() {
      _selectedfromYear = selectedD;
      print(selectedD);
      totalSubscription = int.parse(selectedD)*(int.parse(content.valueAr.toString()));
            print(totalSubscription);
      

    });
  }
List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List _countries) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in _countries) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

}
