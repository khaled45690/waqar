
// import 'package:waqarapp/model/ServiceModel.dart';
// import '../APIProvider.dart';

// class Setservicedata extends Mappable {

//   String waqar_order_target;
//   String waqar_order_type;
//   String waqar_order_category;
//   String waqar_order_city;
//   String waqar_order_distinct;
//   String waqar_order_age;
//   String waqar_order_area;
//   String waqar_order_price;
//   String waqar_order_properities;
//   String waqar_order_more_properities;
//   String waqar_order_period;
//   String waqar_order_office;
//   String waqar_order_pay_target;
//   String waqar_order_owner;
//   String waqar_service_name;
//   String waqar_owner_email;
//   String waqar_user_id;




//   Setservicedata.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {}

//   @override
//   Map<String, dynamic> toJson() => {
//     "order_target": waqar_order_target,
//     "order_type": waqar_order_type,
//     "order_category": waqar_order_category,
//     "order_city": waqar_order_city,
//     "order_distinct": waqar_order_distinct,
//     "order_age": waqar_order_age,
//     "order_area": waqar_order_area,
//     "order_price": waqar_order_price,
//     "order_properities": waqar_order_properities,
//     "order_more_properities": waqar_order_more_properities,
//     "order_period": waqar_order_period,
//     "order_office": waqar_order_office,
//     "order_pay_target": waqar_order_pay_target,
//     "owner_name": waqar_order_owner,
//     "service_name": waqar_service_name,
//     "owner_email": waqar_owner_email,
//     "waqar_user_id": waqar_user_id

//   };


//   Setservicedata( this.waqar_order_target,
//       this.waqar_order_type,
//       this.waqar_order_category,
//       this.waqar_order_city,
//       this.waqar_order_distinct,
//       this.waqar_order_age,
//       this.waqar_order_area,
//       this.waqar_order_price,
//       this.waqar_order_properities,
//       this.waqar_order_more_properities,
//       this.waqar_order_period,
//       this.waqar_order_office,
//       this.waqar_order_pay_target,
//       this.waqar_order_owner,
//       this.waqar_service_name,
//       this.waqar_owner_email,
//       this.waqar_user_id) : super();


// }

// class SetservicedataResponse extends Mappable {

//   int status;
//   String message;
//   ServiceModel dataHome;
//   String dataError;

//   SetservicedataResponse.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {
//     status = json["status"];
//     message = json["message"].toString();

//     if (json["data"] != null && json["data"].toString().length>2) {
//       dataHome = ServiceModel.fromJson( json["data"]);
//     }
//     else{
//        dataError = message;
//     }
//   }

// }

