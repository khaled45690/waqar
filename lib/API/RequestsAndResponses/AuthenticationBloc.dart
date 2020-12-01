
// import 'dart:convert';

// import 'package:rxdart/rxdart.dart';

// import 'package:waqarapp/model/UserModel.dart';
// import 'package:waqarapp/helpers/Preferences.dart' as prefix0;
// import 'package:waqarapp/helpers/Preferences.dart';
// import '../APIProvider.dart';
// import 'GetRegisterdata.dart';
// import 'Getlogindata.dart';

// class AuthenticationBloc {
//   final BehaviorSubject<UserModel> loginSubject = BehaviorSubject<UserModel>();
//   final BehaviorSubject<UserModel> registerSubject = BehaviorSubject<UserModel>();
//   var resAsPos_reg;

//   void login(String userphone, String password) async {
//     var res = await API().get("signin.php?", Getlogindata(userphone, password).toJson());
//       final resAsPos = new GetlogindataResponse.fromJson(jsonDecode(res.data));
//     if(resAsPos.dataHome != null && resAsPos.dataHome.id != null){
//       Preferences().setUserId(resAsPos.dataHome.id);
//       Preferences().setusername(resAsPos.dataHome.username);
//       Preferences().setemail(resAsPos.dataHome.email);
//       Preferences().setPassword(resAsPos.dataHome.password);
//       Preferences().setPhone(resAsPos.dataHome.phone);
//       Preferences().setimage(resAsPos.dataHome.image);
//       Preferences().setusertype(resAsPos.dataHome.usertype);
//       Preferences().setusercity(resAsPos.dataHome.city);
//       Preferences().setfcmID(resAsPos.dataHome.fcmID);


//     }
//     if (resAsPos.dataHome.toString()!= "null") {
//         loginSubject.sink.add(resAsPos.dataHome);
//       } else {
//       if (resAsPos.dataError != null) {
//         loginSubject.sink.addError(resAsPos.dataError);
//       }
//       }
//   }




//   void register(String userName, String password,String phone,String email ,String city,String userimage,String usertype) async {
//     if(userimage.toString().isEmpty){
//       userimage=null;
//     }
//     var res = await API().get("signup.php?", GetRegisterdata(password, "",userName,city,phone,email,"",userimage,usertype).toJson());
//     if(res!= null && jsonDecode(res.data)!= null){
//       resAsPos_reg = new GetRegisterdataResponse.fromJson(jsonDecode(res.data));
//       if(resAsPos_reg.dataHome != null){
//         if(resAsPos_reg.dataHome.id!= null){
//           Preferences().setUserId(resAsPos_reg.dataHome.id);
//         }
//         Preferences().setUserId(resAsPos_reg.dataHome.id);
//         Preferences().setusername(resAsPos_reg.dataHome.username);
//         Preferences().setemail(resAsPos_reg.dataHome.email);
//         Preferences().setPassword(resAsPos_reg.dataHome.password);
//         Preferences().setPhone(resAsPos_reg.dataHome.phone);
//         Preferences().setimage(resAsPos_reg.dataHome.image);
//         Preferences().setusertype(resAsPos_reg.dataHome.usertype);
//         Preferences().setusercity(resAsPos_reg.dataHome.city);
//         Preferences().setfcmID(resAsPos_reg.dataHome.fcmID);
//       }
//     }


//     if (resAsPos_reg.dataHome.toString()!= null) {
//       registerSubject.sink.add(resAsPos_reg.dataHome);
//     } else {
//       if (resAsPos_reg.dataError != null) {
//         registerSubject.sink.addError(resAsPos_reg.dataError);
//       }
//     }
//   }


// //  void autoLogin() async {
// //    login(Preferences().getemail(),Preferences().getPassword());
// //  }



//   dispose() {
//     loginSubject.close();
//     registerSubject.close();

//   }





// }
