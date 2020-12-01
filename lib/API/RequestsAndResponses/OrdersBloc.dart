
// import 'dart:convert';


// import 'package:rxdart/rxdart.dart';
// import 'package:waqarapp/helpers/Preferences.dart';
// import 'package:waqarapp/model/ServiceModel.dart';

// import '../APIProvider.dart';
// import 'Setordersdata.dart';
// import 'Setservicedata.dart';

// class OrdersBloc {
//   final BehaviorSubject<ServiceModel> OrderSubject = BehaviorSubject<ServiceModel>();

//   void getorder(
//       String waqar_user_id
//       ) async {
//     var res = await API().get("get_order_mobile.php?", Setordersdata(
//         waqar_user_id
//     ).toJson());
//       final resAsPos = new SetordersdataResponse.fromJson(jsonDecode(res.data));
// //    if (resAsPos.dataHome.toString()!= "null") {
// //      OrderSubject.sink.add(resAsPos.dataHome);
// //      } else {
// //      if (resAsPos.dataError != null) {
// //        OrderSubject.sink.addError(resAsPos.dataError);
// //      }
// //      }
//   }


//   dispose() {
//     OrderSubject.close();
//   }


// }
