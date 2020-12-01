


import 'ContentVM.dart';

class ContentResponse {
    // bool errors;
    int code;
    String message;
    ContentVM data;

    ContentResponse({this.code, this.message, this.data});

    factory ContentResponse.fromJson(Map<String, dynamic> json) {
          print("start fromjson 111111111 ");
        return ContentResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: int.parse("${json['code']}"), 
            data: json['data'] != null ? ContentVM.fromJson(json['data']) : null,
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