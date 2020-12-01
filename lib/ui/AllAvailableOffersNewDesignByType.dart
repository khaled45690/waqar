import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/RegionApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/model/Region.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';

import 'My_Service_01_Details.dart';
import 'My_Service_02_Details.dart';
import 'My_Service_05_Details.dart';
import 'My_Service_07_Details.dart';
import 'My_Service_08_Details.dart';


class AllAvailableOffersNewDesignByType extends StatefulWidget {
  int type;
  AllAvailableOffersNewDesignByType(this.type);
  @override
  _AllAvailableOffersNewDesignByTypeState createState() => new _AllAvailableOffersNewDesignByTypeState();
}

class _AllAvailableOffersNewDesignByTypeState extends State<AllAvailableOffersNewDesignByType> {

  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //UnboundedScrollController _negativeController = new UnboundedScrollController();

    Widget _appBarTitle =  new Text( 'ابحث عن العقار' );
  Icon _searchIcon = new Icon(Icons.search);



  String name="";
  String email="";

  bool toggle = true;
  String user_id="";
  bool first=true;
List<ServiceDataVM> servicesData = List<ServiceDataVM>();
   List<ServiceDataVM> names = new List<ServiceDataVM>();
  final TextEditingController _filter = new TextEditingController();



  List<ServiceDataVM> selectedUsers;
bool apiCall = true ;
  UserVM user;
  bool sort;

  // void _searchPressed() {
  //   setState(() {
  //     if (this._searchIcon.icon == Icons.search) {
  //       print("Search");
  //       this._searchIcon = new Icon(Icons.close);
  //               print("Search 1");
  //       this._appBarTitle = new TextField(
  //         style: TextStyle(color: Colors.white),
  //         controller: _filter,
  //         decoration: new InputDecoration(
  //           prefixIcon: new Icon(Icons.search),
  //           hintText: "ابحث عن العقار",
  //           fillColor: Colors.white
  //         ),
  //         onChanged: (ff){
  //           print(ff);
  //           search(ff);
  //           ///SearchClient(ff);
  //         },
  //       );
  //               print("Search 2");

  //     } else {
  //       ServiceDataApi.AllAvailableOffers_ByType(user.Id , widget.type).then((ss){
  //               if(ss.code !=200){
  //                 //  Navigator.pop(context);
  //                 }else {
  //                   setState(() {
  //                     print("response.data.ValueAr");
  //                   this.servicesData = ss.data;
  //                   setState(() {
  //                     this.apiCall = false ;
  //                   });
  //                     //this.apiCall = false;
  //                   });
  //                 }

  //               },onError: (error){
  //                 setState(() {
  //                   print("Error response.data.ValueAr");
  //                   //this.content = response.data;
  //                   //this.apiCall = false ;
  //                 });
  //                 print("getting moreDetails error : : : $error");
  //                 //this.apiCall = false ;
  //               });
  //       print("Text");
  //       this._searchIcon = new Icon(Icons.search);
  //       this._appBarTitle = new Text( "ابحث" );
  //       servicesData = names;
  //       _filter.clear();
  //     }
  //   });

  //   print("Osammmmmmmmmmmmma");
  // }

search(){
  String searchTxt='';
  searchTxt = _filter.value.text;
  print(searchTxt);
  ServiceDataApi.Search(searchTxt , _selectedDistrictId , _selectedGovernmentId , _selectedCountryId , widget.type).then((response) {
        if (response.code ==200 ) {
            print("Response Code is 200");
            setState(() {
              //selectedUsers.clear();
              this.servicesData= response.data;
            });
          } else {
            print("${response.message}");
          }
      }, onError: (error) {
        print("login Error : : :$error");
        
      });
}
  List _countries = [];
List _government = [];
List _district = [];
List<Region>ReturnedResult = new List<Region>();
Region regionsVM = new Region();
 Governments governmentVM = new Governments();
 Districts districtVM = new  Districts();

List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List _countries) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in _countries) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }
  String _selectedCountry;
  int _selectedCountryId;

  String _selectedGovernment;
  int _selectedGovernmentId;

