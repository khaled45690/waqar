import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';

import 'About_us.dart';
import 'Contact_us.dart';
import 'HomeScreen.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'OfficeProfile.dart';
import 'OrdersOffers.dart';
import 'Payment.dart';
import 'Update_useraccount.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/resources/fonts.dart';
class Special_users extends StatefulWidget {
  @override
  _Special_usersState createState() => new _Special_usersState();
}

class _Special_usersState extends State<Special_users> {

  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UnboundedScrollController _negativeController = new UnboundedScrollController();


  // List<UserVM> userItems=[
  //                   new UserVM(Address: 'tt',FullName: 'os',Rating: 5 ,UserImage: 'https://tse2.mm.bing.net/th?id=OIP.m7szK5omsnR5gvSq3vK66wHaE8&pid=Api&P=0&w=239&h=160'),
  //                   new UserVM(Address: 'tt',FullName: 'osama 2',Rating: 5 ,UserImage: 'https://tse2.mm.bing.net/th?id=OIP.m7szK5omsnR5gvSq3vK66wHaE8&pid=Api&P=0&w=239&h=160'),
                  
  //                 ];
  bool apiCall = true ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    var screenSize = MediaQuery.of(context).size;
    _context = context;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
    "عملاء مميزون",
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

    body:Container(
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
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
          appButtonbgimage(' عملاء مميزون', () => {},
                        bgColor: desgin_button2_start,
                          bgColor2: desgin_button2_end),
                
          this.apiCall ? Center(child: CircularProgressIndicator(),):new Expanded(child: new ListView(
                  padding: new EdgeInsets.symmetric(vertical: 8.0),
                  children: userItems.map((UserVM socialItem) {
                    return new ShoppingItemList(socialItem);
                  }).toList(),
                )),
        ])),
    
    //  Padding(
    //             padding: EdgeInsets.all(0),
              
    //             child: Column(
    //               textDirection: TextDirection.rtl,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: <Widget>[
    //                 Container(
    //                     margin: EdgeInsets.only(
    //                         right: 35, left: 35, bottom: 0, top: 20),
    //                     child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisSize: MainAxisSize.max,
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: <Widget>[
    //                           appButtonbgimage(' عملاء مميزون', () => {},
    //                               bgColor: desgin_button2_start,
    //                                 bgColor2: desgin_button2_end),
    //                         ])),
    //                 new Expanded(child: new ListView(
    //                         padding: new EdgeInsets.symmetric(vertical: 8.0),
    //                         children: userItems.map((UserVM socialItem) {
    //                           return new ShoppingItemList(socialItem);
    //                         }).toList(),
    //                       )),
    //                 Container(
    //                   alignment: Alignment.bottomCenter,
    //                   child: Text(
    //                     "حقوق البرنامج محفوظه لدي مؤسسه",
    //                     textAlign: TextAlign.center,
    //                     style: AqarFont.getBoldFont(),
    //                   ),
    //                 ),
    //                 Container(
    //                   child: Text(
    //                     "دليل التطبيقات للاتصالات و تقنيه المعلومات",
    //                     textAlign: TextAlign.justify,
    //                     style: AqarFont.getBoldFont(),
    //                   ),
    //                 ),
    //                 Container(
    //                   height: 20,
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //               ],
    //             ),
           
                  
          
    //           ),

          endDrawer: buildDrawer()
        ),
    );
  }


List<UserVM> userItems;
@override
void initState() {
  super.initState();
  AuthApi.listActivatedUsers().then((response){
      if(response.code !=200){
        Navigator.pop(context);
      }else {
        setState(() {
         this.userItems = response.data;
         setState(() {
          this.apiCall = false ;
        });
          //this.apiCall = false;
        });
      }

    },onError: (error){
      setState(() {
         //this.content = response.data;
        //this.apiCall = false ;
      });
      print("getting moreDetails error : : : $error");
    });
}

@override
void dispose() {
  super.dispose();
}
}





class ShoppingItemList extends StatefulWidget{
  final UserVM socialItem;
  ShoppingItemList(UserVM socialItem)
      : socialItem = socialItem,
        super(key: new ObjectKey(socialItem));
  @override
  ShoppingItemState createState() {
    return new ShoppingItemState(socialItem);
  }
}
class ShoppingItemState extends State<ShoppingItemList> {
  final UserVM socialItem;
  ShoppingItemState(this.socialItem);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
       onTap: (){
                            Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) => OfficeProfile(socialItem.Id)));
                          },
        
        leading: null,

        title: Container(
        
                    child: Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                // Container(
                //   decoration: new BoxDecoration(color: Colors.red),
                // //  child: new Center(
                //     child: new Text("  "+socialItem.FullName , textDirection: TextDirection.rtl)
                  
                // ),
                new Expanded(
                  flex: 3,
                  child:Container(
                   // height: 724,
                   // width: (MediaQuery.of(context).size.width/2)+50,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: grey_ligth,
                    ),
                    child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) => OfficeProfile(socialItem.Id)));
                          },
                          child:  Container(
                            alignment: Alignment.topRight,
                            child: Text(socialItem.FullName , textDirection: TextDirection.rtl,style: TextStyle(fontSize: 15),),
                          ),
                          
                        ),
                    ),
                //  child: new Text("  "+socialItem.FullName , textDirection: TextDirection.rtl,style: TextStyle(backgroundColor: Colors.blue),)
                  
                  ),
                Expanded(
                  flex: 1,
                  child: Container(
                    //height: 30,
                    //width: 30,
                    child: CircleAvatar(
                    backgroundImage: NetworkImage(socialItem.UserImage,),
                    maxRadius: 30,
                //     child: new ClipRRect(
                //     //borderRadius: new BorderRadius.circular(60.0),
                //     child:socialItem.UserImage==null?Image.asset("asset15.png", height: 60,width: 50,):
                //      Image.network(socialItem.UserImage, height: 60,width: 50, fit:BoxFit.cover,)
                //     //new Image(image: new NetworkImage(socialItem.UserImage) , height: 60,width: 50,),
                // )
                  ),
                  )
                  
                )
                
                // new Checkbox(value: socialItem.isCheck, onChanged: (bool value) {
                //   setState(() {
                //     socialItem.isCheck = value;
                    
                //   });
                // })
              ],
            ),
            Container(
              height: 10,
            )
          ],
        )
        )
        
        
    );
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