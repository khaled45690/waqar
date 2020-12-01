import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waqarapp/API/ContactUsApi.dart';
import 'package:waqarapp/API/ContentApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/model/ContactUsVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';

import 'About_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Update_useraccount.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart'; 


class Contact_us extends StatefulWidget {
  @override
  _Contact_usState createState() => new _Contact_usState();
}

class _Contact_usState extends State<Contact_us> {

  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UnboundedScrollController _negativeController = new UnboundedScrollController();
  // String name="";
  // String email="";
  bool apiCall = true ;
  UserVM userVM ;
     @override
  void initState() {
    super.initState();
    //post=getAboutApp();


    getUser().then((user){
      setState(() {
              this.userVM = user ;
      });
    });

    ContentApi.getContactUs("null").then((response){
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
       //this.apiCall = false ;
    });
  }




ContactUsVM content = new ContactUsVM();
TextEditingController name = new TextEditingController();
    TextEditingController phone = new TextEditingController();
    TextEditingController email = new TextEditingController();
    TextEditingController message = new TextEditingController();
    TextEditingController complants = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    var screenSize = MediaQuery.of(context).size;
    _context = context;
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
    "تواصل معنا",
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

    body:  Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: <Widget>[
         this.apiCall ? Center(child: CircularProgressIndicator(),):new Container(
              child:    Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              new Image.asset(
                                  "images/Logo-01.png",//"images/logo_head.png",
                                  height: 150.0,
                                  width: 150.0,
                                ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Material(
                                  // borderRadius: BorderRadius.circular(13),
                                elevation: 5,
                                child: InkWell(
                                  onTap: (){
                                   
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF9E9E9E),
                                        // borderRadius: BorderRadius.circular(13)
                                        ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 4,
                                            child: Text(
                                              "تواصل معنا",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        // Expanded(
                                        //     flex: 1, child: Icon(Icons.arrow_forward_ios ,color: SECONDARY_COLOR,))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  height: 240,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width-32,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Center(
                                                    child: Image.asset(
                                                  "images/Phone.png",
                                                  fit: BoxFit.fill,
                                                )),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: InkWell(
                                                  onTap:() async {
                                                    try{
                                                          //  mobileNum="552358049";
                                                          // String s= "https://wa.me/966"+content.phone+"?text=Hello";
                                                          //   await launch(s);//https://wa.me/${}?text=Hello
                                                            new CallService().call(content.phone);
                                                        }catch(Ex){
                                                            new CallService().call(content.phone);
                                                        }
                                                  },
                                                  child: Text(
                                                     "            "+ content.phone ,//content.phone,
                                                     textDirection: TextDirection.ltr,
                                                    //'00000000000',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                )),
                                            // Expanded(
                                            //     flex: 1, child: Icon(Icons.arrow_forward_ios))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                        child: Divider(height: 2, color: Colors.grey,),
                                      ),
                                      Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width-32,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Center(
                                                    child: Image.asset(
                                                  "images/Email.png",
                                                  fit: BoxFit.fill,
                                                )),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: InkWell(
                                                  onTap:(){
                                                   
                                                  },
                                                  child: Text(
                                                   "            "+ content.email,
                                                 //   'W_aqar@gmail.com',
                                                 textDirection: TextDirection.ltr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                )),
                                            // Expanded(
                                            //     flex: 1, child: Icon(Icons.arrow_forward_ios))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                        child: Divider(height: 2, color: Colors.grey,),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width-32,
                                        height: 40,
                                        child:InkWell(
                                          onTap: (){
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Wallet()));
                                            //_launchWebsite();
                                          
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(13)),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    child: Center(
                                                        child: Image.asset(
                                                          "images/Website.png",
                                                          fit: BoxFit.fill,
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex:5,
                                                    child: Text(
                                                      "            "+ content.website ,//content.website,
                                                   //   'www.w_aqar.com',
                                                   textDirection: TextDirection.ltr,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                // Expanded(
                                                //     flex: 1, child: Icon(Icons.arrow_forward_ios))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                        child: Divider(height: 2, color: Colors.grey,),
                                      ),
                                      // Container(
                                      //   height: 40,
                                      //   width: MediaQuery.of(context).size.width-32,
                                      //   child: InkWell(
                                      //     onTap: (){
                                      //     //  _launchFacebook(content.facebook);
                                      //     },
                                      //     child: Container(
                                      //       padding: EdgeInsets.all(8),
                                      //       height: 60,
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.white,
                                      //           borderRadius: BorderRadius.circular(13)),
                                      //       child: Row(
                                      //         children: <Widget>[
                                      //           Expanded(
                                      //             flex: 1,
                                      //             child: Container(
                                      //               child: Center(
                                      //                   child: Image.asset(
                                      //                     "images/ff.png",
                                      //                     fit: BoxFit.fill,
                                      //                   )),
                                      //             ),
                                      //           ),
                                      //           Expanded(
                                      //               flex:5,
                                      //               child: Text(
                                      //                 "Facebook",
                                      //                 style: TextStyle(
                                      //                     fontSize: 18,
                                      //                     fontWeight: FontWeight.bold),
                                      //               )),
                                                
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                               SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Material(
                                elevation: 5,
                                child: InkWell(
                                  onTap: (){
                                   
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF9E9E9E),
                                        ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 4,
                                            child: Text(
                                              "ارسل لنا ملاحظاتك",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        // Expanded(
                                        //     flex: 1, child: Icon(Icons.arrow_forward_ios ,color: SECONDARY_COLOR,))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                             
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  height: 450,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Column(
                                    children: <Widget>[
                                      
                                      // Container(
                                      //   height: 50,
                                      //   width: MediaQuery.of(context).size.width-32,
                                      //   child: Row(
                                      //     children: <Widget>[
                                      //       Expanded(
                                      //           flex: 6,
                                      //           child: InkWell(
                                      //             onTap:(){
                                      //               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowingProducts(this.user.id)));
                                      //             },
                                      //             child: new TextField(
                                      //               controller: name,
                                      //               autofocus: false,
                                      //               obscureText: false,
                                      //               keyboardType: TextInputType.emailAddress,
                                      //               // controller: emailEditingContrller,
                                      //               decoration: InputDecoration(
                                      //                   labelText: "الاسم",
                                      //                   // hintText: " الاسم",
                                      //                   labelStyle: TextStyle(
                                      //                     color: Colors.black,
                                      //                     fontSize: 16.0,
                                      //                   ),
                                      //                   border: OutlineInputBorder(
                                      //                       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      //                       borderSide: BorderSide(
                                      //                           width: 1.0,
                                      //                           color: Colors.green,
                                      //                           style: BorderStyle.solid))),
                                      //             ),
                                      //           )),
                                           
                                      //     ],
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                      //   child: Divider(height: 2, color: Colors.grey,),
                                      // ),
                                      // Container(
                                      //   height: 50,
                                      //   width: MediaQuery.of(context).size.width-32,
                                      //   child: Row(
                                      //     children: <Widget>[
                                      //       Expanded(
                                      //           flex: 6,
                                      //           child: InkWell(
                                      //             onTap:(){
                                      //               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowingProducts(this.user.id)));
                                      //             },
                                      //             child: new TextField(
                                      //               controller: email,
                                      //               autofocus: false,
                                      //               obscureText: false,
                                      //               keyboardType: TextInputType.emailAddress,
                                      //               // controller: emailEditingContrller,
                                      //               decoration: InputDecoration(
                                      //                   labelText:"الايميل",
                                      //                   // hintText: "البريد الالكتروني",
                                      //                   labelStyle: TextStyle(
                                      //                     color: Colors.black,
                                      //                     fontSize: 16.0,
                                      //                   ),
                                      //                   border: OutlineInputBorder(
                                      //                       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      //                       borderSide: BorderSide(
                                      //                           width: 1.0,
                                      //                           color: Colors.green,
                                      //                           style: BorderStyle.solid))),
                                      //             ),
                                      //           )),
                                           
                                      //     ],
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                      //   child: Divider(height: 2, color: Colors.grey,),
                                      // ),
                                      // Container(
                                      //   height: 50,
                                      //   width: MediaQuery.of(context).size.width-32,
                                      //   child: Row(
                                      //     children: <Widget>[
                                      //       Expanded(
                                      //           flex: 6,
                                      //           child: InkWell(
                                      //             onTap:(){
                                      //               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowingProducts(this.user.id)));
                                      //             },
                                      //             child: new TextField(
                                      //               controller: phone,
                                      //               autofocus: false,
                                      //               obscureText: false,
                                      //               keyboardType: TextInputType.emailAddress,
                                      //               // controller: emailEditingContrller,
                                      //               decoration: InputDecoration(
                                      //                   labelText: "التليفون",
                                      //                   // hintText: "رقم الموبايل",
                                      //                   labelStyle: TextStyle(
                                      //                     color: Colors.black,
                                      //                     fontSize: 16.0,
                                      //                   ),
                                      //                   border: OutlineInputBorder(
                                      //                       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      //                       borderSide: BorderSide(
                                      //                           width: 1.0,
                                      //                           color: Colors.green,
                                      //                           style: BorderStyle.solid))),
                                      //             ),
                                      //           )),
                                           
                                      //     ],
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                        child: Divider(height: 2, color: Colors.grey,),
                                      ),
                                      Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width-32,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 6,
                                                child: InkWell(
                                                  onTap:(){
                                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowingProducts(this.user.id)));
                                                  },
                                                  child: new TextField(
                                                    controller: complants,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    keyboardType: TextInputType.emailAddress,
                                                    // controller: emailEditingContrller,
                                                    decoration: InputDecoration(
                                                        labelText: "الشكوي",
                                                        // hintText: "شكوي أو اقتراح",
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                            borderSide: BorderSide(
                                                                width: 1.0,
                                                                color: Colors.green,
                                                                style: BorderStyle.solid))),
                                                  ),
                                                )),
                                           
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                        child: Divider(height: 2, color: Colors.grey,),
                                      ),
                                      Container(
                                        height: 100,
                                        width: MediaQuery.of(context).size.width-32,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 6,
                                                child: new TextField(
                                                  controller: message,
                                                    maxLines: 8,
                                                    keyboardType: TextInputType.multiline,
                                                    // autofocus: false,
                                                    // obscureText: false,
                                                    // controller: emailEditingContrller,
                                                    decoration: InputDecoration(
                                                        labelText: "الرساله",
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                            borderSide: BorderSide(
                                                                width: 1.0,
                                                                color: Colors.green,
                                                                style: BorderStyle.solid))
                                                                ),
                                                                
                                                  ),),
                                           
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8 ,bottom: 8 , right: 32 , left: 32),
                                        child: Divider(height: 2, color: Colors.grey,),
                                      ),
                                      Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width-32,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                              ),
                                            ),
                                            Expanded(
                                                flex: 5,
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
                                                  child: Text("ارسال"),
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
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),

                            ],
                          ),
                        ),
                  
                    ),
                  ),
                  flex: 3,
                ),
            
            
            ),
          ],
      ),
      ),
 
          endDrawer: buildDrawer()
        );
  }


