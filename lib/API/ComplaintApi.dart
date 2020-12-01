import 'dart:async';
import 'dart:convert';
//import 'dart:io';
//import 'package:http/http.dart';
//import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/ContactUsResponse.dart';
import 'package:waqarapp/model/ContentResponse.dart';
//import 'package:async/async.dart';



class ComplaintApi{
  
  static Future<ContentResponse> AddComplaint(String userId , String text , int serviceId)async{
    String url = BASE_URL+"api/Complaint/AddComplaint";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var myData = {
  "UserId": userId,
  "ServiceDataId":serviceId,
  "text":text
  
};
var bb = json.encode(myData);
    var response = await http.post(
      url,
      headers: header,
      body: bb
    );

    print(response.statusCode);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ContentResponse.fromJson(jsonResponse);
  }


  }