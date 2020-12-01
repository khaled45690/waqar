import 'dart:async';
import 'dart:convert';
//import 'dart:io';
//import 'package:http/http.dart';
//import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/ContactUsResponse.dart';
import 'package:waqarapp/model/ContentResponse.dart';
import 'package:waqarapp/model/MyServicesDataResponse.dart';
import 'package:waqarapp/model/RegionResponse.dart';
//import 'package:async/async.dart';



class RegionApi{

static Future<RegionResponse> SelectAll()async{
    String url = BASE_URL+"api/District/SelectAll";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    // var myData = {
    //   "UserId": userId,
    //   "serviceDataId":serviceDataId
    // };
    // var bb = json.encode(myData);

    var response = await http.post(
      url,
      headers: header,
      //body: bb
    );

    print(response.statusCode);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return RegionResponse.fromJson(jsonResponse);
  }


  
  }