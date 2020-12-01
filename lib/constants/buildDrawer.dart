
import 'package:flutter/material.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/ui/About_us.dart';
import 'package:waqarapp/ui/AllAvailableOffersNewDesignByType.dart';
import 'package:waqarapp/ui/ChangePassword.dart';
import 'package:waqarapp/ui/ChosseUser.dart';
import 'package:waqarapp/ui/Contact_us.dart';
import 'package:waqarapp/ui/Favourite.dart';
import 'package:waqarapp/ui/HomeScreen.dart';
import 'package:waqarapp/ui/Membership.dart';
import 'package:waqarapp/ui/OffersNewDesign.dart';
import 'package:waqarapp/ui/Payment.dart';
import 'package:waqarapp/ui/ServicesDataThatUserAcceptedNewDesign.dart';
import 'package:waqarapp/ui/Terms.dart';
import 'package:waqarapp/ui/Update_useraccount.dart';
import 'customcolors.dart';

class buildDrawer extends StatefulWidget {

  @override
  __buildDrawerState createState() => new __buildDrawerState();
}

class __buildDrawerState extends State<buildDrawer> {
  BuildContext _context;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
String usertype = "مستخدم";
 @override
  void initState() {
    super.initState();
    getUser().then((user){
      setState(() {
              this.user = user ;
      });
    });
    if(user!=null){
     //     print("user.emaillllllllllllllllllll");
      //print(user.Email);
    }
    //print(user.UserType);
  }
  UserVM user ;
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;
    return usertype == 'مستخدم' ? drawer_home_user() : drawer_home_user();
  }