String _selectedDistrict;
  int _selectedDistrictId;

List<DropdownMenuItem<String>> _dropDownMenuCountries;
List<DropdownMenuItem<String>> _dropDownMenuGovernment;
List<DropdownMenuItem<String>> _dropDownMenuDistrict;
  List<DropdownMenuItem<String>> _dropDownMenuCategory;
  List<DropdownMenuItem<String>> _dropDownMenuClothStyle;
  void changedDropDownCountry(String selectedCntry) {
    setState(() {
      _selectedCountry = selectedCntry;

      _selectedCountryId = 0;
      _selectedDistrictId = 0;
      _selectedGovernmentId = 0;
    });
  ReturnedResult.forEach((s){
    if(selectedCntry == s.regionName){
      setState(() {
        _selectedCountryId=s.regionId;
        print("Selected Id = $_selectedCountryId" );
        regionsVM = s;
        print("regionsVM : ");
        print(regionsVM);
        
        if(s.governments!=null && s.governments.length>0){
          
          
          setState(() {
            governmentVM = s.governments.first;
            print("governmentVM : ");
            print(governmentVM);
            _selectedGovernment =governmentVM.governmentName;
          _selectedGovernmentId = governmentVM.governmentId;
          });
          if(governmentVM.districts!=null && governmentVM.districts.length>0){
            
            setState(() {
              districtVM = governmentVM.districts.first;
              _selectedDistrict =districtVM.districtName;
            _selectedDistrictId = districtVM.districtId;
            print("districtVM : ");
              print(districtVM);
            });
           
          }else{
            setState(() {
              districtVM=new Districts();
              _selectedDistrictId=0;
            });
          }
        }else{
          setState(() {
            governmentVM=new Governments();
            _selectedGovernmentId = 0;
          });
        }
      });

      setState(() {
        _government.clear();
        _dropDownMenuGovernment = buildAndGetDropDownMenuItems(_government);
            //  _selectedGovernment = _dropDownMenuGovernment[0].value;
      });
      if(s.governments!=null&& s.governments.length>0){
        s.governments.forEach((pp){
            setState(() {
              _government.add(pp.governmentName);
            });

        });
        setState(() {
          _dropDownMenuGovernment = buildAndGetDropDownMenuItems(_government);
              _selectedGovernment = _dropDownMenuGovernment[0].value;
             // _selectedGovernmentId=governmentVM.governmentId;
        });

      }else{
          setState(() {
            governmentVM=new Governments();
          });
        }
      
        ///////////////
        ///////////////
        setState(() {
        _district.clear();
        _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
             // _selectedDistrict = _dropDownMenuDistrict[0].value;
      });
      if(governmentVM.districts!=null && governmentVM.districts.length>0){
        governmentVM.districts.forEach((pp){
            setState(() {
              _district.add(pp.districtName);
            });
      });
      setState(() {
          _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
              _selectedDistrict = _dropDownMenuDistrict[0].value;
              _selectedDistrictId=districtVM.districtId;
        });

      }else{
          setState(() {
            districtVM=new Districts();
          });
        }
      
        /////
        
    }
  });

  print("=====================================================");
  print(_selectedCountryId.toString());
  /////
  print(_selectedGovernmentId.toString());
  /////
  print(_selectedDistrictId.toString());
  /////
  ///
  print("My Govern Id = $_selectedGovernmentId");
  }

  void changedDropDownGovernment(String selectedGov) {
    setState(() {
      _selectedGovernment = selectedGov;
    });
  regionsVM.governments.forEach((s){
    if(selectedGov == s.governmentName){
      setState(() {
        _selectedGovernmentId=s.governmentId;
        governmentVM = s;
        print("Selected Id = $_selectedGovernmentId" );
      });
    }
  });
  setState(() {
        _district.clear();
        _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
             // _selectedDistrict = _dropDownMenuDistrict[0].value;
      });
  if(governmentVM.districts.length>0){
      districtVM = governmentVM.districts.first;
      print("districtVM : ");
      print(districtVM);
      governmentVM.districts.forEach((pp){
            setState(() {
              _district.add(pp.districtName);
            });
      });
      setState(() {
          _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
              _selectedDistrict = _dropDownMenuDistrict[0].value;
              _selectedDistrictId=districtVM.districtId;
        });
          
  }else{
    districtVM = new Districts();
    setState(() {
      _selectedDistrictId = 0;
    });
  }

  print("=====================================================");
  print(_selectedCountryId.toString());
  /////
  print(_selectedGovernmentId.toString());
  /////
  print(_selectedDistrictId.toString());
  /////
  }

  void changedDropDownDistrict(String selectedDist) {
    setState(() {
      _selectedDistrict = selectedDist;
    });
  governmentVM.districts.forEach((s){
    if(selectedDist == s.districtName){
      setState(() {
        _selectedDistrictId=s.districtId;
        print("Selected Id = $_selectedDistrictId" );
      });
    }
  });
  
  
  print("=====================================================");
  print(_selectedCountryId.toString());
  /////
  print(_selectedGovernmentId.toString());
  /////
  print(_selectedDistrictId.toString());
  /////
  }
