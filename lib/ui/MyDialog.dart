
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:waqarapp/API/RegionApi.dart';
import 'package:waqarapp/API/ServiceDataApi.dart';
import 'package:waqarapp/API/UploadApi.dart';
import 'package:waqarapp/constants/buildDrawer.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';

import 'OffersNewDesign.dart';
class MyDialog extends StatefulWidget {
  const MyDialog({this.onValueChange, this.initialValue , this.model});

  final String initialValue;
  final void Function(String) onValueChange;
  final ServiceDataVM model;
  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  String _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;
  }
String adds = "";

 int _radioValue3 = 1;
void _handleRadioValueChange3(int value) {
  print(value.toString());
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
  Widget build(BuildContext context) {

    return new Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog( 
        title: Text('تجديد مده الاعلان'),
        content: const Text(' ' , textDirection: TextDirection.rtl,),
        actions: <Widget>[
          Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _radioValue3,
                  onChanged:_handleRadioValueChange3,
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
                  onChanged: _handleRadioValueChange3,
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
                  onChanged: _handleRadioValueChange3,
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
                  onChanged: _handleRadioValueChange3,
                ),
                Text(
                  '٦٠ يوم',
                  textAlign: TextAlign.right,
                  style: AqarFont.getinputFontV2(),
                ),
              ],
            ),
          FlatButton(
            child: Text('تأكيد'),
            onPressed: () {
              var AddDuration=10;
              if(adds =="١٠ ايام"){
                AddDuration=10;
              }else if(adds=="٢٠ يوم"){
                AddDuration=20;
              }else if(adds=="٣٠ يوم"){
                AddDuration=30;
              }else{
                AddDuration=60;
              }
              ServiceDataApi.UpdateServiceFinishedTime(widget.model.Id , AddDuration).then((ss){
                if(ss.code !=200){
                  //  Navigator.pop(context);
                  }else {
                    // setState(() {
                    //   servicesData.remove(model);
                    // });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => OffersNewDesign()));
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


    // return new SimpleDialog(
    //   title: new Text('تجديد مده الاعلان'),
    //   children: <Widget>[
        
    //   ],
    // );
  }
}