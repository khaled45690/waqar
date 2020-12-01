

// import 'package:waqarapp/model/UserModel.dart';

// import '../APIProvider.dart';

// class Getpassworddata extends Mappable {

//   String user_tele;


//   Getpassworddata.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {}

//   @override
//   Map<String, dynamic> toJson() => {"user_tele": user_tele};


//   Getpassworddata(this.user_tele) : super();


// }

// class GetpassworddataResponse extends Mappable {

//   int status;
//   String message;
//   UserModel dataHome;
//   String dataError;

//   GetpassworddataResponse.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {
//     status = json["status"];
//     message = json["message"].toString();

//     if (json["data"] != null && json["data"].toString().length>2) {
//       dataHome = UserModel.fromJson( json["data"]);
//     }
//     else{
//        dataError = message;
//     }
//   }

// }

