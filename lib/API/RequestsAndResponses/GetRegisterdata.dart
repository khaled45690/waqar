
// import '../APIProvider.dart';
// import 'package:waqarapp/model/UserModel.dart';
// class GetRegisterdata extends Mappable {
//   String user_name;
//   String user_pass;
//   String user_code;
//   String user_tele;
//   String user_city;
//   String user_email;
//   String user_token;
//   String user_image;
//   String  service_type;

//   GetRegisterdata.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {}

//   @override
//   Map<String, dynamic> toJson() => {"user_pass": user_pass,"user_code": user_code,"user_name": user_name,"user_tele": user_tele,"user_city":user_city,"user_email": user_email,"user_token": user_token,"user_image": user_image,"service_id": service_type};


//   GetRegisterdata(this.user_pass,this.user_code,this.user_name,this.user_city,this.user_tele,this.user_email,this.user_token,this.user_image,this.service_type) : super();

// }

// class GetRegisterdataResponse extends Mappable {

//   int status;
//   String message;
//   UserModel dataHome;
//   String dataError;


//   GetRegisterdataResponse.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {
//     status = json["status"];
//     message = json["message"].toString();

//     if (json["data"] != null && json["data"].toString().isEmpty == false) {
//       dataHome = UserModel.fromJson( json["data"]);
//     }
//     else{
//       dataError = message;
//   }
//   }

// }

