
import 'UserVM.dart';

class PaymentAccountResponseV2 {
    // bool errors;
    int code;
    String message;
    int data;

    PaymentAccountResponseV2({this.message, this.code, this.data});

    factory PaymentAccountResponseV2.fromJson(Map<String, dynamic> json) {
        return PaymentAccountResponseV2(
            // errors: json['errors'], 
            message: json['message'], 
            code: json['code'], 
            data: json['data'] != null ?json['data'] : 0,
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