
import 'package:waqarapp/model/ServiceDataVM.dart';

import 'UserVM.dart';

class ServiceDataResponse {
    // bool errors;
    int code;
    String message;
    ServiceDataVM data;

    ServiceDataResponse({this.message, this.code, this.data});

    factory ServiceDataResponse.fromJson(Map<String, dynamic> json) {
        return ServiceDataResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: json['code'], 
            data: json['data'] != null ? ServiceDataVM.fromJson(json['data']) : null,
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