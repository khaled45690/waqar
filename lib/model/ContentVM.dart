
import 'package:shared_preferences/shared_preferences.dart';

class ContentVM {
    int id;
    String key;
    String valueAr="";
    String valueEn="";
    // int status;
    // String token;
    // String updated_at;
    // int view ;
    // bool follow = false ;
    // int numProduct ;

    ContentVM({this.id,this.key, this.valueAr, this.valueEn});

    factory ContentVM.fromJson(Map<String, dynamic> json) {
      print("start fromjson 2222222222 ");
        return ContentVM(
            id: int.parse("${json['id']}"), 
            key: json['key'], 
            valueAr: json['valueAr'], 
            valueEn: json['valueEn'],
        );
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['key'] = this.key;
        data['valueAr'] = this.valueAr;
        data['valueEn'] = this.valueEn;
        return data;
    }
}
Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear() ;

    return true ;
}

Future<bool> saveContent(ContentVM content) async {
    try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // await prefs.setInt("code", user.code);
        await prefs.setInt("id", content.id);
        await prefs.setString("key", content.key);
        await prefs.setString("valueAr", content.valueAr);
        await prefs.setString("valueEn", content.valueEn);
        return true ;
    }catch(Excption){
        print("save to shared faild   :  $Excption");
        return false ;
    }
}

Future< ContentVM > getContent () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return new ContentVM(
        // id: prefs.getInt("userId"),
        id: prefs.getInt("id"),
        key: prefs.getString("key"),
        valueAr: prefs.getString("valueAr"),
        valueEn: prefs.getString("valueEn"),
    );

}