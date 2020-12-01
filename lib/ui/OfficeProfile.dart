import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';

import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/helpers/flutter_rating_bar.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/model/membershipVM.dart';
import 'package:waqarapp/ui/Contact_us.dart';
import 'package:waqarapp/ui/HomeScreen.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ConfirmationCode.dart';

class OfficeProfile extends StatefulWidget {
  String userId;
  OfficeProfile(this.userId);
  @override
  _OfficeProfileState createState() => new _OfficeProfileState();
}

class _OfficeProfileState extends State<OfficeProfile> {

  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name="";
  String email="";

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
    "معلومات المكتب",
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
      child:Container(
        margin: EdgeInsets.only(right: 40, left: 40, bottom: 10, top: 30),
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
          child: this.apiCall ? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 30),
            child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
               appButtonbgimageV2(this.content.Name, () => {},
                        bgColor: desgin_button4_start,
                          bgColor2: desgin_button4_start),
                
              // Text("رقم العضويه", textAlign: TextAlign.center,style: AqarFont.getLightFont_TextFormFieldtextheader(),),
              // Text(content.Id.toString(), textAlign: TextAlign.center,style: AqarFont.getLightFont_TextFormFieldtextheader(),),
              Container(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                   // height: 724,
                    width: MediaQuery.of(context).size.width/3,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: grey_ligth,
                    ),
                    child: Text('المكتب', textAlign: TextAlign.center,),
                    ),
                    Container(
                    width: ((MediaQuery.of(context).size.width)/3),
                    child:Text(this.content.Name, textAlign: TextAlign.center,)
                    ),
                    
                ],
              ),
              Container(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                   // height: 724,
                    width: MediaQuery.of(context).size.width/3,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: grey_ligth,
                    ),
                    child: Text('المدينه', textAlign: TextAlign.center,),
                    ),
                    Container(
                    width: ((MediaQuery.of(context).size.width)/3),
                    child:Text(this.content.City, textAlign: TextAlign.center,)
                    ),
                    
                ],
              ),
              Container(
                height: 10,
              ),

              Row(
                children: <Widget>[
                  Container(
                   // height: 724,
                    width: MediaQuery.of(context).size.width/3,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: grey_ligth,
                    ),
                    child: Text('الايميل', textAlign: TextAlign.center,),
                    ),
                    Container(
                    width: ((MediaQuery.of(context).size.width)/3),
                    child:Text(this.content.Email, textAlign: TextAlign.center,)
                    ),
                    
                ],
              ),
              Container(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                   // height: 724,
                    width: MediaQuery.of(context).size.width/3,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: grey_ligth,
                    ),
                    child: Text('رقم التواصل', textAlign: TextAlign.center,),
                    ),
                    Container(
                    width: ((MediaQuery.of(context).size.width)/3),
                    child:InkWell(
                          onTap: () async {
                            try{
                              //  mobileNum="552358049";
                               String s= "https://wa.me/966"+this.content.Phone+"?text=Hello";
                                await launch(s);//https://wa.me/${}?text=Hello
                             }catch(Ex){
                                new CallService().call(this.content.Phone);
                             }
                          },
                          child: Text(this.content.Phone, textAlign: TextAlign.center,),
                        ),
                    
                    
                    ),
                    
                ],
              ),
              
              
              Container(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                   // height: 724,
                    width: MediaQuery.of(context).size.width/3,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: grey_ligth,
                    ),
                    child: Text('اسم المدير', textAlign: TextAlign.center,),
                    ),
                    Container(
                    width: ((MediaQuery.of(context).size.width)/3),
                    child:Text(this.content.ManagerName, textAlign: TextAlign.center,)
                    ),
                    
                ],
              ),
              Container(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                   // height: 724,
                    width: MediaQuery.of(context).size.width/3,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: grey_ligth,
                    ),
                    child: Text('العنوان', textAlign: TextAlign.center,),
                    ),
                    Container(
                    width: ((MediaQuery.of(context).size.width)/3),
                    child:Text(this.content.Address, textAlign: TextAlign.center,)
                    ),
                    
                ],
              ),
              Container(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                   // height: 724,
                    width: (MediaQuery.of(context).size.width/3),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color:grey_ligth,//Color.fromRGBO(255, 0, 0, 0.5)
                    ),
                    child: Text('تقييم خدماتكم', textAlign: TextAlign.center,),
                    ),
                    this.content.Email != this.user.Email? Container(
                    width: ((MediaQuery.of(context).size.width)/3),
                    child:FlutterRatingBar(
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  initialRating: this.content.Rating,
                                  allowHalfRating: true,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  onRatingUpdate: (rating) {
                                    addRating(rating);
                                    print(rating);
                                  },
                                ),
                    //new Image(image: new AssetImage('images/fiveStars.PNG') , height: 40,width: 60,)
                    ):Container(
                      child: this.content.Rating>=5?
                      new Image(image: new AssetImage('images/fiveStars.PNG') , height: 40,width: 60,)
                      :(this.content.Rating>=4?
                          new Image(image: new AssetImage('images/fourStars.PNG') , height: 40,width: 50,)
                        :(this.content.Rating>=3?
                            new Image(image: new AssetImage('images/threeStars.PNG') , height: 40,width: 40,)
                            :((this.content.Rating>=2?
                              new Image(image: new AssetImage('images/twoStars.PNG') , height: 40,width: 30,)
                                :(this.content.Rating>=1?
                                  new Image(image: new AssetImage('images/oneStars.PNG') , height: 40,width: 20,)
                                  :new Image(image: new AssetImage('images/oneStars.PNG') , height: 40,width: 10,)))))),
                    ),
                    
                ],
              ),
              Container(
                height: 10,
              ),
              appButtonbgimage(
                  'ارسال ملاحظه للمكتب',
                      () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact_us())),
                //      () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => My_services_01())),
                  bgColor: Colors.red,
                  bgColor2: Colors.yellow),
            ],
          ),
          ),
          ),
          
          
          // Container(
          //   height: 724,
          //             width: 724,
          //           padding: EdgeInsets.all(8.0),
          //           decoration: BoxDecoration(
          //             color: Color.fromRGBO(255, 0, 0, 0.5)
          //           ),
          //           child: Text('data'),
          //           ),
        ) ,
      ),
    endDrawer: buildDrawer()
        );
    
  }


bool apiCall = true ;
membershipVM content = new membershipVM();

  @override
  void initState() {
    restore();
    getUser().then((user){
      setState(() {
              this.user = user ;
              AuthApi.myMembership(widget.userId).then((response){
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
      });
    });
    super.initState();
    
    
  }
  UserVM user ;

  restore() async {
    final SharedPreferences Prefs= await SharedPreferences.getInstance();
    setState(() {
      name=Prefs.getString('username') ?? "";
      email= Prefs.getString('email') ?? "";
    });
  }

addRating(double value){
  AuthApi.AddRating(user.Id , widget.userId , value).then((response){
              if(response.code !=200){
                Navigator.pop(context);
              }else {
                setState(() {
                  print("response.data.ValueAr");
                //this.content = response.data;
                // setState(() {
                //   this.apiCall = false ;
                // });
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
@override
void dispose() {
  super.dispose();
}
}


