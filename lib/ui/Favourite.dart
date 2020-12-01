import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/FavouriteApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/ui/testTable.dart';
import 'About_us.dart';
import 'Contact_us.dart';
import 'Membership.dart';
import 'MyServices.dart';
import 'My_Service_01_Details.dart';
import 'My_Service_05_Details.dart';
import 'My_Service_07_Details.dart';
import 'Update_useraccount.dart';

import 'package:waqarapp/utilis/json_table_column.dart';
import 'package:waqarapp/utilis/json_table.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => new _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  bool toggle = true;
  String user_id="";
  bool first=true;
List<ServiceDataVM> servicesData;
  List<ServiceDataVM> selectedUsers;
bool apiCall = true ;
  UserVM user;
  bool sort;
  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    getUser().then((user){
      this.user = user ;
      setState(() {
              this.user = user ;
      });
      print(user.Id);
              FavouriteApi.AllFavourites(user.Id).then((ss){
                if(ss.code !=200){
                  //  Navigator.pop(context);
                  }else {
                    setState(() {
                      print("response.data.ValueAr");
                    this.servicesData = ss.data;
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
              
              //////////////
      
    });
    
    //servicesData = ServiceDataVM.getServicesData();
    super.initState();
  }
 
  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        servicesData.sort((a, b) => a.Id.compareTo(b.Id));
      } else {
        servicesData.sort((a, b) => b.ServiceName.compareTo(a.ServiceName));
      }
    }
  }
 
  onSelectedRow(bool selected, ServiceDataVM sD) async {
    setState(() {
      if (selected) {
        selectedUsers.add(sD);
      } else {
        selectedUsers.remove(sD);
      }
    });
  }
 
  deleteSelected() async {
    showAppLoading(_context);
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<ServiceDataVM> temp = [];
        temp.addAll(selectedUsers);
        for (ServiceDataVM user in temp) {
          ServiceDataApi.changeStatus(user).then((response) {
            print(response.code.toString());
              if (response.code ==200 ) {
                
                //_displayDialog(_context , response.data.Id);
              } else {
                print("${response.message}");
               hideAppDialog(_context);
              }
              setState(() {
              });
            }, onError: (error) {
              hideAppDialog(_context);
              print("login Error : : :$error");
              setState(() {
              });
            });
          //servicesData.remove(user);
          //selectedUsers.remove(user);
        }
      }
      hideAppDialog(_context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Favourite()));
    });
  }
  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
       scrollDirection: Axis.horizontal, 
       child: SingleChildScrollView( 
         scrollDirection: Axis.vertical, 
         child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("رقم العرض"),
              numeric: false,
              tooltip: "رقم العرض",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              }),
          DataColumn(
            label: Text("تفاصيل العرض"),
            numeric: false,
            tooltip: "تفاصيل العرض",
          ),
          DataColumn(
            label: Text(" التاريخ"),
            numeric: false,
            tooltip: " التاريخ",
          ),
        ],
        rows: servicesData
            .map(
              (user) => DataRow(
                      // selected: selectedUsers.contains(user),
                      // onSelectChanged: (b) {
                      //   print("Onselect");
                      //   onSelectedRow(b, user);
                      // },
                      cells: [
                        DataCell(
                          user.IsCancelled==true?Text(user.Id.toString(), style:AqarFont.getLighttableRed()):Text(user.Id.toString() , style: AqarFont.getLighttableBlue(),),
                        ),
                        DataCell(
                          user.IsCancelled==true? Text(user.ServiceName , style:AqarFont.getLighttableRed()):Text(user.ServiceName , style: AqarFont.getLighttableBlue(),),
                          onTap: () {
                            if(user.ServiceId==1 ||user.ServiceId==2 ||user.ServiceId==3||user.ServiceId==5||user.ServiceId==7 ){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_01_Details(user)));
                            }else if(user.ServiceId ==4){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_05_Details(user)));
                            }else if(user.ServiceId ==6){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_07_Details(user)));
                            }
                            
                            print('Selected ${user.ServiceName}');
                          },
                        ),
                        DataCell(
                           user.IsCancelled==true? Text(user.creationDateTxt.toString(), style:AqarFont.getLighttableRed()):Text(user.creationDateTxt.toString() , style: AqarFont.getLighttableBlue(),),
                        ),
                      ]),
            ).toList(),
      ),),
         );

   
  }
 

  restore() async {
    final SharedPreferences Prefs= await SharedPreferences.getInstance();
    setState(() {
      user_id=Prefs.getString('userID') ?? "";
    });
  }


  Submit() {
   
//    showAppLoading(_context);
//    try {
//        _bloc.getorder(user_id);
//    } catch (error) {
//      hideAppDialog(_context);
//      showSnack(error.toString());
//    };
  }



  @override
  void dispose() {
//    _bloc.Favouriteubject.close();
//    _bloc.dispose();
    super.dispose();
  }

  void showSnack(String msg, {Duration duration}) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        msg,
        style: AqarFont.getRegularFont(),
      ),
      duration: duration == null ? Duration(seconds: 5) : duration,
    ));
  }