submitForm() {
    print(name.text);
    print(message.text);
    
    print(email.text);
    print(phone.text);
    print(complants.text);

    String Fname= userVM.FullName == null||userVM.FullName==""?"زائر":userVM.FullName;
    String Phon = userVM.Phone ==null||userVM.Phone==""?"":userVM.Phone;
    String Eml = userVM.Email==null||userVM.Email==""?"":userVM.Email;
   if(//name.text==null||name.text=="" ||
      message.text==null||message.text=="" ||
     // email.text==null||email.text=="" ||
    //  phone.text==null||phone.text=="" ||
      complants.text==null||complants.text==""
      ){
        showInSnackBar("من فضلك قد بادراج جميع الحقول ", context, _scaffoldKey);
      }else{
        ContactUsApi.contactUs(
            //  widget.id,
              //name.text,
              Fname,Phon,Eml,
              //phone.text,
              //email.text,
              complants.text,
              message.text,
              content.email
            )
        .then((response) {
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
@override
void dispose() {
  super.dispose();
}
}


class UnboundedScrollPosition extends ScrollPositionWithSingleContext {
  UnboundedScrollPosition({
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition oldPosition,
  }) : super(physics: physics, context: context, oldPosition: oldPosition);

  @override
  double get minScrollExtent => double.negativeInfinity;
}

class UnboundedScrollController extends ScrollController {
  @override
  UnboundedScrollPosition createScrollPosition(
      ScrollPhysics physics,
      ScrollContext context,
      ScrollPosition oldPosition,
      ) {
    return new UnboundedScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
    );
  }
}