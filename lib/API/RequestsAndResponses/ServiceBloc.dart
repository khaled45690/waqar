
// import 'dart:convert';


// import 'package:rxdart/rxdart.dart';

// import 'package:waqarapp/helpers/Preferences.dart';
// import 'package:waqarapp/model/ServiceModel.dart';
// import '../APIProvider.dart';
// import 'Setservicedata.dart';

// class ServiceBloc {
//   final BehaviorSubject<ServiceModel> ServiceSubject = BehaviorSubject<ServiceModel>();

//   void addservice(
//       String waqar_order_target,
//       String waqar_order_type,
//       String waqar_order_category,
//       String waqar_order_city,
//       String waqar_order_distinct,
//       String waqar_order_age,
//       String waqar_order_area,
//       String waqar_order_price,
//       String waqar_order_properities,
//       String waqar_order_more_properities,
//       String waqar_order_period,
//       String waqar_order_office,
//       String waqar_order_pay_target,
//       String waqar_order_owner,
//       String waqar_service_name,
//       String waqar_owner_email,
//       String waqar_user_id
//       ) async {
//     var res = await API().get("add_order_mobile.php?", Setservicedata(
//         waqar_order_target,
//         waqar_order_type,
//         waqar_order_category,
//         waqar_order_city,
//         waqar_order_distinct,
//         waqar_order_age,
//         waqar_order_area,
//         waqar_order_price,
//         waqar_order_properities,
//         waqar_order_more_properities,
//         waqar_order_period,
//         waqar_order_office,
//         waqar_order_pay_target,
//         waqar_order_owner,
//         waqar_service_name,
//         waqar_owner_email,
//         waqar_user_id
//     ).toJson());
//       final resAsPos = new SetservicedataResponse.fromJson(jsonDecode(res.data));
//     if(resAsPos.dataHome != null && resAsPos.dataHome.waqar_order_id != null){
//       Preferences().setwaqar_order_id(resAsPos.dataHome.waqar_order_id);
//       Preferences().setwaqar_order_target(resAsPos.dataHome.waqar_order_target);
//       Preferences().setwaqar_order_type(resAsPos.dataHome.waqar_order_type);
//       Preferences().setwaqar_order_category(resAsPos.dataHome.waqar_order_category);
//       Preferences().setwaqar_order_city(resAsPos.dataHome.waqar_order_city);
//       Preferences().setwaqar_order_distinct(resAsPos.dataHome.waqar_order_distinct);
//       Preferences().setwaqar_order_age(resAsPos.dataHome.waqar_order_age);
//       Preferences().setwaqar_order_area(resAsPos.dataHome.waqar_order_area);
//       Preferences().setwaqar_order_price(resAsPos.dataHome.waqar_order_price);
//       Preferences().setwaqar_order_properities(resAsPos.dataHome.waqar_order_properities);
//       Preferences().setwaqar_order_more_properities(resAsPos.dataHome.waqar_order_more_properities);
//       Preferences().setwaqar_order_period(resAsPos.dataHome.waqar_order_period);
//       Preferences().setwaqar_order_office(resAsPos.dataHome.waqar_order_office);
//       Preferences().setwaqar_order_pay_target(resAsPos.dataHome.waqar_order_pay_target);
//       Preferences().setwaqar_order_owner(resAsPos.dataHome.waqar_order_owner);
//       Preferences().setwaqar_service_name(resAsPos.dataHome.waqar_service_name);
//     }
//     if (resAsPos.dataHome.toString()!= "null") {
//       ServiceSubject.sink.add(resAsPos.dataHome);
//       } else {
//       if (resAsPos.dataError != null) {
//         ServiceSubject.sink.addError(resAsPos.dataError);
//       }
//       }
//   }


//   dispose() {
//     ServiceSubject.close();
//   }


// }
