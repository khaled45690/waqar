// import 'package:waqarapp/model/ServiceModel.dart';

// import '../APIProvider.dart';

// class Setordersdata extends Mappable {


//   String waqar_user_id;




//   Setordersdata.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {}

//   @override
//   Map<String, dynamic> toJson() => {
//     "waqar_user_id": waqar_user_id

//   };


//   Setordersdata(
//       this.waqar_user_id) : super();


// }

// class SetordersdataResponse extends Mappable {

//   int status;
//   String message;
// //  ServiceModel dataHome;
//   List<ServiceModel> dataHome = new List();

//   String dataError;

//   SetordersdataResponse.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {
//     status = json["status"];
//     message = json["message"].toString();

//     if (json["data"] != null && json["data"].toString().length>2) {
//       for(int i=0;i< json["data"].toString().length;i++){
//         dataHome.add(ServiceModel.fromJson( json["data"]));
//       }
//      //  dataHome=ServiceModel.fromJson( json["data"]);

//     }
//     else{
//       dataError = message;
//     }
//   }

// }


