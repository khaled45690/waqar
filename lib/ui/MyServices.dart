
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/ui/My_services_09.dart';
import 'About_us.dart';
import 'Contact_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'My_services_01.dart';
import 'My_services_02.dart';
import 'My_services_03.dart';
import 'My_services_05.dart';
import 'My_services_06.dart';
import 'My_services_07.dart';
import 'My_services_08.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Update_useraccount.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MyServices extends StatefulWidget {
  @override
  _MyServicesState createState() => new _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;
    return WillPopScope(
        onWillPop: ()async{
          print("back button presed");
          Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          //Categories.changeNotifierCategoriesBackPressed.sink.add("back hah ");
          //return false ;
        },
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.png"), fit: BoxFit.cover)),
        child:  Scaffold(
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
              "الخدمات",
              style: AqarFont.baseFontStyle(),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            elevation: 0.0,
            leading: new IconButton(
                icon: new Image.asset("images/actionback.png"),
                iconSize: 30.0,
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                onPressed: () =>Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()))),// Navigator.of(context).pop()),
            actions: <Widget>[
              IconButton(
                icon:
                new IconButton(icon: new Image.asset("images/asset17.png")),
                iconSize: 40.0,
                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              ),
            ],
          ),
          body: Padding(
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            main_container(),
                          ]),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(0,100, 0, 0),
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
                  ],
                ),
              )),
          endDrawer:buildDrawer()
        ),
      
        
      ),
    ),
        );
        
  }
UserVM user ;
  @override
  void initState() {
    restore();
    super.initState();
    getUser().then((user){
      setState(() {
        this.user = user ;
        //print("From Services : "+user.Email.toString());
        if(user!=null){
        }
      });
    });
  }

  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      name = Prefs.getString('username') ?? "";
      email = Prefs.getString('email') ?? "";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

youMustLogin(){
    showInSnackBar("من فضلك قم بتسجيل الدخول اولا ", context, _scaffoldKey);
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
            accountName: new Text(
              name,
              style: AqarFont.baseFontStyle(),
            ),
            accountEmail: new Text(
              email,
              style: AqarFont.baseFontStyle(),
            ),
            currentAccountPicture: Image.asset('images/asset15.png'),
            decoration: new BoxDecoration(
              color: gray,
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
            title: Text(
              'الرئيسيه',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
              'تعديل بياناتي',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Update_useraccount()));
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
              'خدماتي',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyServices()));
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
              'الدفع',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Payment()));
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
              'الطلبات والعروض',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrdersOffers()));
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
              'تواصل معنا',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
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
              'عن الشركه',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
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
              'الخروج',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              showAlertDialog(_context);
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

  drawer_home_waseet() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: new Text(
              name,
              style: AqarFont.baseFontStyle(),
            ),
            accountEmail: new Text(
              email,
              style: AqarFont.baseFontStyle(),
            ),
            currentAccountPicture: Image.asset('images/asset15.png'),
            decoration: new BoxDecoration(
              color: gray,
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
            title: Text(
              'الرئيسيه',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
              'تعديل بياناتي',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Update_useraccount()));
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
              'خدماتي',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyServices()));
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
              'العضويه',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Membership(user.Id)));
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
              'الدفع',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Payment()));
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
              'تواصل معنا',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
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
              'عن الشركه',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
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
              'الخروج',
              style: AqarFont.baseRegularcolorFont(),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              showAlertDialog(_context);
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

  main_container() {
    return Container(
        margin: EdgeInsets.only(right: 40, left: 40, bottom: 10, top: 50),
        width: MediaQuery.of(context).size.width,
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
            children: [
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 30),
                child: Text(
                  "اطلب خدمتك الان",
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField2(),
                ),
              ),
              Container(
                height: 20,
              ),

              appButtonbgimage(
                  'عرض عقار',
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin(): Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_01())),
                //      () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_01())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),

              appButtonbgimage(
                  'طلب عقار',
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin():  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_02())),
                  //    () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_02())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),
              appButtonbgimage(
                  'تقبيل موقع',
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin():  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_03())),
                     // () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_03())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),
              appButtonbgimage(
                  'تثمين عقاري',
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin():  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_05())),
                //      () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_05())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),
              appButtonbgimage(
                  'إداره املاك',
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin():  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_06())),
                   //   () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_06())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),
              appButtonbgimage(
                  'طلب عقد ايجار موحد',
                     // () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_07())),
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin():  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_07())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),
              appButtonbgimage(
                  'تصميم او تصوير عقار',
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin():  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_08())),
                   //   () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_08())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),
              appButtonbgimage(
                  ' طلب صيانه عقار',
                      () =>user.Email.toString()==""||user.Email.toString()==null||user.Email==null?youMustLogin():  Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_09())),
                  bgColor: desgin_button1_start,
                  bgColor2: desgin_button1_end),
              Container(
                height: 10,
              ),
              
        ]));
  }
}
