import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:waqarapp/API/ContentApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/model/ContentVM.dart';
import 'package:waqarapp/resources/fonts.dart';


class Terms extends StatefulWidget{
  Terms():super();

  @override
  _TermsState createState()=>_TermsState();
}




class _TermsState extends State<Terms> {
BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name="";
  String email="";
  String imageprofile="";
bool apiCall = true ;

  @override
  void initState() {
    super.initState();
    //post=getAboutApp();
    ContentApi.getTerms().then((response){
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
  }

ContentVM content = new ContentVM();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    " الشروط والاحكام",
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
        child:ListView(
        children: <Widget>[
         
            new Image.asset(
              "images/logo_head.png",
              height: 150.0,
              width: 150.0,
            ),
            new SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: this.apiCall ? Center(child: CircularProgressIndicator(),):Text(content.valueAr.toString() , 
              //child: Text('الشروط والاحكام ................' , 
            style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    //fontStyle: FontStyle.italic,
                    // padding: EdgeInsets.all(24.0),
                    color: Colors.black)),
            ),
            
          ],
      ) ,
      ),
       
      endDrawer: buildDrawer()
    );
  }
}