showAlertDialog(BuildContext context) {
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
      title: Text("تاكيد",
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
      content: Text("هل تريد الخروج",
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
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
  }

   drawer_home_user() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:user==null||user.Email==null||user.Email.toString()==""||user.Email==null?Text("من فضلك قم بتسجيل الدخول"): Text(user.FullName==null?"":user.FullName),
            accountEmail: user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Text(""):Text(user.Email.toString()),
            currentAccountPicture:user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?
               Padding(
                          padding:EdgeInsets.all(0.0),
                          child: Image.asset('images/asset15.png' , width: 500,height: 500,),
                        ):Padding(
                          padding:EdgeInsets.all(0.0),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage(user.UserImage),
                            backgroundColor: Colors.transparent,
                          ),
                          
                          
                          //Image.network(user.image , width: 500,height: 500,),
                        ),
                        // :Padding(
                        //   padding:EdgeInsets.all(0.0),
                        //   child: Image.network(user.UserImage , width: 500,height: 500,),
                        // ),
               
            decoration: BoxDecoration(color: Colors.blueAccent),
            // accountName: new Text(
            //   "name",
            //   style: AqarFont.baseFontStyle(),
            // ),
            // accountEmail: new Text(
            //   "email",
            //   style: AqarFont.baseFontStyle(),
            // ),
            // currentAccountPicture: Image.asset('images/asset15.png'),
            // decoration: new BoxDecoration(
            //   color: gray,
            //   gradient: new LinearGradient(
            //     colors: [desgin_button1_start, desgin_button1_start],
            //     begin: const FractionalOffset(0.0, 0.0),
            //     end: const FractionalOffset(0.5, 0.0),
            //     stops: [0.0, 1.0],
            //     tileMode: TileMode.clamp,
            //   ),
            // ),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'الرئيسية',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
              if( user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseUser()));
              }else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              }
               
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),


          user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'تعديل بياناتي',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Update_useraccount()));
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),
          user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'تغيير الرقم السري',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangePassword()));
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),

          // ListTile(
          //   contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          //   title: Text(
          //     'خدماتي',
          //     style: AqarFont.baseRegularcolorFont(),
          //     textAlign: TextAlign.right,
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) => MyServices()));
          //     _scaffoldKey.currentState.openDrawer();
          //   },
          // ),
          // (user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null)||(user.Email!=null && user.UserType=="User") ?Divider(
          //   indent: 40.0,
          //   endIndent: 40.0,
          //   height: 2.0,
          //   color: desgin_button1_start,
          // ):Container(),
          // (user!=null&&user.Email.toString()!=null&&user.Email.toString()!=""&&user.Email!=null)&&
          // (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")?Divider(
          //   indent: 40.0,
          //   endIndent: 40.0,
          //   height: 2.0,
          //   color: desgin_button1_start,
          // ):Container(),


          (user!=null&&user.Email.toString()!=null&&user.Email.toString()!=""&&user.Email!=null)&&
          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")?ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'العضويه',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Membership(user.Id)));
              _scaffoldKey.currentState.openDrawer();
            },
          ):Container(),
          (user!=null&&user.Email.toString()!=null&&user.Email.toString()!=""&&user.Email!=null)&&
          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")?Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ):Container(),


          //user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'تجديد الاشتراك',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Payment()));
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          //user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():
          Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),


          user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              user.UserType.toString()=="mediator"?"طلباتي و عروضي":"طلباتي و عروضي",
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
             // Navigator.of(context).push(
               //   MaterialPageRoute(builder: (context) => OrdersOffers()));
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OffersNewDesign()));
              _scaffoldKey.currentState.openDrawer();
            },
          ),

          user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),

          // (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")?Divider(
          //   indent: 40.0,
          //   endIndent: 40.0,
          //   height: 2.0,
          //   color: desgin_button1_start,
          // ):Container(),

          // (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")
          // ?ListTile(
          //   contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          //   title: Text(
          //     ' الطلبات و العروض',
          //     style: AqarFont.baseRegularcolorFont(),
          //     textAlign: TextAlign.right,
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //         Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => AllAvailableOffers()));
          //     _scaffoldKey.currentState.openDrawer();
          //   },
          // ):Container(),
 
  //         (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")||
  //          user.Id==null ||user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null
  //         ?ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             ' الطلبات و العروض',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.pop(context);
  //                 Navigator.of(context).push(
  //                 MaterialPageRoute(builder: (context) => AllAvailableOffersNewDesign()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ):Container(),

  //         (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator") ||
  // user.Id==null || user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ):Container(),

          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")||
           user.Id==null ||user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null
          ?ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              ' الطلبات ',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllAvailableOffersNewDesignByType(1)));
              _scaffoldKey.currentState.openDrawer();
            },
          ):Container(),

          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator") ||
  user.Id==null || user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ):Container(),

          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")||
           user.Id==null ||user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null
          ?ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              '  العروض',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllAvailableOffersNewDesignByType(0)));
              _scaffoldKey.currentState.openDrawer();
            },
          ):Container(),

          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator") ||
  user.Id==null || user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ):Container(),


        

          (user.UserType!=null&&user.UserType.toString()!=null)?ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              ' المفضله',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Favourite()));
              _scaffoldKey.currentState.openDrawer();
            },
          ):Container(),
          (user.UserType!=null&&user.UserType.toString()!=null)?Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ):Container(),









          

          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")?ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              ' الطلبات و العروض المستلمه',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
             // Navigator.of(context).push(
               //   MaterialPageRoute(builder: (context) => OrdersOffers()));
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ServicesDataThatUserAcceptedNewDesign(user.Id)));
              _scaffoldKey.currentState.openDrawer();
            },
          ):Container(),
          (user.UserType!=null&&user.UserType.toString()!=null&&user.UserType.toString()=="mediator"&&user.UserType=="mediator")?Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ):Container(),
          // user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
          //   indent: 40.0,
          //   endIndent: 40.0,
          //   height: 2.0,
          //   color: desgin_button1_start,
          // ),

          // user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
          //   contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          //   title: Text(
          //     ' الاشعارات ',
          //     style: AqarFont.baseRegularcolorFont(),
          //     textAlign: TextAlign.right,
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //    // Navigator.of(context).push(
          //      //   MaterialPageRoute(builder: (context) => OrdersOffers()));
          //         Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => MessagingWidget()));
          //     _scaffoldKey.currentState.openDrawer();
          //   },
          // ),
          // user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
          //   indent: 40.0,
          //   endIndent: 40.0,
          //   height: 2.0,
          //   color: desgin_button1_start,
          // ),

          // user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
          //   contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          //   title: Text(
          //     ' طلباتي',
          //     style: AqarFont.baseRegularcolorFont(),
          //     textAlign: TextAlign.right,
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //    // Navigator.of(context).push(
          //      //   MaterialPageRoute(builder: (context) => OrdersOffers()));
          //         Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => Orders()));
          //     _scaffoldKey.currentState.openDrawer();
          //   },
          // ),
          


          ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'تواصل معنا',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Contact_us()));
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          
          Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),


          ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'عن التطبيق',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => About_us()));
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              ' الشروط و الاحكام',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Terms()));
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),
          user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
              title: Text(
                'تسجيل الدخول',
                style: AqarFont.baseRegularcolorFont(),
                textAlign: TextAlign.right,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ChooseUser()//HomeScreen()
                    ));
                _scaffoldKey.currentState.openDrawer();
              },
            ):ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            title: Text(
              'الخروج',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              // Preferences().setUserId("");
              // Preferences().setusername("");
              // Preferences().setemail("");
              // Preferences().setPassword("");
              // Preferences().setPhone("");
              // Preferences().setimage("");
              // Preferences().setusertype("");
              // Preferences().setusercity("");
              // Preferences().setfcmID("");
              clear();
                 Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ChooseUser()//HomeScreen()
                      ));
             // showAlertDialog(_context);
            },
          ),
          Divider(
            indent: 40.0,
            endIndent: 40.0,
            height: 2.0,
            color: desgin_button1_start,
          ),
        ],
      ),
    );
  }

  // drawer_home_waseet() {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: <Widget>[
  //         UserAccountsDrawerHeader(
  //           accountName: new Text(
  //             "name",
  //             style: AqarFont.baseFontStyle(),
  //           ),
  //           accountEmail: new Text(
  //             "email",
  //             style: AqarFont.baseFontStyle(),
  //           ),
  //           currentAccountPicture: Image.asset('images/asset15.png'),
  //           decoration: new BoxDecoration(
  //             color: gray,
  //             gradient: new LinearGradient(
  //               colors: [desgin_button1_start, desgin_button1_start],
  //               begin: const FractionalOffset(0.0, 0.0),
  //               end: const FractionalOffset(0.5, 0.0),
  //               stops: [0.0, 1.0],
  //               tileMode: TileMode.clamp,
  //             ),
  //           ),
  //         ),
  //         ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'الرئيسية',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'تعديل بياناتي',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => Update_useraccount()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'تغيير الرقم السري',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => ChangePassword()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'خدماتي',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context)
  //                 .push(MaterialPageRoute(builder: (context) => MyServices()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'العضويه',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context)
  //                 .push(MaterialPageRoute(builder: (context) => Membership(user.Id)));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'الدفع',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context)
  //                 .push(MaterialPageRoute(builder: (context) => Payment()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?Container():Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'تواصل معنا',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context)
  //                 .push(MaterialPageRoute(builder: (context) => Contact_us()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'عن الشركه',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context)
  //                 .push(MaterialPageRoute(builder: (context) => About_us()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             ' الشروط و الاحكام',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             Navigator.of(context)
  //                 .push(MaterialPageRoute(builder: (context) => Terms()));
  //             _scaffoldKey.currentState.openDrawer();
  //           },
  //         ),
  //         Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //         user==null||user.Email.toString()==null||user.Email.toString()==""||user.Email==null?
  //           ListTile(
  //             contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //             title: Text(
  //               'تسجيل الدخول',
  //               style: AqarFont.baseRegularcolorFont(),
  //               textAlign: TextAlign.right,
  //             ),
  //             onTap: () {
  //               Navigator.of(context)
  //                   .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //               _scaffoldKey.currentState.openDrawer();
  //             },
  //           ):ListTile(
  //           contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //           title: Text(
  //             'الخروج',
  //             style: AqarFont.baseRegularcolorFont(),
  //             textAlign: TextAlign.right,
  //           ),
  //           onTap: () {
  //             clear();
  //                Navigator.pop(context);
  //                 Navigator.of(context).push(
  //                     MaterialPageRoute(builder: (context) => HomeScreen()));
  //             // Preferences().setUserId("");
  //             // Preferences().setusername("");
  //             // Preferences().setemail("");
  //             // Preferences().setPassword("");
  //             // Preferences().setPhone("");
  //             // Preferences().setimage("");
  //             // Preferences().setusertype("");
  //             // Preferences().setusercity("");
  //             // Preferences().setfcmID("");
  //             // showAlertDialog(_context);
  //           },
  //         ),
  //         Divider(
  //           indent: 40.0,
  //           endIndent: 40.0,
  //           height: 2.0,
  //           color: desgin_button1_start,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Future dispose() {
    super.dispose();
  }


}












        