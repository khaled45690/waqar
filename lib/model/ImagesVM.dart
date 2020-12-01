

class ImagesVM {
    int id;
    String resourceName;
    // int status;
    // String token;
    // String updated_at;
    // int view ;
    // bool follow = false ;
    // int numProduct ;

    ImagesVM({this.id,this.resourceName});

    factory ImagesVM.fromJson(Map<String, dynamic> json) {
      print("start fromjson 2222222222 ");
        return ImagesVM(
            id: int.parse("${json['id']}"), 
            resourceName: json['resourceName'],
        );
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['resourceName'] = this.resourceName;
        return data;
    }
}

class ImagesResponse {
    List<ImagesVM> data;
    int code;
    String message;
    ImagesResponse({ this.data , this.message , this.code});

    factory ImagesResponse.fromJson(Map<String, dynamic> json) {
          print("start fromjson 111111111 ");
        return ImagesResponse(
          message: json['message'], 
            code: json['code'], 
            data: json['data'] =(json['data'] as List).map((i) => ImagesVM.fromJson(i)).toList(),// ImagesVM.fromJson(json['data']),
        );
    }

}
