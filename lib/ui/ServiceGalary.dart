import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waqarapp/API/ContentApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/model/ContentVM.dart';
import 'package:waqarapp/model/ImagesVM.dart';

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

class ServiceGalary extends StatefulWidget {
  int serviceId;
  ServiceGalary(this.serviceId);
  @override
  _ServiceGalaryState createState() => new _ServiceGalaryState();
}

class _ServiceGalaryState extends State<ServiceGalary> {

  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UnboundedScrollController _negativeController = new UnboundedScrollController();
  String name="";
  String email="";
@override
  void initState() {
    print("Start About App");
    super.initState();
    //post=getAboutApp();
    ServiceDataApi.GetAllServiceDataImages(widget.serviceId).then((response){
      if(response.code !=200){
        //Navigator.pop(context);
      }else {
        setState(() {
          print("response.data.ValueAr");
         this.images = response.data;
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
  }
  bool apiCall = true ;
ContentVM content = new ContentVM();
List<ImagesVM> images = new List<ImagesVM>();

_displayDialog(BuildContext context , String path) async {
    int _currentIndex = 1;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text("يتطلب تصريح تثمين ",
            //       textAlign: TextAlign.center,
            //       style: AqarFont.getLightFont_TextFormField()),
            content: Image.network(path,
                  fit: BoxFit.fill)
           // actions: <Widget>[
            // FlatButton(
            //   child: Text("تأكيد",
            //       textAlign: TextAlign.left,
            //       style: AqarFont.getLightFont_TextFormField()),
            //   onPressed: () {
            //     licenceValue=licenseNumberKey.currentState.value;
            //     Navigator.of(context).pop();
            //   //  Submit();
            //   },
            // ),
          //  ],
          );
        });
  }

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
    "صور الاعلان",
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

    body: this.apiCall ? Center(child: CircularProgressIndicator(),):GridView.builder(
    itemBuilder: (context, position) {
      return Card(
        
        clipBehavior: Clip.antiAlias,
       // elevation: ,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 20.0 / 20,
                child: InkWell(
                  onTap: () {
                    print('object');
                    _displayDialog(_context ,images[position].resourceName );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(images[position].resourceName,
                          fit: BoxFit.fill),
                    ),),
                ),
                
                //Image.network(images[position].resourceName , fit: BoxFit.fill),
              ),
              
            ],
          ),
        );
    },
    itemCount: images.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),    
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
}

