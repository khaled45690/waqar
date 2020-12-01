import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'dart:io';
//import 'package:http/http.dart';
//import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;
//import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/UploadResponse.dart';


class UploadApi{
  static Future<UploadResponse> upload_Base64(File file)async{
    String url = BASE_URL+"api/UploadFile/SaveFile";
   // url="http://mansa-app.com/api/UploadFile/SaveFile";
    print(url);
    print(file);
    if (file == null) print("Null => No File");
   String base64Image = base64Encode(file.readAsBytesSync());
   String fileName = file.path.split("/").last;

  print("base64 : "+base64Image);
  print("FileName : "+fileName);
  print( {
     "FileBase64": base64Image,
     "FileExtention": fileName,
   });
  //  Response response = await http.post(url, body: {
  //    "FileBase64": base64Image,
  //    "FileExtention": fileName,
  //  },
  //  headers: {
  //    "Accept":"application/json",
  //    "Content-Type":"application/json"
  //  });
   Map<String,String> headers = {'Content-Type':'application/json'};
final msg = jsonEncode({"FileBase64":base64Image,"FileExtention":fileName});

var response = await post(url,
               headers: headers,
               body: msg,
            );
   print(response.body);
    final jsonResponse = json.decode(response.body);
    
    print('After response :$jsonResponse');
    return UploadResponse.fromJson(jsonResponse);
  }
  static Future<UploadResponse2> upload_Base64AndReturnId(File file)async{
    String url = BASE_URL+"api/UploadFile/SaveFileAndRetrnId";
    print(url);
    
    if (file == null) print("Null => No File");
   String base64Image = base64Encode(file.readAsBytesSync());
   String fileName = file.path.split("/").last;
   Map<String,String> headers = {'Content-Type':'application/json'};
final msg = jsonEncode({"FileBase64":base64Image,"FileExtention":fileName});

var response = await post(url,
               headers: headers,
               body: msg,
            );
   print(response.statusCode);
   print(response.body);
    final jsonResponse = json.decode(response.body);
    return UploadResponse2.fromJson(jsonResponse);
 
  }
 static Future<UploadResponse2> upload_Base64AndReturnId2(String base64Image , String fileName)async{
    String url = BASE_URL+"api/UploadFile/SaveFileAndRetrnId";
    print(url);
    print(url);
    print(fileName);
    
  //   if (file == null) print("Null => No File");
  //  String base64Image = base64Encode(file.readAsBytesSync());
  //  String fileName = file.path.split("/").last;
print("base64 : "+base64Image);
  print("FileName : "+fileName);
//    if (file == null) print("Null => No File");
//    String base64Image = base64Encode(file.readAsBytesSync());
// //   String fileName = file.path.split("/").last;
   Map<String,String> headers = {'Content-Type':'application/json'};
final msg = jsonEncode({"FileBase64":base64Image,"FileExtention":fileName});

var response = await post(url,
               headers: headers,
               body: msg,
            );
   print(response.statusCode);
   print(response.body);
    final jsonResponse = json.decode(response.body);
    return UploadResponse2.fromJson(jsonResponse);
  }




}