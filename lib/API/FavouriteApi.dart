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
//import 'package:async/async.dart';



class FavouriteApi{
  
  static Future<MyServicesDataResponse> AddFavourite(int serviceDataId , String userId)async{
    String url = BASE_URL+"api/Favourite/AddFavourite";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var myData = {
  "UserId": userId,
  "ServiceDataId":serviceDataId
  
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
    return MyServicesDataResponse.fromJson(jsonResponse);
  }
  
  
  static Future<MyServicesDataResponse> RemoveFavourite(int serviceDataId , String userId)async{
    String url = BASE_URL+"api/Favourite/RemoveFavourite";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var myData = {
  "UserId": userId,
  "ServiceDataId":serviceDataId
  
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
    return MyServicesDataResponse.fromJson(jsonResponse);
  }

  static Future<MyServicesDataResponse> AllFavourites(String userId)async{
    String url = BASE_URL+"api/Favourite/AllFavourites?userId=$userId";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var myData = {
      "userId": userId
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
    return MyServicesDataResponse.fromJson(jsonResponse);
  }

static Future<MyServicesDataResponse> CheckProductIsInFavourite(int serviceDataId , String userId)async{
    String url = BASE_URL+"api/Favourite/CheckProductIsInFavourite?serviceDataId=$serviceDataId&UserId=$userId";
    print(url);
    Map<String,String>header={
      'Content-type': 'application/json',
      'Accept' : 'application/json'
    };
    var myData = {
      "UserId": userId,
      "serviceDataId":serviceDataId
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
    return MyServicesDataResponse.fromJson(jsonResponse);
  }


  
  }