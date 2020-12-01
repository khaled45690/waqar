import 'dart:async';
import 'dart:convert';
//import 'dart:io';
//import 'package:http/http.dart';
//import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/ImagesVM.dart';
import 'package:waqarapp/model/MyServicesDataResponse.dart';
import 'package:waqarapp/model/ServiceDataResponse.dart';
import 'package:waqarapp/model/ServiceDataVM.dart';
import 'package:waqarapp/model/UserVM.dart';
//import 'package:async/async.dart';



class ServiceDataApi{
  static Future<ServiceDataResponse>changeStatus(ServiceDataVM model)async{
    var ServiceId = model.Id;
    String url = BASE_URL+"api/ServiceData/ChangeStatus?ServiceId=$ServiceId";
    print(url);
    print(ServiceId);
var myData = {
  "ServiceId": model.Id
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ServiceDataResponse.fromJson(jsonResponse);
  }


  static Future<ServiceDataResponse> addService(ServiceDataVM model)async{
    String url = BASE_URL+"api/ServiceData/PostServiceData";
    print(url);
var myData = {
  "ServiceId": model.ServiceId,
  "AddDuration":model.AddDuration,
  "AppearingForOffice": model.AppearingForOffice,
  "BankAccount": model.BankAccount,
  "BuildingAge": model.BuildingAge,
  "BuildingAgeFrom": model.BuildingAge,
  "BuildingAgeTo": model.BuildingAgeTo,
  "BuildingPrice": model.BuildingPrice,
  "BuildingPriceFrom": model.BuildingPrice,
  "BuildingPriceTo": model.BuildingPriceTo,
  "BuildingType": model.BuildingType,
  "City": model.City,
  "Country": model.Country,
  "Description": model.Description,
  "District": model.District,
  "ElectricAccount": model.ElectricAccount,
  "forBuy": model.forBuy,
  "ForRent": model.ForRent,
  "ForSell": model.ForSell,
  "IsAgent": model.IsAgent,
  "IsCancelled": model.IsCancelled,
  "IsCommercial": model.IsCommercial,
  "IsHousing": model.IsHousing,
  "IsManagement": model.IsManagement,
  "IsEntertainment": model.IsEntertainment,
  "IsEducational": model.IsEducational,
  "IsOwner": model.IsOwner,
  "Lat": model.Lat,
  "Long_Lat": model.Long_Lat,
  "Long": model.Long,
  
  "LessorAddress": model.LessorAddress,
  "LessorEmail": model.LessorEmail,
  "LessorName": model.LessorName,
  "LessorPhone": model.LessorPhone,
  
  "PricingPurpose": model.PricingPurpose,
  "ServiceName": model.ServiceName,
  "TenantAddress": model.TenantAddress,
  "TenantEmail": model.TenantEmail,
  "TenantName": model.TenantName,
  "TenantPhone": model.TenantPhone,
  "UserId": model.UserId,
  "BuildingSize":model.BuildingSize,
  "BuildingSizeFrom":model.BuildingSize,
  "BuildingSizeTo":model.BuildingSizeTo,
  "files":model.files
};
print(myData);
var bb = json.encode(myData);
print(bb);
 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ServiceDataResponse.fromJson(jsonResponse);
  }



  static Future<MyServicesDataResponse> myOrders(String userId)async{
    String url = BASE_URL+"api/ServiceData/MyOrders?UserId=$userId";
    print(url);
var myData = {
  "UserId": userId,
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return MyServicesDataResponse.fromJson(jsonResponse);
  }


  static Future<MyServicesDataResponse> myOffers(String userId)async{
    String url = BASE_URL+"api/ServiceData/MyOffers?UserId=$userId";
    print(url);
var myData = {
  "UserId": userId,
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return MyServicesDataResponse.fromJson(jsonResponse);
  }

  static Future<MyServicesDataResponse> allAvailableOffers(String userId)async{
    String url = BASE_URL+"api/ServiceData/AllAvailableOffers?UserId=$userId";
    print(url);
var myData = {
  "UserId": userId,
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return MyServicesDataResponse.fromJson(jsonResponse);
  }

static Future<MyServicesDataResponse> AllAvailableOffers_ByType(String userId , int type)async{
    String url = BASE_URL+"api/ServiceData/AllAvailableOffers_ByType?UserId=$userId&Type=$type";
    print(url);
var myData = {
  "UserId": userId,
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return MyServicesDataResponse.fromJson(jsonResponse);
  }


 static Future<MyServicesDataResponse> ServicesDataThatUserAccepted(String userId)async{
    String url = BASE_URL+"api/ServiceData/ServicesDataThatUserAccepted?UserId=$userId";
    print(url);
var myData = {
  "UserId": userId,
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return MyServicesDataResponse.fromJson(jsonResponse);
  }


  static Future<ImagesResponse> GetAllServiceDataImages(int serviceId)async{
    String url = BASE_URL+"api/ServiceData/GetServiceDataImages?ServiceId=$serviceId";
    print(url);
var myData = {
  "ServiceId": serviceId,
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ImagesResponse.fromJson(jsonResponse);
  }



   static Future<ServiceDataResponse> Delete(int id)async{
    String url = BASE_URL+"api/ServiceData/Delete?ID=$id";
    print(url);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.get(
      url,
      headers: header,
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ServiceDataResponse.fromJson(jsonResponse);
  }


  static Future<ServiceDataResponse> UpdateServiceFinishedTime(int id , int duration) async {
    String url = BASE_URL+"api/ServiceData/UpdateServiceFinishedTime?ID=$id&Duration=$duration";
    print(url);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.get(
      url,
      headers: header,
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ServiceDataResponse.fromJson(jsonResponse);
  }

  static Future<MyServicesDataResponse> Search(String searchTxt , int district , int government , int country , int type)async{
    String url = BASE_URL+"api/ServiceData/SearchServiceData?SearchTxt=$searchTxt&type=$type&DistrictId=$district&GovernmentId=$government&CountryId=$country";
    print(url);
var myData = {
  "SearchTxt": searchTxt,
  
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.post(
      url,
      headers: header,
      body: bb
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return MyServicesDataResponse.fromJson(jsonResponse);
  }



}