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



class ContentApi{
  
  static Future<ContentResponse> getAboutApp()async{
    String url = BASE_URL+"api/Contents/AboutApp";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var response = await http.get(
      url,
      headers: header
    );

    print(response.statusCode);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ContentResponse.fromJson(jsonResponse);
  }
  static Future<ContentResponse> getTerms()async{
    String url = BASE_URL+"api/Contents/TermsAndConditions";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var response = await http.get(
      url,
      headers: header
    );

    print(response.statusCode);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ContentResponse.fromJson(jsonResponse);
  }

  static Future<ContentResponse> SubscriptionValueInYear()async{
    String url = BASE_URL+"api/Contents/SubscriptionValueInYear";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var response = await http.get(
      url,
      headers: header
    );

    print(response.statusCode);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ContentResponse.fromJson(jsonResponse);
  }

  static Future<ContactUsResponse> getContactUs(String userId)async{
    String url ="";
    if(userId == "null"){
      url = BASE_URL+"api/Contents/ContactUs";
    }else{
      url = BASE_URL+"api/Contents/ContactUs?userId=$userId";
    }
   
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var response = await http.get(
      url,
      headers: header
    );

    print(response.statusCode);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ContactUsResponse.fromJson(jsonResponse);
  }
  }