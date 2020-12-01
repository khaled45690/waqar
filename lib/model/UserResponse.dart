
import 'UserVM.dart';

class UserResponse {
    // bool errors;
    int code;
    String message;
    UserVM data;

    UserResponse({this.message, this.code, this.data});

    factory UserResponse.fromJson(Map<String, dynamic> json) {
        return UserResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: json['code'], 
            data: json['data'] != null ? UserVM.fromJson(json['data']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['code'] = this.code;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}