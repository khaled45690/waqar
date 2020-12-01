import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/API/ContentApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/ContentVM.dart';
import 'package:waqarapp/model/UserVM.dart';

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

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => new _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UnboundedScrollController _negativeController = new UnboundedScrollController();
  String name="";
  String email="";
  
  UserVM userVM ;
@override
  void initState() {
    print("Start About App");
    super.initState();
    getUser().then((user){
      setState(() {
              this.userVM = user ;
      });
    });
    
  }
      TextEditingController newpassword = new TextEditingController();

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
    "تغيير كلمه السر ",
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
          Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  height: 450,
                                  // decoration: BoxDecoration(
                                  //     color: Colors.white,
                                  //     borderRadius: BorderRadius.circular(13)),
                                  child: Column(
                                    children: <Widget>[
                                      
                                      Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width-32,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 6,
                                                child: InkWell(
                                                  onTap:(){
                                                  },
                                                  child: new TextField(
                                                    controller: newpassword,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    keyboardType: TextInputType.text,
                                                    // controller: emailEditingContrller,
                                                    decoration: InputDecoration(
                                                       // labelText: AppLocalizations.of(context).lblpassword,
                                                        // hintText: " الاسم",
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                        ),
                                                        // border: OutlineInputBorder(
                                                        //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                        //     borderSide: BorderSide(
                                                        //         width: 1.0,
                                                        //         color: Colors.green,
                                                        //         style: BorderStyle.solid))
                                                                ),
                                                  ),
                                                )),
                                           
                                          ],
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                      //   child: Divider(height: 2, color: Colors.grey,),
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                      //   child: Divider(height: 2, color: Colors.grey,),
                                      // ),
                                      Container(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width-32,
                                        child: Row(
                                          children: <Widget>[
                                            
                                            Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                  onTap:(){
                                                    submitForm();
                                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowingProducts(this.user.id)));
                                                  },
                                                  child:RaisedButton(
                                                  onPressed: () {
                                                    // Validate returns true if the form is valid, otherwise false.
                                                   submitForm();
                                                  },
                                                  child: Text("تغيير الرقم السري"),
                                                ),
                                                  // child: new FlatButton(
                                                  //   child: new Text("ارسال"),
                                                  //   // onPressed: () => Navigator.pop(context),
                                                  // ),
                                                )),
                                           
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             

                            ],
                          ),
                        ),
                  
                    ),
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
 submitForm() {
    // setState(() {
    //   this.addingApi = true;
    // });
    // print(widget.id);
    // int subcatId=0;
    showAppLoading(context);

   if(newpassword.text==null||newpassword.text==""){
        showInSnackBar("من فضلك قد بادراج جميع الحقول ", context, _scaffoldKey);
      }else{
        AuthApi.changePassWord(
              userVM.Id,
              newpassword.text,
            )
        .then((response) {
                      hideAppDialog(context);

           if (response.code ==200 ) {
            showInSnackBar(response.message, context, _scaffoldKey);
   
            //showInSnackBar("تم اضافه الخدمه الي سله الطلبات", _context, _scaffoldKey);
           // showSnack("تم اضافه الخدمه الي سله المهملات");
          } else {
                        showInSnackBar(response.message, context, _scaffoldKey);

            print("${response.message}");
            //showInSnackBar("${response.message}", context, _scaffoldKey);
          }
      setState(() {
        // this.addingApi = false;
      });
    }, onError: (error) {
      setState(() {
        // this.addingApi = false;
      });
     // print("adding product error : :$error");
    });
      }
   
}

}

