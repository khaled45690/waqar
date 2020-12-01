
import 'package:waqarapp/model/ServiceDataVM.dart';

import 'UserVM.dart';

class MyServicesDataResponse {
    // bool errors;
    int code;
    String message;
    List<ServiceDataVM> data;

    MyServicesDataResponse({this.message, this.code, this.data});

    factory MyServicesDataResponse.fromJson(Map<String, dynamic> json) {
        return MyServicesDataResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: json['code'], 
            data: json['data'] != null ? (json['data'] as List).map((i) => ServiceDataVM.fromJson(i)).toList() : null,
        );
    }

    // Map<String, dynamic> toJson() {
    //     final Map<String, dynamic> data = new Map<String, dynamic>();
    //     data['message'] = this.message;
    //     data['code'] = this.code;
    //     if (this.data != null) {
    //         data['data'] = this.data.toJson();
    //     }
    //     return data;
    // }
}