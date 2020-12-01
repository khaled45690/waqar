import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/API/ComplaintApi.dart';
import 'package:waqarapp/API/FavouriteApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/API/UserAcceptServiceApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/ui/AllAvailableOffers.dart';
import 'package:waqarapp/ui/MyServices.dart';
import 'package:waqarapp/ui/Offers.dart';
import 'package:waqarapp/ui/ServiceGalary.dart';
import 'package:waqarapp/utilis/Utils.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/helpers/ImagePickerHelper.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/API/RequestsAndResponses/ServiceBloc.dart';
import 'HomeScreen.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
//import 'package:toast/toast.dart';
import 'package:async/async.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import 'OfficeAcceptService.dart'; 


 

class My_Service_02_Details extends StatefulWidget {
  ServiceDataVM serviceData;
  My_Service_02_Details(this.serviceData);
  @override
  _My_Service_02_DetailsState createState(){
    try{
      set();
    }catch(ex){

    }
    return _My_Service_02_DetailsState();
  } 
}

class _My_Service_02_DetailsState extends State<My_Service_02_Details>
    with WidgetsBindingObserver {
  BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isUploading = false;
  String baseUrl = 'http://box5515.temp.domains/~waqarcom/admin/web/api/upload.php';
  String name = "";
  String email = "";
  String photonumber = 'لم يتم رفع اي صور بعد';
  String imagename = "";

  var aqartypeKey = GlobalKey<FormFieldState>();
  var distinctKey = GlobalKey<FormFieldState>();
  var cityKey = GlobalKey<FormFieldState>();
  var aqarageKey = GlobalKey<FormFieldState>();
  var aqarareaKey = GlobalKey<FormFieldState>();
  var aqarpriceKey = GlobalKey<FormFieldState>();
  var aqardetailsKey = GlobalKey<FormFieldState>();

  var complaintDescKey = GlobalKey<FormFieldState>();

  String user = "";
  String usertype = "";

  File _image = null;
  String urlImage = "";

  String office = "";
  String adds = "";
  String category = "";
  String target = "";

  int _radioValue1 = -1;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  
Color wishListColor = Colors.white;//Colors.white;


AddToFavourite(){
  FavouriteApi.AddFavourite(widget.serviceData.Id,userVM.Id).then((ss){
      if(ss.code !=200){
        //  Navigator.pop(context);
        }else {
          setState(() {
            print("response.data.ValueAr");
          //this.servicesData = ss.data;
          setState(() {
            wishListColor = Colors.red;
            //this.apiCall = false ;
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

RemoveFromFavourite(){
  FavouriteApi.RemoveFavourite(widget.serviceData.Id,userVM.Id).then((ss){
      if(ss.code !=200){
        //  Navigator.pop(context);
        }else {
          setState(() {
            print("response.data.ValueAr");
          //this.servicesData = ss.data;
          setState(() {
            wishListColor = Colors.white;
            //this.apiCall = false ;
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


CheckProductIsInFavourite(){
  print(widget.serviceData.Id.toString());
  print(userVM.Id);
  FavouriteApi.CheckProductIsInFavourite(widget.serviceData.Id , userVM.Id).then((response) {
        if (response.code ==200 ) {
            print("Response Code is 200");
            print(response.message);
            wishListColor = response.message=="1"?Colors.red:Colors.white;
          } else {
            print("${response.message}");
          }
      }, onError: (error) {
        print("login Error : : :$error");
        
      });
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement getBody
    _context = context;
    return Scaffold(
              backgroundColor: gray,
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
                  "تفاصيل العقار",
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
                child: Padding(
                padding: EdgeInsets.all(0),
                child: Builder(
                  builder: (cont) => SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  right: 35, left: 35, bottom: 0, top: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // appButtonbgimage('نموذج عرض عقار', () => {},
                                    //     bgColor: desgin_button4_start,
                                    //     bgColor2: desgin_button4_start),
                                  ])),
                          Container(
                              margin: EdgeInsets.only(
                                  right: 40, left: 40, bottom: 10, top: 10),
                              width: MediaQuery.of(_context).size.width,
                              decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [bgColor, bgColor],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(0.5, 2.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(children: [
                                userNameInputs(cont),
                                Container(
                                  height: 10,
                                ),
                              ])),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "حقوق البرنامج محفوظه لدي مؤسسه",
                              textAlign: TextAlign.center,
                              style: AqarFont.getBoldFont(),
                            ),
                          ),
                          Container(
                            child: Text(
                              "دليل التطبيقات للاتصالات و تقنيه المعلومات",
                              textAlign: TextAlign.justify,
                              style: AqarFont.getBoldFont(),
                            ),
                          ),
                          Container(
                            height: 20,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ),
              
              endDrawer:buildDrawer()
            );
  }

  userNameInputs(BuildContext cont) {
    _context = cont;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(child: _buildCard()),
    );
  }

  // #docregion Card
  Widget _buildCard() => SizedBox(
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            widget.serviceData.ServiceId==5?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: widget.serviceData.ForSell?0:-1,
                //  onChanged: _handleRadioValueChange1,
                ),
                Text(
                  'مالك',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFont(),
                ),
                Container(
                  width: 20,
                ),
                Radio(
                  value: 1,
                  //groupValue: _radioValue1,
                  groupValue:widget.serviceData.ForRent?1:-1,
                 // onChanged: _handleRadioValueChange1,
                ),
                Text(
                  'وكيل',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFont(),
                ),
              ],
            ):Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: widget.serviceData.ForSell?0:-1,
                //  onChanged: _handleRadioValueChange1,
                ),
                Text(
                  widget.serviceData.ServiceId==2?'شراء':'بيع',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFont(),
                ),
                Container(
                  width: 20,
                ),
                Radio(
                  value: 1,
                  //groupValue: _radioValue1,
                  groupValue:widget.serviceData.ForRent?1:-1,
                 // onChanged: _handleRadioValueChange1,
                ),
                Text(
                  'إيجار',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFont(),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        key: aqartypeKey,
                        initialValue: widget.serviceData.BuildingType,
                        enabled: false,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "نوع العقار",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "محل او فيلا او مسكن",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Text(
                "التصنيف",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue:  widget.serviceData.IsCommercial?0:-1,//_radioValue2,
                //  onChanged: _handleRadioValueChange2,
                ),
                Text(
                  'تجاري',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 1,
                  groupValue: widget.serviceData.IsHousing?1:-1,//_radioValue2,
                //  onChanged: _handleRadioValueChange2,
                ),
                Text(
                  'سكني',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 2,
                  groupValue: widget.serviceData.IsManagement?2:-1,//_radioValue2,
                //  onChanged: _handleRadioValueChange2,
                ),
                Text(
                  'إداري',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        key: cityKey,
                        initialValue: widget.serviceData.City,
                        enabled: false,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "المدينه",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "المدينه",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
          height: 10,
        ),
        widget.serviceData.ServiceId==1? Container(
          child: Text(
            "الصفه",
            textAlign: TextAlign.center,
            style: AqarFont.getLightFont_TextFormField3(),
          ),
        ):Container(),
        widget.serviceData.ServiceId==1?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("مالك "),
            Radio(
              value: 0,
              groupValue: widget.serviceData.IsOwner?0:-1,
              //onChanged: _handleRadioValueChange1,
            ),
            Container(
              width: 5,
            ),
            Text("وكيل"),
            Radio(
              value: 1,
              groupValue: widget.serviceData.IsAgent?1:-1,
              //onChanged: _handleRadioValueChange1,
            ),
          ],
        ):Container(),
            Container(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        key: distinctKey,
                        initialValue: widget.serviceData.District,
                        enabled: false,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الحي",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          hintText: "الحي",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Text(
                "عمر العقار *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: TextFormField(
                        maxLines: 1,
                        initialValue: widget.serviceData.BuildingAge,
                        key: aqarageKey,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "من  *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "من",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                ),
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: TextFormField(
                        maxLines: 1,
                        //key: aqarageToKey,
                        initialValue: widget.serviceData.BuildingAgeTo,
                        enabled: false,
                        textAlign: TextAlign.right,
                        
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الي  *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "الي",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Text(
                "مساحه العقار *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child:TextFormField(
                        maxLines: 1,
                        key: aqarareaKey,
                        initialValue: widget.serviceData.BuildingSize,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "من *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "+متر مربع",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                  
                ),
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child:TextFormField(
                        maxLines: 1,
                        //key: aqarareaToKey,
                        initialValue: widget.serviceData.BuildingSizeTo,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الي *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "+متر مربع",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Text(
                "سعر العقار *",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: TextFormField(
                        maxLines: 1,
                        key: aqarpriceKey,
                        initialValue: widget.serviceData.BuildingPrice.toString(),
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "من *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "12.3",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                  
                ),
                Expanded(
                  flex: 1,
                  // wrap your Column in Expanded
                  child: TextFormField(
                        maxLines: 1,
                        initialValue: widget.serviceData.BuildingPriceTo.toString(),
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الي *",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "12.3",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: gray, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            
            Container(
              child: Text(
                "مواصفات العقار",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Container(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        key: aqardetailsKey,
                        initialValue: widget.serviceData.Description,
                        enabled: false,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: null,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "الوصف ",
                          fillColor: Colors.blueGrey,
                          hintText: "كتابه الوصف ٢٠٠٠ حرف",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            widget.serviceData.Long_Lat ==""||widget.serviceData.Long_Lat==null?Container():Container(
              child: Text(
                "موقع العقار",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            widget.serviceData.Long_Lat ==""||widget.serviceData.Long_Lat==null?Container():Container(
              height: 10,
            ),
            widget.serviceData.Long_Lat ==""||widget.serviceData.Long_Lat==null?Container():Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // wrap your Column in Expanded
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        // key: aqarareaKey,
                        initialValue: widget.serviceData.Long_Lat,
                        enabled: false,
                        scrollPadding:
                            EdgeInsets.only(right: 25, left: 25, bottom: 0),
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          labelText: "موقع العقار",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: Colors.blueGrey,
                          hintText: "موقع العقار مربع",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            widget.serviceData.Long_Lat ==""||widget.serviceData.Long_Lat==null?Container():Container(
              height: 15,
            ),
            
            Container(
              height: 10,
            ),
            widget.serviceData.ServiceId==5?Container():Container(
              child: Text(
                "مده الاعلان",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            widget.serviceData.ServiceId==5?Container():
            
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _radioValue3,
                          //onChanged: _handleRadioValueChange3,
                        ),
                        Text(
                          '١٠ ايام',
                          textAlign: TextAlign.right,
                          style: AqarFont.getinputFontV2(),
                        ),
                        Text(
                          '         ',
                          textAlign: TextAlign.right,
                          style: AqarFont.getinputFontV2(),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _radioValue3,
                          //onChanged: _handleRadioValueChange3,
                        ),
                        Text(
                          '٢٠ يوم',
                          textAlign: TextAlign.right,
                          style: AqarFont.getinputFontV2(),
                        ),
                        
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        
                        Radio(
                          value: 2,
                          groupValue: _radioValue3,
                          //onChanged: _handleRadioValueChange3,
                        ),
                        Text(
                          '٣٠ يوم',
                          textAlign: TextAlign.right,
                          style: AqarFont.getinputFontV2(),
                        ),
                        Text(
                          '         ',
                          textAlign: TextAlign.right,
                          style: AqarFont.getinputFontV2(),
                        ),
                        Radio(
                          value: 3,
                          groupValue: _radioValue3,
                          //onChanged: _handleRadioValueChange3,
                        ),
                        Text(
                          '٦٠ يوم',
                          textAlign: TextAlign.right,
                          style: AqarFont.getinputFontV2(),
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                  ],
                ),
                // Radio(
                //   value: 0,
                //   groupValue: _radioValue3,
                //   //onChanged: _handleRadioValueChange3,
                // ),
                // Text(
                //   '١٠ ايام',
                //   textAlign: TextAlign.right,
                //   style: AqarFont.getinputFontV2(),
                // ),
                // Radio(
                //   value: 1,
                //   groupValue: _radioValue3,
                //   //onChanged: _handleRadioValueChange3,
                // ),
                // Text(
                //   '٢٠ يوم',
                //   textAlign: TextAlign.right,
                //   style: AqarFont.getinputFontV2(),
                // ),
                // Radio(
                //   value: 2,
                //   groupValue: _radioValue3,
                //   //onChanged: _handleRadioValueChange3,
                // ),
                // Text(
                //   '٣٠ يوم',
                //   textAlign: TextAlign.right,
                //   style: AqarFont.getinputFontV2(),
                // ),
              ],
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Text(
                "المكاتب",
                textAlign: TextAlign.center,
                style: AqarFont.getLightFont_TextFormField2(),
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _radioValue4,
                  //onChanged: _handleRadioValueChange4,
                ),
                Text(
                  'الحي',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue4,
                  //onChanged: _handleRadioValueChange4,
                ),
                Text(
                  'المنطقة',
                  textAlign: TextAlign.right,
                 // style: AqarFont.getinputFontV2(),
                ),
                Radio(
                  value: 2,
                  groupValue: _radioValue4,
                  //onChanged: _handleRadioValueChange4,
                ),
                Text(
                  'الجميع',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
           (userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null)?Container() :widget.serviceData.UserId==userVM.Id?Container():Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                    child: Text(' رفض',
                        //style: AqarFont.baseRegularFont()
                        ),
                    onPressed: (){
                      AcceptOrRefuser( 1);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                    child: Text(' بلاغ',
                        style: AqarFont.baseRegularFont()),
                    onPressed: (){
                      _ComplaintShowDialog();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    splashColor: Colors.blueAccent,
                    child: Text('قبول',
                        style: AqarFont.baseRegularFont()),
                    onPressed: (){
                      AcceptOrRefuser(2);
                    }
                  ),
                ),
                
              ],
            ),

            Container(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(child: Text("  ") , flex: 1,),
                Expanded(
                    flex: 1,
                    child: Container(
            //            margin: EdgeInsets.only(left: 30, right: 20),
                        decoration: ShapeDecoration(shape: CircleBorder(), color: Color(0xffdddddd)),
                        child: IconButton(
                        icon: Icon(Icons.favorite, color: wishListColor), onPressed: () {
                          setState(() {
                            if(wishListColor ==Colors.red){
                              RemoveFromFavourite();
                              
                            }else{
                              AddToFavourite();
                              
                            }
                            
                          });
                        }),
                        padding: EdgeInsets.all(10),
                      ),
                  ),
                  Expanded(child: Text("  ") , flex: 1,),
              ],
            ),
            Container(
              height: 15,
            ),
            widget.serviceData.mainImage.contains("noLogo.jpg")?Container():Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(_context).size.width - 130,
                    child: Column(
                      children: <Widget>[
                        appButtonbgimage(
                          'صور الاعلان',
                          (){
                            if(userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null){
                                print("HHHHHH");
                                showInSnackBar("من فضلك قم بتسجيل الدخول للاطلاع علي الصور ", _context, _scaffoldKey);
                            }else{
                                Navigator.of(_context).push(MaterialPageRoute(builder: (context) => ServiceGalary(widget.serviceData.Id)));
                            }
                          },
                          bgColor: grey_ligth2,
                          bgColor2: grey_ligth2),
                      ],
                    ),
                  ),
                ]),

            Container(
              height: 15,
            ),

            (userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null)?Container() :Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(_context).size.width - 130,
                    child: Column(
                      children: <Widget>[
                        appButtonbgimage(
                          ' مكاتب قبلت الخدمه',
                          (){
                            Navigator.of(_context).push(MaterialPageRoute(builder: (context) => OfficeAcceptService(widget.serviceData.Id)));
                          },
                          bgColor: grey_ligth2,
                          bgColor2: grey_ligth2),
                      ],
                    ),
                  ),
                ]),

            Container(
              height: 15,
            ),
            
            //(userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null)?Container() :
            widget.serviceData.UserId==userVM.Id?Container(): Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(_context).size.width - 130,
                    child: Column(
                      children: <Widget>[
                        appButtonbgimage(
                          'تواصل مع المعلن ',
                          () async {
                             try{
                               if(userVM==null||userVM.Email.toString()==null||userVM.Email.toString()==""||userVM.Email==null){
                                    print("HHHHHHHHH");
                                    showInSnackBar("من فضلك قم بتسجيل الدخول للاتصال بالمعلن", _context, _scaffoldKey);
                               }else{
                                 //  mobileNum="552358049";
                                  String s= "https://wa.me/966"+mobileNum+"?text="+"هل "+(widget.serviceData.ServiceId==2?"الطلب رقم ":"العرض  رقم ")+widget.serviceData.Id.toString()+" "
                                  +"مازال متوفر ؟";
                                    await launch(s);//https://wa.me/${}?text=Hello
                               }
                              
                             }catch(Ex){
                                new CallService().call(mobileNum);
                             }

                          },
                          bgColor: grey_ligth2,
                          bgColor2: grey_ligth2),
                      ],
                    ),
                  ),
                ]),
                Container(
                  height: 20,
                )
            // appButtonbgimage('إرسال الطلب', () => Submit(),
            //     bgColor: desgin_button1_start, bgColor2: desgin_button1_end),
          ],
        ),
      );

  void _handleRadioValueChange4(int value) {
    setState(() {
      _radioValue4 = value;

      switch (_radioValue4) {
        case 0:
          office = "مكاتب الحي";
          break;
        case 1:
          office = "مكاتب المنطقة";
          break;
        case 2:
          office = "جميع المكاتب";
          break;
      }
    });
  }

  void _handleRadioValueChange3(int value) {
    setState(() {
      _radioValue3 = value;

      switch (_radioValue3) {
        case 0:
          adds = "١٠ ايام";
          break;
        case 1:
          adds = "٢٠ يوم";
          break;
        case 2:
          adds = "٣٠ يوم";
          break;
        case 3:
          adds = "٦٠ يوم";
          break;
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;

      switch (_radioValue2) {
        case 0:
          category = "تجاري";
          break;
        case 1:
          category = "سكني";
          break;
        case 2:
          category = "إداري";
          break;
      }
    });
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          target = "بيع";
          break;
        case 1:
          target = "إيجار";
          break;
      }
    });
  }


  @override
  void dispose() {
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
UserVM userVM ;
var mobileNum="";
  @override
  void initState() {
    restore();
    super.initState();
    getUser().then((user){
      setState(() {
              this.userVM = user ;
              CheckProductIsInFavourite();
      });
    });
    
    AuthApi.GetMobileNumber(widget.serviceData.UserId).then((response) {
        if (response.code ==200 ) {
            print("Response Code is 200");
            print(response.message);
            setState(() {
              mobileNum=response.message;
            });
          } else {
            print("${response.message}");
          }
      }, onError: (error) {
        print("login Error : : :$error");
        
      });

    // if(widget.serviceData.ForSell==true){
    //   _radioValue1=0;
    // }else if(widget.serviceData.ForRent==true){
    //   _radioValue1=1;
    // }
    ////
    print("IsCommercial Value");
    print("Comm "+widget.serviceData.IsCommercial.toString());
    print("Hous "+widget.serviceData.IsHousing.toString());
    print("Manag "+widget.serviceData.IsManagement.toString());
    // if(widget.serviceData.IsCommercial){
    //   _radioValue2=0;
    // }else if(widget.serviceData.IsHousing){
    //   _radioValue2=1;
    // }else if(widget.serviceData.IsManagement){
    //   _radioValue2=2;
    // }
    /////
    if(widget.serviceData.AddDuration==10){
      _radioValue3=0;
    }else if(widget.serviceData.AddDuration==20){
      _radioValue3=1;
    }else if(widget.serviceData.AddDuration==30){
      _radioValue3=2;
    }
  //////
   if(widget.serviceData.AppearingForOffice==1){
     _radioValue4 =0;
   }else if(widget.serviceData.AppearingForOffice==2){
     _radioValue4 =1;
   }else if(widget.serviceData.AppearingForOffice==3){
     _radioValue4 =2;
   }
    
  }

  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      name = Prefs.getString('username') ?? "";
      email = Prefs.getString('email') ?? "";
      usertype = Prefs.getString('usertype') ?? "";
    });
  }

  Submit() {
    showAppLoading(_context);
    if (_formKey.currentState.validate()) {
      ServiceDataVM model = new ServiceDataVM();
      model.ServiceId=1;
      if(target=="بيع"){
        model.ForSell=true;
        model.ForRent=false;
      }else{
        model.ForSell=false;
        model.ForRent=true;
      }
      model.City=cityKey.currentState.value;
      model.BuildingType=aqartypeKey.currentState.value;
      model.District=distinctKey.currentState.value;
      model.BuildingAge=aqarageKey.currentState.value;
      model.BuildingPrice=double.parse(aqarpriceKey.currentState.value);
      model.Description=aqardetailsKey.currentState.value;
     
      if(adds =="١٠ ايام"){
         model.AddDuration=10;
      }else if(adds=="٢٠ يوم"){
        model.AddDuration=20;
      }else{
        model.AddDuration=30;
      }
      
     if(office =="مكاتب الحي"){
       model.AppearingForOffice=1;
     }else if(office =="مكاتب المنطقة"){
       model.AppearingForOffice=2;
     }else{
       model.AppearingForOffice=3;
     }
     model.UserId=userVM.Id;
     ServiceDataApi.addService(model).then((response) {
          if (response.code ==200 ) {
            hideAppDialog(_context);
            _displayDialog(_context , response.data.Id);
           // print(object)
         //   showInSnackBarAfterAddService(AppLocalizations.of(_context).lblServiceAdded, _context, _scaffoldKey);
   
           // showInSnackBar("تم اضافه الخدمه الي سله الطلبات", _context, _scaffoldKey);
           // showSnack("تم اضافه الخدمه الي سله المهملات");
          } else {
            print("${response.message}");
            //showInSnackBar("${response.message}", context, _scaffoldKey);
          }
          setState(() {
          //this.loginApi = false;
          });
        }, onError: (error) {
          print("login Error : : :$error");
          setState(() {
          // this.loginApi = false;
          });
        });
    //   _bloc.addservice(
    //       target,
    //       aqartypeKey.currentState.value,
    //       category,
    //       cityKey.currentState.value,
    //       distinctKey.currentState.value,
    //       aqarageKey.currentState.value,
    //       aqarareaKey.currentState.value,
    //       aqarpriceKey.currentState.value,
    //       aqardetailsKey.currentState.value,
    //       '',
    //       adds,
    //       office,
    //       '',
    //       '',
    //       'عرض عقار',
    //       'amadian2010@gmail.com',
    //       '1');
    // } else {
    //   hideAppDialog(_context);
    // }
  }
  }

  _displayDialog(BuildContext context , int orderNum) async {
    int _currentIndex = 1;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("سيتم التواصل معكم ",
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text("رقم طلبكم هو "+orderNum.toString(),
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
            actions: <Widget>[
              FlatButton(
              child: Text("رجوع",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => My_Service_02_Details()));
              },
            ),

            FlatButton(
              child: Text("تم",
                  textAlign: TextAlign.left,
                  style: AqarFont.getLightFont_TextFormField()),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyServices()));
              },
            ),
              // new FlatButton(
              //   child: new Text('CANCEL'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // )
            ],
          );
        });
  }



