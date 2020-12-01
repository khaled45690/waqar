import 'dart:async';
import 'dart:convert';
//import 'dart:io';
//import 'package:http/http.dart';
//import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/AllUsersResponse.dart';
import 'package:waqarapp/model/UserResponse.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/model/membershipResponseVM.dart';
//import 'package:async/async.dart';



class AuthApi{
  static Future<UserResponse> login(String email , String password , String fcmtoken)async{
    String url = BASE_URL+"api/Auth/Login";
    print(url);
    print(email);
    print(password);
    print(fcmtoken);
var myData = {
  "Email": email,
  "UserName":"bsbs",
  "PasswordHash": password,
  "DeviceToken":fcmtoken
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
    return UserResponse.fromJson(jsonResponse);
  }
static Future<AllUsersResponse> GetServiceDataUsers(int serviceId)async{
    String url = BASE_URL+"api/UserAcceptService/GetServiceData?serviceId=$serviceId";
    print(url);

// var myData = {
//   "Id": id,
//   "DeviceToken":token
// };
// var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.get(
      url,
      headers: header
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return AllUsersResponse.fromJson(jsonResponse);
  }

  static Future<UserResponse> updateToken(String id , String token)async{
    String url = BASE_URL+"api/Auth/UpdateToken";
    print(url);
    print(id);
    print(token);
var myData = {
  "Id": id,
  "DeviceToken":token
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
    return UserResponse.fromJson(jsonResponse);
  }


  static Future<UserResponse> GetMobileNumber(String userId )async{
    String url = BASE_URL+"api/Auth/GetMobileNumber?UserId=$userId";
    print(url);
    print(userId);
var myData = {
  "UserId": userId,
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.get(
      url,
      headers: header
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return UserResponse.fromJson(jsonResponse);
  }


  static Future<UserResponse>updateProfile(UserVM model)async{
    String url = BASE_URL+"api/Auth/UpdateProfile";
    print(url);
    print(model.Email);
    print(model.Phone);
    print(model.UserType);
    print(model.FullName);
var myData = {
  "Id":model.Id,
  "Email": model.Email,
  "PasswordHash": model.PasswordHash,
  "Phone":model.Phone,
  "UserName":model.Email,
  "FullName":model.FullName,
  "UserImage":model.UserImage,
  "Address":model.Address,
  "City":model.City,
  "ManagerName":model.ManagerName,
  "Commercial_Register":model.Commercial_Register,
  "UserType":model.UserType,
  "Allowbuy":model.Allowbuy,
  "AllowContractDocument":model.AllowContractDocument,
  "AllowMarketting":model.AllowMarketting,
  "AllowPricing":model.AllowPricing,
  "AllowSell":model.AllowSell,
  "AllowSellOnMap":model.AllowSellOnMap,
  "License_Number":model.License_Number,
  "Lat": model.Lat,
  "Long_Lat": model.Long_Lat,
  "Long": model.Long,
  
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
    return UserResponse.fromJson(jsonResponse);
  }


  static Future<UserResponse>AddRating(String FromUser , String ToUser , double value)async{
    String url = BASE_URL+"api/Auth/AddRating";
    print(url);
var myData = {
  "From_User":FromUser,
  "To_User": ToUser,
  "Rating_Value": value
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
    return UserResponse.fromJson(jsonResponse);
  }

  static Future<UserResponse> register(UserVM model)async{
    String url = BASE_URL+"api/Auth/InsertUser";
    
    print(url);
    print(model.Email);
    print(model.Phone);
    print(model.UserType);
    print(model.FullName);
var myData = {
  "Email": model.Email,
  "PasswordHash": model.PasswordHash,
  "Phone":model.Phone,
  "UserName":model.UserName,
  "FullName":model.FullName,
  "UserImage":model.UserImage,
  "Address":model.Address,
  "City":model.City,
  "Commercial_Register":model.Commercial_Register,
  "UserType":model.UserType,
  "Allowbuy":model.Allowbuy,
  "AllowContractDocument":model.AllowContractDocument,
  "AllowMarketting":model.AllowMarketting,
  "AllowPricing":model.AllowPricing,
  "AllowSell":model.AllowSell,
  "IsDesign":model.IsDesign,
  "IsPhoto":model.IsPhoto,
  "IsSupport":model.IsSupport,
  "AllowSellOnMap":model.AllowSellOnMap,
  "License_Number":model.License_Number,
  "DeviceToken":model.DeviceToken,
  "DeviceType":model.DeviceType,
  "ManagerName":model.ManagerName,
  "RegionId":model.RegionId,
  "GovernmentId":model.GovernmentId,
  "DistrictId":model.DistrictId
};

var bb = json.encode(myData);
print(myData);
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
    return UserResponse.fromJson(jsonResponse);
  }

static Future<UserResponse> rememberPass(String email)async{
  String url = BASE_URL+"api/Auth/RememberPassword?Email=$email";
  print(url);
  var myData = {
  "email":email
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
    return UserResponse.fromJson(jsonResponse);
}
static Future<UserResponse> changePassWord(String userId ,String pass )async{
  String url = BASE_URL+"api/Auth/changePassWord";
  print(userId);
  var myData = {
  "userId":userId,
  "NewPassword":pass
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
    return UserResponse.fromJson(jsonResponse);
}
  static Future<UserResponse> verifyCode(String userId,String email , String first , String second , String third , String fourth)async{
    String url = BASE_URL+"api/Auth/VerifyCode";
    print(url);
    print(email);
    print(userId);
    print("$first$second$third$fourth");
var myData = {
  "user_Id": userId,
  "code": "$first$second$third$fourth",
  "email":email
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
    return UserResponse.fromJson(jsonResponse);
  }


  static Future<AllUsersResponse> listActivatedUsers()async{
    String url = BASE_URL+"api/Auth/ListActivatedUsers";
    print(url);
var myData = {
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
    return AllUsersResponse.fromJson(jsonResponse);
  }


  static Future<membershipResponseVM> myMembership(String UserId)async{
    String url = BASE_URL+"api/Auth/GetMembership?UserId=$UserId";
    print(url);
var myData = {
  "UserId":UserId
};
var bb = json.encode(myData);

 Map<String,String>header={
  'Content-type': 'application/json',
  'Accept' : 'application/json'
};
 var response = await http.get(
      url,
      headers: header
    );

print(response.statusCode);
print(response);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return membershipResponseVM.fromJson(jsonResponse);
  }
  

}