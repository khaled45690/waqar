
import 'ContactUsVM.dart';
import 'ContentVM.dart';


class ContactUsResponse {
    int code;
    String message;
    ContactUsVM data;

    ContactUsResponse({this.code, this.message, this.data});

    factory ContactUsResponse.fromJson(Map<String, dynamic> json) {
        return ContactUsResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: int.parse("${json['code']}"), 
            data: json['data'] != null ? ContactUsVM.fromJson(json['data']) : null,
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