AcceptOrRefuser(int status){
  showAppLoading(_context);
  int serviceId = widget.serviceData.Id;
  String userId = userVM.Id;
  bool isAccept = false;
    if(status==1){//refus
      isAccept=false;
    }else if(status==2){//refus
      isAccept=true;
    }
    UserAcceptServiceApi.UserAcceptService(userId, "text", serviceId, isAccept).then((response) {
          if (response.code ==200 ) {
            print("Suceeeeeees");
             hideAppDialog(_context);
             _showDialog(status);
          } else {
            print("failllllll");
            hideAppDialog(_context);
            print(response.message.toString());
            _showDialogV2(response.message.toString());
          }
          setState(() {
          //this.loginApi = false;
          });
        }, onError: (error) {
          hideAppDialog(_context);
          print("login Error : : :$error");
          setState(() {
          // this.loginApi = false;
          });
        });
    
  //Call Api
  //showInSnackBar("الرقم السري اقل من 6 حروف", _context, _scaffoldKey);
  
}
_showDialog(int status) async {
  String txt = "";
    if(status==1){//refus
      txt = " تم تاكيد الرفض بنجاح  ";
    }else if(status==2){//refus
      txt = " تم تاكيد القبول بنجاح  ";
    }
    print(txt);
    await showDialog<String>(
      context: _context,
      child: new _SystemPadding(child: new AlertDialog(
            title: Text(txt,
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text("",
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
            actions: <Widget>[
              FlatButton(
              child: Text("نعم",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                Navigator.of(_context).pop();
                //  Navigator.of(_context)
                //      .push(MaterialPageRoute(builder: (_context) => AllAvailableOffers()));
              },
            ),
            ],
          ),),
    );
  }
_showDialogV2(String txt) async {
    print(txt);
    await showDialog<String>(
      context: _context,
      child: new _SystemPadding(child: new AlertDialog(
            title: Text(txt,
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text("",
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
            actions: <Widget>[
              FlatButton(
              child: Text("نعم",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                Navigator.of(_context).pop();
              },
            ),
            ],
          ),),
    );
  }

  _ComplaintShowDialog() async {
  
    await showDialog<String>(
      context: _context,
      child: new AlertDialog(
            title: Text('سبب الابلاغ',
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: SingleChildScrollView(
              child: Container(
              height: 155,
              child: Column(
              children: <Widget>[
                Text("سبب الابلاغ ",
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
                TextFormField(
                        maxLines: 8,
                        key: complaintDescKey,
                        //  scrollPadding: EdgeInsets.only(
                        //     right: 25, left: 25, bottom: 0),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        minLines: 4,
                        
                        style: AqarFont.getLightFont(),
                        decoration: InputDecoration(
                          //labelText: "اسم المكتب",
                          labelStyle: AqarFont.getLightFont_TextFormField(),
                          fillColor: gray,
                          //hintText: " المكتب",
                          // contentPadding: new EdgeInsets.symmetric(
                          //     vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //       color: Colors.grey, width: 1.0),
                          //   borderRadius: BorderRadius.circular(25.0),
                          // ),
                        ),
                      )
              ],
            ),
            ),
            ),
            
            actions: <Widget>[
              FlatButton(
              child: Text("نعم",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                SendComplaint();
              },
            ),
            ],
          ),
    );
  }
  SendComplaint(){
    showAppLoading(_context);
  int serviceId = widget.serviceData.Id;
  String userId = userVM.Id;
  bool isAccept = false;
    String text = complaintDescKey.currentState.value;
    ComplaintApi.AddComplaint(userId, text, serviceId).then((response) {
          if (response.code ==200 ) {
            print("Suceeeeeees");
             hideAppDialog(_context);
             Navigator.of(_context).pop();
                Navigator.of(_context)
                    .push(MaterialPageRoute(builder: (context) => MyServices()));
          } else {
            print("failllllll");
            hideAppDialog(_context);
          }
          setState(() {
          //this.loginApi = false;
          });
        }, onError: (error) {
          hideAppDialog(_context);
          print("login Error : : :$error");
          setState(() {
          // this.loginApi = false;
          });
        });
    
  //Call Api
  //showInSnackBar("الرقم السري اقل من 6 حروف", _context, _scaffoldKey);
  
  }
  _displayDialogV2(BuildContext context , int status) async {
    String txt = "";
    if(status==1){//refus
      txt = " تم تاكيد الرفض بنجاح  ";
    }else if(status==2){//refus
      txt = " تم تاكيد القبول بنجاح  ";
    }
    print(txt);
   
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(txt,
                  textAlign: TextAlign.center,
                  style: AqarFont.getLightFont_TextFormField()),
            content: Text("هل تريد العوده للعروض ؟",
                    textAlign: TextAlign.right,
                    style: AqarFont.getLightFont_TextFormField()),
            actions: <Widget>[
              FlatButton(
              child: Text("نعم",
                  textAlign: TextAlign.right,
                  //style: AqarFont.getLightFont_TextFormField()
                  ),
              onPressed: () {
                Navigator.of(_context).pop();
                Navigator.of(_context).pop();
                Navigator.of(_context)
                    .push(MaterialPageRoute(builder: (context) => MyServices()));
              },
            ),

            FlatButton(
              child: Text("تم",
                  textAlign: TextAlign.left,
                  style: AqarFont.getLightFont_TextFormField()),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyServices()));
              },
            ),
            ],
          );
        });
  }

  showAlertDialog(BuildContext context , int orderNum) {
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
      title: Text("سيتم التواصل معكم ",
          textAlign: TextAlign.center,
          style: AqarFont.getLightFont_TextFormField()),
      content: Text("رقم طلبكم هو "+orderNum.toString(),
          textAlign: TextAlign.right,
          style: AqarFont.getLightFont_TextFormField()),
      actions: [
        
      //  okButton,
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


  upload_2(File imageFile) async {

    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(baseUrl);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    Map<String,String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    request.headers.addAll(headers);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }


  // void upload(File image) async {
  //   final Map<String, dynamic> response = await _uploadImage(image);
  //   print(response);
  //   // Check if any error occured
  //   if (response == null || response.containsKey("error")) {
  //     Toast.show("Image Upload Failed!!!", _context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   } else {
  //     Toast.show("Image Uploaded Successfully!!!", _context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   }
  // }

  // Future<Map<String, dynamic>> _uploadImage(File image) async {
  //   setState(() {
  //     _isUploading = true;
  //   });
  //   // Find the mime type of the selected file by looking at the header bytes of the file
  //   final mimeTypeData =
  //       lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
  //   // Intilize the multipart request
  //   final imageUploadRequest =
  //       http.MultipartRequest('POST', Uri.parse(baseUrl));
  //   // Attach the file in the request
  //   final file = await http.MultipartFile.fromPath('image', image.path,
  //       contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  //   // Explicitly pass the extension of the image with request body
  //   // Since image_picker has some bugs due which it mixes up
  //   // image extension with file name like this filenamejpge
  //   // Which creates some problem at the server side to manage
  //   // or verify the file extension
  //   imageUploadRequest.fields['ext'] = mimeTypeData[1];
  //   imageUploadRequest.files.add(file);
  //   try {
  //     final streamedResponse = await imageUploadRequest.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     if (response.statusCode != 200) {
  //       return null;
  //     }
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     _resetState();
  //     return responseData;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  // void _resetState() {
  //   setState(() {
  //     _isUploading = false;
  //     _image = null;
  //   });
  // }

    }

    class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}