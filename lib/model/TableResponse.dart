
import 'package:shared_preferences/shared_preferences.dart';

class TableResponse {
    String date;
    String details;
    String number="";
    String type="";
    TableResponse({this.date,this.details, this.number, this.type});

    factory TableResponse.fromJson(Map<String, dynamic> json) {
        return TableResponse(
            date: json['date'], 
            details: json['details'], 
            number: json['number'], 
            type: json['type'],
        );
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['date'] = this.date;
        data['details'] = this.details;
        data['number'] = this.number;
        data['type'] = this.type;
        return data;
    }
}
