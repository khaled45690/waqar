


import 'package:waqarapp/model/membershipVM.dart';

import 'ContentVM.dart';

class membershipResponseVM {
    // bool errors;
    int code;
    String message;
    membershipVM data;

    membershipResponseVM({this.code, this.message, this.data});

    factory membershipResponseVM.fromJson(Map<String, dynamic> json) {
          print("start fromjson 111111111 ");
        return membershipResponseVM(
            // errors: json['errors'], 
            message: json['message'], 
            code: int.parse("${json['code']}"), 
            data: json['data'] != null ? membershipVM.fromJson(json['data']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        //data['message'] = this.message;
        data['code'] = this.code;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}