DeleteAlert(ServiceDataVM model){
  
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog( 
        title: Text('تنبيه حذف'),
        content: const Text('هل تريد التاأكيد علي الحذف' , textDirection: TextDirection.rtl,),
        actions: <Widget>[
          FlatButton(
            child: Text('تأكيد'),
            onPressed: () {
              ServiceDataApi.Delete(model.Id).then((ss){
                if(ss.code !=200){
                  //  Navigator.pop(context);
                  }else {
                    setState(() {
                      servicesData.remove(model);
                    });
                    Navigator.of(context).pop();
                  }

                },onError: (error){
                  setState(() {
                    print("Error response.data.ValueAr");
                  });
                  print("getting moreDetails error : : : $error");
                });
              
            },
          ),
        ],
      ),
        );
      
    },
  );
  
}

  @override
  Widget build(BuildContext context) {

   // var json = jsonDecode(jsonSample);

    // TODO: implement getBody
    var screenSize = MediaQuery.of(context).size;

     var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = width / 3;

     
     
    _context = context;
    return Container(
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
            "المفضله",
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


          body:this.apiCall ? Center(child: CircularProgressIndicator(),):Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      appButtonbsmall('', () => {},
                          bgColor: desgin_button_red,
                          bgColor2: desgin_button_red),
                      Text(
                        "العروض الملغاه او المنتهيه ",
                        textAlign: TextAlign.center,
                        style: AqarFont.getLightFont_TextFormsmall(),
                      ),
                      

                    Container(
                      width: 5,
                    ),
                    appButtonbsmall('', () => {},
                          bgColor: desgin_button4_end,
                          bgColor2: desgin_button4_end),
                      Text(
                        "العروض المرسله",
                        textAlign: TextAlign.center,
                        style: AqarFont.getLightFont_TextFormsmall(),
                      ),
                      

                    ]
                ),

                // Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       Text(
                //         "الطلبات الملغاه او المنتهيه ",
                //         textAlign: TextAlign.center,
                //         style: AqarFont.getLightFont_TextFormsmall(),
                //       ),
                //       appButtonbsmall('', () => {},
                //           bgColor: desgin_button_red_back,
                //           bgColor2: desgin_button_red_back),
                //       Text(
                //         "الطلبات المستلمه",
                //         textAlign: TextAlign.center,
                //         style: AqarFont.getLightFont_TextFormsmall(),
                //       ),
                //       appButtonbsmall('', () => {},
                //           bgColor: desgin_button4_start,
                //           bgColor2: desgin_button4_start),

                //     ]
                // ),

               Expanded(
                 
            child: new Container(
              color: Colors.white,
              child: ListView(
                              children: servicesData.map((product) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return  Container(
      child: new Card(
          elevation: 3.0,
          margin: EdgeInsets.all(10.0),
          child: new Container(
            child:InkWell(
                          onTap: (){
                            if(product.ServiceId==1 ||product.ServiceId==2 ||product.ServiceId==3||
                            product.ServiceId==5||product.ServiceId==7 ){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_01_Details(product)));
                            }else if(product.ServiceId ==4){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_05_Details(product)));
                            }else if(product.ServiceId ==6){
                              Navigator.of(context)
                                 .push(MaterialPageRoute(builder: (context) => My_Service_07_Details(product)));
                            }
                            
                            print('Selected ${product.ServiceName}');
                          },
                          child:  new Row(
              children: <Widget>[
                new Container(
                  width: 150,
                  height: height,
                  child: Image.network(
                    product.mainImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: <Widget>[

                    // product.IsCancelled==true? Text(product.creationDateTxt.toString(), style:AqarFont.getLighttableRed()):Text(product.creationDateTxt.toString() , style: AqarFont.getLighttableBlue(),),
                    SizedBox(
                       width: width-200,
                      child:  product.IsCancelled==true? Text("  "+product.ServiceName , style:AqarFont.getLighttableRed()):Text("  "+product.ServiceName , style: AqarFont.getLighttableBlue(),),//new Text(' و 2 حمام و 3 غرفه نوم ', textAlign: TextAlign.right,),
                    ),
                    SizedBox(
                       width: width-200,
                      child:product.IsCancelled==true?Text("  رقم الطلب "+product.Id.toString(), style:AqarFont.getLighttableRed()):Text("  رقم الطلب "+product.Id.toString() , style: AqarFont.getLighttableBlue(),),// new Text('رقم الطلب  ' , textAlign: TextAlign.right),
                    ),
                    SizedBox(
                       width: width-200,
                      child: product.IsCancelled==true? Text("  سعر العقار "+product.BuildingPrice.toString() +" ريال " , style:AqarFont.getLighttableRed()):Text("  سعر العقار "+product.BuildingPrice.toString()+" ريال " , style: AqarFont.getLighttableBlue(),),//new Text('6000 ريال', textAlign: TextAlign.right,),
                    ),
                    // SizedBox(
                    //    width: width-200,
                    //   child: new Text('القاهره مدينه نصر اول عباس', textAlign: TextAlign.right,),
                    // ),
              
                
               
                
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                  ],
                )
              ],
            ),
                        ),
          
            
            // new Column(
            //   children: <Widget>[
            //     new Container(
            //       width: width,
            //       height: height,
            //       child: Image.network(
            //         "http://worthly.com/wp-content/uploads/2014/07/1332176822_0.jpg",
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     new Padding(padding: new EdgeInsets.only(top: 10.0)),
            //     new Text('اسم العقار'),
            //     new Padding(padding: new EdgeInsets.only(top: 10.0)),
            //   ],
            // ),
          )
      ),
    );
                                  },
                                );
                              }).toList(),
                            ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Padding(
          //       padding: EdgeInsets.all(20.0),
          //       child: OutlineButton(
          //         child: Text('تم اختيار ${selectedUsers.length}'),
          //         onPressed: () {},
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.all(20.0),
          //       child: OutlineButton(
          //         child: Text('تغيير الحاله '),
          //         onPressed: selectedUsers.isEmpty
          //             ? null
          //             : () {
          //                 deleteSelected();
          //               },
          //       ),
          //     ),
          //   ],
          // ),
                // Container(
                //   child: Text(
                //     "حقوق البرنامج محفوظه لدي مؤسسه",
                //     textAlign: TextAlign.center,
                //     style: AqarFont.getBoldFont(),
                //   ),
                // ),
                // Container(
                //   child: Text(
                //     "دليل التطبيقات للاتصالات و تقنيه المعلومات",
                //     textAlign: TextAlign.justify,
                //     style: AqarFont.getsmallFont(),
                //   ),
                // ),
                Container(
                  height: 5,
                ),
              ]),
          ),
          
          
        

        endDrawer: buildDrawer()

        ),
      );


  }


}
