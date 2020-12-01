
// import 'dart:convert';

// import 'package:waqarapp/model/UserModel.dart';
// import 'package:rxdart/rxdart.dart';

// import '../APIProvider.dart';
// import 'Getpassworddata.dart';

// class ForgetBloc {
//   final BehaviorSubject<UserModel> loginSubject = BehaviorSubject<UserModel>();
//   var resAsPos_reg;

//   void forget(String userphone) async {
//     var res = await API().get("forget.php?", Getpassworddata(userphone).toJson());
//       final resAsPos = new GetpassworddataResponse.fromJson(jsonDecode(res.data));
// //    if(resAsPos.dataHome != null && resAsPos.dataHome.id != null){
// //      Preferences().setUserId(resAsPos.dataHome.id);
// //      Preferences().setusername(resAsPos.dataHome.username);
// //      Preferences().setemail(resAsPos.dataHome.email);
// //      Preferences().setPassword(resAsPos.dataHome.password);
// //      Preferences().setPhone(resAsPos.dataHome.phone);
// //      Preferences().setimage(resAsPos.dataHome.image);
// //      Preferences().setusertype(resAsPos.dataHome.usertype);
// //      Preferences().setusercity(resAsPos.dataHome.city);
// //      Preferences().setfcmID(resAsPos.dataHome.fcmID);
// //
// //
// //    }
//     if (resAsPos.dataHome.toString()!= "null") {
//         loginSubject.sink.add(resAsPos.dataHome);
//       } else {
//       if (resAsPos.dataError != null) {
//         loginSubject.sink.addError(resAsPos.dataError);
//       }
//       }

//   }


//   dispose() {
//     loginSubject.close();
//   }


// }
