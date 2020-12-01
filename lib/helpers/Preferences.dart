// import 'dart:async';

// import 'package:shared_preferences/shared_preferences.dart';


// import 'package:waqarapp/model/UserModel.dart';
// final int LANG_EN = 1;
// final int LANG_AR = 2;

// class Preferences {

//   UserModel currentUser;
//   static SharedPreferences prefs;
//   static final phoneKey = 'phone';
//   static final passwordKey = 'pass';
//   static final fcmIDkey = 'token';
//   static final userIdKey = 'id';
//   static final usernameKey = 'name';
//   static final emailKey = 'email';
//   static final imageKey = 'image';
//   static final usertypekey = 'usertype';
//   static final isuser = 'isuser';
//   static final usercitykey = 'city';




//   static final waqar_order_id = 'order_id';
//   static final waqar_order_target = 'order_target';
//   static final waqar_order_type = 'order_type';
//   static final waqar_order_category = 'order_category';
//   static final waqar_order_city = 'order_city';
//   static final waqar_order_distinct = 'order_distinct';
//   static final waqar_order_age = 'order_age';
//   static final waqar_order_area = 'order_area';
//   static final waqar_order_price = 'order_price';
//   static final waqar_order_properities = 'order_properities';
//   static final waqar_order_more_properities = 'order_more_properities';
//   static final waqar_order_period = 'order_period';
//   static final waqar_order_office = 'order_office';
//   static final waqar_order_pay_target = 'order_pay_target';
//   static final waqar_order_owner = 'order_owner';
//   static final waqar_service_name = 'service_name';

//   static final langKey = 'langID';
//   static bool english = true;


//   setisuser(x) async {
//     await prefs.setInt(isuser, x);
//   }
//   getisuser() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(isuser);
//   }

//   static setLangId(langId) async {
//     langId == LANG_EN ?  english = true : english = false;

//     prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(langKey, langId);
//   }

//   static Future<int> getLangId() async {
//     prefs = await SharedPreferences.getInstance();
//     try {
//       return prefs.getInt(langKey);
//     } catch (exp) {
//       return LANG_EN;
//     }
//   }


//   static Future<bool> isAuthenticated() async {
//     return prefs.getString(phoneKey).isNotEmpty;
//   }

//   setUserData(phone, password) async {
//     prefs = await SharedPreferences.getInstance();
//     prefs.setString(phoneKey, phone);
//     prefs.setString(passwordKey, password);
//   }

//   setUserId(userId) async {
//     prefs = await SharedPreferences.getInstance();
//     currentUser = UserModel.fromJson( {
//       "id": "",
//       "pass": "",
//       "name": "",
//       "phone": "",
//       "email": "",
//       "city": "",
//       "token": "",
//       "image": "",
//       "usertype": ""
//     });
//     await prefs.setString(userIdKey, userId);
//   }

//   setusertype(username) async {
//     await prefs.setString(usertypekey, username);
//   }

//   setusername(username) async {
//     await prefs.setString(usernameKey, username);
//   }
//   setemail(email) async {
//     await prefs.setString(emailKey, email);
//   }

//   setimage(image) async {
//     await prefs.setString(imageKey, image);
//   }
//   setfcmID(image) async {
//     if(fcmIDkey!= null)
//     await prefs.setString(fcmIDkey, image);
//   }

//   setusercity(image) async {
//     if(usercitykey!= null)
//       await prefs.setString(usercitykey, image);
//   }



//   setPhone(phone) async {
//     await prefs.setString(phoneKey, phone);
//   }

//   setPassword(password) async {
//     await prefs.setString(passwordKey, password);
//   }

//   setwaqar_order_id(userId) async {
//     await prefs.setString(waqar_order_id, userId);
//   }
//   setwaqar_order_target(userId) async {
//     await prefs.setString(waqar_order_target, userId);
//   }
//   setwaqar_order_type(userId) async {
//     await prefs.setString(waqar_order_type, userId);
//   }
//   setwaqar_order_category(userId) async {
//     await prefs.setString(waqar_order_category, userId);
//   }
//   setwaqar_order_city(userId) async {
//     await prefs.setString(waqar_order_city, userId);
//   }
//   setwaqar_order_distinct(userId) async {
//     await prefs.setString(waqar_order_distinct, userId);
//   }
//   setwaqar_order_age(userId) async {
//     await prefs.setString(waqar_order_age, userId);
//   }
//   setwaqar_order_area(userId) async {
//     await prefs.setString(waqar_order_area, userId);
//   }
//   setwaqar_order_price(userId) async {
//     await prefs.setString(waqar_order_price, userId);
//   }
//   setwaqar_order_properities(userId) async {
//     await prefs.setString(waqar_order_properities, userId);
//   }
//   setwaqar_order_more_properities(userId) async {
//     await prefs.setString(waqar_order_more_properities, userId);
//   }
//   setwaqar_order_period(userId) async {
//     await prefs.setString(waqar_order_period, userId);
//   }
//   setwaqar_order_office(userId) async {
//     await prefs.setString(waqar_order_office, userId);
//   }
//   setwaqar_order_pay_target(userId) async {
//     await prefs.setString(waqar_order_pay_target, userId);
//   }
//   setwaqar_order_owner(userId) async {
//     await prefs.setString(waqar_order_owner, userId);
//   }
//   setwaqar_service_name(userId) async {
//     await prefs.setString(waqar_service_name, userId);
//   }


//   getId() async {
//     prefs = await SharedPreferences.getInstance();
//     final id = prefs.getString(userIdKey).toString();
//     return id;
//   }

//   getPhone() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(phoneKey).toString();
//   }

//   getcity() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(usercitykey).toString();
//   }

//   getusername() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(usernameKey).toString();
//   }

//   getemail() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(emailKey).toString().toString();
//   }

//   getusertype() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(usertypekey).toString();
//   }

//   getimage() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(imageKey).toString();
//   }

//   getfcmID() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(fcmIDkey).toString();
//   }

//   getwaqar_order_id() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_id);
//   }
//   getwaqar_order_target() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_target);
//   }
//   getwaqar_order_type() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_type);
//   }
//   getwaqar_order_category() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_category);
//   }
//   getwaqar_order_city() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_city);
//   }
//   getwaqar_order_distinct() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_distinct);
//   }
//   getwaqar_order_age() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_age);
//   }
//   getwaqar_order_area() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_area);
//   }
//   getwaqar_order_price() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_price);
//   }
//   getwaqar_order_properities() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_properities);
//   }
//   getwaqar_order_more_properities() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_more_properities);
//   }
//   getwaqar_order_period() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_period);
//   }
//   getwaqar_order_office() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_office);
//   }
//   getaqar_order_pay_target() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_pay_target);
//   }
//   getwaqar_order_owner() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_order_owner);
//   }
//   getwaqar_service_name() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getString(waqar_service_name);
//   }





//   getPassword() async => prefs.getString(passwordKey).toString();

//   static setToken(String token) async => prefs.setString(fcmIDkey, token);

//   static getToken() async => prefs.getString(fcmIDkey);

//   getUserId() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(userIdKey);
//   }

//   logout() async{
//     prefs = await SharedPreferences.getInstance();
//     prefs.setInt(userIdKey, 0);
//     prefs.setString(phoneKey, "");
//     prefs.setString(passwordKey, "");
//     prefs.setString(fcmIDkey, "");
//   }
// }
