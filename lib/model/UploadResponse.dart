
import 'ContentVM.dart';
import 'UserVM.dart';


class UploadResponse {
    int code;
    String message;
    String data;

    UploadResponse({this.code, this.message, this.data});

    factory UploadResponse.fromJson(Map<String, dynamic> json) {
        return UploadResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: int.parse("${json['code']}"), 
            data:json['data'],
            // data:json['data'] == null ?null: (json['data'] as List).map((i) => ServiceVM.fromJson(i)).toList(),
        );
    }

    // Map<String, dynamic> toJson() {
    //     final Map<String, dynamic> data = new Map<String, dynamic>();
    //     //data['message'] = this.message;
    //     data['code'] = this.code;
    //     if (this.data != null) {
    //         data['data'] = this.data.toJson();
    //     }
    //     return data;
    // }
}

class UploadResponse2 {
    int code;
    String message;
    int data;

    UploadResponse2({this.code, this.message, this.data});

    factory UploadResponse2.fromJson(Map<String, dynamic> json) {
        return UploadResponse2(
            // errors: json['errors'], 
            message: json['message'], 
            code: int.parse("${json['code']}"), 
            data:json['data'],
            // data:json['data'] == null ?null: (json['data'] as List).map((i) => ServiceVM.fromJson(i)).toList(),
        );
    }

    // Map<String, dynamic> toJson() {
    //     final Map<String, dynamic> data = new Map<String, dynamic>();
    //     //data['message'] = this.message;
    //     data['code'] = this.code;
    //     if (this.data != null) {
    //         data['data'] = this.data.toJson();
    //     }
    //     return data;
    // }
}