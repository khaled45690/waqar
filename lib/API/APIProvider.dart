// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:rxdart/rxdart.dart';

// class Mappable {
//   Map<String, dynamic> toJson() => {};

//   Mappable.fromJson(Map<String, dynamic> json) {}

// //  fromJson(Map<String, dynamic> json) {}

//   Mappable() {}
// }

// enum Environment { Live}

// class API {
//   static var token = "";
//   Environment _environment = Environment.Live;
//   String get baseURL {
//     if (_environment == Environment.Live)
//       return "http://box5515.temp.domains/~waqarcom/admin/web/api/mobile";
//   }

//   final String apiVersion = "1.0";

//   String error = "";
//   static BehaviorSubject<String> errorSubject = BehaviorSubject<String>();

//   Map<String, dynamic> headers() {
//     var header;
//     if (token.isEmpty) {
//       header = null;
//     } else {
//       header = {"token": API.token};
//     }
//     return header;
//   }

//   Future<Response> postFromFormData(String endPoint, Mappable request) async {
//     final map = request.toJson();
//     final formData = FormData.from(map);
//     Response res = await Dio().post(await getUrl(endPoint),
//         data: formData, options: Options(headers: headers()));

//     logResponse(res);
//     return res;
//   }

// //  Future<Response> postFromBody(String endPoint, Mappable request) async {
// //    var header;
// //    if (token.isEmpty) {
// //      header = null;
// //    } else {
// //      header = {"token": API.token};
// //    }
// //
// //    final json = request.toJson();
// //    Response res = await Dio().post(getUrl(endPoint),
// //        data: json,
// //        options: Options(contentType: ContentType.json, headers: header));
// //
// //    return res;
// //  }

//   getUrl(String endPoint) async {
//     return "$baseURL/$endPoint";

//   }

//   Future<Response> get(String endPoint, Map<String, dynamic> params) async {
//     Response res;
//     try {
//       DateTime beforeJSONParsing = DateTime.now();
//       res = await Dio().get(await getUrl(endPoint),
//           queryParameters: params, options: Options(headers: headers()));
//       Duration apiCallDuration = DateTime.now().difference(beforeJSONParsing);
//       print(
//           'Response of $endPoint => ${apiCallDuration.inMilliseconds} milliseconds');
//       logResponse(res);
//     } catch (e) {
//       errorSubject.sink.add(e.toString());
//     }
//     return res;
//   }

//   Future<Response> postFromParams(
//       String endPoint, Map<String, dynamic> params) async {
//     Response response;
//     try {
//       DateTime beforeAPICall = DateTime.now();
//       response =
//           await Dio().post(await getUrl(endPoint), queryParameters: params);
//       Duration apiCallDuration = DateTime.now().difference(beforeAPICall);
//       print(
//           'Response of $endPoint => ${apiCallDuration.inMilliseconds} milliseconds');
//       logResponse(response);
//     } catch (e) {
//       errorSubject.sink.add(e);
//     }
//     return response;
//   }

//   logResponse(Response res) {
//     print(res.request.uri);
//     print(res.request.headers);
//     print(res.request.data);
//     print(res.statusCode);
//     print(res.headers);
//     print(res.data);
//   }
// }

// class CreatePostRequest extends Mappable {
//   String title;
//   String body;
//   int userId;

//   CreatePostRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

//   @override
//   Map<String, dynamic> toJson() =>
//       {"title": title, "body": body, "userId": userId};

//   CreatePostRequest(this.title, this.body, this.userId) : super();
// }

// class CreatePostResponce extends Mappable {
//   String title;
//   String body;
//   int userId;

//   CreatePostResponce.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json) {
//     title = json["title"].toString();
//   }
// }

// class APIProviderTests {
// //  static void testpostFromBody() async {
// //    var res = await API().postFromBody(
// //        "authentication",
// //        AuthenticationRequest(
// //            "login", "pgtadminsite", "Ab@123456", "", "", "", ""));
// //    final resAsPos = new AuthenticationResponse.fromJson(res.data);
// //
// //    print(res.data);
// //    print(resAsPos.status);
// //    print(resAsPos.message);
// //  }

// //  static void testGetToken() async {
// //    final bloc = GetDeviceTokenBloc();
// //    final token = await bloc.getToken();
// //
// //    print("ssssssssss" + token);
// //  }

// //  static void testlogin() async {
// //    final bloc = AuthenticationBloc();
// //    final userId = bloc.login("pgtadminsite", "Ab@123456");
// //
// //  }

// //  static void runTests() {
// //    testGetToken();
// ////    testlogin();
// //  }
// }