bool isSearch=false;
  


void _searchPressed() {
    setState(() {
      isSearch=true;
    });
 

    print("Osammmmmmmmmmmmma");
  }


@override
  void initState() {
    print("Start About App");
    super.initState();
    _appBarTitle = widget.type==1? new Text( 'الطلبات' ): new Text( 'العروض' );
    sort = false;
    selectedUsers = [];
    RegionApi.SelectAll().then((response){
      if(response.code !=200){
      }else{
        setState(() {
          this.ReturnedResult = response.data;
          regionsVM = response.data.first;
          governmentVM = regionsVM.governments.first;
          districtVM = regionsVM.governments.first.districts.first;
          _selectedCountryId=regionsVM.regionId;
          _selectedDistrictId=districtVM.districtId;
          _selectedGovernmentId=governmentVM.governmentId;
        });
      response.data.forEach((s){
          print(s.regionName);
          setState(() {
            _countries.add(s.regionName);
          });
      });
        setState(() {
          _dropDownMenuCountries = buildAndGetDropDownMenuItems(_countries);
        _selectedCountry = _dropDownMenuCountries[0].value;
        });
        ///////////////
      regionsVM.governments.forEach((m){
        print(m.governmentName);
        setState(() {
            _government.add(m.governmentName);
          });
          
      });
      setState(() {
          _dropDownMenuGovernment = buildAndGetDropDownMenuItems(_government);
        _selectedGovernment = _dropDownMenuGovernment[0].value;
        });
        //////////////////
      governmentVM.districts.forEach((m){
        print(m.districtName);
        setState(() {
            _district.add(m.districtName);
          });
          
      });
      setState(() {
          _dropDownMenuDistrict = buildAndGetDropDownMenuItems(_district);
        _selectedDistrict = _dropDownMenuDistrict[0].value;
        });

      }
      
      });

    selectedUsers = [];
    getUser().then((user){
      this.user = user ;
      setState(() {
              this.user = user ;
      });
      print(user.Id);
              ServiceDataApi.AllAvailableOffers_ByType(user.Id , widget.type).then((ss){
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
  
  }
//ContentVM content = new ContentVM();
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    //  return Scaffold(
    //    key: _scaffoldKey,
    //     backgroundColor:gray,


    //     appBar: AppBar(
    //     flexibleSpace: Container(
    //     decoration: new BoxDecoration(
    //     gradient: new LinearGradient(
    //     colors: [Colors.blue, Colors.blue],
    //     begin: const FractionalOffset(0.0, 0.0),
    // end: const FractionalOffset(0.5, 0.0),
    // stops: [0.0, 1.0],
    // tileMode: TileMode.clamp),
    
    // ),
    // ),
    // title: new Text(
    // " العقارات",
    // style: AqarFont.baseFontStyle(),
    // ),
    // centerTitle: true,
    // automaticallyImplyLeading: true,
    // elevation: 0.0,
    // leading: new IconButton(
    // icon: new Image.asset("images/actionback.png"),
    // iconSize: 30.0,
    // padding: EdgeInsets.fromLTRB(20, 17, 0, 17),
    // onPressed: () => Navigator.of(context).pop()),
    // actions: <Widget>[
    //   IconButton(
        
    //     icon: Icon(Icons.search , color: Colors.white,),
    //     iconSize: 40.0,
    //     padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
    //     onPressed: () => _scaffoldKey.currentState.openEndDrawer(),

    //   ),
    // ],
    // ),
    // body: new Container(
    //   color: Colors.white,
    //   child: SingleChildScrollView(
    //     child: new Column(
    //       children: <Widget>[
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //         _buildItemView(context, DateTime.now().toString()),
    //       ],
    //     ),
    //   ),
    // ),
    //  );
     var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = width / 3;

     var screenSize = MediaQuery.of(context).size;

     
     
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
          title: _appBarTitle,
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          // leading: new IconButton(
          //     icon: _searchIcon,
          //     onPressed: _searchPressed,
          //   ),
          actions: <Widget>[
              IconButton(
                  icon: new IconButton(icon: new Image.asset("images/asset17.png")),
                  iconSize: 40.0,
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              ),
          // IconButton(
          //     icon: _searchIcon,
          //     onPressed: _searchPressed,
          //   ),
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
                  height: 10,
                ),
               isSearch?Container(
                    //height: 400,
                  margin: EdgeInsets.only
                    (right: 30, left: 30, bottom: 50, top: 20),
                  width: screenSize.width,
                  //height: 650,
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        colors: [bgColor, bgColor],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.5, 2.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                    children: <Widget>[
                      Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     Expanded(child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _filter,
                      decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search),
                        hintText: "نوع العقار",
                        fillColor: Colors.white
                      ),
                      // onChanged: (ff){
                      //   print(ff);
                      //   search(ff);
                      // },
                    ),),
                     
                  ],
                ),
            //     Container(
            //   height: 5,
            // ),
            Row(
              children: <Widget>[
                Expanded(
              flex: 1,
              child: Text(
                "المنطقه",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              )),
              Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                            child: new DropdownButton(
                              value: _selectedCountry,
                              items: _dropDownMenuCountries,
                              onChanged: changedDropDownCountry,
                            )
                           // DropdownCountryExample("قم بالاختيار"),
                          ),
                  ),
              ],
            ),
            // Container(
            //   height: 5,
            // ),
            Row(
              children: <Widget>[
                Expanded(
              flex: 1,
              child: Text(
                "المحافظه",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              )),
              Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                            child: new DropdownButton(
                              value: _selectedGovernment,
                              items: _dropDownMenuGovernment,
                              onChanged: changedDropDownGovernment,
                            )
                           // DropdownCountryExample("قم بالاختيار"),
                          ),
                  ),
              ],
            ),
            // Container(
            //   height: 5,
            // ),
            Row(
              children: <Widget>[
                Expanded(
              flex: 1,
              child: Text(
                "الحي",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              )),
              Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                            child: new DropdownButton(
                              value: _selectedDistrict,
                              items: _dropDownMenuDistrict,
                              onChanged: changedDropDownDistrict,
                            )
                           // DropdownCountryExample("قم بالاختيار"),
                          ),
                  ),
                  
              
              ],
            ),
            appButtonbgimage(
                      'بحث',
                      () => search(),
                      bgColor: desgin_button1_start,
                      bgColor2: desgin_button1_end),
                  // Container(
                  //   height: 20,
                  // ),
                    ],
                  ),
                  )
                  
                  
                  ): IconButton(
                    icon: _searchIcon,
                    onPressed: _searchPressed,
                  ),

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
                if(product.ServiceId==1 ||product.ServiceId==3||//||product.ServiceId==2 
                product.ServiceId==5||product.ServiceId==7 ){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => My_Service_01_Details(product)));
                }else if(product.ServiceId ==2){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => My_Service_02_Details(product)));
                }
                else if(product.ServiceId ==4){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => My_Service_05_Details(product)));
                }else if(product.ServiceId ==6){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => My_Service_07_Details(product)));
                }else if(product.ServiceId ==8){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => My_Service_08_Details(product)));
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
                      child:Text(product.ServiceId==2?"  رقم الطلب : "+product.Id.toString():"  رقم العرض : "+product.Id.toString() ,style: product.IsCancelled==true?AqarFont.getLighttableRed() : AqarFont.getLighttableBlue()),
                      // Text("  رقم الطلب "+product.Id.toString(),
                      //  style:AqarFont.getLighttableRed()):
                      //  Text("  رقم الطلب "+product.Id.toString() ,
                      //   style: AqarFont.getLighttableBlue(),),
                    ),
                    // SizedBox(
                    //    width: width-200,
                    //   child:product.IsCancelled==true?Text(" :  رقم الطلب "+product.Id.toString(), style:AqarFont.getLighttableRed()):Text(" :  رقم الطلب "+product.Id.toString() , style: AqarFont.getLighttableBlue(),),// new Text('رقم الطلب  ' , textAlign: TextAlign.right),
                    // ),
                    SizedBox(
                       width: width-200,
                      child:  product.IsCancelled==true? Text("  "+product.ServiceName , style:AqarFont.getLighttableRed()):Text("  "+product.ServiceName , style: AqarFont.getLighttableBlue(),),//new Text(' و 2 حمام و 3 غرفه نوم ', textAlign: TextAlign.right,),
                    ),
                    
                    SizedBox(
                       width: width-200,
                      child: product.IsCancelled==true? Text("  سعر العقار : "+product.BuildingPrice.toString() +" ريال " , style:AqarFont.getLighttableRed()):Text("  سعر العقار : "+product.BuildingPrice.toString()+" ريال " , style: AqarFont.getLighttableBlue(),),//new Text('6000 ريال', textAlign: TextAlign.right,),
                    ),
                    product.BuildingSize!=null?SizedBox(
                       width: width-200,
                      child: product.IsCancelled==true? Text(" المساحه : "+product.BuildingSize.toString() , style:AqarFont.getLighttableRed()):Text("  المساحه : "+product.BuildingSize.toString() , style: AqarFont.getLighttableBlue(),),//new Text('6000 ريال', textAlign: TextAlign.right,),
                    ):Container(),

                    product.District!=null?SizedBox(
                       width: width-200,
                      child: product.IsCancelled==true? Text(" الحي : "+product.District.toString() , style:AqarFont.getLighttableRed()):Text("  الحي : "+product.District.toString() , style: AqarFont.getLighttableBlue(),),//new Text('6000 ريال', textAlign: TextAlign.right,),
                    ):Container(),
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
                Container(
                  height: 5,
                ),
              ]),
          ),
          
          
        

        endDrawer: buildDrawer()

        ),
      );
     
  
  }


 _buildItemView(BuildContext context, var text) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = width / 3;

    return new Container(
      child: new Card(
          elevation: 3.0,
          margin: EdgeInsets.all(10.0),
          child: new Container(
            child: new Row(
              children: <Widget>[
                new Container(
                  width: 150,
                  height: height,
                  child: Image.network(
                    "http://worthly.com/wp-content/uploads/2014/07/1332176822_0.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: <Widget>[
                    //new Padding(padding: new EdgeInsets.only(top: 10.0)),
                    SizedBox(
                       width: width-200,
                      child: new Text('عماره للبيع ' , textAlign: TextAlign.right),
                    ),
                    SizedBox(
                       width: width-200,
                      child: new Text('6000 ريال', textAlign: TextAlign.right,),
                    ),SizedBox(
                       width: width-200,
                      child:  new Text(' و 2 حمام و 3 غرفه نوم ', textAlign: TextAlign.right,),
                    ),
                    SizedBox(
                       width: width-200,
                      child: new Text('القاهره مدينه نصر اول عباس', textAlign: TextAlign.right,),
                    ),
                
                
               
                
                new Padding(padding: new EdgeInsets.only(top: 10.0)),
                  ],
                )
              ],
            )
            
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
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;


}

