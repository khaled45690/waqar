


// import 'package:waqarapp/model/UserModel.dart';
// import '../APIProvider.dart';

// class Getlogindata extends Mappable {

//   String user_tele;
//   String user_pass;


//   Getlogindata.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {}

//   @override
//   Map<String, dynamic> toJson() => {"user_tele": user_tele,"user_pass": user_pass};


//   Getlogindata(this.user_tele,this.user_pass) : super();


// }

// class GetlogindataResponse extends Mappable {

//   int status;
//   String message;
//   UserModel dataHome;
//   String dataError;

//   GetlogindataResponse.fromJson(Map<String, dynamic> json)
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

