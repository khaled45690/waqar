
import 'UserVM.dart';

class AllUsersResponse {
    // bool errors;
    int code;
    String message;
    List<UserVM> data;

    AllUsersResponse({this.message, this.code, this.data});

    factory AllUsersResponse.fromJson(Map<String, dynamic> json) {
        return AllUsersResponse(
            // errors: json['errors'], 
            message: json['message'], 
            code: json['code'], 
            data: json['data'] != null ? (json['data'] as List).map((i) => UserVM.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['code'] = this.code;
        // if (this.data != null) {
        //     data['data'] = this.data.toJson();
        // }
        return data;
    }
}