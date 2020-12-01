
import 'PaymentAccountVM.dart';
import 'UserVM.dart';

class PaymentAccountResponse {
    // bool errors;
    int code;
    String message;
    PaymentAccountVM data;

    PaymentAccountResponse({this.message, this.code, this.data});

    factory PaymentAccountResponse.fromJson(Map<String, dynamic> json) {
        return PaymentAccountResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: json['code'], 
            data: json['data'] != null ? PaymentAccountVM.fromJson(json['data']) : null,
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